local M = {}

M.show_only_one_sign_in_sign_column = function()
    local ns = vim.api.nvim_create_namespace("severe-diagnostics")
    local orig_signs_handler = vim.diagnostic.handlers.signs
    ---Overriden diagnostics signs helper to only show the single most relevant sign
    ---see `:h diagnostic-handlers`
    local filter_diagnostics = function(diagnostics)
        if not diagnostics then
            return {}
        end
        -- find the "worst" diagnostic per line
        local most_severe = {}
        for _, cur in pairs(diagnostics) do
            local max = most_severe[cur.lnum]

            -- higher severity has lower value (`:h diagnostic-severity`)
            if not max or cur.severity < max.severity then
                most_severe[cur.lnum] = cur
            end
        end
        -- return list of diagnostics
        return vim.tbl_values(most_severe)
    end
    vim.diagnostic.handlers.signs = {
        show = function(_, bufnr, _, opts)
            -- get all diagnostics from the whole buffer rather
            -- than just the diagnostics passed to the handler
            local diagnostics = vim.diagnostic.get(bufnr)
            local filtered_diagnostics = filter_diagnostics(diagnostics)
            -- pass the filtered diagnostics (with the
            -- custom namespace) to the original handler
            orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
        end,

        hide = function(_, bufnr)
            orig_signs_handler.hide(ns, bufnr)
        end,
    }
end

-- Wansmer/symbol-usage.nvim
M.text_format = function(symbol)
    local fragments = {}
    -- Indicator that shows if there are any other symbols in the same line
    local stacked_functions = symbol.stacked_count > 0
        and (' | +%s'):format(symbol.stacked_count)
        or ''
    if symbol.references then
        local usage = symbol.references <= 1 and 'usage' or 'usages'
        local num = symbol.references == 0 and 'no' or symbol.references
        table.insert(fragments, ('%s %s'):format(num, usage))
    end
    if symbol.definition then
        table.insert(fragments, symbol.definition .. ' defs')
    end
    if symbol.implementation then
        table.insert(fragments, symbol.implementation .. ' impls')
    end
    return table.concat(fragments, ', ') .. stacked_functions
end

M.client_format = function(client_name, spinner, series_messages)
    if #series_messages == 0 then
        return nil
    end
    return {
        name = client_name,
        body = spinner .. " " .. table.concat(series_messages, ", "),
    }
end

M.format = function(client_messages)
    --- @param name string
    --- @param msg string?
    --- @return string
    local function stringify(name, msg)
        return msg and string.format("%s %s", name, msg) or name
    end

    local sign = "" -- nf-fa-gear \uf013
    local lsp_clients = vim.lsp.get_clients()
    local messages_map = {}
    for _, climsg in ipairs(client_messages) do
        messages_map[climsg.name] = climsg.body
    end

    if #lsp_clients > 0 then
        table.sort(lsp_clients, function(a, b)
            return a.name < b.name
        end)
        local builder = {}
        for _, cli in ipairs(lsp_clients) do
            if
                type(cli) == "table"
                and type(cli.name) == "string"
                and string.len(cli.name) > 0
            then
                if messages_map[cli.name] then
                    table.insert(builder, stringify(cli.name, messages_map[cli.name]))
                else
                    table.insert(builder, stringify(cli.name))
                end
            end
        end
        if #builder > 0 then
            return sign .. " " .. table.concat(builder, ", ")
        end
    end
    return ""
end

return M
