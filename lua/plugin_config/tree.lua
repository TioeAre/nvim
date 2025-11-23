local M = {}

-- nvim-tree/nvim-tree.lua
M.config_nvim_tree = function()
    vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=None]])
    require("nvim-tree").setup({
        filters = {
            git_ignored = false,
            dotfiles = false,
            git_clean = false,
            no_buffer = false,
            no_bookmark = false,
            custom = { ".history" },
            exclude = { "venv", ".vscode", ".idea" },
        },
        sort = {
            sorter = "filetype", -- "case_sensitive"},
        },
        view = {
            width = 35, -- need to be modified
        },
        renderer = {
            group_empty = true,
            indent_markers = {
                enable = true,
            },
            icons = {
                web_devicons = {
                    folder = {
                        enable = true,
                    },
                },
                git_placement = "after",
                modified_placement = "after",
            },
        },
        prefer_startup_root = false,
        -- ahmedkhalf/project.nvim
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
            enable = true,
            update_root = false, -- false
        },
    })
end

-- hedyhli/outline.nvim
M.opts_outline = {}
M.config_outline = function()
    require("outline").setup({
        outline_window = {
            width = 22,
            relative_width = true,
            auto_close = false,
            auto_jump = false,
            focus_on_open = false,
        },

        outline_items = {
            show_symbol_lineno = true,
        },

        preview_window = {
            width = 50,     -- Percentage or integer of columns
            min_width = 35, -- This is the number of columns
            relative_width = true,
            border = "rounded",
            live = true,
        },

        keymaps = {
            hover_symbol = "<C-h>",
            fold_toggle = { "<Tab>", "za" },
            fold_toggle_all = { "<S-Tab>", "zA" },
            fold_all = "zc",
            unfold_all = "zo",
            fold_reset = "zr",
        },

        providers = {
            priority = { "lsp", "coc", "markdown", "norg" },
            lsp = {
                blacklist_clients = {},
            },
        },

        symbols = {
            filter = {
                default = {
                    "String",
                    exclude = true,
                },
            },
        },
    })
end

-- ahmedkhalf/project.nvim
M.config_project = function()
    require("project_nvim").setup({
        manual_mode = true,
        detection_methods = { "lsp", "pattern" },
        patterns = {
            -- ".git",
            -- "_darcs",
            -- ".hg",
            -- ".bzr",
            -- ".svn", -- "Makefile",
            -- "package.json",
            -- "CMakeLists.txt", -- "makefile",
            -- "cmakelists.txt",
            -- "MAKEFILE",
            -- ".vscode",
            ".idea", -- "venv",
            "requirements.txt",
            "devel",
            "build",
            ".gitignore",
        },
        exclude_dirs = {
            "**/src/**",
            "**/lua/**",
            "**/scripts/**",
            "**/build/**",
            "**/devel/**",
            os.getenv("HOME"),
            "/home/tioeare",
            "/home/linuxbrew/",
            "/home/Systemback/",
        },
        show_hidden = true,
        silent_chdir = false,
    })
end

-- neolooong/whichpy.nvim
M.config_whichpy = {
    picker = {
        name = "telescope",
    },
    locator = {
        workspace = {
            display_name = "Workspace",
            search_pattern = ".*env.*",
            depth = 2,
            ignore_dirs = {
                ".git",
                ".mypy_cache",
                ".pytest_cache",
                ".ruff_cache",
                "__pycache__",
                "__pypackages__",
            },
        },
        global = {
            display_name = "Global",
        },
        global_virtual_environment = {
            display_name = "Global Virtual Environment",
            dirs = {
                -- { path, vim.uv.os_uname().sysname }
                "~/envs",
                "~/.direnv",
                "~/.venvs",
                "~/.virtualenvs",
                "~/.local/share/virtualenvs",
                { "~/Envs", "Windows_NT" }, -- only search on Windows
                vim.env.WORKON_HOME,
            }
        },
        pyenv = {
            display_name = "Pyenv",
            venv_only = true,
        },
        poetry = {
            display_name = "Poetry",
        },
        pdm = {
            display_name = "PDM",
        },
        conda = {
            display_name = "Conda",
        },
        uv = { -- disabled by default
            display_name = "uv",
        },
    },
}
-- j-morano/buffer_manager.nvim
M.config_buffer_manager = function()
    require("buffer_manager").setup({
        select_menu_item_commands = {
            edit = {
                key = "<cr>",
                command = "edit",
            },
            v = {
                key = "<C-v>",
                command = "vsplit",
            },
            h = {
                key = "<C-x>",
                command = "split",
            },
        },
        width = 0.4,
        height = 0.4,
    })
    local opts = { noremap = true }
    local map = vim.keymap.set
    local bmui = require("buffer_manager.ui")
    local keys = "1234567890"
    for i = 1, #keys do
        local key = keys:sub(i, i)
        map("n", string.format("<leader>%s", key), function()
            bmui.nav_file(i)
        end, opts)
    end
end

return M
