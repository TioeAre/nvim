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
            width = 30, -- need to be modified
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
                git_placement = "before",
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
    -- vim.api.nvim_exec([[autocmd VimEnter * NvimTreeToggle]], false)
    local function open_nvim_tree(data)
        local real_file = vim.fn.filereadable(data.file) == 1
        local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
        if not real_file then -- and not no_name then
            return
        end
        require("nvim-tree.api").tree.toggle({
            focus = false,
            find_file = true,
        })
    end
    vim.api.nvim_create_autocmd({ "VimEnter" }, {
        callback = open_nvim_tree,
    })
end
M.keys_nvim_tree = {
    -- {
    --     "<leader>tt",
    --     ":NvimTreeToggle<cr>", -- 打开/关闭树
    --     desc = "Open or close the tree. See |nvim-tree-api.tree.toggle()|"
    -- }, {
    --     "<leader>tf",
    --     ":NvimTreeFindFile<cr>", -- 定位当前文件
    --     desc = "The command will change the cursor in the tree for the current bufname."
    -- }, {
    --     "<leader>tr",
    --     ":NvimTreeRefresh<cr>", -- 刷新树
    --     desc = "Refresh the tree. See |nvim-tree-api.tree.reload()|"
    -- }, {
    --     "<leader>tc",
    --     ":NvimTreeCollapse<cr>", -- 折叠树
    --     desc = "Collapses the nvim-tree recursively."
    -- }
}

-- nvim-neo-tree/neo-tree.nvim
M.config_neo_tree = function()
    -- If you want icons for diagnostic errors, you'll need to define them somewhere:
    vim.fn.sign_define("DiagnosticSignError", {
        text = " ",
        texthl = "DiagnosticSignError",
    })
    vim.fn.sign_define("DiagnosticSignWarn", {
        text = " ",
        texthl = "DiagnosticSignWarn",
    })
    vim.fn.sign_define("DiagnosticSignInfo", {
        text = " ",
        texthl = "DiagnosticSignInfo",
    })
    vim.fn.sign_define("DiagnosticSignHint", {
        text = "󰌵",
        texthl = "DiagnosticSignHint",
    })

    require("neo-tree").setup({
        close_if_last_window = false,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
        -- sort_function = nil, -- use a custom function for sorting files and directories in the tree
        sort_function = function(a, b)
            if a.type == b.type then
                return a.path > b.path
            else
                return a.type < b.type
            end
        end, -- this sorts files and directories descendantly
        default_component_configs = {
            container = {
                enable_character_fade = true,
            },
            indent = {
                indent_size = 2,
                padding = 1, -- extra padding on left hand side
                -- indent guides
                with_markers = true,
                indent_marker = "│",
                last_indent_marker = "└",
                highlight = "NeoTreeIndentMarker",
                -- expander config, needed for nesting files
                with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
            },
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "󰜌",
                -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                -- then these will never be used.
                default = "*",
                highlight = "NeoTreeFileIcon",
            },
            modified = {
                symbol = "[+]",
                highlight = "NeoTreeModified",
            },
            name = {
                trailing_slash = false,
                use_git_status_colors = true,
                highlight = "NeoTreeFileName",
            },
            git_status = {
                symbols = {
                    -- Change type
                    added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                    modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
                    deleted = "✖", -- this can only be used in the git_status source
                    renamed = "󰁕", -- this can only be used in the git_status source
                    -- Status type
                    untracked = "",
                    ignored = "",
                    unstaged = "󰄱",
                    staged = "",
                    conflict = "",
                },
            },
            -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
            file_size = {
                enabled = true,
                required_width = 64, -- min width of window required to show this column
            },
            type = {
                enabled = false,
                required_width = 122, -- min width of window required to show this column
            },
            last_modified = {
                enabled = true,
                required_width = 88, -- min width of window required to show this column
            },
            created = {
                enabled = false,
                required_width = 110, -- min width of window required to show this column
            },
            symlink_target = {
                enabled = true,
            },
        },
        -- A list of functions, each representing a global custom command
        -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
        -- see `:h neo-tree-custom-commands-global`
        commands = {},
        window = {
            position = "left",
            width = 30,
            mapping_options = {
                noremap = true,
                nowait = true,
            },
            mappings = {
                ["<tab>"] = {
                    "toggle_node",
                    nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
                },
                ["<2-LeftMouse>"] = "open",
                ["<cr>"] = "open",
                ["<esc>"] = "cancel", -- close preview or floating neo-tree window
                ["K"] = {
                    "toggle_preview",
                    config = {
                        use_float = true,
                        use_image_nvim = true,
                    },
                },
                -- Read `# Preview Mode` for more information
                ["l"] = "focus_preview",
                ["<c-h>"] = "split_with_window_picker",
                ["<c-v>"] = "vsplit_with_window_picker",
                -- ["S"] = "split_with_window_picker",
                -- ["s"] = "vsplit_with_window_picker",
                ["o"] = "open",
                -- ["<cr>"] = "open_drop",
                -- ["t"] = "open_tab_drop",
                ["w"] = "open_with_window_picker",
                -- ["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
                -- ["za"] = "close_node",
                -- ['C'] = 'close_all_subnodes',
                ["<leader>zc"] = "close_all_nodes",
                ["<leader>zo"] = "expand_all_nodes",
                ["a"] = {
                    "add",
                    -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
                    -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                    config = {
                        show_path = "none", -- "none", "relative", "absolute"
                    },
                },
                ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
                ["d"] = "delete",
                ["r"] = "rename",
                ["y"] = "copy_to_clipboard",
                ["x"] = "cut_to_clipboard",
                ["p"] = "paste_from_clipboard",
                ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
                -- ["c"] = {
                --  "copy",
                --  config = {
                --    show_path = "none" -- "none", "relative", "absolute"
                --  }
                -- }
                ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
                ["q"] = "close_window",
                ["R"] = "refresh",
                ["?"] = "show_help",
                ["<"] = "prev_source",
                [">"] = "next_source",
                ["i"] = "show_file_details",
            },
        },
        nesting_rules = {},
        filesystem = {
            filtered_items = { -- TODO: test
                visible = true, -- when true, they will just be displayed differently than normal items
                hide_dotfiles = true,
                hide_gitignored = true,
                hide_hidden = false, -- only works on Windows for hidden files/directories
                hide_by_name = {
                    ".history",
                },
                hide_by_pattern = { -- uses glob style patterns
                    -- "*.meta",
                    -- "*/src/*/tsconfig.json",
                },
                always_show = { -- remains visible even if other settings would normally hide it
                    "venv",
                    ".vscode",
                },
                never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                    -- ".DS_Store",
                    -- "thumbs.db"
                },
                never_show_by_pattern = { -- uses glob style patterns
                    -- ".null-ls_*",
                },
            },
            follow_current_file = {
                enabled = true, -- This will find and focus the file in the active buffer every time the current file is changed while the tree is open.
                leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
            },
            group_empty_dirs = false, -- when true, empty folders will be grouped together
            hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
            -- in whatever position is specified in window.position
            -- "open_current",  -- netrw disabled, opening a directory opens within the
            -- window like netrw would, regardless of window.position
            -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
            use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
            -- instead of relying on nvim autocmd events.
            window = {
                mappings = {
                    ["<bs>"] = "navigate_up",
                    ["<c-]>"] = "set_root",
                    ["H"] = "toggle_hidden",
                    ["/"] = "fuzzy_finder",
                    ["D"] = "fuzzy_finder_directory",
                    ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
                    -- ["D"] = "fuzzy_sorter_directory",
                    ["f"] = "filter_on_submit",
                    ["<c-x>"] = "clear_filter",
                    ["[g"] = "prev_git_modified",
                    ["]g"] = "next_git_modified",
                    ["<c-o>"] = {
                        "show_help",
                        nowait = false,
                        config = {
                            title = "Order by",
                            prefix_key = "o",
                        },
                    },
                    ["tc"] = {
                        "order_by_created",
                        nowait = false,
                    },
                    ["td"] = {
                        "order_by_diagnostics",
                        nowait = false,
                    },
                    ["tg"] = {
                        "order_by_git_status",
                        nowait = false,
                    },
                    ["tm"] = {
                        "order_by_modified",
                        nowait = false,
                    },
                    ["tn"] = {
                        "order_by_name",
                        nowait = false,
                    },
                    ["ts"] = {
                        "order_by_size",
                        nowait = false,
                    },
                    ["tt"] = {
                        "order_by_type",
                        nowait = false,
                    },
                },
                fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
                    ["<down>"] = "move_cursor_down",
                    ["<C-j>"] = "move_cursor_down",
                    ["<up>"] = "move_cursor_up",
                    ["<C-k>"] = "move_cursor_up",
                },
            },
            commands = {}, -- Add a custom command or override a global one using the same function name
        },
        buffers = {
            follow_current_file = {
                enabled = true, -- This will find and focus the file in the active buffer every time
                --              -- the current file is changed while the tree is open.
                leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
            },
            group_empty_dirs = true, -- when true, empty folders will be grouped together
            show_unloaded = true,
            window = {
                mappings = {
                    ["bd"] = "buffer_delete",
                    ["<bs>"] = "navigate_up",
                    ["<c-]>"] = "set_root",
                    ["<c-o>"] = {
                        "show_help",
                        nowait = false,
                        config = {
                            title = "Order by",
                            prefix_key = "o",
                        },
                    },
                    ["tc"] = {
                        "order_by_created",
                        nowait = false,
                    },
                    ["td"] = {
                        "order_by_diagnostics",
                        nowait = false,
                    },
                    ["tm"] = {
                        "order_by_modified",
                        nowait = false,
                    },
                    ["tn"] = {
                        "order_by_name",
                        nowait = false,
                    },
                    ["ts"] = {
                        "order_by_size",
                        nowait = false,
                    },
                    ["tt"] = {
                        "order_by_type",
                        nowait = false,
                    },
                },
            },
        },
        git_status = {
            window = {
                position = "float",
                mappings = {
                    ["<leader>A"] = "git_add_all",
                    ["<leader>tu"] = "git_unstage_file",
                    ["<leader>to"] = "git_add_file",
                    ["<leader>tr"] = "git_revert_file",
                    ["<leader>tc"] = "git_commit",
                    ["<leader>tp"] = "git_push",
                    ["gg"] = "git_commit_and_push",
                    ["<c-o>"] = {
                        "show_help",
                        nowait = false,
                        config = {
                            title = "Order by",
                            prefix_key = "o",
                        },
                    },
                    ["tc"] = {
                        "order_by_created",
                        nowait = false,
                    },
                    ["td"] = {
                        "order_by_diagnostics",
                        nowait = false,
                    },
                    ["tm"] = {
                        "order_by_modified",
                        nowait = false,
                    },
                    ["tn"] = {
                        "order_by_name",
                        nowait = false,
                    },
                    ["ts"] = {
                        "order_by_size",
                        nowait = false,
                    },
                    ["tt"] = {
                        "order_by_type",
                        nowait = false,
                    },
                },
            },
        },
    })
    vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
end

-- simrat39/symbols-outline.nvim
M.opts_outline = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = false,
    position = "right",
    relative_width = false,
    width = 27,
    auto_close = false,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = true,
    preview_bg_highlight = "Pmenu",
    autofold_depth = nil,
    auto_unfold_hover = true,
    fold_markers = { "", "" },
    wrap = false,
    keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = { "<Esc>", "q" },
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        toggle_preview = "K",
        rename_symbol = "r",
        code_actions = "a",
        fold = "h",
        unfold = "l",
        fold_all = "zc",
        unfold_all = "zo",
        fold_reset = "zr",
    },
    lsp_blacklist = {},
    symbol_blacklist = {},
    symbols = {
        File = { icon = "", hl = "@text.uri" },
        Module = { icon = "", hl = "@namespace" },
        Namespace = { icon = "N", hl = "@namespace" },
        Package = { icon = "", hl = "@namespace" },
        Class = { icon = "𝓒", hl = "@type" },
        Method = { icon = "ƒ", hl = "@method" },
        Property = { icon = "", hl = "@method" },
        Field = { icon = "F", hl = "@field" },
        Constructor = { icon = "", hl = "@constructor" },
        Enum = { icon = "ℰ", hl = "@type" },
        Interface = { icon = "ﰮ", hl = "@type" },
        Function = { icon = "", hl = "@function" },
        Variable = { icon = "", hl = "@constant" },
        Constant = { icon = "", hl = "@constant" },
        String = { icon = "𝓐", hl = "@string" },
        Number = { icon = "#", hl = "@number" },
        Boolean = { icon = "⊨", hl = "@boolean" },
        Array = { icon = "a", hl = "@constant" },
        Object = { icon = "⦿", hl = "@type" },
        Key = { icon = "🔐", hl = "@type" },
        Null = { icon = "NULL", hl = "@type" },
        EnumMember = { icon = "", hl = "@field" },
        Struct = { icon = "𝓢", hl = "@type" },
        Event = { icon = "🗲", hl = "@type" },
        Operator = { icon = "+", hl = "@operator" },
        TypeParameter = { icon = "𝙏", hl = "@parameter" },
        Component = { icon = "", hl = "@function" },
        Fragment = { icon = "", hl = "@constant" },
    },
}
M.config_outline = function()
    require("symbols-outline").setup()
end

-- ahmedkhalf/project.nvim
M.config_project = function()
    require("project_nvim").setup({
        detection_methods = { "lsp", "pattern" },
        patterns = {
            ".git",
            "_darcs",
            ".hg",
            ".bzr",
            ".svn",
            "Makefile",
            "package.json",
            "CMakeLists.txt",
            "makefile",
            "cmakelists.txt",
            "MAKEFILE",
            ".vscode",
            ".idea",
            "venv",
            "requirements.txt",
            "devel",
        },
        show_hidden = false,
    })
end

return M
