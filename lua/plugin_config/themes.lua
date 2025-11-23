local M = {}
local themes_utils = require("utils.themes")
local themes_vars = require("variables.themes")

-- local colors = require("tokyonight.colors")
M.theme_config = function()
    -- vim.cmd("colorscheme catppuccin") -- tokyonight-storm tokyonight-day catppuccin catppuccin-latte onedark  onelight
    vim.cmd("colorscheme Eva-Light-Bold")
    -- require("catppuccin").setup({
    --     integrations = {
    --         alpha = true,
    --         cmp = true,
    --         dap = true,
    --         dap_ui = true,
    --         dropbar = {
    --             enabled = false,
    --             color_mode = false, -- enable color for kind's texts, not just kind's icons
    --         },
    --         flash = true,
    --         gitsigns = true,
    --         illuminate = true,
    --         lsp_trouble = true,
    --         nvimtree = true,
    --         noice = true,
    --         rainbow_delimiters = true,
    --         snacks = {
    --             enabled = true,
    --             indent_scope_color = "latte", -- catppuccin color (eg. `lavender`) Default: text
    --         },
    --         symbols_outline = true,
    --         telescope = true,
    --         treesitter = true,
    --         window_picker = true,
    --         which_key = true,
    --         -- aerial = true,
    --         -- indent_blankline = {
    --         --     enabled = true,
    --         --     -- scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
    --         --     colored_indent_levels = true,
    --         -- },
    --         -- lsp_saga = true,
    --         -- mini = {
    --         --     enabled = true,
    --         --     indentscope_color = "",
    --         -- },
    --         -- notify = true,
    --         -- outline = true,
    --         -- ufo = true,
    --     },
    --     highlight_overrides = {
    --         mocha = function(cp)
    --             return {
    --                 -- folke/trouble.nvim
    --                 TroubleNormal = { bg = cp.base },
    --             }
    --         end,
    --         latte = function(cp)
    --             return {
    --                 -- folke/trouble.nvim
    --                 TroubleNormal = { bg = cp.base },
    --             }
    --         end,
    --         frappe = function(cp)
    --             return {
    --                 -- folke/trouble.nvim
    --                 TroubleNormal = { bg = cp.base },
    --             }
    --         end,
    --         macchiato = function(cp)
    --             return {
    --                 -- folke/trouble.nvim
    --                 TroubleNormal = { bg = cp.base },
    --             }
    --         end,
    --     },
    -- })
end
-- local colors = require("catppuccin.colors").setup()

-- nvim-lualine/lualine.nvim
M.config_lualine = function()
    require("lualine").setup({
        options = {
            theme = "ayu_light",
            globalstatus = true,
            component_separators = {
                left = ">",
                right = "<",
            },
            section_separators = {
                left = "",
                right = "",
            },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = {
                "branch",
                {
                    "filename",
                    file_status = true,     -- Displays file status (readonly status, modified status)
                    newfile_status = false, -- Display new file status (new file means no write after created)
                    path = 1,               -- 0: Just the filename
                    -- 1: Relative path
                    -- 2: Absolute path
                    -- 3: Absolute path, with tilde as the home directory
                    -- 4: Filename and parent dir, with tilde as the home directory
                    shorting_target = 30, -- Shortens path to leave 40 spaces in the window
                    -- for other components. (terrible name, any suggestions?)
                    symbols = {
                        modified = "[+]",      -- Text to show when the file is modified.
                        readonly = "[x]",      -- Text to show when the file is non-modifiable or readonly.
                        unnamed = "[No Name]", -- Text to show for unnamed buffers.
                        newfile = "[*]",       -- Text to show for newly created file before first write
                    },
                },
            },
            lualine_c = {
                {
                    function()
                        local utc8_time = os.time() + 8 * 3600 -- UTC+8 offset in seconds
                        return os.date("%a %d/%b %H:%M:%S", utc8_time)
                    end,
                },
            },
            lualine_y = {
                {
                    function()
                        local ok, plugin = pcall(require, 'lsp-progress')
                        if ok then
                            return plugin.progress()
                        end
                        return ''
                    end,
                },
                "whichpy",
                "diff",
                "diagnostics",
                "filesize",
                "encoding",
            },
            lualine_z = {
                "fileformat",
                "filetype",
                "progress",
                "location"
            },
        },
        tabline = {},
        extensions = {
            "quickfix",
            "fzf",
            "lazy",            -- "mason",
            "nvim-dap-ui",
            "nvim-tree",       -- "outline",
            "symbols-outline", -- "aerial",
            "toggleterm",
            "trouble",
        },
    })
end

-- akinsho/bufferline.nvim
M.config_bufferline = function()
    vim.opt.termguicolors = true
    require("bufferline").setup({
        options = {
            enforce_regular_tabs = false,
            move_wraps_at_ends = true,
            color_icons = true,
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_tab_indicators = false,
            show_duplicate_prefix = true,
            always_show_bufferline = true,
            numbers = "buffer_id",
            groups = {
                items = {
                    require("bufferline.groups").builtin.pinned:with({
                        icon = "",
                    }),
                },
            },
            offsets = {
                {
                    filetype = "neo-tree",
                    text = function()
                        return "󰙅  " .. vim.fn.getcwd()
                    end,
                    highlight = "Directory",
                    separator = true, -- use a "true" to enable the default, or set your own character
                },
                {
                    filetype = "filetree",
                    text = "",
                    highlight = "Explorer",
                    text_align = "left",
                },
                {
                    filetype = "NvimTree",
                    text = function()
                        return "󰙅  " .. vim.fn.getcwd()
                    end,
                    highlight = "Directory",
                    separator = true,
                },
                {
                    filetype = 'snacks_layout_box',
                    -- text = '󰙅  File Explorer',
                    text = function()
                        return "󰙅  " .. vim.fn.getcwd()
                    end,
                    separator = true,
                }
            },
            name_formatter = themes_utils.name_formatter,
        },
    })
    vim.g.transparent_groups = vim.list_extend(
        vim.g.transparent_groups or {},
        vim.tbl_map(function(v)
            return v.hl_group
        end, vim.tbl_values(require("bufferline.config").highlights))
    )
end

-- goolord/alpha-nvim
M.config_alpha = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = themes_vars.dashboard

    dashboard.section.buttons.val = {
        dashboard.button("l", "🖫  > last layout", "<cmd>SessionLoadLast<cr>"), -- "<cmd>lua require('persistence').load()<CR>"),
        dashboard.button("s", "🖪  > layouts", "<cmd>Telescope persisted<cr>"), -- "<cmd>lua require('persistence').load()<CR>"),
        dashboard.button("p", "🗟  > projects", "<cmd>lua require'telescope'.extensions.projects.projects{}<CR>"),
        dashboard.button("r", "   > recent", ":Telescope oldfiles<CR>"),
        dashboard.button("e", "   > new file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "🗒  > find file", ":Telescope find_files<CR>"),
        dashboard.button("q", "🖬  > quit nvim", ":qa<CR>"),
    }
    alpha.setup(dashboard.opts)
    -- require("alpha").setup(require("alpha.themes.dashboard").config)
end

-- b0o/incline.nvim
M.config_incline = function()
    require("incline").setup({
        render = themes_utils.render,
        window = {
            padding = {
                left = 0,
                right = 0,
            },
            margin = {
                horizontal = 0,
                vertical = 1,
            },
            winhighlight = {
                active = {
                    Normal = "InclineActive",
                },
                inactive = {
                    Normal = "InclineInactive",
                },
            },
        },
        highlight = {
            groups = {
                InclineNormal = { guibg = "#ab6f60", gui = "bold" },
                InclineNormalNC = {
                    default = true,
                    group = "NormalFloat",
                },
                InclineActive = { guibg = "FF5F3737", gui = "bold" },
                InclineInactive = {
                    default = true,
                    group = "NormalFloat",
                },
            },
        },
        hide = {
            cursorline = true,
        },
    })
end

-- xiyaowong/transparent.nvim
M.config_transparent = function()
    vim.cmd([[hi StatusLine ctermbg=0 cterm=NONE]])
    require("transparent").setup({
        extra_groups = { "CursorLine", "NormalFloat", "TablineFill" },
    })
    --  require('transparent').clear_prefix('BufferLine')
    --  require('transparent').clear_prefix('lualine')
    require("transparent").clear_prefix("NvimTree")
    vim.cmd("TransparentEnable")
end

-- folke/noice.nvim
M.opt_noice = {}
M.config_noice = function()
    require("noice").setup({
        lsp = {
            progress = {
                enabled = false,
            },
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = true,         -- use a classic bottom cmdline for search
            command_palette = false,      -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false,           -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
    })
    -- nvim-lualine/lualine.nvim
    require("lualine").setup({
        sections = {
            lualine_x = {
                {
                    require("noice").api.status.search.get,
                    cond = require("noice").api.status.search.has,
                    color = {
                        fg = "#ff9e64",
                    },
                },
                {
                    require("noice").api.status.command.get,
                    cond = require("noice").api.status.command.has,
                    color = {
                        fg = "#ff9e64",
                    },
                },
                {
                    function()
                        local max_length = 50 -- 设置最大长度
                        local text = require("noice").api.status.message.get_hl()
                        if #text > max_length then
                            return text:sub(1, max_length) .. " ..." -- 截断字符串并添加省略号
                        else
                            return text
                        end
                    end,
                    cond = require("noice").api.status.message.has,
                },
            },
        }
    })
end

-- rcarriga/nvim-notify
M.config_notify = function()
    require("notify").setup({
        background_color = "#404040fa",
    })
end

-- stevearc/dressing.nvim
M.opts_dressing = {}
M.config_dressing = function()
    require("dressing").setup({
        input = {
            insert_only = true,
            start_in_insert = true,
        }
    })
end

-- petertriho/nvim-scrollbar
M.config_nvim_scrollbar = function()
    require("scrollbar").setup()
    require("scrollbar.handlers.search").setup()
    require("scrollbar.handlers.gitsigns").setup()
end

return M
