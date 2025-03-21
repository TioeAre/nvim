local M = {}
local filetype = require("utils.filetype")

-- nvim-treesitter/nvim-treesitter
M.config_treesitter = function()
    require("nvim-treesitter.configs").setup({
        build = ":TSUpdate",
        indent = {
            enable = true,
        },
        autotag = {
            enable = true,
        },
        matchup = {
            enable = true, -- mandatory, false will disable the whole extension
            -- disable = { "c", "ruby" }, -- optional, list of language that will be disabled
            -- [options]
        },
        event = { "BufReadPost", "BufNewFile" },
        ensure_installed = {
            "bash",
            "bibtex",
            "c",
            "cmake",
            "cpp",
            "css",
            "csv",
            "cuda",
            "dockerfile",
            "diff",
            "git_config",
            "git_rebase",
            "gitattributes",
            "gitcommit",
            "gitignore",
            "go",
            "html",
            "java",
            "json",
            "json5",
            "jsonc",
            "latex",
            "lua",
            "luadoc",
            "make",
            "markdown",
            "markdown_inline",
            "matlab",
            "python",
            -- "pip_requirements",
            "regex",
            "ssh_config",
            "todotxt",
            "toml",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
        },
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
            additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<Leader>ta",
                node_incremental = "<Leader>ta",
                scope_incremental = false,
                node_decremental = "<BS>",
            },
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
                        desc = "Select inner part of a class region",
                    },
                    -- You can also use captures from other query groups like `locals.scm`
                    ["as"] = {
                        query = "@scope",
                        query_group = "locals",
                        desc = "Select language scope",
                    },
                },
                -- You can choose the select mode (default is charwise 'v')
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * method: eg 'v' or 'o'
                -- and should return the mode ('v', 'V', or '<c-v>') or a table
                -- mapping query_strings to modes.
                selection_modes = {
                    ["@parameter.outer"] = "v", -- charwise
                    ["@function.outer"] = "V", -- linewise
                    ["@class.outer"] = "<c-v>", -- blockwise
                },
                include_surrounding_whitespace = false,
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]m"] = "@function.outer",
                    ["]]"] = { query = "@class.outer", desc = "Next class start" },
                    ["]o"] = "@loop.inner",
                    ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                    ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                },
                goto_next_end = {
                    ["]M"] = "@function.outer",
                    ["]["] = "@class.outer",
                    ["]O"] = "@loop.inner",
                    ["]S"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                    ["]Z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                },
                goto_previous_start = {
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                    ["[o"] = "@loop.inner",
                    ["[s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                    ["[z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer",
                    ["[O"] = "@loop.inner",
                    ["[S"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                    ["[Z]"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                },
                goto_next = {
                    ["]d"] = "@conditional.outer",
                },
                goto_previous = {
                    ["[d"] = "@conditional.outer",
                },
            },
            lsp_interop = {
                enable = true,
                border = "none",
                floating_preview_opts = {},
                peek_definition_code = {
                    ["<leader>pf"] = "@function.outer",
                    ["<leader>pF"] = "@class.outer",
                },
            },
        },
    })
    require("nvim-treesitter.install").prefer_git = true

    -- auto pairs setup
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")
    npairs.setup({
        check_ts = true,
        ts_config = {
            lua = { "string" }, -- it will not add a pair on that treesitter node
            javascript = { "template_string" },
            java = false, -- don't check treesitter on java
        },
        enable_check_bracket_line = false,
        disable_filetype = filetype.excluded_filetypes,
        -- { "TelescopePrompt", "guihua", "guihua_rust", "clap_input" },
    })
    local ts_conds = require("nvim-autopairs.ts-conds")
    -- press % => %% only while inside a comment or string
    npairs.add_rules({
        Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
        Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
    })
    if vim.o.ft == "clap_input" and vim.o.ft == "guihua" and vim.o.ft == "guihua_rust" then
        require("cmp").setup.buffer({ completion = { enable = false } })
    end

    -- prevent folds after format
    local function has_buffer_target(commands)
        return #vim.tbl_filter(function(item)
            return #vim.tbl_filter(function(target)
                -- Only supports <buffer>, more complicated for things like
                -- <buffer=N>
                return target == "<buffer>"
            end, item.targets or {}) > 0
        end, commands) > 0
    end
    local function augroup(name, commands)
        vim.cmd("augroup " .. name)
        -- Clear autogroup appropraitely for <buffer> targets
        if has_buffer_target(commands) then
            vim.cmd("autocmd! * <buffer>")
        else
            vim.cmd("autocmd!")
        end
        for _, c in ipairs(commands) do
            local command = c.command
            -- if type(command) == "function" then
            --     local fn_id = tap._create(command)
            --     command = string.format("lua tap._execute(%s)", fn_id)
            -- end
            vim.cmd(
                string.format(
                    "autocmd %s %s %s %s",
                    table.concat(c.events, ","),
                    table.concat(c.targets or {}, ","),
                    table.concat(c.modifiers or {}, " "),
                    command
                )
            )
        end
        vim.cmd("augroup END")
    end
    local parsers = require("nvim-treesitter.parsers")
    local configs = parsers.get_parser_configs()
    local ts_fts = vim.tbl_map(function(ft)
        return configs[ft].filetype or ft
    end, parsers.available_parsers())
    augroup("TreesitterFolding", {
        {
            events = { "Filetype" },
            targets = ts_fts,
            command = "setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()",
            -- command = "lua vim.treeesitter.foldexpr()"
        },
    })
end

-- nvim-treesitter/nvim-treesitter-context
M.config_treesitter_context = function()
    require("treesitter-context").setup({
        enable = true,
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 10, -- Maximum number of lines to show for a single context
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = "-", -- "-"
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    })
end

return M
