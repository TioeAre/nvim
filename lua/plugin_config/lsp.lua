local M = {}

function M.vale_add_word_to_accept_txt()
    local diagnostics = vim.diagnostic.get()
    local current_pos = vim.api.nvim_win_get_cursor(0)
    local line = current_pos[1] - 1 -- Lua 的数组是从 1 开始的
    local col = current_pos[2]
    for _, diag in ipairs(diagnostics) do
        if diag.lnum == line and col >= diag.col and col <= diag.end_col then
            -- local word = diag.message
            local word = diag.message:match("'([^']*)'") or diag.message:match('"([^"]*)"')
            local home = os.getenv("HOME")
            local accept_txt_path = home .. "/vale/styles/Vocab/Vale/accept.txt"
            local file = io.open(accept_txt_path, "a")
            if file then
                file:write(word .. "\n")
                file:close()
                print("Added '" .. word .. "' to accept.txt")
                return
            else
                print("Error: Unable to open accept.txt")
                return
            end
        end
    end
    print("No diagnostic found under cursor")
end

-- williamboman/mason.nvim
M.config_mason = function() end

-- williamboman/mason-lspconfig.nvim
M.opts_mason_lspconfig = {}
M.config_mason_lspconfig = function() end

-- neovim/nvim-lspconfig
M.config_lspconfig = function()
    local util = require("lspconfig.util")
    local clangd_root_files = {
        "build/compile_commands.json",
        "compile_commands.json",
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        -- "build",
        "compile_flags.txt",
        "configure.ac", -- AutoTools
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
        "CMakeLists.txt",
        -- ".vscode",
    }
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }
    local servers = {
        bashls = {},
        clangd = {
            root_dir = function(fname)
                return util.root_pattern(unpack(clangd_root_files))(fname) -- or util.find_git_ancestor(fname)
            end,
            -- root_dir = function(fname)
            -- 	return util.root_pattern("compile_commands.json")(fname)
            -- 		or util.root_pattern("build/compile_commands.json")(fname)
            -- end,
            cmd = {
                "clangd",
                "--compile-commands-dir=./build",
            },
        },
        -- cmake = {},
        neocmake = {
            default_config = {
                cmd = { "neocmakelsp", "--stdio" },
                filetypes = { "cmake" },
                root_dir = function(fname)
                    return util.root_pattern(unpack(cmake_root_files))(fname) or util.find_git_ancestor(fname)
                    -- return require("lspconfig").util.find_git_ancestor(fname)
                end,
                single_file_support = true, -- suggested
                init_options = {
                    format = {
                        enable = false,
                    },
                    scan_cmake_in_package = true, -- default is true
                },
            },
            -- capabilities = {
            -- 	workspace = {
            -- 		didChangeWatchedFiles = {
            -- 			dynamicRegistration = true,
            -- 		},
            -- 	},
            -- },
        },
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
            ["<c-h>"] = {
                "<cmd>Lspsaga peek_definition<cr>",
                "lspsaga peek definition",
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
                    "<cmd>Lspsaga finder def+tyd<cr>",
                    -- "<cmd>lua require'telescope.builtin'.lsp_definitions() <cr>",
                    "lspsaga find to (type)definition",
                    buffer = bufnr,
                },
                i = {
                    "<cmd>Lspsaga finder imp<cr>",
                    -- "<cmd>lua require'telescope.builtin'.lsp_implementations() <cr>",
                    "lspsaga find to implementation",
                    buffer = bufnr,
                },
                r = {
                    "<cmd>Lspsaga finder def+ref+imp+tyd<cr>",
                    -- "<cmd>lua require'telescope.builtin'.lsp_references() <cr>",
                    "lspsaga find to references",
                    buffer = bufnr,
                },
            },
            ["<leader>"] = {
                f = {
                    name = "find telescope/todo/undo/buffer/project/dap configurations/lspsaga",
                    l = {
                        "<cmd>Lspsaga finder ++normal def+ref+imp+tyd<cr>",
                        "lspsaga find def+ref+imp",
                    },
                },
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
                    v = {
                        "<cmd>lua require('plugin_config.lsp').vale_add_word_to_accept_txt()<cr>",
                        "lsp vale add word to accept.txt",
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
                    -- "<cmd>lua vim.lsp.buf.type_definition() <cr>",
                    "<cmd>Lspsaga peek_type_definition<cr>",
                    "type definition",
                    buffer = bufnr,
                },
                r = {
                    name = "rename/remove",
                    n = {
                        "<cmd>Lspsaga rename ++project <cr>",
                        "lspsaga smart rename",
                        buffer = bufnr,
                    },
                    a = {
                        "<cmd>Lspsaga project_replace<cr>",
                        "use cmd Lspsaga project_replace old new",
                    },
                },
                o = {
                    name = "open layout/outline/gitgraph",
                    s = { "<cmd>Lspsaga outline<cr>", "open lspsaga outline" },
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
        rename = {
            in_select = false,
        },
        finder = {
            keys = {
                shuttle = "<tab>",
                vsplit = "<C-v>",
                split = "<C-x>",
                tab = "n",
                tabnew = "o",
                toggle_or_open = "<CR>",
                quit = { "<esc>", "q" },
            },
            methods = {
                tyd = "textDocument/typeDefinition",
            },
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
    -- if not require("lspconfig.configs").neocmake then
    --     require("lspconfig.configs").neocmake = {
    --         default_config = {
    --             cmd = { "neocmakelsp", "--stdio" },
    --             filetypes = { "cmake" },
    --             root_dir = function(fname)
    --                 return util.root_pattern(unpack(cmake_root_files))(fname) -- or util.find_git_ancestor(fname)
    --             end,
    --             single_file_support = true, -- suggested
    --             on_attach = on_attach, -- on_attach is the on_attach function you defined
    --             init_options = {
    --                 -- format = {
    --                 --     enable = true
    --                 -- }
    --                 scan_cmake_in_package = true, -- default is true
    --             },
    --             capabilities = {
    --                 workspace = {
    --                     didChangeWatchedFiles = {
    --                         dynamicRegistration = true,
    --                     },
    --                 },
    --             },
    --         },
    --     }
    --     require("lspconfig").neocmake.setup({})
    -- end

    -- WhoIsSethDaniel/mason-tool-installer.nvim
    require("mason-tool-installer").setup({
        ensure_installed = {
            "shellcheck",
            -- "clangtidy",
            "cmakelint",
            "hadolint",
            -- "djlint",
            "htmlhint",
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
            "write_good",
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
    -- dnlhc/glance.nvim
    local glance = require("glance")
    local actions = glance.actions
    glance.setup({
        height = 8, -- Height of the window
        zindex = 35,
        -- By default glance will open preview "embedded" within your active window
        -- when `detached` is enabled, glance will render above all existing windows
        -- and won't be restiricted by the width of your active window
        -- Or use a function to enable `detached` only when the active window is too small
        -- detached = false,
        detached = function(winid)
            return vim.api.nvim_win_get_width(winid) < 80
        end,
        preview_win_opts = { -- Configure preview window options
            cursorline = true,
            number = true,
            wrap = true,
        },
        border = {
            enable = false, -- Show window borders. Only horizontal borders allowed
            top_char = "―",
            bottom_char = "―",
        },
        list = {
            position = "right", -- Position of the list window 'left'|'right'
            width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5
        },
        theme = { -- This feature might not work properly in nvim-0.7.2
            enable = true, -- Will generate colors for the plugin based on your current colorscheme
            mode = "auto", -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
        },
        mappings = {
            list = {
                ["j"] = actions.next, -- Bring the cursor to the next item in the list
                ["k"] = actions.previous, -- Bring the cursor to the previous item in the list
                ["<Down>"] = actions.next,
                ["<Up>"] = actions.previous,
                ["<Tab>"] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
                ["<S-Tab>"] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
                ["<c-u>"] = actions.preview_scroll_win(5),
                ["<c-d>"] = actions.preview_scroll_win(-5),
                ["<c-v>"] = actions.jump_vsplit,
                ["<c-x>"] = actions.jump_split,
                ["t"] = actions.jump_tab,
                ["<CR>"] = actions.jump,
                ["o"] = actions.jump,
                ["l"] = actions.open_fold,
                ["h"] = actions.close_fold,
                ["<c-l>"] = actions.enter_win("preview"), -- Focus preview window
                ["q"] = actions.close,
                ["Q"] = actions.close,
                ["<Esc>"] = actions.close,
                ["<C-q>"] = actions.quickfix,
                -- ['<Esc>'] = false -- disable a mapping
            },
            preview = {
                ["q"] = actions.close,
                ["Q"] = actions.close,
                ["<Tab>"] = actions.next_location,
                ["<S-Tab>"] = actions.previous_location,
                ["<c-l>"] = actions.enter_win("list"), -- Focus list window
            },
        },
        hooks = {},
        folds = {
            fold_closed = "",
            fold_open = "",
            folded = true, -- Automatically fold list on startup
        },
        indent_lines = {
            enable = true,
            icon = "│",
        },
        winbar = {
            enable = true, -- Available strating from nvim-0.8+
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
