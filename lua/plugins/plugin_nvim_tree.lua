local config_nvim_tree = function()
    vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=None]])
    require("nvim-tree").setup({
        filters = {
            dotfiles = false
        },
        sort = {
            sorter = "case_sensitive",
            folders_first = true,
            files_first = false
        },
        view = {
            cursorline = true,
            side = "left",
            signcolumn = "yes",
            width = 30, -- TODO: need to be modified
            float = {
                enable = false,
                quit_on_focus_loss = true,
                open_win_config = {
                    relative = "editor",
                    border = "rounded",
                    width = 30,
                    height = 30,
                    row = 1,
                    col = 1
                }
            }
        },
        renderer = {
            group_empty = true,
            indent_width = 2,
            symlink_destination = true,
            highlight_opened_files = "none", -- TODO: need to be modified
            highlight_modified = "none",
            indent_markers = {
                enable = true,
                inline_arrows = true,
                icons = {
                    corner = "└",
                    edge = "│",
                    item = "│",
                    bottom = "─",
                    none = " "
                }
            },
            icons = {
                web_devicons = {
                    file = {
                        enable = true,
                        color = true
                    },
                    folder = {
                        enable = true,
                        color = true
                    }
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
                    bookmarks = true
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
                        symlink_open = ""
                    },
                    git = {
                        unstaged = "✗",
                        staged = "✓",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "★",
                        deleted = "",
                        ignored = "◌"
                    }
                }
            }
        },
        auto_reload_on_write = true,
        prefer_startup_root = false,
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true
        },
    })
    vim.api.nvim_exec([[autocmd VimEnter * NvimTreeToggle]], false)
end

local config_project = function()
    require("project_nvim").setup({
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "CMakeLists.txt", "makefile", "cmakelists.txt", "MAKEFILE", ".vscode" },
        show_hidden = false,
      })
end

return {{
    "nvim-tree/nvim-tree.lua",
    dependencies = {'nvim-tree/nvim-web-devicons'},
    lazy = false,
    config = config_nvim_tree,
    keys = {{
        "<leader>tt",
        ":NvimTreeToggle<cr>", -- 打开/关闭树
        desc = "Open or close the tree. See |nvim-tree-api.tree.toggle()|"
    }, {
        "<leader>tf",
        ":NvimTreeFindFile<cr>", -- 定位当前文件
        desc = "The command will change the cursor in the tree for the current bufname."
    }, {
        "<leader>tr",
        ":NvimTreeRefresh<cr>", -- 刷新树
        desc = "Refresh the tree. See |nvim-tree-api.tree.reload()|"
    }, {
        "<leader>tc",
        ":NvimTreeCollapse<cr>", -- 折叠树
        desc = "Collapses the nvim-tree recursively."
    }}},
    {
        'ahmedkhalf/project.nvim',
        config = config_project,
    }
}
