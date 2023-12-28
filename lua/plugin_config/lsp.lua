local M = {}

-- williamboman/mason.nvim
M.config_mason = function() end

-- williamboman/mason-lspconfig.nvim
M.opts_mason_lspconfig = {}
M.config_mason_lspconfig = function() end

-- neovim/nvim-lspconfig
M.config_lspconfig = function()
    local util = require("lspconfig.util")
    local clangd_root_files = {
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "./build/compile_commands.json",
        "compile_flags.txt",
        "configure.ac", -- AutoTools
        "CMakeLists.txt",
        "Makefile",
        ".catkin_workspace",
        "devel",
        ".vscode",
    }
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local servers = {
        bashls = {},
        clangd = {
            root_dir = function(fname)
                return util.root_pattern(unpack(clangd_root_files))(fname) or util.find_git_ancestor(fname)
            end,
        },
        cmake = {},
        dockerls = {},
        docker_compose_language_service = {},
        html = {},
        jsonls = {},
        ltex = {},
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
        marksman = {},
        pyright = {},
        lemminx = {},
        yamlls = {},
    }
    local on_attach = function(client, bufnr)
        local wk = require("which-key")

        wk.register({
            K = {
                "<cmd>Lspsaga hover_doc <cr>",
                "show documentation for what is under cursor",
                buffer = bufnr,
            },
            ["<c-k>"] = {
                "<cmd>lua vim.lsp.buf.signature_help() <cr>",
                "Signature Documentation",
                buffer = bufnr,
            },
            g = {
                name = "go to declaration/definitions/implementations/references",
                D = { "<cmd>lua vim.lsp.buf.declaration() <cr>", "go to declaration", buffer = bufnr },
                d = {
                    "<cmd>lua require'telescope.builtin'.lsp_definitions() <cr>",
                    "go to definition",
                    buffer = bufnr,
                },
                i = {
                    "<cmd>lua require'telescope.builtin'.lsp_implementations() <cr>",
                    "go to implementation",
                    buffer = bufnr,
                },
                r = {
                    "<cmd>lua require'telescope.builtin'.lsp_references() <cr>",
                    "go to references",
                    buffer = bufnr,
                },
            },
            ["<leader>"] = {
                w = {
                    name = "workspace",
                    a = {
                        "<cmd>lua vim.lsp.buf.add_workspace_folder() <cr>",
                        "workspace add folder",
                        buffer = bufnr,
                    },
                    r = {
                        "<cmd>lua vim.lsp.buf.remove_workspace_folder() <cr>",
                        "workspace remove folder",
                        buffer = bufnr,
                    },
                    l = {
                        function()
                            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                        end,
                        "workspace list folder",
                        buffer = bufnr,
                    },
                },
                c = {
                    name = "close/code action",
                    a = {
                        "<cmd>Lspsaga code_action <cr>",
                        "see available code actions",
                        buffer = bufnr,
                    },
                },
                d = {
                    name = "diagnostics/type_definition",
                    a = {
                        "<cmd>lua require'telescope.builtin'.diagnostics() <cr>",
                        "diagnostics",
                        buffer = bufnr,
                    },
                },
                D = {
                    "<cmd>lua vim.lsp.buf.type_definition() <cr>",
                    "type definition",
                    buffer = bufnr,
                },
                r = {
                    name = "rename/remove",
                    n = {
                        "<cmd>Lspsaga rename ++project <cr>",
                        "smart rename",
                        buffer = bufnr,
                    },
                },
            },
        })

        if client.name == "pyright" then
            wk.register({
                ["<leader>"] = {
                    o = {
                        name = "organize",
                        i = {
                            "<cmd>PyrightOrganizeImports <cr>",
                            "PyrightOrganizeImports",
                        },
                    },
                },
            })
        end
    end
    -- red setup()
    require("neoconf").setup()
    require("neodev").setup({
        library = { plugins = { "nvim-dap-ui" }, types = true },
    })
    require("fidget").setup()
    require("lspsaga").setup({
        -- keybindings for navigation in lspsaga window
        move_in_saga = { prev = "<C-k>", next = "<C-j>" },
        -- use enter to open file with finder
        finder_action_keys = {
            open = "<CR>",
        },
        -- use enter to open file with definition preview
        definition_action_keys = {
            edit = "<CR>",
        },
    })
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
        pip = {
            upgrade_pip = false,
            install_args = { "--proxy", "http://127.0.0.1:7890" },
        },
    })
    require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
    })
    -- neovim/nvim-lspconfig
    for server, config in pairs(servers) do
        require("lspconfig")[server].setup(vim.tbl_deep_extend("keep", {
            on_attach = on_attach,
            capabilities = capabilities,
        }, config))
    end
    -- WhoIsSethDaniel/mason-tool-installer.nvim
    require("mason-tool-installer").setup({
        ensure_installed = {
            "shellcheck",
            -- "clangtidy",
            "cmakelint",
            "hadolint",
            "djlint",
            "jsonlint",
            "luacheck",
            "vale",
            "flake8",
            "yamllint",
            "shfmt",
            "clang-format",
            "prettier",
            "xmlformatter",
            "latexindent",
            "stylua",
            "autopep8",
        },
    })
    -- jay-babu/mason-nvim-dap.nvim
    require("mason-nvim-dap").setup({
        ensure_installed = {
            "bash-debug-adapter",
            "cpptools",
            "debugpy",
            "mockdebug",
        },
    })

    local diagnostic_signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = "" }
    for type, icon in pairs(diagnostic_signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
end

-- VidocqH/lsp-lens.nvim
M.config_lsp_lens = function()
    local SymbolKind = vim.lsp.protocol.SymbolKind
    require("lsp-lens").setup({
        enable = true,
        include_declaration = false, -- Reference include declaration
        sections = { -- Enable / Disable specific request, formatter example looks 'Format Requests'
            definition = false,
            references = true,
            implements = true,
            git_authors = true,
        },
        ignore_filetype = {},
        -- Target Symbol Kinds to show lens information
        target_symbol_kinds = { SymbolKind.Function, SymbolKind.Method, SymbolKind.Interface },
        -- Symbol Kinds that may have target symbol kinds as children
        wrapper_symbol_kinds = { SymbolKind.Class, SymbolKind.Struct },
    })
end

return M
