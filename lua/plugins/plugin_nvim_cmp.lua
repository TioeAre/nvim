local config_cmp = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    require("luasnip/loaders/from_vscode").lazy_load()
    vim.opt.completeopt = "menu,menuone,noselect"
    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
            ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
            ["<C-e>"] = cmp.mapping.abort(), -- close completion window
            ["<CR>"] = cmp.mapping.confirm({
                select = false
            }),
            ['<Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end,
            ['<S-Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end

        }),
        -- sources for autocompletion
        sources = cmp.config.sources({{
            name = "nvim_lsp"
        }, -- lsp
        {
            name = "luasnip"
        }, -- snippets
        {
            name = "buffer"
        }, -- text within current buffer
        {
            name = "path"
        }, -- file system paths
        {
            name = "cmdline"
        } -- command line
        }),
        -- configure lspkind for vs-code like icons
        formatting = {
            format = lspkind.cmp_format({
                maxwidth = 50,
                ellipsis_char = "..."
            })
        }

    })
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({{
            name = 'git'
        } -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {{
            name = 'buffer'
        }})
    })
    cmp.setup.cmdline({'/', '?'}, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {{
            name = 'buffer'
        }}
    })
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({{
            name = 'path'
        }}, {{
            name = 'cmdline'
        }})
    })
    -- if file is too big
    local bufIsBig = function(bufnr)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
        if ok and stats and stats.size > max_filesize then
            return true
        else
            return false
        end
    end
    vim.api.nvim_create_autocmd('BufReadPre', {
        callback = function(t)
            local sources = default_cmp_sources
            if not bufIsBig(t.buf) then
                sources[#sources+1] = {name = 'treesitter', group_index = 2}
            end
        cmp.setup.buffer {
            sources = sources
        }
        end
    })

    -- auto pairs when <cr>
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

return {
    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        config = config_cmp,
        dependencies = {
            "onsails/lspkind.nvim",
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-calc',
            'f3fora/cmp-spell',
            'saadparwaiz1/cmp_luasnip',
            {
                'ray-x/cmp-treesitter',
                require'cmp'.setup {
                    sources = {
                      { name = 'treesitter' }
                    }
                },
            },
        },
        {
            "L3MON4D3/LuaSnip",
            -- follow latest release.
            version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp",
            dependencies = 'rafamadriz/friendly-snippets',
        },
    },
}
