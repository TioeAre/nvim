local M = {}

-- nvim-treesitter/nvim-treesitter
M.config_treesitter = function()
    require("nvim-treesitter.configs").setup({
        build = ":TSUpdate",
        indent = {
            enable = true
        },
        autotag = {
            enable = true
        },
        event = {"BufReadPre", "BufNewFile"},
        ensure_installed = {"bash", "bibtex", "c", "cmake", "cpp", "css", "csv", "cuda", "dockerfile", "git_config",
                            "git_rebase", "gitattributes", "gitcommit", "gitignore", "go", "html", "java", "json",
                            "json5", "latex", "lua", "make", "markdown", "markdown_inline", "matlab", "python",
        -- "pip_requirements",
                            "regex", "ssh_config", "todotxt", "toml", "vim", "xml", "yaml"},
        auto_install = true,
        highlight = {
            enable = true,
            disable = function(lang, buf)
                local max_filesize = 3 * 1024 * 1024 -- 1024 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            additional_vim_regex_highlighting = false
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<Leader>ta",
                node_incremental = "<Leader>ta",
                scope_incremental = false,
                node_decremental = "<BS>"
            }
        },
        textobjects = {
            select = {
                enable = true,
                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    -- You can optionally set descriptions to the mappings (used in the desc parameter of
                    -- nvim_buf_set_keymap) which plugins like which-key display
                    ["ic"] = {
                        query = "@class.inner",
                        desc = "Select inner part of a class region"
                    },
                    -- You can also use captures from other query groups like `locals.scm`
                    ["as"] = {
                        query = "@scope",
                        query_group = "locals",
                        desc = "Select language scope"
                    }
                },
                -- You can choose the select mode (default is charwise 'v')
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * method: eg 'v' or 'o'
                -- and should return the mode ('v', 'V', or '<c-v>') or a table
                -- mapping query_strings to modes.
                selection_modes = {
                    ['@parameter.outer'] = 'v', -- charwise
                    ['@function.outer'] = 'V', -- linewise
                    ['@class.outer'] = '<c-v>' -- blockwise
                },
                include_surrounding_whitespace = false
            },
            lsp_interop = {
                enable = true,
                border = 'none',
                floating_preview_opts = {},
                peek_definition_code = {
                    ["<leader>gf"] = "@function.outer",
                    ["<leader>gF"] = "@class.outer"
                }
            }
        }
    })
    require("nvim-treesitter.install").prefer_git = true

    -- auto pairs setup
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")
    npairs.setup({
        check_ts = true,
        ts_config = {
            lua = {"string"}, -- it will not add a pair on that treesitter node
            javascript = {"template_string"},
            java = false -- don't check treesitter on java
        },
        enable_check_bracket_line = false
    })
    local ts_conds = require("nvim-autopairs.ts-conds")
    -- press % => %% only while inside a comment or string
    npairs.add_rules({Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({"string", "comment"})),
                      Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({"function"}))})

    -- -- kevinhwang91/nvim-ufo
    require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
            return {"treesitter", "indent"}
        end
    })
end

-- nvim-treesitter/nvim-treesitter-context
M.config_treesitter_context = function()
    require("treesitter-context").setup({
        enable = true,
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil -- (fun(buf: integer): boolean) return false to disable attaching
    })
end

return M
