local M = {}
local themes_vars = require("variables.themes")

M.get_all_buffer_filenames = function()
    local filenames = {}
    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
            local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
            if filename ~= "" then
                filenames[filename] = (filenames[filename] or 0) + 1
            end
        end
    end
    return filenames
end

M.name_formatter = function(buf)
    local path = buf.path or ""
    local filename = vim.fn.fnamemodify(path, ":t")
    local tail = vim.fn.fnamemodify(path, ":p:h:t")
    local all_filenames = M.get_all_buffer_filenames()
    if all_filenames[filename] and all_filenames[filename] > 1 then
        return tail .. "/" .. filename
    else
        return filename
    end
end

M.get_diagnostic_label = function(props)
    local labels = {}
    if not vim.api.nvim_buf_is_valid(props.buf) then
        return labels -- Return an empty table if buffer is not valid
    end
    local icons = { error = " ", warn = " ", hint = "❃", info = "" }
    local severity_map = {
        error = vim.diagnostic.severity.ERROR,
        warn = vim.diagnostic.severity.WARN,
        info = vim.diagnostic.severity.INFO,
        hint = vim.diagnostic.severity.HINT,
    }
    for severity, icon in pairs(icons) do
        local n = #vim.diagnostic.get(props.buf, { severity = severity_map[severity] })
        if n > 0 then
            table.insert(labels, { icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity })
        end
    end
    if #labels > 0 then
        table.insert(labels, 1, " ")
        table.insert(labels, { "|" })
    end
    return labels
end

M.get_git_diff = function(props)
    local icons = { removed = "", added = "", changed = "" }
    local labels = {}
    -- local signs = vim.api.nvim_buf_get_var(props.buf, "gitsigns_status_dict")
    local success, signs = pcall(vim.api.nvim_buf_get_var, props.buf, "gitsigns_status_dict")
    if not success then
        return labels -- Return an empty table if gitsigns_status_dict is not found
    end
    -- local signs = vim.b.gitsigns_status_dict
    for name, icon in pairs(icons) do
        if tonumber(signs[name]) and signs[name] > 0 then
            table.insert(labels, { icon .. " " .. signs[name] .. " ", group = "Diff" .. name })
        end
    end
    if #labels > 0 then
        table.insert(labels, 1, " ")
        table.insert(labels, { "|" })
    end
    return labels
end

M.render = function(props)
    -- local bufnum = props.buf
    local buffullname = vim.api.nvim_buf_get_name(props.buf)
    local bufname_t = vim.fn.fnamemodify(buffullname, ":t")

    local path = buffullname or ""
    local filename = bufname_t
    local tail = vim.fn.fnamemodify(path, ":p:h:t")
    local all_filenames = M.get_all_buffer_filenames()
    if all_filenames[filename] and all_filenames[filename] > 1 then
        bufname_t = tail .. "/" .. filename
    end

    local bufname = (bufname_t and bufname_t ~= "") and bufname_t or "[No Name]"

    -- optional devicon
    local devicon = { " " }
    local success, nvim_web_devicons = pcall(require, "nvim-web-devicons")
    if success then
        local bufname_r = vim.fn.fnamemodify(buffullname, ":r")
        local bufname_e = vim.fn.fnamemodify(buffullname, ":e")
        local base = (bufname_r and bufname_r ~= "") and bufname_r or bufname
        local ext = (bufname_e and bufname_e ~= "") and bufname_e or vim.fn.fnamemodify(base, ":t")
        local ic, hl = nvim_web_devicons.get_icon(base, ext, { default = true })
        devicon = {
            " ",
            ic,
            " ",
            group = hl,
        }
    end
    -- buffer name
    local display_bufname = vim.tbl_extend("force", { bufname, " " }, themes_vars.field_format.name)
    -- modified indicator
    local modified_icon = {}
    if vim.api.nvim_get_option_value("modified", { buf = props.buf }) then
        modified_icon = vim.tbl_extend("force", { "● " }, themes_vars.field_format.modified)
        display_bufname.guifg = themes_vars.field_format.modified.guifg
    end

    -- buffer number
    -- local display_bufnum = vim.tbl_extend("force", { bufnum, " " }, field_format.num)

    -- example: █▓   incline-nvim.lua 13  ▓█
    return {
        -- start,
        { M.get_diagnostic_label(props) },
        { M.get_git_diff(props) },
        devicon,
        display_bufname,
        modified_icon,
        -- display_bufnum,
        -- stop,
    }
end

return M
