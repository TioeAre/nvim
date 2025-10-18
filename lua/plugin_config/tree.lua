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
            folders_first = true,
            files_first = false,
        },
        view = {
            cursorline = true,
            side = "left",
            signcolumn = "yes",
            width = 35, -- need to be modified
            float = {
                enable = false,
                quit_on_focus_loss = true,
                open_win_config = {
                    relative = "editor",
                    border = "rounded",
                    width = 30,
                    height = 30,
                    row = 1,
                    col = 1,
                },
            },
        },
        renderer = {
            group_empty = true,
            indent_width = 2,
            symlink_destination = true,
            highlight_opened_files = "none",
            highlight_modified = "none",
            indent_markers = {
                enable = true,
                inline_arrows = true,
                icons = {
                    corner = "└",
                    edge = "│",
                    item = "│",
                    bottom = "─",
                    none = " ",
                },
            },
            icons = {
                web_devicons = {
                    file = {
                        enable = true,
                        color = true,
                    },
                    folder = {
                        enable = true,
                        color = true,
                    },
                },
                git_placement = "after",
                modified_placement = "after",
                diagnostics_placement = "signcolumn",
                bookmarks_placement = "signcolumn",
                padding = " ",
                symlink_arrow = " ➛ ",
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true,
                    modified = true,
                    diagnostics = true,
                    bookmarks = true,
                },
                glyphs = {
                    default = "",
                    symlink = "",
                    bookmark = "󰆤",
                    modified = "●",
                    folder = {
                        arrow_closed = "",
                        arrow_open = "",
                        default = "",
                        open = "",
                        empty = "",
                        empty_open = "",
                        symlink = "",
                        symlink_open = "",
                    },
                    git = {
                        unstaged = "✗",
                        staged = "✓",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "★",
                        deleted = "",
                        ignored = "◌",
                    },
                },
            },
        },
        auto_reload_on_write = true,
        prefer_startup_root = false,
        -- ahmedkhalf/project.nvim
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
            enable = true,
            update_root = false,
        },
    })
end

-- hedyhli/outline.nvim
M.opts_outline = {}
M.config_outline = function()
    require("outline").setup({
        outline_window = {
            position = "right",
            -- The default split commands used are 'topleft vs' and 'botright vs'
            -- depending on `position`. You can change this by providing your own
            -- `split_command`.
            -- `position` will not be considered if `split_command` is non-nil.
            -- This should be a valid vim command used for opening the split for the
            -- outline window. Eg, 'rightbelow vsplit'.
            split_command = nil,
            width = 22,
            relative_width = true,
            auto_close = false,
            auto_jump = false,
            jump_highlight_duration = 300,
            center_on_jump = true,
            show_numbers = false,
            show_relative_numbers = false,
            wrap = false,
            -- true/false/'focus_in_outline'/'focus_in_code'.
            show_cursorline = true,
            hide_cursor = false,
            focus_on_open = false,
            winhl = "",
        },

        outline_items = {
            show_symbol_details = true,
            -- Show corresponding line numbers of each symbol on the left column as
            -- virtual text, for quick navigation when not focused on outline.
            -- Why? See this comment:
            -- https://github.com/simrat39/symbols-outline.nvim/issues/212#issuecomment-1793503563
            show_symbol_lineno = true,
            highlight_hovered_item = true,
            auto_set_cursor = true,
            -- Autocmd events to automatically trigger these operations.
            auto_update_events = {
                follow = { "CursorMoved" },
                items = { "InsertLeave", "WinEnter", "BufEnter", "BufWinEnter", "TabEnter", "BufWritePost" },
            },
        },
        guides = {
            enabled = true,
            markers = {
                bottom = "└",
                middle = "├",
                vertical = "│",
            },
        },
        symbol_folding = {
            autofold_depth = 1,
            auto_unfold = {
                hovered = true,
                only = true,
            },
            markers = { "", "" },
        },

        preview_window = {
            auto_preview = false,
            open_hover_on_preview = true,
            width = 50,     -- Percentage or integer of columns
            min_width = 35, -- This is the number of columns
            relative_width = true,
            -- Border option for floating preview window.
            -- Options include: single/double/rounded/solid/shadow or an array of border
            -- characters.
            -- See :help nvim_open_win() and search for "border" option.
            border = "rounded",
            -- winhl options for the preview window, see ':h winhl'
            winhl = "NormalFloat:",
            -- Pseudo-transparency of the preview window, see ':h winblend'
            winblend = 0,
            -- Experimental feature that let's you edit the source content live
            -- in the preview window. Like VS Code's "peek editor".
            live = true,
        },

        -- These keymaps can be a string or a table for multiple keys.
        -- Set to `{}` to disable. (Using 'nil' will fallback to default keys)
        keymaps = {
            show_help = "?",
            close = { "<Esc>", "Q" },
            goto_location = "<Cr>",
            peek_location = "o",
            goto_and_close = "<S-Cr>",
            restore_location = "<C-g>",
            -- Open LSP/provider-dependent symbol hover information
            hover_symbol = "<C-h>",
            -- Preview location code of the symbol under cursor
            toggle_preview = "K",
            rename_symbol = "r",
            code_actions = "a",
            fold = "h",
            unfold = "l",
            fold_toggle = { "<Tab>", "za" },
            fold_toggle_all = { "<S-Tab>", "zA" },
            fold_all = "zc",
            unfold_all = "zo",
            fold_reset = "zr",
            -- Move down/up by one line and peek_location immediately.
            -- You can also use outline_window.auto_jump=true to do this for any
            -- j/k/<down>/<up>.
            down_and_jump = "<C-j>",
            up_and_jump = "<C-k>",
        },

        providers = {
            priority = { "lsp", "coc", "markdown", "norg" },
            lsp = {
                -- Lsp client names to ignore
                blacklist_clients = {},
            },
        },

        symbols = {
            -- Filter by kinds (string) for symbols in the outline.
            -- Possible kinds are the Keys in the icons table below.
            -- A filter list is a string[] with an optional exclude (boolean) field.
            -- The symbols.filter option takes either a filter list or ft:filterList
            -- key-value pairs.
            -- Put  exclude=true  in the string list to filter by excluding the list of
            -- kinds instead.
            -- Include all except String and Constant:
            --   filter = { 'String', 'Constant', exclude = true }
            -- Only include Package, Module, and Function:
            --   filter = { 'Package', 'Module', 'Function' }
            -- See more examples below.
            filter = {
                default = {
                    "String",
                    exclude = true,
                },
            },
            -- You can use a custom function that returns the icon for each symbol kind.
            -- This function takes a kind (string) as parameter and should return an
            -- icon as string.
            icon_fetcher = nil,
            -- 3rd party source for fetching icons. Fallback if icon_fetcher returned
            -- empty string. Currently supported values: 'lspkind'
            icon_source = nil,
            -- The next fallback if both icon_fetcher and icon_source has failed, is
            -- the custom mapping of icons specified below. The icons table is also
            -- needed for specifying hl group.
            icons = {
                File = {
                    icon = "󰈔",
                    hl = "Identifier",
                },
                Module = {
                    icon = "󰆧",
                    hl = "Include",
                },
                Namespace = {
                    icon = "󰅪",
                    hl = "Include",
                },
                Package = {
                    icon = "󰏗",
                    hl = "Include",
                },
                Class = {
                    icon = "𝓒",
                    hl = "Type",
                },
                Method = {
                    icon = "ƒ",
                    hl = "Function",
                },
                Property = {
                    icon = "",
                    hl = "Identifier",
                },
                Field = {
                    icon = "󰆨",
                    hl = "Identifier",
                },
                Constructor = {
                    icon = "",
                    hl = "Special",
                },
                Enum = {
                    icon = "ℰ",
                    hl = "Type",
                },
                Interface = {
                    icon = "󰜰",
                    hl = "Type",
                },
                Function = {
                    icon = "",
                    hl = "Function",
                },
                Variable = {
                    icon = "",
                    hl = "Constant",
                },
                Constant = {
                    icon = "",
                    hl = "Constant",
                },
                String = {
                    icon = "𝓐",
                    hl = "String",
                },
                Number = {
                    icon = "#",
                    hl = "Number",
                },
                Boolean = {
                    icon = "⊨",
                    hl = "Boolean",
                },
                Array = {
                    icon = "󰅪",
                    hl = "Constant",
                },
                Object = {
                    icon = "⦿",
                    hl = "Type",
                },
                Key = {
                    icon = "🔐",
                    hl = "Type",
                },
                Null = {
                    icon = "NULL",
                    hl = "Type",
                },
                EnumMember = {
                    icon = "",
                    hl = "Identifier",
                },
                Struct = {
                    icon = "𝓢",
                    hl = "Structure",
                },
                Event = {
                    icon = "🗲",
                    hl = "Type",
                },
                Operator = {
                    icon = "+",
                    hl = "Identifier",
                },
                TypeParameter = {
                    icon = "𝙏",
                    hl = "Identifier",
                },
                Component = {
                    icon = "󰅴",
                    hl = "Function",
                },
                Fragment = {
                    icon = "󰅴",
                    hl = "Constant",
                },
                TypeAlias = {
                    icon = " ",
                    hl = "Type",
                },
                Parameter = {
                    icon = " ",
                    hl = "Identifier",
                },
                StaticMethod = {
                    icon = " ",
                    hl = "Function",
                },
                Macro = {
                    icon = " ",
                    hl = "Function",
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

M.config_venv = function()
    -- linux-cultist/venv-selector.nvim
    require("venv-selector").setup(
        {
            picker = "snacks",
            --     -- Your options go here
            --     name = { "venv" },
            --     auto_refresh = true,
            --     path = nil,
            --     dap_enabled = true,
            --     parents = 4,
            --     anaconda_base_path = "/home/tioeare/anaconda3",
            --     anaconda_envs_path = "/home/tioeare/anaconda3/envs",
        }
    )
end

-- j-morano/buffer_manager.nvim
M.config_buffer_manager = function()
    require("buffer_manager").setup({
        line_keys = "1234567890",
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
        focus_alternate_buffer = false,
        width = 0.4,
        hight = 0.4,
        short_file_names = false,
        short_term_names = false,
        loop_nav = true,
        highlight = "",
        win_extra_options = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
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
