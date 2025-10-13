local M = {}

-- hrsh7th/nvim-cmp
M.config_cmp = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    local neogen = require('neogen')
    require("luasnip/loaders/from_vscode").lazy_load()
    vim.opt.completeopt = "menu,menuone,noselect"

    local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end
    local bufIsBig = function(bufnr)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
        if ok and stats and stats.size > max_filesize then
            return true
        else
            return false
        end
    end
    local sources1 = cmp.config.sources({
        -- lsp
        {
            name = "nvim_lsp",
        },
        -- lsp function help
        {
            name = "nvim_lsp_signature_help",
        },
        -- snippets
        {
            name = "luasnip",
        },
        -- text within current buffer
        {
            name = "buffer",
        },
        -- file system paths
        {
            name = "path",
        },
        -- calc
        {
            name = "calc",
        },
        -- spell
        {
            name = "spell",
        },
        -- latex
        {
            name = "latex_symbols",
            option = {
                strategy = 0, -- 0-mixed 1-julia 2-latex
            },
        },
        -- nvim lua grammar
        {
            name = "nvim_lua",
        },
        {
            name = 'tmux'
        },
        {
            name = 'treesitter'
        },
        {
            name = "copilot"
        },
    })

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        -- sources for autocompletion
        sources = sources1,
        mapping = cmp.mapping.preset.insert({
            ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
            ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
            ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
            ["<CR>"] = cmp.mapping.confirm({
                select = false,
            }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() and has_words_before() then
                    cmp.select_next_item()
                    -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                    -- they way you will only jump inside the snippet region
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                    -- elseif has_words_before() then
                    -- cmp.complete()
                elseif neogen.jumpable() then
                    neogen.jump_next()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() and has_words_before() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                elseif neogen.jumpable(true) then
                    neogen.jump_prev()
                else
                    fallback()
                end
            end, { "i", "s" }),
        }),
        experimental = {
            ghost_text = false,
        },
        window = {
            --documentation = {
            --border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            --},
            completion = {
                border = "rounded",
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
            },
            documentation = {
                border = "rounded",
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
            },
        },
        -- configure lspkind for vs-code like icons
        formatting = {
            format = lspkind.cmp_format({
                maxwidth = 120,
                ellipsis_char = "...",
                symbol_map = { Copilot = "" }
            }),
        },
        -- if file is too big
        vim.api.nvim_create_autocmd("FileReadPre", {
            pattern = "*.*",
            callback = function(t)
                if not bufIsBig(t.buf) then
                    -- sources1 = vim.tbl_deep_extend("keep",
                    --     sources1,
                    --     { name = "treesitter", group_index = 2 }
                    -- )
                    sources1[#sources1 + 1] = { name = "treesitter", group_index = 2 }
                end
                cmp.setup.buffer({
                    sources = sources1,
                })
            end,
        }),
    })

    cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { {
            name = "buffer",
        } },
    })
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ {
            name = "path",
        } }, { {
            name = "cmdline",
        } }),
    })

    cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
            {
                name = "git",
            }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, { {
            name = "buffer",
        } }),
    })

    -- auto pairs when <cr>
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    -- lsp ray-x/navigator.lua
    if vim.o.ft == 'clap_input' and vim.o.ft == 'guihua' and vim.o.ft == 'guihua_rust' then
        require 'cmp'.setup.buffer { completion = { enable = false } }
    end
end

-- danymat/neogen
M.config_neogen = function()
    require("neogen").setup({
        snippet_engine = "luasnip",
        enabled = true,             --if you want to disable Neogen
        input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
        languages = {
            lua = {
                template = {
                    annotation_convention = "emmylua" -- for a full list of annotation_conventions,
                }
            },
            python = {
                template = {
                    annotation_convention = "numpydoc" -- for a full list of annotation_conventions,
                }
            },
        },
    })
end

return M
