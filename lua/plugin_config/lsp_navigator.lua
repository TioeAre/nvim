local M = {}
local W = require("utils.windows_ignore")
local filetypes = require("utils.filetype")

-- williamboman/mason.nvim
M.config_mnson = function() end

-- williamboman/mason-lspconfig.nvim
M.opts_mason_lspconfig = {}
M.config_mason_lspconfig = function() end

-- neovim/nvim-lspconfig
M.config_lspconfig = function()
    require("neoconf").setup()
    require("mason").setup({
        ui = {
            icons = {
                width = 0.6,
                height = 0.7,
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
        -- pip = {
        -- 	upgrade_pip = false,
        -- 	install_args = { "--proxy", "http://127.0.0.1:7890" },
        -- },
        PATH = "append",
    })
    require("mason-tool-installer").setup({
        ensure_installed = {
            "shellcheck", -- "clangtidy",
            "cmakelint",
            "hadolint",
            "htmlhint",
            "jsonlint",
            W.windows_ignore_list("luacheck"),
            "flake8",   -- "yamllint",
            "beautysh", -- "shfmt", -- "clang-format",
            "prettier",
            "xmlformatter",
            "latexindent",
            "stylua", -- "autopep8",
        },
    })
    -- require("mason-nvim-dap").setup({
    --     ensure_installed = { "bash-debug-adapter", "cpptools", "debugpy", "mockdebug" },
    -- })

    local util = vim.lsp.config.util
    local clangd_root_files = {
        "build/compile_commands.json",
        "compile_commands.json",
        ".clangd",
        ".clang-tidy",
        ".clang-format", -- "build",
        "compile_flags.txt",
        "configure.ac",  -- AutoTools
        -- "CMakeLists.txt",
        -- "Makefile",
        -- ".catkin_workspace",
        -- "devel",
        -- ".vscode",
    }
    local cmake_root_files = {
        "build/compile_commands.json",
        "compile_commands.json",
        "src/CMakeLists.txt",
        "devel",
        "build",
        "CMakeLists.txt", -- ".vscode",
    }
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = true,
        lineFoldingOnly = true,
    }
    local user_lspconfig_servers = {
        clangd = {
            root_dir = function(fname)
                return util.root_pattern(unpack(clangd_root_files))(fname) -- or util.find_git_ancestor(fname)
            end,
            cmd = {
                "clangd",
                "--compile-commands-dir=./build",
            },
        },
        neocmake = {
            default_config = {
                cmd = { "neocmakelsp", "--stdio" },
                filetypes = { "cmake" },
                root_dir = function(fname)
                    return util.root_pattern(unpack(cmake_root_files))(fname) or util.find_git_ancestor(fname)
                    -- return vim.lsp.config.util.find_git_ancestor(fname)
                end,
                single_file_support = true, -- suggested
                init_options = {
                    format = {
                        enable = false,
                    },
                    scan_cmake_in_package = true, -- default is true
                },
            },
        },
        docker_compose_language_service = {},
        lemminx = {},
        matlab_ls = {},
        bashls = {},
        pyright = {},
        lua_ls = {
            settings = {
                Lua = {
                    telemetry = { enable = false },
                    -- make the language server recognize "vim" global
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        -- make language server aware of runtime files
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        },
        dockerls = {},
        html = {},
        jsonls = {},
        yamlls = {},
    }
    local on_attach = function(client, bufnr)
        -- package.loaded["navigator.lspclient.mapping"] = require("plugin_config.navigator_mapping")
        require("navigator.lspclient.mapping").setup({ client = client, bufnr = bufnr })
        require("navigator.dochighlight").documentHighlight(bufnr)
        require("navigator.codeAction").code_action_prompt(bufnr)
        local wk = require("which-key")
        if client.name == "pyright" then
            wk.add({
                mode = "n",
                {
                    "<leader>oi",
                    "<cmd> PyrightOrganizeImports <cr>",
                    desc = "PyrightOrganizeImports",
                },
            })
        end
    end

    local exclude_servers = { "ltex" }
    local installed_servers = vim.tbl_keys(user_lspconfig_servers)
    local filtered_servers = {}
    for _, server in ipairs(installed_servers) do
        if not vim.tbl_contains(exclude_servers, server) then
            table.insert(filtered_servers, server)
        end
    end
    require("mason-lspconfig").setup({
        ensure_installed = filtered_servers,
    })
    -- neovim/nvim-lspconfig
    for server, config in pairs(user_lspconfig_servers) do
        vim.lsp.config[server] = {
            vim.tbl_deep_extend("keep", {
                on_attach = on_attach,
                capabilities = capabilities,
            }, config)
        }
    end

    require("ltex_extra").setup({
        load_langs = { "en-US", "zh-CN" },
        init_check = true,
        -- path = "",
        log_level = "none",
        server_opts = {
            capabilities = capabilities,
            on_attach = on_attach,
        },
    })
    local navigator_servers = {
        bashls = {},
        dockerls = {},
        pyright = {},
        lua_ls = {
            settings = {
                Lua = {
                    telemetry = { enable = false },
                    -- make the language server recognize "vim" global
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        -- make language server aware of runtime files
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        },
        html = {},
        jsonls = {},
        yamlls = {},

        clangd = {
            root_dir = function(fname)
                return util.root_pattern(unpack(clangd_root_files))(fname) -- or util.find_git_ancestor(fname)
            end,
            cmd = {
                "clangd",
                "--compile-commands-dir=./build",
            },
        },
        neocmake = {
            default_config = {
                cmd = { "neocmakelsp", "--stdio" },
                filetypes = { "cmake" },
                root_dir = function(fname)
                    return util.root_pattern(unpack(cmake_root_files))(fname) or util.find_git_ancestor(fname)
                    -- return vim.lsp.config.util.find_git_ancestor(fname)
                end,
                single_file_support = true, -- suggested
                init_options = {
                    format = {
                        enable = false,
                    },
                    scan_cmake_in_package = true, -- default is true
                },
            },
        },
        docker_compose_language_service = {},
        lemminx = {},
        matlab_ls = {},
    }
    require("navigator").setup({
        ts_fold = {
            enable = true,
            max_lines_scan_comments = 99,
            disable_filetypes = filetypes.excluded_filetypes,
        },
        icons = {
            icons = true,
            code_action_icon = "󰌵",
            diagnostic_head = "❃",
            diagnostic_head_severity_1 = "",
            fold = {
                prefix = "⚡",
                separator = "", -- e.g. shows   3 lines 
            },
        },
        lsp = {
            enable = true,
            document_highlight = true,
            format_on_save = false,
            disable_lsp = "all", -- navigator_disable_lsp,
            servers = vim.tbl_keys(navigator_servers),
            hover = {
                enable = false,
            },
        },
    })

    local diagnostic_signs = {
        Error = " ",
        Warn = " ",
        Hint = "❃",
        Info = "",
    }
    for type, icon in pairs(diagnostic_signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, {
            text = icon,
            texthl = hl,
            numhl = "",
        })
    end

    local function show_only_one_sign_in_sign_column()
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
    -- call
    show_only_one_sign_in_sign_column()
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        signs = true,
        underline = true,
        virtual_text = {
            spacing = 4,
            -- severity_limit = "Warning",
            -- virt_text_priority = 15,
        },
        update_in_insert = true,
    })
    -- vim.diagnostic.config({
    -- 	severity_sort = true,
    -- 	signs = {
    -- 		severity_limit = "Warning",
    -- 	},
    -- })
end

-- ray-x/navigator.lua
M.config_navigator = function()
    require 'navigator'.setup({
        debug = false,         -- log output, set to true and log path: ~/.cache/nvim/gh.log
        width = 0.75,          -- max width ratio (number of cols for the floating window) / (window width)
        height = 0.3,          -- max list window height, 0.3 by default
        preview_height = 0.35, -- max height of preview windows
        ts_fold = {
            enable = true,
            -- comment_fold = true,
            max_lines_scan_comments = 99,
            disable_filetypes = filetypes.excluded_filetypes,
        },
        default_mapping = false,
        keymaps = {
            {
                model = { 'n', 'x' },
                key = 'K',
                func = require('navigator.hover').hover,
                desc = "hover_doc"
            },
            {
                model = "n",
                key = "<c-h>",
                func = require('navigator.definition').definition_preview,
                desc = "lsp peek definition",
            },
            {
                model = "n",
                key = "<c-k>",
                func = vim.lsp.buf.signature_help,
                desc = "Signature Documentation",
            },
            {
                model = "n",
                key = "gD",
                func = vim.lsp.buf.declaration,
                desc = "go to declaration",

            },
            {
                model = "n",
                key = "gd",
                func = require('navigator.definition').definition,
                desc = "lsp find definition",

            },
            {
                model = "n",
                key = "gi",
                func = require('navigator.implementation').implementation,
                desc = "lsp find implementation",

            },
            {
                model = "n",
                key = "gr",
                func = require('navigator.reference').reference,
                desc = "lsp find references",

            },
            {
                model = "n",
                key = "<leader>fl",
                func = require('navigator.reference').reference,
                desc = "lspsaga find def+ref+imp+tyd",
            },
            {
                model = "n",
                key = "<leader>wa",
                func = vim.lsp.buf.add_workspace_folder,
                desc = "lsp workspace add folder",

            },
            {
                model = "n",
                key = "<leader>wr",
                func = vim.lsp.buf.remove_workspace_folder,
                desc = "lsp workspace remove folder",

            },
            {
                model = "n",
                key = "<leader>wl",
                func = function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end,
                desc = "lsp workspace list folder",

            },

            {
                model = "n",
                key = "<leader>ca",
                func = require('navigator.codeAction').code_action,
                desc = "available code actions",

            },
            {
                model = "n",
                key = "<leader>da",
                func = require('navigator.diagnostics').goto_prev,
                desc = "lsp diagnostic_jump_prev",
            },
            {
                model = "n",
                key = "<leader>dw",
                func = require('navigator.diagnostics').goto_next,
                desc = "lsp diagnostic_jump_next",
            },

            {
                model = "n",
                key = "<leader>D",
                func = require('navigator.definition').type_definition_preview,
                desc = "lsp type definition",

            },
            {
                model = "n",
                key = "<leader>rn",
                func = require('navigator.rename').rename,
                desc = "lsp rename",

            },

            {
                model = "n",
                key = "<leader>osd",
                func = require('navigator.symbols').document_symbols,
                desc = "open lsp document_symbols",
            },
            {
                model = "n",
                key = "<leader>oso",
                func = require('navigator.hierarchy').outgoing_calls,
                desc = "lsp outgoing calls",
            },
            {
                model = "n",
                key = "<leader>osi",
                func = require('navigator.hierarchy').incoming_calls,
                desc = "lsp incoming calls",
            },
            {
                model = "n",
                key = "[e",
                func = require('navigator.diagnostics').goto_prev,
                desc = "lsp diagnostic_jump_prev",
            },
            {
                model = "n",
                key = "]e",
                func = require('navigator.diagnostics').goto_next,
                desc = "lsp diagnostic_jump_next",
            },
        },
        treesitter_analysis = true,
        treesitter_navigation = true,
        treesitter_analysis_max_num = 100,   -- how many items to run treesitter analysis
        treesitter_analysis_condense = true, -- condense form for treesitter analysis
        -- this value prevent slow in large projects, e.g. found 100000 reference in a project
        transparency = 50,
        lsp_signature_help = true,
        signature_help_cfg = nil,
        icons = {
            icons = true,
            code_action_icon = "󰌵",
            diagnostic_head = "❃",
            diagnostic_head_severity_1 = "",
            fold = {
                prefix = "⚡",
                separator = "", -- e.g. shows   3 lines 
            },
        },
        lsp = {
            enable = false,
            code_action = { enable = true, sign = true, sign_priority = 40, virtual_text = true },
            code_lens_action = { enable = true, sign = true, sign_priority = 40, virtual_text = true },
            document_highlight = true, -- LSP reference highlight,
            format_on_save = false,
            format_options = { async = false },
            diagnostic = {
                underline = true,
                virtual_text = { spacing = 3, source = true },
                update_in_insert = true,
                severity_sort = { reverse = true },
                float = {
                    focusable = false,
                    style = 'minimal',
                    border = 'rounded',
                    source = 'always',
                    header = '',
                    prefix = '',
                },
                virtual_lines = {
                    current_line = false, -- show diagnostic only on current line
                },
                -- register = 'D',           -- yank the error into register
            },

            hover = {
                enable = false,
            },

            -- diagnostic_scrollbar_sign = { '▃', '▆', '█' }, -- experimental:  diagnostic status in scroll bar area; set to false to disable the diagnostic sign, for other style, set to {'╍', 'ﮆ'} or {'-', '='}
            diagnostic_virtual_text = true, -- show virtual for diagnostic message
            diagnostic_update_in_insert = true, -- update diagnostic message in insert mode
            display_diagnostic_qf = true, -- always show quickfix if there are diagnostic errors, set to false if you want to ignore it
            -- set to 'trouble' to show diagnostcs in Trouble
        }
    })
end
-- VidocqH/lsp-lens.nvim
M.config_lsp_lens = function()
    local SymbolKind = vim.lsp.protocol.SymbolKind
    require("lsp-lens").setup({
        enable = true,
        include_declaration = true, -- Reference include declaration
        sections = {                -- Enable / Disable specific request, formatter example looks 'Format Requests'
            definition = true,
            references = true,
            implements = true,
            -- git_authors = true,
            git_authors = function(latest_author, count)
                return " " .. latest_author .. (count - 1 == 0 and "" or (" + " .. count - 1))
            end,
        },
        ignore_filetype = filetypes.excluded_filetypes,
        -- Target Symbol Kinds to show lens information
        target_symbol_kinds = { SymbolKind.Function, SymbolKind.Method, SymbolKind.Interface },
        -- Symbol Kinds that may have target symbol kinds as children
        wrapper_symbol_kinds = { SymbolKind.Class, SymbolKind.Struct },
    })
end

-- https://git.sr.ht/~whynothugo/lsp_lines.nvim
M.config_whynothugo_lsp_lens = function()
    require("lsp_lines").setup({
        -- virtual_text = false,
        virtual_lines = {
            only_current_line = false,
            highlight_whole_line = false,
        },
    })
    vim.cmd("lua require('lsp_lines').toggle()")
end

return M
