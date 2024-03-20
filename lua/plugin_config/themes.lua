local M = {}

-- local colors = require("tokyonight.colors")
M.theme_config = function()
    vim.cmd("colorscheme catppuccin") -- tokyonight-storm tokyonight-day catppuccin catppuccin-latte onedark  onelight
    require("catppuccin").setup({
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            notify = true,
            alpha = true,
            flash = true,
            lsp_saga = true,
            dap = true,
            dap_ui = true,
            -- ufo = true,
            window_picker = true,
            -- outline = true,
            symbols_outline = true,
            -- aerial = true,
            telescope = true,
            lsp_trouble = true,
            illuminate = true,
            which_key = true,
            rainbow_delimiters = true,
            indent_blankline = {
                enabled = true,
                scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
                colored_indent_levels = false,
            },
            -- mini = {
            --     enabled = true,
            --     indentscope_color = "",
            -- },
        },
        highlight_overrides = {
            mocha = function(cp)
                return {
                    -- folke/trouble.nvim
                    TroubleNormal = { bg = cp.base },
                }
            end,
            latte = function(cp)
                return {
                    -- folke/trouble.nvim
                    TroubleNormal = { bg = cp.base },
                }
            end,
            frappe = function(cp)
                return {
                    -- folke/trouble.nvim
                    TroubleNormal = { bg = cp.base },
                }
            end,
            macchiato = function(cp)
                return {
                    -- folke/trouble.nvim
                    TroubleNormal = { bg = cp.base },
                }
            end,
        },
    })
end
-- local colors = require("catppuccin.colors").setup()

-- nvim-lualine/lualine.nvim
M.config_lualine = function()
    -- local colors = {
    -- 	yellow = "#ECBE7B",
    -- 	cyan = "#008080",
    -- 	darkblue = "#081633",
    -- 	green = "#98be65",
    -- 	orange = "#FF8800",
    -- 	violet = "#a9a1e1",
    -- 	magenta = "#c678dd",
    -- 	blue = "#51afef",
    -- 	red = "#ec5f67",
    -- }
    local function lsp_client_names()
        local client_names = {}
        for _, client in ipairs(vim.lsp.get_active_clients()) do
            table.insert(client_names, client.name)
        end
        return table.concat(client_names, ",")
    end
    -- require("weather").setup({
    --     openweathermap = {
    --         app_id = {
    --             var_name = "70e55ee4c82cef2997c087aa6540d9b8",
    --             value = "70e55ee4c82cef2997c087aa6540d9b8",
    --         },
    --     },
    --     -- default = "openweathermap",
    -- })

    require("lualine").setup({
        options = {
            theme = "catppuccin",
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
                    file_status = true, -- Displays file status (readonly status, modified status)
                    newfile_status = false, -- Display new file status (new file means no write after created)
                    path = 1, -- 0: Just the filename
                    -- 1: Relative path
                    -- 2: Absolute path
                    -- 3: Absolute path, with tilde as the home directory
                    -- 4: Filename and parent dir, with tilde as the home directory
                    shorting_target = 30, -- Shortens path to leave 40 spaces in the window
                    -- for other components. (terrible name, any suggestions?)
                    symbols = {
                        modified = "[+]", -- Text to show when the file is modified.
                        readonly = "[x]", -- Text to show when the file is non-modifiable or readonly.
                        unnamed = "[No Name]", -- Text to show for unnamed buffers.
                        newfile = "[*]", -- Text to show for newly created file before first write
                    },
                },
            },
            lualine_c = {
                -- "os.date('%A %B/%d %H:%M:%S')",
                {
                    function()
                        local utc8_time = os.time() + 8 * 3600 -- UTC+8 offset in seconds
                        return os.date("%a %d/%b %H:%M:%S", utc8_time)
                    end,
                },
                -- {
                --     require("weather.lualine").custom(weather_format, { pending = "羽", error = "" }),
                --     -- require('weather.lualine').default_c()
                -- },
            },

            lualine_x = {
                {
                    require("noice").api.status.search.get,
                    cond = require("noice").api.status.search.has,
                    color = {
                        fg = "#ff9e64",
                    },
                },
                -- {
                -- 	require("noice").api.status.mode.get,
                -- 	cond = require("noice").api.status.mode.has,
                -- 	color = { fg = "#ff9e64" },
                -- },
                {
                    require("noice").api.status.command.get,
                    cond = require("noice").api.status.command.has,
                    color = {
                        fg = "#ff9e64",
                    },
                },
                {
                    -- require("noice").api.status.message.get_hl,
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
            lualine_y = {
                "diff",
                "diagnostics",
                "filesize",
                "encoding",
                "fileformat",
                {
                    'swenv',
                    icon = "",
                },
                lsp_client_names,
                -- {
                -- 	"lsp_progress",
                -- 	display_components = { "lsp_client_name", "spinner", { "title", "percentage", "message" } },
                -- 	colors = {
                -- 		percentage = colors.cyan,
                -- 		title = colors.cyan,
                -- 		message = colors.cyan,
                -- 		spinner = colors.cyan,
                -- 		lsp_client_name = colors.magenta,
                -- 		use = true,
                -- 	},
                -- 	timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
                -- },
                "filetype",
            },
            lualine_z = { "progress", "location" },
        },
        tabline = {},
        extensions = {
            "quickfix",
            "fzf",
            "lazy", -- "mason",
            "nvim-dap-ui",
            "nvim-tree", -- "outline",
            "symbols-outline", -- "aerial",
            "toggleterm",
            "trouble",
        },
    })
end
-- akinsho/bufferline.nvim
function M.get_all_buffer_filenames()
    local filenames = {}
    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
        -- if vim.api.nvim_buf_is_loaded(buf) and not vim.api.nvim_buf_get_option(buf, "buflisted") then
        --     -- Optionally, you can add additional checks here to prevent closing certain types of buffers.
        --     vim.api.nvim_buf_delete(buf, { force = true })
        -- end
        if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
            local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
            if filename ~= "" then
                filenames[filename] = (filenames[filename] or 0) + 1
            end
        end
    end
    return filenames
end
function M.name_formatter(buf)
    local path = buf.path or ""
    local filename = vim.fn.fnamemodify(path, ":t")
    local tail = vim.fn.fnamemodify(path, ":p:h:t")
    local all_filenames = M.get_all_buffer_filenames()
    if all_filenames[filename] and all_filenames[filename] > 1 then
        return tail .. "/" .. filename
    else
        return filename
    end
end
M.config_bufferline = function()
    local mocha = require("catppuccin.palettes").get_palette("mocha")
    local latte = require("catppuccin.palettes").get_palette("latte")
    require("bufferline").setup({
        highlights = require("catppuccin.groups.integrations.bufferline").get({
            styles = { "italic", "bold" },
            custom = {
                all = {
                    fill = {
                        bg = "#000000",
                    },
                },
                mocha = {
                    background = {
                        fg = mocha.text,
                    },
                },
                latte = {
                    background = {
                        fg = latte.text,
                    },
                },
            },
        }),
        options = {
            mode = "buffers", -- "buffers" "tabs"
            move_wraps_at_ends = true,
            color_icons = true,
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_tab_indicators = false,
            show_duplicate_prefix = false,
            always_show_bufferline = true,
            hover = {
                enabled = true,
                delay = 200,
                reveal = { "close" },
            },
            numbers = function(opts)
                return string.format("%s|%s", opts.id, opts.raise(opts.ordinal))
            end,
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
                        return vim.fn.getcwd()
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
                        return vim.fn.getcwd()
                    end,
                    highlight = "Directory",
                    separator = true, -- use a "true" to enable the default, or set your own character
                },
            },
            name_formatter = M.name_formatter,
            --          function(buf)
            -- 	local path = buf.path or ""
            -- 	local filename = vim.fn.fnamemodify(path, ":t")
            -- 	local tail = vim.fn.fnamemodify(path, ":p:h:t")
            -- 	local all_filenames = M.get_all_buffer_filenames()
            -- 	if all_filenames[filename] and all_filenames[filename] > 1 then
            -- 		return tail .. "/" .. filename
            -- 	else
            -- 		return filename
            -- 	end
            -- end,
        },
    })
    vim.g.transparent_groups = vim.list_extend(
        vim.g.transparent_groups or {},
        vim.tbl_map(function(v)
            return v.hl_group
        end, vim.tbl_values(require("bufferline.config").highlights))
    )
    -- require("close_buffers").setup({
    -- 	filetype_ignore = {}, -- Filetype to ignore when running deletions
    -- 	file_glob_ignore = {}, -- File name glob pattern to ignore when running deletions (e.g. '*.md')
    -- 	file_regex_ignore = {}, -- File name regex pattern to ignore when running deletions (e.g. '.*[.]md')
    -- 	preserve_window_layout = { "this", "nameless" }, -- Types of deletion that should preserve the window layout
    -- 	next_buffer_cmd = function(windows)
    -- 		require("bufferline").cycle(1)
    -- 		local bufnr = vim.api.nvim_get_current_buf()
    -- 		for _, window in ipairs(windows) do
    -- 			vim.api.nvim_win_set_buf(window, bufnr)
    -- 		end
    -- 	end, -- Custom function to retrieve the next buffer when preserving window layout
    -- })
end
M.keys_bufferline = {
    -- {
    --     "<leader>bn",
    --     ":BufferLineCycleNext<cr>", -- 切换到下一个buffer
    --     desc = "change to next buffer"
    -- }, {
    --     "<leader>bm",
    --     ":BufferLineCyclePrev<cr>",   -- 切换到上一个buffer
    --     desc = "change to preview buffer"
    -- },
    -- {
    --     "<leader>bcr",
    --     ":BufferLineCloseRight<cr>",
    --     desc = "close right buffers"
    -- }, {
    --     "<leader>bcf",
    --     ":BufferLineCloseLeft<cr>",
    --     desc = "close left buffers"
    -- }, {
    --     "<leader>bco",
    --     ":BufferLineCloseOthers<cr>",
    --     desc = "close other buffers"
    -- },
    -- {
    --     "<leader>bg",
    --     ":BufferLinePick<cr>",
    --     desc = "go to certain buffer"
    -- },
    -- {
    --     "<leader>bD",
    --     ":BufferLinePickClose<cr>",
    --     desc = "close certain buffer"
    -- }
}

-- goolord/alpha-nvim
M.config_alpha = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val =
        { -- [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
            -- [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⣠⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
            -- [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣡⣾⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣟⠻⣿⣿⣿⣿⣿⣿⣿⣿]],
            -- [[⣿⣿⣿⣿⣿⣿⣿⣿⡿⢫⣷⣿⣿⣿⣿⣿⣿⣿⣾⣯⣿⡿⢧⡚⢷⣌⣽⣿⣿⣿⣿⣿⣶⡌⣿⣿⣿⣿⣿⣿]],
            -- [[⣿⣿⣿⣿⣿⣿⣿⣿⠇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⣇⣘⠿⢹⣿⣿⣿⣿⣿⣻⢿⣿⣿⣿⣿⣿]],
            -- [[⣿⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⣿⡇⣿⣿⣿⣿⣿⣿⣿⣿⡟⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣻⣿⣿⣿⣿]],
            -- [[⣿⣿⣿⣿⣿⣿⣿⡇⠀⣬⠏⣿⡇⢻⣿⣿⣿⣿⣿⣿⣿⣷⣼⣿⣿⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⢻⣿⣿⣿⣿]],
            -- [[⣿⣿⣿⣿⣿⣿⣿⠀⠈⠁⠀⣿⡇⠘⡟⣿⣿⣿⣿⣿⣿⣿⣿⡏⠿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣇⣿⣿⣿⣿]],
            -- [[⣿⣿⣿⣿⣿⣿⡏⠀⠀⠐⠀⢻⣇⠀⠀⠹⣿⣿⣿⣿⣿⣿⣩⡶⠼⠟⠻⠞⣿⡈⠻⣟⢻⣿⣿⣿⣿⣿⣿⣿]],
            -- [[⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢿⠀⡆⠀⠘⢿⢻⡿⣿⣧⣷⢣⣶⡃⢀⣾⡆⡋⣧⠙⢿⣿⣿⣟⣿⣿⣿⣿]],
            -- [[⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⡥⠂⡐⠀⠁⠑⣾⣿⣿⣾⣿⣿⣿⡿⣷⣷⣿⣧⣾⣿⣿⣿⣿⣿⣿⣿]],
            -- [[⣿⣿⡿⣿⣍⡴⠆⠀⠀⠀⠀⠀⠀⠀⠀⣼⣄⣀⣷⡄⣙⢿⣿⣿⣿⣿⣯⣶⣿⣿⢟⣾⣿⣿⢡⣿⣿⣿⣿⣿]],
            -- [[⣿⡏⣾⣿⣿⣿⣷⣦⠀⠀⠀⢀⡀⠀⠀⠠⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⣡⣾⣿⣿⢏⣾⣿⣿⣿⣿⣿]],
            -- [[⣿⣿⣿⣿⣿⣿⣿⣿⡴⠀⠀⠀⠀⠀⠠⠀⠰⣿⣿⣿⣷⣿⠿⠿⣿⣿⣭⡶⣫⠔⢻⢿⢇⣾⣿⣿⣿⣿⣿⣿]],
            -- [[⣿⣿⣿⡿⢫⣽⠟⣋⠀⠀⠀⠀⣶⣦⠀⠀⠀⠈⠻⣿⣿⣿⣾⣿⣿⣿⣿⡿⣣⣿⣿⢸⣾⣿⣿⣿⣿⣿⣿⣿]],
            -- [[⡿⠛⣹⣶⣶⣶⣾⣿⣷⣦⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠉⠛⠻⢿⣿⡿⠫⠾⠿⠋⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
            -- [[⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀⡆⣠⢀⣴⣏⡀⠀⠀⠀⠉⠀⠀⢀⣠⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
            -- [[⠿⠛⠛⠛⠛⠛⠛⠻⢿⣿⣿⣿⣿⣯⣟⠷⢷⣿⡿⠋⠀⠀⠀⠀⣵⡀⢠⡿⠋⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
            -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⢿⣿⣿⠂⠀⠀⠀⠀⠀⢀⣽⣿⣿⣿⣿⣿⣿⣿⣍⠛⠿⣿⣿⣿⣿⣿⣿]],
            -- "⣿⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣿⣿⣿⣎⢿⣿⣿⣿⣿⣎⢿⣿⣿⣿⣶⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣻⣽⣿⣯⣷⣿⣿⣿⣟⣯⡿⣿⣿⣟⣿⣿⣮⠻⣿⣿⣿⣿⡞⣿⡟⣽⣿⡇⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿",
            -- "⣿⣿⡾⣿⣿⣿⣿⣷⣿⣷⣿⣷⣿⣿⣾⣿⣯⣷⣿⣿⣿⣾⣿⣿⣿⣿⣾⡽⡿⣿⣿⢿⢿⣿⡇⣿⣿⣶⢻⣿⣿⣷⡝⢿⣿⣿⣿⡼⣿⣮⡻⣻⡹⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⡗⣿⣿⣷⣟⣿⡿⣿⣿⣿⣿⣿⢿⣿⢿⣷⡝⡿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣯⣟⢿⣝⣿⣿⡙⣿⣿⣷⡻⣿⣿⣿⣧⡻⣿⣟⣧⢷⡻⣿⡵⣻⡹⣿⣿⣻⣿⣿⣿⣿⣿",
            -- "⣿⣿⡇⣿⣻⣞⣺⣿⡯⣿⣿⣾⣿⣿⣿⣿⣏⣿⣿⣞⣮⢝⣟⣯⣿⣿⢿⣻⣿⣿⣿⣷⣯⣝⢿⣷⣻⣿⣿⣿⣮⡻⣿⣿⣷⡝⣿⣿⣟⢿⣝⣿⡱⡍⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⡇⡷⢗⣵⣿⣯⣗⣿⣿⡿⣿⣽⣿⣿⣧⠻⣿⣷⣭⢿⣙⢶⣯⣽⣻⠿⠿⣿⣽⣿⣿⣿⣮⣻⢧⠿⣿⣿⣿⣿⣮⣝⣻⣻⢽⣿⡿⣷⣝⠼⣗⡧⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⢣⣷⣿⣿⡿⣽⡸⣾⣿⣿⣿⣿⣿⣿⣽⡾⡽⣿⣿⣰⡽⡮⡪⣟⠿⣿⣮⣞⠯⡩⢽⣞⡻⡿⢿⣷⣯⠿⣯⡻⢿⣿⣿⣷⣝⣻⣿⣮⢿⣷⣵⡣⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣽⣿⣿⡿⣿⣳⣿⣺⠸⣿⣿⡿⣿⣻⣽⣿⣷⢻⡼⣿⣗⠿⢝⣪⣦⠻⣶⣪⣟⡻⡮⣇⡟⣿⣝⠿⣾⣮⠿⣚⢿⣵⣝⣻⡻⣿⣷⣙⡿⣷⣻⣿⣿⡜⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⡿⣳⢺⣿⣸⡎⡼⣿⣿⣿⣿⣿⣿⣿⡟⢗⢿⡧⣿⢿⡿⢚⢋⣖⣹⡙⠋⠯⠷⣳⣦⡪⡽⣊⣟⢿⣝⢿⡮⣻⢷⣝⣔⢶⣭⢿⣝⢧⣿⣿⡣⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⢺⣿⣷⣟⢿⣽⣿⠏⣗⡕⡪⣿⣻⣿⣿⢿⣿⣿⡯⣹⢽⡾⢣⣶⣟⣾⣿⣿⣿⢸⢅⢌⣸⣾⣯⣞⣿⣷⡹⡸⣝⡯⡻⣷⣛⡾⣽⣿⣿⣿⣿⡺⡿⣾⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⡏⣿⡷⣯⣗⣿⣿⢈⠞⡴⣗⡎⣎⣻⢽⣿⣿⣿⣿⢪⣯⣮⣿⣿⣷⠿⣿⣯⠷⡿⣀⢸⣿⣿⣷⡷⣿⣿⣜⠮⠻⣿⣿⣷⣿⣿⣺⣷⡽⣿⣿⣿⢹⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣷⡸⣟⣗⣷⢻⣿⢽⡘⣎⢏⢴⢑⠪⣱⢏⡻⣿⣿⢜⣿⣿⣿⣻⣯⣷⢷⢾⣽⡽⣇⣽⣿⣿⣿⣿⣿⣿⣷⣕⣷⢻⣿⣿⣿⣿⣿⣿⣿⡹⣿⣿⣇⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣮⡕⣿⢹⣿⢸⣳⢊⢆⢯⡟⣯⡞⣿⣭⣮⣻⢱⣿⣿⣿⣿⣯⣯⣭⣴⣷⣾⣿⣿⣿⣿⣯⣿⣿⣿⢿⣿⣻⠌⣧⣿⣿⣿⣿⣿⣿⡺⣹⡻⣿⡜⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⢦⠻⣿⣠⢽⢞⣮⣻⣿⡓⣕⢻⣿⣿⢯⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣿⣿⡿⣿⣿⣿⣿⢹⡼⣺⢽⣿⣿⣿⡾⣿⢣⢯⢿⣭⢻⣿⣿⣿⣽⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⡧⣿⡇⣗⡗⣯⣧⢝⣿⡽⣻⣿⣿⣿⣿⣿⣿⣻⣿⣿⡿⣿⣟⣿⣽⣿⣿⣾⣿⣿⣿⣿⣿⣿⡟⣫⣻⡥⣯⢻⣿⣿⣟⣧⣿⡏⣏⡾⣿⣸⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣌⣷⢣⢯⣻⢿⣮⣾⣾⣿⣿⢿⣻⣿⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⢿⡗⣿⣿⡿⣽⢸⡭⣿⣿⡷⣽⣺⣷⢻⢡⣿⢮⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣽⣞⣯⢾⣿⣯⣪⢍⢻⣚⡿⢿⣿⣿⣿⣿⢿⢯⠷⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣷⣿⡿⣯⣻⣛⡫⢕⡜⡇⣿⣿⡎⣿⣺⡿⣹⣚⡿⣽⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣻⣿⡮⣚⢿⣿⣶⢹⣞⢾⢽⣿⣿⠟⣯⣾⣿⣾⡯⣿⣿⣿⣻⣷⣿⣿⣿⡿⣟⡿⡙⢕⠋⢌⠝⣪⡺⣎⢗⣿⣿⣗⣻⢽⣷⣽⣧⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣓⣿⣦⣻⢿⣸⣗⢧⣝⢿⣿⣬⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡾⠟⡫⢐⠄⠆⠕⡢⢃⢓⣻⡕⣹⡿⢿⣮⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⣿⣿⢸⢯⣯⣟⣯⣮⣻⢿⣿⣿⣷⣿⣿⣿⢿⣻⡿⢓⠣⢂⠂⡊⡢⠡⠍⠎⢄⠥⠘⠭⠯⠯⠞⢛⢿⢿⣟⣿⣻⣻⣟⠿⢷⣿⣿⣷⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡯⡯⢾⢸⣯⡷⣟⡾⡪⢮⡫⣿⣿⢿⠟⡏⣑⣨⣐⣡⣑⡌⠐⠌⡜⡘⡌⣢⠵⡋⠏⡍⠍⡍⠕⠮⢍⡻⢿⣿⣿⣿⣿⣿⣾⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣳⣝⢮⢗⡿⡷⣟⢧⣏⡮⣿⣛⡳⢒⣥⣏⣯⣻⢝⢻⢻⣿⣿⣿⣿⣾⡜⡮⢅⢇⢕⢱⠡⠑⠔⡡⢈⡂⣉⠲⣙⢿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣾⢿⡵⣗⡽⢾⣻⣫⣿⣵⣿⣿⠿⣩⡾⣽⣾⣾⣾⣾⣷⣾⣷⣶⣷⣥⣣⠧⡝⣒⣅⡣⣶⢕⡿⡇⡿⡽⣸⢧⢣⢻⢨⡎⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⣵⢯⡷⣟⣿⣿⣿⣿⣿⣯⣻⣿⣿⣿⣿⣿⢱⢑⢿⡳⡬⡿⡖⣟⠧⢙⡋⣮⡽⡬⣸⢶⢸⢜⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢣⣟⣯⢟⣽⣿⣿⣿⣿⣿⣿⣿⣷⣮⢻⣿⣿⣿⢸⢨⣮⣭⡷⡷⣞⣾⣻⢯⢷⡹⡽⢝⢕⡫⣣⡇⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣿⣿⣿⣿⣿⣿⣿⢇⣾⣽⣞⡯⣟⣿⣿⣿⣿⣿⢿⣿⣿⣿⣷⣝⣿⣿⣧⡺⠽⣾⣫⣛⣫⡮⣭⣳⣳⣾⡺⠯⠷⡻⣙⠜⡽⣿⣿⣿⣿⣿⣿",
            -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠤⠐⠠⢀⡀⢀⢀⣠⢒⢉⠁⠒⠠⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠄⠂⠁⠀⠀⠀⠀⠀⠈⠐⠢⠀⡀⠀⠁⠃⢂⠀⢋⠐⠤⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⠔⠑⠀⠀⠁⠈⠈⠈⠐⠐⠠⠀⣀⠀⠀⠀⠀⠀⠀⠀⠂⠀⠤⠐⢀⢈⡡⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            -- "⠀⠀⠀⠀⢀⣀⠤⠔⠒⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠁⠀⠀⠀⡀⠀⠀⠀⠀⠈⠠⠥⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            -- "⠀⠀⡠⠊⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠐⠢⢀⠀⠀⠀⠀⢄⠀⢇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            -- "⠀⡔⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠑⠂⢄⠀⠡⠐⠬⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            -- "⢐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢄⠀⠀⠀⠀⢃⠀⠀⠀⠈⡄⠀⠀       ",
            -- "⠀⡂⠀⠀⠀⠀⡀⠄⠀⠀⢀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠐⢄⠀⠀⠂⠀⠀⠀⡆⠀⠐⡄⠀⠈⠢⡀⠀⠀⠈⠆⠐⢄⠀⢡⠀⠀⠀⠀⠀⠀⠀  ",
            -- "⠀⡇⠀⠀⡀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠐⣀⠀⠀⠁⠀⠀⠀⠀⠁⠢⢀⠐⢊⠀⠡⠀⠀⠐⡄⠀⠀⠑⠤⠀⠀⠸⠠⡀⠢⡡⢂⠀       ",
            -- "⠀⡂⠄⡐⠌⠀⢐⠀⠀⠐⠀⠀⠈⢐⠀⠐⡑⠤⠐⡀⠈⠀⠀⠀⠀⠀⠁⠊⢄⠀⢣⠀⠀⠈⠢⡀⠀⠀⠱⠀⠀⠡⠐⡀⠰⠹⡀⠀⠀⠀⠀⠀⠀⠀",
            -- "⠀⡊⡐⠈⠀⠀⢌⠀⠀⠀⠀⡀⠄⠈⡄⠀⠐⡌⠤⡈⠐⠠⢄⡈⠀⠀⠠⠀⠈⠢⢈⢂⠀⠀⠀⠈⠢⠤⣀⠃⠀⢀⠑⠬⡀⠆⡃⠀⠀⠀⠀⠀⠀⠀",
            -- "⢀⠃⠐⠀⢠⠊⡊⡀⠀⠈⠀⠀⠀⠀⠅⠆⠀⠡⠒⢌⢅⢢⣀⠈⠊⠥⡣⡐⠢⡠⢀⣀⠑⢀⠐⠄⡀⠀⠀⠉⢄⠀⠢⠀⠈⠢⡀⠀⠀⠀⠀⠀⠀ ",
            -- "⠀⠀⠀⠠⡠⠐⠅⣇⠀⠀⠀⠀⠀⠀⠨⡈⡄⢨⠤⠒⠊⡂⠆⡉⠐⠢⠨⠌⢢⣈⠢⢀⠈⠢⠑⠌⡈⠂⠆⢄⣀⡑⢄⠑⠄⠀⢘⠀⠀⠀⠀⠀⠀⠀",
            -- "⡄⠀⠀⠅⠆⠀⢁⢂⠧⡀⠀⠂⠀⠀⠀⠰⠡⢐⠄⣐⡔⢫⠋⠉⠙⢻⢻⣬⠔⠀⢎⠃⠁⠦⡐⠠⠊⠂⢌⢈⠆⠀⠀⠒⢐⠀⠨⠀⠀⠀⠀⠀⠀⠀",
            -- "⢃⠀⠨⢐⠁⠀⣳⡘⡱⠪⡢⡀⠀⠀⠁⠀⢋⢂⠔⠅⠀⠨⠀⠀⠀⠆⣜⠇⠁⠀⠂⡁⠀⢱⠱⡈⠁⠒⠀⠐⠂⠠⡀⠀⠀⢦⠁⠀⠀⠀⠀⠀⠀⠀",
            -- "⠸⠀⠂⡂⠄⢨⢂⢖⢡⡨⢖⡬⣂⠔⡀⠀⠸⠀⠀⠀⠀⠀⡒⠒⢘⠂⢃⠃⠀⠀⠀⠀⠀⠨⠺⢂⠀⠀⠀⠀⠀⠀⠡⠀⠀⠸⡀⠀⠀⠀⠀⠀⠀⠀",
            -- "⠀⠉⠢⡂⠇⢐⡅⢊⢜⡆⢥⠈⡆⠡⠐⢄⢘⠀⠀⠀⠀⠅⠤⠱⠒⠈⠀⠀⠀⠀⡀⠄⠀⠀⠁⢨⡌⠄⠀⠂⠀⠀⡈⡑⡀⠀⢡⠀⠀⠀⠀⠀⠀⠀",
            -- "⠀⠀⠀⠑⣅⠀⠝⡄⡇⠢⠀⢄⠝⠄⠀⢀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⢨⠰⠉⡠⠀⠀⠀⡄⠘⢠⠃⠐⡄⠀⠀⠀⠀⠀⠀",
            -- "⠀⠀⠀⠀⠘⡀⠸⡨⡂⠀⢧⠀⡢⠄⠀⠀⠀⠀⠀⠀⠁⠀⠀⢀⠀⠀⠠⠀⠀⢀⠀⠀⠀⠀⡂⠬⠐⡇⠬⠀⠀⠠⢠⠀⠃⡜⠀⢅⠀⠀⠀⠀⠀⠀",
            -- "⠀⠀⠀⠀⠀⠱⡀⡒⡐⠠⡁⣀⠀⠀⢀⠠⠀⠀⠀⠂⠀⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢑⠀⠀⣐⢸⢘⠀⠀⠌⡌⠀⢸⠰⡅⡐⠀⠀⠀⠀⠀⠀",
            -- "⠀⠀⠀⠀⠀⠀⠐⡐⡅⠀⠡⡊⡊⠔⡐⠀⠀⠀⡠⠠⠄⢡⠀⠀⠀⠀⠠⠐⠀⢀⠠⠀⡠⢐⣊⠂⡵⠨⢎⠀⠀⠱⢹⠀⡸⠈⠄⠂⠀⠀⠀⠀⠀⠀",
            -- "⠀⠀⠀⠀⠀⠐⠀⠨⠢⠄⠀⡃⢨⠢⡂⠀⠴⠁⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⢀⡤⣞⢮⡻⡼⣍⠢⡁⡕⠀⠀⡊⠄⠂⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀",
            -- "⠀⠀⠀⠀⠀⠀⠀⠁⠀⠈⠀⡂⢌⠢⠈⡂⢄⠈⠀⠀⡀⠀⠀⠀⡀⠁⢀⡬⣼⣫⢮⣝⢽⢺⡺⡵⡥⠠⠢⠔⣁             ",
            -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠱⡐⠔⠠⢀⠂⢍⡒⢄⠀⠀⢀⡠⡴⠞⠽⠮⢏⣞⢷⢜⡮⣳⠽⡊⣭⡩⣱⡩⡥⣒⠤⡀⠀⠀⠀       ",
            -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠤⡃⡬⠁⢂⠠⡍⠢⠥⠢⢨⠍⠧⠥⠤⠥⠠⣄⠀⡀⠈⠁⣑⢊⢎⢮⢎⢮⢳⠽⡺⡳⠽⡮⡕⡄⠀⠀⠀⠀⠀⠀⠀⠀",
            -- "⠀⠀⠀⠀⠀⠀⠀⢀⠀⠅⠑⠊⠄⠌⠐⠀⠀⢀⡠⠔⢁⠂⠂⠁⠁⠈⠁⠁⠁⠑⠊⠱⢆⢋⠪⡊⠹⡀⠈⡇⠨⡂⢱⢕⠸⡜⡄⠀⠀⠀⠀⠀⠀⠀",
            -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⠡⠐⢈⠀⠀⠀⠀⠀⠀⠢⡀⠀⠀⠀⢸⡸⡂⢨⣑⡈⠦⠅⠏⢚⠓⠨⣙⡉⢱⢢⠀⠀⠀⠀⠀⠀⠀",
            -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⡰⢁⠡⠨⢀⠀⠀⠀⠀⠀⠀⠀⠈⢂⠀⠀⠘⢩⠉⠀⠄⠄⡡⣈⠌⠬⠪⠒⠒⠊⠌⡊⡂⠀⠀⠀⠀⠀⠀",
            -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠃⠠⠐⡈⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠡⡀⠀⢓⠒⠁⠡⢉⢐⣀⡊⡰⢤⠕⠑⠣⡩⠸⢂⠄⠀⠀⠀⠀⠀",
            -- "             ⡀⠀⠁⠀⡀⠀⡀⢀⠀⠀⠀⢀⠀⢀⠀⡀⠀⠀⠢⠀⢐⢃⠊⠈⠈⠀⠀⠀⡀⠀⡊⢀⠡⠁⡐⠑⠄⠀⠀⠀⠀",
            -- "⠄⠄⠄⠄⠄⠄⠄⢸⠿⣟⣽⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣧⠈⣿⣿⣾⣺⣷⣬⣻⠿⣿⣿⡆⠠⠁⠄⠄⠄⠄⠄",
            -- "⠄⠄⠄⢀⠄⢄⣠⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⢹⣿⣿⣿⣿⡿⣿⣷⣬⡻⠇⠌⡁⠄⠄⠄⠄⠄",
            -- "⠈⠂⠜⠊⣴⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⢯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡹⣿⣿⣷⠄⢤⡄⠄⠄⡂⠄⡀",
            -- "⡀⠖⠘⢰⣿⣿⣿⣿⣿⣿⣿⣿⣟⣶⢣⣿⣿⣿⣿⣿⣟⠟⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡌⣿⣿⡂⢀⡁⠄⢈⡁⡀⣀",
            -- "⠆⠮⡸⠘⣿⣿⣿⣿⣿⣿⣿⢟⡾⣠⣿⣿⣿⣿⡿⠏⣱⣿⣿⣿⣿⣿⡧⠹⣿⣿⣿⣿⣿⣿⣯⡹⣿⡿⣿⣿⣷⣌⡻⣿⣿⣿⣿⣯⠻⣿⣿⣿⣞⢿⠁⣘⡃⢀⣟⣃⠒⣛",
            -- "⠄⠄⡇⢀⢹⣿⣿⣿⣿⡿⣱⣟⢣⣿⣿⣿⣿⢋⢡⣼⣿⠿⡻⣿⣿⣿⣗⡢⣝⢿⣿⣿⣿⣿⣿⣷⣄⠋⠝⢯⣛⢿⣷⣌⢿⣿⣿⣿⣷⡝⢿⣿⣿⣎⠸⣾⡀⢦⣄⣀⣀⡐",
            -- "⠂⢢⡔⢣⣥⠹⣿⣿⡿⣹⣿⡿⣼⣿⣿⡿⢱⢇⣿⣿⣋⠊⢸⣿⣿⣿⣿⣿⣬⠕⡍⢿⣿⣿⣿⣿⣿⣷⣄⢀⠼⡁⢻⣿⡎⢿⢿⣿⣿⣿⣆⢹⣿⣿⡆⣝⡣⡄⡛⢃⢛⣻",
            -- "⠿⣷⡻⣿⣏⣷⣸⡟⣱⣿⡟⠁⣿⣿⣿⠻⠋⣸⡟⢡⢳⣿⢼⢹⣿⣿⣿⣿⣿⣇⢺⠄⠉⣝⠻⢿⣿⣿⣿⣷⣮⣬⡀⡙⣿⣸⣧⢻⣿⣿⣿⣧⠙⠏⣠⡶⣇⣼⣿⣦⢶⣿",
            -- "⡄⢯⣝⣒⣯⣭⡇⢹⣿⣿⢁⠄⣿⣿⡟⠰⠆⡟⠌⠈⣿⣿⣇⢏⢿⣿⣿⣿⣿⣿⡜⣏⢦⢻⣆⢠⡲⢶⣔⢾⣿⣭⣛⠦⣝⠇⠙⠧⡹⣿⡛⠻⠄⣈⣥⣴⣧⣴⣛⣻⡞⢿",
            -- "⢾⣾⡗⣿⣿⣿⡇⣿⣿⡇⣧⠄⢹⣿⡇⣿⡧⠇⠛⠄⠶⣄⡝⠘⣌⢿⣿⣿⣿⣿⣿⡘⢦⠂⣿⠘⣛⣋⢬⡡⠤⠒⠒⠤⢜⠆⠄⠘⣛⠻⣧⡀⢸⣿⣽⣿⣿⣿⣿⣿⡿⣻",
            -- "⣿⣾⡿⣿⣽⣿⡇⣿⣿⠇⣿⡀⠄⢿⣷⠆⢀⣆⣟⠞⡆⣶⣌⠻⢌⢧⡻⣿⣿⣿⣿⣷⡑⡅⡿⢸⡷⡋⢡⢰⣾⣿⣼⣿⣆⢠⠄⠄⠄⠄⠈⢰⣸⣧⣯⣿⣿⡯⣟⣿⡟⢿",
            -- "⣿⣿⣻⣿⣿⣿⣳⢹⣿⡇⠘⢧⢀⠄⠙⢋⢻⣟⠻⣮⢝⣹⣛⠳⣿⣯⡳⣮⢝⠻⣿⣿⣿⣦⡣⣿⣿⣿⡡⣯⣭⡍⠼⢟⣯⡟⠁⠄⣦⡌⠌⣸⡇⣿⣿⣿⣿⣽⠿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣧⣝⢿⣄⢴⠄⠄⠄⢰⡐⣾⣿⣷⣶⣶⣶⣿⣿⣿⣿⣾⣷⣉⣶⣯⠭⣉⣭⣿⣿⣿⣿⣶⣶⣶⣿⣿⣿⢣⡾⣿⣿⡹⡔⢹⢏⣿⣿⣿⣿⣿⣿⢿⡿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣬⡭⠄⠠⠄⣷⣿⡸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢇⣿⡃⡿⣿⣇⢿⡆⣾⣿⣿⣿⣿⣿⣿⣿⣷⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣈⣾⢇⠄⢰⠄⠘⢿⣦⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡉⣮⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⣼⣾⡇⠃⣿⣿⣸⡿⣺⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣧⣸⠃⣸⡃⠄⠄⠄⠄⠈⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠙⠛⠁⠄⠄⣿⣿⣏⠃⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣏⡟⢲⣿⣇⠄⠄⠄⠄⠄⠄⠄⠻⣿⣿⣿⣿⣿⣿⣿⣿⣛⣛⣻⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠄⠄⠄⠄⠄⠄⢹⣿⣽⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣇⢿⠸⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⠄⠄⠄⠄⠄⠄⠄⠄⢸⣿⡇⣷⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⣷⣿⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣋⡆⠤⣶⣀⡀⠄⠄⠄⠄⠄⢸⣿⡧⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣸⣿⣿⣆⠄⠄⣠⣤⣶⣶⣿⣿⣿⠟⠁⠨⡛⢿⣿⣿⣿⣿⣿⡿⡛⠥⠞⠋⠁⠄⠘⣿⣿⣷⣄⣀⠄⢀⣿⣿⣇⢟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢉⣻⣿⣿⡀⣾⣿⣿⣿⣿⣿⣿⡿⣄⠄⠄⠈⠄⠉⠙⠛⠛⠉⠄⠄⠄⠄⠄⠄⢰⣷⡹⣿⣿⣿⣿⢇⣼⣿⢟⣵⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣤⣌⣛⡳⢿⣿⣿⣿⣿⣿⢛⣼⣿⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢘⣿⣿⡜⠿⣿⣥⣾⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⣟⣉⣭⢰⣿⣿⡏⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸⣿⣿⣿⡖⣾⣍⣙⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⣟⣻⣯⣭⣶⣾⣿⣿⣿⢏⣿⣿⣿⡇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸⣿⣿⣿⣿⡹⣿⣿⣿⣿⣷⣶⣾⣭⣭⣟⣛⣛⡿⠿⣿⣿⣿",
            -- "⣿⣿⢿⣛⣭⣭⣿⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢣⣾⣿⣿⣿⡇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸⣿⣿⣿⣿⣷⡹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣾",
            -- "⡟⣱⣿⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⣿⣿⣿⣿⣿⠇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸⣿⣿⣿⣿⣿⣧⡹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣼",
            -- "⠀⠀⠀⠀⠀⠀⠀⢸⠿⣟⣽⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣧⠈⣿⣿⣾⣺⣷⣬⣻⠿⣿⣿⡆⠠⠁⠀⠀⠀⠀⠀",
            -- "⠀⠀⠀⢀⠄⢄⣠⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⢹⣿⣿⣿⣿⡿⣿⣷⣬⡻⠇⠌⡁⠀⠀⠀⠀⠀",
            -- "⠈⠂⠜⠊⣴⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⢯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡹⣿⣿⣷⠀⢤⡄⠀⠀⡂⠀⡀",
            -- "⡀⠖⠘⢰⣿⣿⣿⣿⣿⣿⣿⣿⣟⣶⢣⣿⣿⣿⣿⣿⣟⠟⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡌⣿⣿⡂⢀⡁⠀⢈⡁⡀⣀",
            -- "⠆⠮⡸⠘⣿⣿⣿⣿⣿⣿⣿⢟⡾⣠⣿⣿⣿⣿⡿⠏⣱⣿⣿⣿⣿⣿⡧⠹⣿⣿⣿⣿⣿⣿⣯⡹⣿⡿⣿⣿⣷⣌⡻⣿⣿⣿⣿⣯⠻⣿⣿⣿⣞⢿⠁⣘⡃⢀⣟⣃⠒⣛",
            -- "⠀⠀⡇⢀⢹⣿⣿⣿⣿⡿⣱⣟⢣⣿⣿⣿⣿⢋⢡⣼⣿⠿⡻⣿⣿⣿⣗⡢⣝⢿⣿⣿⣿⣿⣿⣷⣄⠋⠝⢯⣛⢿⣷⣌⢿⣿⣿⣿⣷⡝⢿⣿⣿⣎⠸⣾⡀⢦⣄⣀⣀⡐",
            -- "⠂⢢⡔⢣⣥⠹⣿⣿⡿⣹⣿⡿⣼⣿⣿⡿⢱⢇⣿⣿⣋⠊⢸⣿⣿⣿⣿⣿⣬⠕⡍⢿⣿⣿⣿⣿⣿⣷⣄⢀⠼⡁⢻⣿⡎⢿⢿⣿⣿⣿⣆⢹⣿⣿⡆⣝⡣⡄⡛⢃⢛⣻",
            -- "⠿⣷⡻⣿⣏⣷⣸⡟⣱⣿⡟⠁⣿⣿⣿⠻⠋⣸⡟⢡⢳⣿⢼⢹⣿⣿⣿⣿⣿⣇⢺⠀⠉⣝⠻⢿⣿⣿⣿⣷⣮⣬⡀⡙⣿⣸⣧⢻⣿⣿⣿⣧⠙⠏⣠⡶⣇⣼⣿⣦⢶⣿",
            -- "⡄⢯⣝⣒⣯⣭⡇⢹⣿⣿⢁⠀⣿⣿⡟⠰⠆⡟⠌⠈⣿⣿⣇⢏⢿⣿⣿⣿⣿⣿⡜⣏⢦⢻⣆⢠⡲⢶⣔⢾⣿⣭⣛⠦⣝⠇⠙⠧⡹⣿⡛⠻⠀⣈⣥⣴⣧⣴⣛⣻⡞⢿",
            -- "⢾⣾⡗⣿⣿⣿⡇⣿⣿⡇⣧⠀⢹⣿⡇⣿⡧⠇⠛⠀⠶⣄⡝⠘⣌⢿⣿⣿⣿⣿⣿⡘⢦⠂⣿⠘⣛⣋⢬⡡⠤⠒⠒⠤⢜⠆⠀⠘⣛⠻⣧⡀⢸⣿⣽⣿⣿⣿⣿⣿⡿⣻",
            -- "⣿⣾⡿⣿⣽⣿⡇⣿⣿⠇⣿⡀⠀⢿⣷⠆⢀⣆⣟⠞⡆⣶⣌⠻⢌⢧⡻⣿⣿⣿⣿⣷⡑⡅⡿⢸⡷⡋⢡⢰⣾⣿⣼⣿⣆⢠⠀⠄⠀⠀⠈⢰⣸⣧⣯⣿⣿⡯⣟⣿⡟⢿",
            -- "⣿⣿⣻⣿⣿⣿⣳⢹⣿⡇⠘⢧⢀⠀⠙⢋⢻⣟⠻⣮⢝⣹⣛⠳⣿⣯⡳⣮⢝⠻⣿⣿⣿⣦⡣⣿⣿⣿⡡⣯⣭⡍⠼⢟⣯⡟⠁⠀⣦⡌⠌⣸⡇⣿⣿⣿⣿⣽⠿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣧⣝⢿⣄⢴⠀⠀⠀⢰⡐⣾⣿⣷⣶⣶⣶⣿⣿⣿⣿⣾⣷⣉⣶⣯⠭⣉⣭⣿⣿⣿⣿⣶⣶⣶⣿⣿⣿⢣⡾⣿⣿⡹⡔⢹⢏⣿⣿⣿⣿⣿⣿⢿⡿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣬⡭⠀⠠⠀⣷⣿⡸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢇⣿⡃⡿⣿⣇⢿⡆⣾⣿⣿⣿⣿⣿⣿⣿⣷⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣈⣾⢇⠄⢰⠀⠘⢿⣦⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡉⣮⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⣼⣾⡇⠃⣿⣿⣸⡿⣺⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣧⣸⠃⣸⡃⠀⠀⠀⠀⠈⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠙⠛⠁⠀⠀⣿⣿⣏⠃⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣏⡟⢲⣿⣇⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣛⣛⣻⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠀⠀⠀⠀⠀⠀⢹⣿⣽⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣇⢿⠸⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡇⣷⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⣷⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣋⡆⠤⣶⣀⡀⠀⠀⠀⠀⠀⢸⣿⡧⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣸⣿⣿⣆⠀⠀⣠⣤⣶⣶⣿⣿⣿⠟⠁⠨⡛⢿⣿⣿⣿⣿⣿⡿⡛⠥⠞⠋⠁⠀⠘⣿⣿⣷⣄⣀⠀⢀⣿⣿⣇⢟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢉⣻⣿⣿⡀⣾⣿⣿⣿⣿⣿⣿⡿⣄⠀⠀⠈⠀⠉⠙⠛⠛⠉⠀⠀⠀⠀⠀⠀⢰⣷⡹⣿⣿⣿⣿⢇⣼⣿⢟⣵⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣤⣌⣛⡳⢿⣿⣿⣿⣿⣿⢛⣼⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢘⣿⣿⡜⠿⣿⣥⣾⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⣟⣉⣭⢰⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⡖⣾⣍⣙⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            -- "⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⣟⣻⣯⣭⣶⣾⣿⣿⣿⢏⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⡹⣿⣿⣿⣿⣷⣶⣾⣭⣭⣟⣛⣛⡿⠿⣿⣿⣿",
            -- "⣿⣿⢿⣛⣭⣭⣿⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢣⣾⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣷⡹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣾",
            -- "⡟⣱⣿⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣧⡹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣼",
            -- [[⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⡠⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⠀⢤⣠⡈⣷⠀⢹⢸⢸⣁⠔⠋⠙⣿⢻⣿⣿⣿⣿⣻⣿⣿⣿]],
            -- [[⣿⣿⣿⣿⣧⣿⣿⠀⠀⠀⠀⠀⠀⡠⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠊⠢⠀⠀⠁⠍⣵⣼⠠⢛⠞⠀⠀⠀⠒⠩⢞⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
            -- [[⣿⣿⣿⣿⣿⣷⣿⠀⠀⠀⢀⠔⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠟⠁⢸⡇⠀⠠⡖⡠⢄⠀⠀⠀⠈⢹⣿⡿⡟⣿⣿⣿⣿]],
            -- [[⣿⣿⣿⣿⣿⣿⣿⠠⠀⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠀⢿⡀⠀⠀⠂⠀⠑⠢⢄⠀⠀⣿⣽⡿⣿⣽⣿⣿]],
            -- [[⡿⣿⣏⣝⡿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠷⠀⠀⠀⠀⢀⠀⠀⠙⢦⣯⣟⡿⣿⣿⣿⣿]],
            -- [[⣿⣾⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⡠⢠⠎⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢢⠀⠀⢸⣛⢻⣷⠻⢻⣿⣟]],
            -- [[⢽⢟⣦⡇⠀⠀⠀⠀⠀⠀⠀⡔⢡⠃⠀⠀⠀⠀⠠⡴⠊⠀⠀⠀⠠⡄⠀⠀⠀⠀⠀⠐⢄⠀⠀⠀⠀⠐⢄⠀⠀⠀⠀⠀⢀⠀⠀⠀⠣⠀⢀⣶⠀⠀⣴⣿⠽⠁]],
            -- [[⢾⢒⣉⣱⠀⠀⠀⠀⠀⢀⠌⢠⠃⠀⠀⠀⣠⢴⠋⠀⢀⠄⠀⠀⠈⡞⢄⠀⠀⠀⠀⠀⠈⠲⣆⣂⡀⣄⠀⠑⢄⠀⠀⠀⠀⠳⡀⠀⠀⠙⣼⣯⠉⠀⢿⣏⡟⠉]],
            -- [[⢾⢾⣍⠑⢧⠀⠀⠀⢀⠂⠀⡌⠀⠀⠀⡸⢯⠃⠀⡠⣣⠃⠀⠀⠀⠘⠌⠧⣀⠀⠀⠀⠀⠀⠘⢷⣶⣭⡧⡀⠈⢦⠀⠀⠀⠀⠸⣄⠀⠀⠸⣏⠉⠁⢽⣯⠀⠑]],
            -- [[⣶⡈⠙⡂⡈⢧⠀⠠⠁⠀⢠⡇⠀⠀⡐⣠⠋⢀⡔⡕⢻⢠⠀⠀⠀⠀⠀⢸⠊⣶⣄⡀⠀⠀⠀⠀⠙⠫⢢⣻⣄⠀⢃⠠⡀⠀⠀⠘⣆⠀⣰⠃⢀⣶⡈⣃⣴⣆]],
            -- [[⢿⠠⠄⢀⠁⠄⣦⠁⠀⢠⣿⡄⠀⢀⡟⣿⢀⢮⠳⠀⠈⡎⡄⠀⠀⠀⠀⠀⢇⢩⢳⠀⢻⠶⡒⠲⡒⠀⠤⢈⠺⠄⣸⣄⠱⡄⠀⣀⢸⣿⠡⠶⠃⠀⠴⠇⢃⠀]],
            -- [[⠊⠃⢀⠀⠁⣀⡏⠀⠀⡎⢾⣇⠀⢸⠉⢹⣼⣉⣎⡒⢢⢼⡜⡀⠀⠀⠀⠀⠈⣦⡣⣇⢸⣄⡬⠴⡌⢒⣶⣒⣛⠦⡹⣻⣯⣴⡀⢹⣿⠁⠀⡀⠀⠁⢠⠀⠈⠁]],
            -- [[⠀⠀⠉⠀⠀⠐⡇⠀⠀⡇⢸⣿⡀⠘⣨⡿⠻⢀⠏⡏⠲⢎⡸⡈⢄⠀⠀⠀⠀⠘⢕⢿⢸⠀⢀⣵⢾⠋⠁⠹⠈⠻⣟⣿⢿⣿⣿⣶⢹⠀⠀⡄⠀⠀⠠⠀⠐⠀]],
            -- [[⠀⠀⠉⠀⡀⠀⢳⠀⠀⣿⡜⢿⣿⣦⡡⡁⠤⣀⢚⠤⠄⢠⡃⠈⢄⡑⢦⢀⠀⠀⠈⠢⡌⠀⠀⠹⡧⠦⢤⣞⡀⠤⠀⣿⣭⠙⢯⡾⠀⣷⠀⠀⠀⠀⠀⠀⠀⠀]],
            -- [[⠀⠀⠀⠀⠀⠀⠀⠣⣄⠘⠏⢹⣿⣿⡏⢏⠀⠀⠉⠉⠉⠁⠀⠀⠀⠈⠂⠱⠉⠐⣲⠒⠀⠁⠀⠀⠈⠉⠉⠁⠀⠀⣰⢁⠀⠘⡌⢶⢀⠞⠀⠀⠀⠀⠀⠀⢀⠀]],
            -- [[⠀⠀⠀⠀⠀⠀⠀⠀⢀⠏⠀⣿⣿⣿⡈⢈⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⠁⢸⠀⠀⢱⠈⠏⠀⠀⠀⠀⠀⠀⠀⠈⠀]],
            -- [[⠀⠀⠀⠀⠀⠀⠀⠀⣟⠆⣸⢸⣏⣿⣷⡀⠉⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠉⠁⣸⣾⠀⠀⡄⡐⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            -- [[⠀⠀⠀⠀⠀⠀⠀⠀⡟⢠⡇⢸⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣧⣶⣾⣿⣿⠀⠀⢡⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠆⢶⠀⠈⢻⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠐⠒⠂⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⡇⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            -- [[⠀⠀⠀⠀⠀⠀⠀⠀⢧⡈⠄⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⣧⠀⠀⢸⣿⣿⣿⣿⠿⠟⠛⠛⠛⢛⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⢁⣷⣦⠈⠙⠻⣿⣿⣿⣿⠃⠀⠀⠘⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢋⡀⠀⠘⣿⠟⠉⠁⠀⠀⠀⠀⢰⣿⣧⣝⣲⣄⡀⠀⠀⣀⣴⣮⣴⣾⣿⣿⠟⡄⠀⠀⠈⠙⢻⡟⠀⠀⠤⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠵⢄⡀⠹⠀⠀⠀⠀⠀⠀⡠⠂⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠘⢦⠀⠀⢠⣎⡤⠔⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠀⠀⣀⣠⠤⡔⠁⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠀⠀⢓⠦⠄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⠤⠒⠂⠉⠀⠀⡸⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠈⡄⠀⠀⠉⠉⠓⠒⠠⠤⢄⣀⠀⠀⠀⠀⠀⠀]],
            -- [[⠀⠀⢀⡀⠤⠄⠐⠂⠈⠁⠀⠀⠀⠀⠀⠀⠀⡰⠁⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠉⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠀⠀⠒⠂]],
            -- [[⢀⠔⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⠁⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠘⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂]],
            -- [[⠋⠀⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠌⠀⠀⠀⠀⠐⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠈⢂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠢⢄⠀⠀⠀⠈⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠈⠢⠀⠀⠀⣀⠧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            -- "⠀⠀          ⠉⢀⠎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⣷⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            -- "⠀⠀        ⠇⠁⠀⡀⡠⠔⠹⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣷⣄⠀⠀⠀⠀⠀⠀⠀",
            "⠀⠀      ⢝⠟⠀⠀⠘⠌⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠤⠀⣀⣀⠙⢿⣦⡀⠀⠀⠀⠀⠀",
            "⠀⠀     ⠗⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡶⠃⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠉⠙⠶⣯⣇⣀⠀⠀⠀⠀",
            "⠀⠀    ⣫⠎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡴⠟⠋⠀⠀⠀⠀⠀⠠⠘⡀⠀⠈⡳⣦⡀⠀⠀⠀⠀⠙⢻⣷⡄⠀⠀",
            "⠀⠀   ⡾⠃⡐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡤⠖⠉⠀⠀⠀⠀⠀⠀⠀⠀⢀⡆⠙⣆⠀⠁⠀⠙⢦⣀⠀⠀⠀⢸⣿⣿⡄⠀",
            "⠀⠀  ⢸⣇⡜⠀⢀⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠐⠊⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⡇⠀⠈⢷⡈⠀⠀⠀⠙⢧⡀⠀⠸⣿⣿⠃⡀",
            "⠀⠀  ⢋⡽⠁⢀⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⡇⠀⠀⠀⠻⡆⠀⠀⠀⠂⠙⠆⢀⣿⣿⠀⠀",
            "   ⠀⢸⡇⢠⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡔⠀⠀⡠⠀⣴⠁⠀⠀⣴⠃⠀⢠⣿⡟⡝⠀⠀⠀⠀⠘⡀⠀⢀⠈⡆⠘⣮⢿⡇  ",
            "   ⠀⢸⣇⡿⠀⠀⠀⠀⠀⠀⠀⠀⠄⠀⢀⣠⡴⠿⠋⣀⣴⣾⢁⣼⠇⠀⣠⣾⠃⠀⣰⡿⠋⠀⣷⠀⠀⢰⠀⠀⠁⠀⠘⠀⣧⠀⢹⣯⢷  ",
            " ⠀ ⠀⠊⢿⢧⠃⠀⠀⠀⠀⠀⢠⡞⢀⣾⣿⣟⣥⣴⣾⣶⣿⣅⣞⡿⠀⣰⡿⠁⢀⠼⠋⠀⡰⢸⣼⡇⠀⣸⡆⠀⠀⠀⠀⡇⣿⠀⠈⣿⣧  ",
            "⠀⠀ ⠀⠼⡘⡞⠀⠀⠀⠀⠀⠀⣼⠃⣈⢤⠀⢀⣭⣝⡿⣿⣻⣼⣿⣿⠠⠋⠀⠂⠁⠀⢀⣼⠃⠷⠿⡇⠀⣿⡷⠀⠀⠀⢠⡇⡇⢸⠀⣿⣿  ",
            "   ⠀⠈⣿⠇⠀⠀⠀⠀⠀⠀⣿⣾⣿⠈⢷⣾⣿⣿⣷⣷⣽⡻⣿⣛⢀⣠⣤⡶⣊⣴⣿⢃⣴⣿⣿⠇⠼⢿⣿⠀⢀⡄⢸⣷⠇⢸⠀⣿⣿  ",
            "    ⡏⢻⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⢤⡀⠚⠛⢛⣿⣿⣿⣿⣿⣿⣼⣿⣷⣿⣿⣿⣷⣟⠻⢩⣶⣾⣷⣦⠙⣠⡾⠀⡼⠉⢠⢸⢰⣿⡟  ",
            "   ⣿⡇⣿⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣮⣽⣿⣿⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠛⠿⣿⣿⣿⣇⠝⠁⠠⡓⠀⠄⣈⣿⡿⠑⠀⠀",
            "   ⣿⡇⣿⠀⠀⠀⠀⠀⠀⠀⣏⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣤⠶⣿⣻⣿⠃⠀⠀⢰⠀⠀⢡⢿⠟⠈⠄  ",
            "    ⡇⣿⠀⠀⠀⠀⠀⠀⠀⠻⢿⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⢟⣽⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠜⠀⠀⣴   ",
            "     ⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⡅⠀⠀⠀⠀⠀⠀⠈⠀⠀⢀⡏   ",
            "      ⡃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⣿⣿⣿⣿⣿⣿⣶⣿⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇   ",
            "        ⣶⣤⣀⠀⠀⠰⣖⣶⠶⣤⢤⣷⣿⡻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠋⠁⠀⠀⠀⠀⠀⠀⢠⣶         ",
            "           ⣿⣦⣤⣹⣿⣿⣯⣿⢿⣿⣿⣾⣝⡿⣿⣿⣿⣿⡿⣿⡛⠉⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⢸          ",
            "           ⣾⣿⣿⣿⣿⣿⣭⣟⡷⣝⢿⣿⣿⣿⣷⣿⣽⣾⣿⣽⡇⠀⠀⠙⠳⢤⡰⢠⠀⠀⠀⠀⠈⣿         ",
            "         ⣟⠿⠻⢻⡿⣿⣿⣿⣿⣿⣿⣿⣷⣽⣻⢿⣿⣿⠹⣯⣿⣿⣖⠀⠀⠀⠀⠀⢹⠀⣀⠀⠀⠀⠀⣿         ",
            "         ⣵⣾⣷⡀⠻⣄⠈⠙⠛⠿⠿⠿⠿⠿⠿⠟⣪⢿⣿⣼⠿⠿⠛⢀⠀⠀⠀⠀⢨⡼⣿⠀⠀⠀⠀⣿         ",
            "       ⣽⣿⣿⣿⣿⣿⣦⡙⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣯⣿⣿⡆⠀⠀⠈⡎⣦⠀⠀⢸⣻⡏⣒⣒⣒⣒⡚⣯⣝⣻      ",
            "     ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡝⣿⡇⠀⠀⠀⠣⢉⣧⣤⣼⢰⠧⢤⣤⣤⣤⣴⣿        ", -- "    ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠿⠿⠇⠀⠀⠀⠀⢸⢿⡟⡏⣽⡋⣏⣽⣭           ",
            -- "  ⠀⠀⠀⠀⠀⠀⠀⡰⠁⢃⣶⡿⣱⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣄             ",
            -- "  ⠀⠀⠀⠀⠀⠀⡐⠁⣸⣾⣿⢿⢟⣫⣆⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄           ",
            -- "  ⠀⠀⠀⠀⠀⠀⡢⣠⣿⣿⣧⣳⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣛⣿⠿⠿⣦⡀         ",
            -- "  ⠀⠀⠀⠀⠔⣨⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢉⣼⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣶⣦⣉⠐        ",
            -- "  ⠀⠀⠀⠸⠔⣱⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢋⣠⣴⣿⣿⣿⣿⣿⣟⣧⢿⣿⣷⢌⠙⢿⣿⣿⣿⣿⣦⡄      ",
            -- "  ⠀⠀⡔⢁⣼⢯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢛⣩⣶⣿⣿⣿⣿⣿⣿⣿⣿⡿⢹⣦⠹⣿⣾⣿⣦⡙⠿⣿⣿⣿⡇⠀⠀    ",
            -- "  ⠀⠀⡇⠸⢣⣿⡿⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣯⣵⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⢸⣿⣷⡈⢷⣿⣿⣿⣦⡘⢿⣿⣇⠀⠀    ",
            -- "  ⠀⢀⡴⢂⣾⡿⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⢸⣿⣿⣿⣄⢹⣿⣿⣿⣽⣦⣹⡿⠀⠀    ",
            -- "  ⠀⣿⡇⢸⡟⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢫⣿⣿⢟⣿⠋⣾⣿⣿⠋⣼⣿⡟⠀⢠⢢⣿⣿⣿⣿⣧⢿⣿⡿⣷⢹⣧⠑⡀⢸    ",
            -- "  ⠀⠉⠛⠸⢀⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⡿⠟⢋⣀⣴⠿⠋⠁⡾⠃⣸⣿⠟⠁⣼⣿⠏⢀⣴⣿⠈⣿⣿⡏⣿⣿⣾⣿⣧⣿⠘⣿⡆⠐⡈⠀⠀  ",
            -- "    ⠉⡀⡘⣼⣿⣿⣿⣿⣿⡟⢡⡿⠁⠀⠠⠚⠋⠁⠉⠀⠺⠡⢀⣿⠏⢀⣾⡿⣃⣴⣿⢏⡇⠃⢸⣿⠇⢹⣿⣿⣿⣿⢸⠀⣿⣷⠀⠘⡀⠀  ",
            -- "    ⣃⢧⢡⣿⣿⣿⣿⣿⣿⠃⣼⠷⡛⣿⡿⠒⠢⢀⠀⠄⠃⠀⠀⣟⣴⣿⣽⣾⣿⡿⠃⣼⣈⣀⢸⣿⠀⢈⣿⣿⣿⡟⢸⢸⡇⣿⠀⠀⡇   ",
            -- "    ⣷⠀⣸⣿⣿⣿⣿⣿⣿⠀⠁⠀⣷⡈⠁⠀⠀⠈⠈⠂⢄⠀⠤⡿⠟⠛⢉⠵⠋⠀⡼⠋⠀⠀⣸⣃⡀⠀⣿⡿⢻⡇⠈⣸⡇⣿⠀⠀⣧   ",
            -- "⠀⠀⠀⠀⢰⡄⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⡛⢿⣥⣤⡤⠀⠀⠀⠀⠀⠀⠃⠀⠈⠀⠀⠀⠈⠠⣄⡖⠉⠁⠈⠙⣦⠟⢁⣿⢃⣶⡟⡇⡏⠀⢠    ",
            -- "   ⠀⢸⠀⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠑⠂⠀⠀⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣤⣀⠀⠀⠀⠸⣢⣾⣟⢬⣿⣻⠷⠀⢀     ",
            -- "⠀⠀⠀⠀⢸⠀⣿⣿⣿⣿⣿⣿⣿⠰⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠛⣉⠀⠄⠀⣼⣿⣿⡏⣿⣿⡞⡀⣠      ",
            -- "⠀⠀⠀⠀⢸⠀⣿⣿⣿⣿⣿⣿⣿⣄⡀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⡠⠂⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣣        ",
            -- "⠀⠀⠀⠀⠘⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢺⣿⣿⣿⣿⣿⣿⣷         ",
            -- "⠀⠀⠀⠀⠀⠁⢼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣄⠀⠀⠀⠀⠀⠀⠉⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣾⣿⣿⣿⣿⣿⣿          ",
            -- "⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠿⣿⣿⣏⠩⠉⣉⠛⡛⠈⠀⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⣾⣿⣿⣿⣿⣿⣿⡟⠉⠉          ",
            -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠛⠆⠀⠀⠐⠀⡀⠀⠀⠁⠢⢀⠀⠀⠀⠀⢀⠀⢤⣶⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀          ",
            -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠁⠀⠀⠀⠀⠀⠒⠠⢈⠢⡀⠀⠀⠀⠈⠀⠂⠁⠀⠂⢸⣿⣿⣦⣌⡛⢏⡟⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ",
            -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣀⣄⡄⢀⠀⠀⠀⠀⠀⠀⠀⠈⠂⠄⡀⠀⠀⣆⠐⠀⠀⠩⣿⣿⣿⣿⣿⡆⣿⠿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ",
            -- "⠀⠀⠀⠀⠀⠀⠀⠀⡠⠊⠁⠈⢿⣄⠻⣷⣦⣤⣀⣀⣀⣀⣀⣀⣠⠕⡀⠀⠃⣀⣀⣤⡿⣿⣿⣿⣿⡗⢃⠀⣿⣿⣿⣿⠀⠀⠇⠀⠀⠀⠀⠀⠀⠀  ",
            -- "⠀⠀⠀⠀⠀⠀⠀⠂⠀⠀⠀⠀⠀⠙⢦⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠐⠀⠀⢹⣿⣿⣷⢱⠙⣿⣿⡇⠄⢰⠭⠭⠭⠭⢥⠐⠢⠄⠀⠀⠀⠀⠀⠀  ",
            -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⢢⠀⢸⣿⣿⣿⣜⡶⠘⠛⠃⡏⣘⡛⠛⠛⠛⠋⠀⢀⠀⠀⠀⠀⠀⠀⠀  ",
            -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀⣀⣸⣿⣿⣿⣿⡇⡀⢠⢰⠂⢴⠰⠂⠒⠒⢰⠀⠈⠀⠀⠀⠀⠀⠀⠀  ",
            -- [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⡿⠿⢿⡻⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
            -- [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⣛⣛⣛⡛⠛⠛⠛⢛⣋⣩⣭⣴⣶⣶⣿⣿⣿⣿⣶⣝⡻⣿⣯⣿⣿⣿⣿⣿⣿⣯⣿⣿⣿⣿⣿]],
            -- [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢟⣯⣭⣥⣴⣶⣿⣿⣿⡿⣿⣻⣯⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⣝⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
            -- [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢏⣱⣾⣿⣿⣿⣿⣿⣟⣿⣽⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣝⡻⣿⣿⣿⣽⣿⣿⣿⣿⣿]],
            -- [[⣿⣿⣿⣿⣿⣿⣿⡿⠛⣱⣾⢧⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣿⠿⣿⣿⣿⣿⣾⡻⣿⣿⣿⣿⣿⣿⣿]],
            -- [[⣿⣿⣿⣿⣿⣿⠋⣴⣿⣿⡏⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣾⣯⣭⣭⣤⣍⣛⡛⢻⣿⠛]],
            -- [[⣿⣿⣿⣿⣿⠏⣼⣿⣿⣿⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⢀⣀]],
            -- [[⣿⣿⣿⡿⠋⡄⣿⣿⣿⡿⣿⣿⢟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣤⣶⣿⣿]],
            -- [[⣿⣿⡿⣴⢀⣷⣿⣿⣿⣿⣟⣱⣿⣿⣿⣿⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
            -- [[⣿⣿⠇⣿⣆⣿⡜⣿⣱⡟⡞⣽⢿⣟⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣝⢿⣿⣿]],
            -- [[⣿⣟⠘⣮⣻⣟⢿⣿⣿⢿⢻⡟⢯⣮⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣝⢿]],
            -- [[⣿⡏⣐⣮⣿⣾⣿⣿⣿⣾⣼⣿⣿⣿⣿⣿⢟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢟⣷⣿⣿⣿⣿⣿⣿⡿⣻⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦]],
            -- [[⡿⢸⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢏⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣫⣿⣿⣿⣿⣿⣿⣿⢟⣿⣿⣿⣿⣿⣷⢹⣿⣿⣹⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿]],
            -- [[⢁⣿⣾⡟⣿⣿⣿⣿⢯⣿⣿⣿⡟⢱⣿⣿⣿⣿⣿⣿⣿⣿⢟⠋⣡⣾⣿⣿⣿⣿⣿⡿⣻⣷⣿⣿⣿⣿⣿⣿⣿⡎⢿⣿⣷⢹⢻⣿⡞⣿⣿⣿⣟⢿⣿⣿]],
            -- [[⣿⣿⣟⣾⣿⣿⣿⢯⣿⣿⣿⡟⣽⣿⣿⣿⣿⡿⢟⡭⢵⣐⣵⣿⣿⣿⣿⣿⡿⣛⣯⣾⡟⣿⣿⣿⣿⣿⣿⣟⣿⢡⣯⢻⣿⣏⡏⠻⣿⡘⣿⣿⣿⣯⡝⣿]],
            -- [[⣿⢯⣾⣿⣿⢿⣿⣼⣿⣿⢏⢸⣿⣿⠟⢛⣠⣾⣟⢚⣿⠟⣿⣿⡛⣻⡯⡠⢰⣿⣿⡟⣸⣿⣿⣿⣿⣿⣟⣼⡟⢸⣿⣏⣿⣿⡇⣧⢻⣿⣸⣿⣿⣿⣿⡜]],
            -- [[⣱⣿⣿⣿⣿⣼⡏⣿⣿⢧⡇⡾⢫⣵⢰⣿⣿⢏⣱⣿⢏⣾⣿⣿⢱⢯⣾⣷⣿⣿⢏⢶⣿⣿⣿⣿⣿⡏⣸⣿⢷⣿⣿⣿⢹⣿⣇⣿⣧⢿⡏⣿⣿⣷⢹⣿]],
            -- [[⣿⣿⣿⣿⣿⣿⣿⣿⣟⡿⡵⣱⡟⡱⢋⡕⠵⠟⠛⣭⣾⠟⠋⠶⣯⣿⣿⣼⣿⢣⢮⣿⣿⣿⣿⡿⢫⢦⣿⣏⡾⠟⣫⣭⢸⡏⣵⣭⣭⡘⡇⢹⣿⣿⡟⣿]],
            -- [[⣿⣿⣿⣿⣫⣽⣿⣿⡿⡽⣽⡟⣈⡌⢮⣶⠿⢫⣾⣯⣵⣿⣿⣧⣼⣿⣿⣿⡟⣵⣿⣿⣿⢿⣫⣾⢛⣾⢯⣾⣾⣿⣿⣿⠾⠟⠛⠛⠿⣿⢿⠂⣿⣿⡇⣿]],
            -- [[⢻⣿⣿⢿⢿⣵⣿⣿⡁⢿⢟⣼⣿⠧⠛⢃⣤⣤⠤⣀⣙⠻⢿⣿⣽⣿⢿⣡⣾⣿⢿⣻⣵⣿⡿⣣⠿⣣⣿⣿⣿⡿⢋⣠⣼⡛⢷⣤⡄⠛⢾⠀⣿⣿⢧⣿]],
            -- [[⡆⢿⣿⢻⣿⣿⣿⡏⣇⠘⣾⣋⠖⢀⣴⣿⣿⣳⣿⣿⣿⡷⣠⢈⢷⣶⣾⣧⣶⣾⣿⣿⠿⢋⣚⣵⣿⣿⣿⡿⠋⣰⣿⣿⣿⢷⡇⣿⣿⣀⡇⠀⣿⣏⡞⣟]],
            -- [[⣿⡎⢸⣿⣿⣿⣿⣿⣿⡘⣿⣇⢠⣿⣿⣿⡟⢿⣿⣿⠿⣵⠃⠈⣿⣿⣿⣿⣷⣯⣿⣶⣿⣿⣿⣿⣿⣿⣿⣷⡞⠿⠿⠿⣻⡟⠀⣿⣿⡿⢜⢀⢟⣾⢣⡜]],
            -- [[⠸⡇⣌⡟⣿⣿⢿⣿⣿⢧⢻⣿⣾⣿⣿⣿⣧⣶⣿⣧⣜⣧⢄⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣖⢾⣷⣽⢗⣴⣿⡟⠀⢞⣼⣿⣳⣾⡇]],
            -- [[⠆⢻⣿⣿⣿⣿⢸⣿⣿⣷⡌⢿⣿⣿⣿⣝⡻⢿⣦⣭⡭⢭⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣽⣓⡶⠾⢟⣯⣾⢇⡟⢸⣿⣿⣿⣟⣄]],
            -- [[⡙⡀⢻⣸⣿⢹⢸⣿⣿⣌⢿⡞⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⢈⣾⡇⣿⣿⣿⣿⢿]],
            -- [[⣧⢆⡈⣿⣿⢸⡏⣿⣿⠸⣿⣍⡹⣿⣿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣫⣷⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣿⠿⠁⣿⣿⣿⢸⡼]],
            -- [[⣿⡎⡅⠸⣿⢸⡇⣿⣿⣴⣝⡛⢷⡝⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣽⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⣾⠏⢰⠀⣿⣿⣿⢸⣇]],
            -- [[⣿⢷⣿⣆⠻⣿⣇⢸⣿⡏⣿⡇⢲⣤⢨⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢃⣪⣴⠷⡿⡆⡟⣿⣿⢻⣿]],
            -- [[⡿⠸⣿⣿⡄⢳⣿⢸⣿⣷⢿⣿⠸⣿⣾⡾⣶⣌⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣡⡸⣸⣿⢋⠷⣴⡇⢇⣿⣿⢸⡿]],
            -- [[⢷⡇⢻⣿⣿⡌⢿⡾⡽⣿⣞⠿⠞⢿⣓⣑⣛⡛⠋⠀⣝⡻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣾⣶⣿⣿⣿⣿⡿⠿⣋⣵⣿⡯⢳⣟⣵⣕⣽⣻⣧⣼⡿⣎⡾⣡]],
            -- [[⣿⡁⣿⣿⣿⣷⠘⣷⣻⣿⣿⣞⣿⣿⣿⣿⣿⡇⠀⠀⠈⠙⠒⠍⠙⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⣋⣥⣾⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⢈⣿⡳⣩⣵⣿]],
            -- [[⣛⣥⡸⣿⣿⣿⣧⠸⣿⣿⣷⣽⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠛⠿⠟⠋⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣼⣿⣿⣿⣿⣿]],
            -- [[⣿⣿⣷⡜⠿⡿⣿⣇⠻⣿⣿⣿⣿⣿⣿⡟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
            -- [[⣿⣿⣿⣿⣿⣾⣶⣽⡀⢻⣿⣿⣿⣿⢣⣎⣀⢀⡀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠿⡌⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
            -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⠤⠤⠤⢤⣤⣤⣤⡤⠴⠖⠒⠋⠉⠉⠀⠀⠀⠀⠉⠢⢄⠀⠐⠀⠀⠀⠀⠀⠀⠐⠀⠀⠀⠀⠀]],
            -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⠐⠒⠚⠋⠉⠀⠀⠀⢀⠀⠄⠐⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⠢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡰⠎⠁⠀⠀⠀⠀⠀⠠⠀⠂⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠢⢄⠀⠀⠀⠂⠀⠀⠀⠀⠀]],
            -- [[⠀⠀⠀⠀⠀⠀⠀⢀⣤⠎⠁⡘⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⣀⠀⠀⠀⠀⠁⢄⠀⠀⠀⠀⠀⠀⠀]],
            -- [[⠀⠀⠀⠀⠀⠀⣴⠋⠀⠀⢰⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠁⠐⠒⠒⠛⠲⠤⢤⡄⠀⣤]],
            -- [[⠀⠀⠀⠀⠀⣰⠃⠀⠀⠀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⡿⠿]],
            -- [[⠀⠀⠀⢀⣴⢻⠀⠀⠀⢀⠀⠀⡠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠛⠉⠀⠀]],
            -- [[⠀⠀⢀⠋⡿⠈⠀⠀⠀⠀⠠⠎⠀⠀⠀⠀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            -- [[⠀⠀⣸⠀⠹⠀⢣⠀⠎⢠⢡⠂⡀⠠⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠢⡀⠀⠀]],
            -- [[⠀⠠⣧⠑⠄⠠⡀⠀⠀⡀⡄⢠⡐⠑⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠢⡀]],
            -- [[⠀⢰⠯⠑⠀⠁⠀⠀⠀⠁⠃⠀⠀⠀⠀⠀⡠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠈⠀⠀⠀⠀⠀⠀⢀⠄⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙]],
            -- [[⢀⡇⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠔⠀⠀⠀⠀⠀⠀⠀⡠⠀⠀⠀⠀⠀⠈⡆⠀⠀⠆⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀]],
            -- [[⡾⠀⠁⢠⠀⠀⠀⠀⡐⠀⠀⠀⢠⡎⠀⠀⠀⠀⠀⠀⠀⠀⡠⣴⠞⠁⠀⠀⠀⠀⠀⢀⠄⠈⠀⠀⠀⠀⠀⠀⠀⢱⡀⠀⠈⡆⡄⠀⢡⠀⠀⠀⠠⡀⠀⠀]],
            -- [[⠀⠀⠠⠁⠀⠀⠀⡐⠀⠀⠀⢠⠂⠀⠀⠀⠀⢀⡠⢒⡊⠯⠊⠀⠀⠀⠀⠀⢀⠤⠐⠁⢠⠀⠀⠀⠀⠀⠀⠠⠀⡞⠐⡄⠀⠰⢰⣄⠀⢧⠀⠀⠀⠐⢢⠀]],
            -- [[⠀⡐⠁⠀⠀⡀⠀⠃⠀⠀⡰⡇⠀⠀⣠⡤⠟⠁⠠⡥⠀⣠⠀⠀⢤⠄⢐⢟⡏⠀⠀⢠⠇⠀⠀⠀⠀⠀⠠⠃⢠⡇⠀⠰⠀⠀⢸⠘⡄⠀⠇⠀⠀⠀⠀⢣]],
            -- [[⠎⠀⠀⠀⠀⠃⢰⠀⠀⡘⢸⢁⡔⠊⡏⠀⠀⡰⠎⠀⡰⠁⠀⠀⡎⡐⠁⠈⠀⠀⡰⡉⠀⠀⠀⠀⠀⢰⠇⠀⡈⠀⠀⠀⡆⠀⠸⠀⠘⡀⢰⠀⠀⠈⡆⠀]],
            -- [[⠀⠀⠀⠀⠀⠀⠀⠀⠠⢀⢊⠎⢠⢎⡴⢪⣊⣠⣤⠒⠁⣠⣴⣉⠐⠀⠀⠃⠀⡜⡑⠀⠀⠀⠀⢀⡔⡙⠀⠰⢁⣠⠔⠒⡇⢰⠊⠒⠒⢧⢸⡆⠀⠀⢠⠀]],
            -- [[⠀⠀⠀⠀⠔⠂⠀⠀⢀⢂⠂⢠⠷⢳⡑⠉⣀⡔⠁⠐⠊⠀⠀⠘⠃⠀⠀⠀⢠⠊⠀⠀⠀⡀⠔⠁⡤⠁⡐⠁⠁⠀⠀⠀⣁⣠⣤⣤⣀⠀⡀⣽⠀⠀⢸⠀]],
            -- [[⡄⠀⠀⡀⡀⠊⠀⠀⢾⡀⡠⠃⠀⣘⣤⡼⠛⠛⣛⠿⠦⣄⡀⠀⠂⠀⡀⠞⠁⠀⡀⠄⠊⠀⢀⠜⣀⠜⠀⠀⠀⢀⡴⠟⠃⢤⡈⠛⢻⣤⡁⣿⠀⠀⡘⠀]],
            -- [[⢹⡀⠀⡄⠀⠀⠀⢰⠸⣧⠁⠴⣩⡿⠋⠀⠀⠌⠀⠀⠀⢈⠟⡷⡈⠉⠁⠘⠉⠁⠀⠀⣀⡴⠥⠊⠀⠀⠀⢀⣴⠏⠀⠀⠀⡈⢸⠀⠀⠿⢸⣿⠀⠰⢡⠠]],
            -- [[⠀⢱⡇⠀⠀⠀⠀⠀⠀⢧⠀⠸⡟⠀⠀⠀⢠⡀⠀⠀⣀⠊⣼⣷⠀⠀⠀⠀⠈⠐⠀⠉⠀⠀⠀⠀⠀⠀⠀⠈⢡⣀⣀⣀⠄⢠⣿⠀⠀⢀⡣⡿⡠⠁⡜⢣]],
            -- [[⣇⢸⠳⢠⠀⠀⡀⠀⠀⡘⡄⠀⠁⠀⠀⠀⠘⠉⠀⠘⠣⠘⡻⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠩⡁⠈⠂⡨⠋⠀⢠⣿⡡⠃⠀⠌⠁⢸]],
            -- [[⣹⡄⠀⠀⠀⠀⡇⠀⠀⠈⢳⡀⠀⠀⠀⠢⢄⡀⠙⠒⢒⡒⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠂⠬⢉⣁⡠⠐⠁⡸⢠⡇⠀⠀⠀⠠⠻]],
            -- [[⢦⢿⡄⠇⠀⡆⡇⠀⠀⠳⡀⢡⠀⠀⠀⠀⠀⠀⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡷⠁⢸⠀⠀⠀⠀⡀]],
            -- [[⠘⡹⢷⠀⠀⡇⢰⠀⠀⣇⠀⠲⢆⠀⠀⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠔⠈⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡿⠀⣀⣾⠀⠀⠀⡇⢃]],
            -- [[⠀⢱⢺⣇⠀⡇⢸⠀⠀⠋⠢⢤⡈⢢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠂⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⠁⣰⡏⣿⠀⠀⠀⡇⠸]],
            -- [[⠀⡈⠀⠹⣄⠀⠸⡇⠀⢰⠀⢸⡍⠛⡗⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡼⠕⠋⣈⢀⢹⢠⠀⠀⡄⠀]],
            -- [[⢀⣇⠀⠀⢻⡌⠀⡇⠀⠈⡀⠀⣇⠀⠁⢁⠉⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⢇⠇⠀⡴⣈⠋⢸⡸⠀⠀⡇⢀]],
            -- [[⡈⢸⡄⠀⠀⢳⡀⢁⢂⠀⠡⣀⣡⡀⠬⠮⠤⢤⣴⣿⠢⢄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠉⠀⠀⠀⠀⢀⣀⠴⠊⠀⢐⡌⠠⠊⠪⠂⠄⠘⠃⢀⠱⢁⠞]],
            -- [[⠀⢾⠀⠀⠀⠈⣧⠈⠄⠀⠀⠡⠀⠀⠀⠀⠀⢸⣿⣿⣷⣦⣭⣲⣦⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠴⠚⠁⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⡷⠀⢌⠖⠊⠀]],
            -- [[⠤⠚⢇⠀⠀⠀⠘⣇⠀⠀⠈⠂⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⣤⣀⣠⣴⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠃⠀⠀⠀⠀⠀]],
            -- [[⠀⠀⠈⢣⣀⢀⠀⠸⣄⠀⠀⠀⠀⠀⠀⢠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            -- [[⠀⠀⠀⠀⠀⠁⠉⠂⢿⡄⠀⠀⠀⠀⡜⠱⠿⡿⢿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣀⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        }

    dashboard.section.buttons.val = {
        dashboard.button("l", "🖫  > last layout", "<cmd>SessionLoadLast<cr>"), -- "<cmd>lua require('persistence').load()<CR>"),
        dashboard.button("s", "🖪  > layouts", "<cmd>Telescope persisted<cr>"), -- "<cmd>lua require('persistence').load()<CR>"),
        dashboard.button("p", "🗟  > projects", "<cmd>lua require'telescope'.extensions.projects.projects{}<CR>"),
        dashboard.button("r", "  > recent", ":Telescope oldfiles<CR>"),
        dashboard.button("e", "  > new file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "🗒 > find file", ":Telescope find_files<CR>"),
        dashboard.button("q", "🖬  > quit nvim", ":qa<CR>"),
    }
    alpha.setup(dashboard.opts)
    -- require("alpha").setup(require("alpha.themes.dashboard").config)
end

-- b0o/incline.nvim
M.config_incline = function()
    local field_format = {
        name = {
            guifg = "#d95466",
            -- guibg = "#acc7ae",
        },
        num = {
            guifg = "#968c81",
        },
        modified = {
            guifg = "#d95466",
            -- guifg = "#070707",
            -- guifg = "#4af478",
        },
        blocks = {
            gui = "bold",
            guifg = "#070707",
        },
    }

    -- local start = vim.tbl_extend("force", { "" }, field_format.blocks)
    -- local stop = vim.tbl_extend("force", { "" }, field_format.blocks)

    local function get_diagnostic_label(props)
        local labels = {}
        if not vim.api.nvim_buf_is_valid(props.buf) then
            return labels -- Return an empty table if buffer is not valid
        end
        local icons = { error = " ", warn = " ", hint = "❃", info = "" }
        local severity_map = {
            error = vim.diagnostic.severity.ERROR,
            warn = vim.diagnostic.severity.WARN,
            info = vim.diagnostic.severity.INFO,
            hint = vim.diagnostic.severity.HINT,
        }
        for severity, icon in pairs(icons) do
            local n = #vim.diagnostic.get(props.buf, { severity = severity_map[severity] })
            if n > 0 then
                table.insert(labels, { icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity })
            end
        end
        -- for severity, icon in pairs(icons) do
        --     local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
        --     if n > 0 then
        --         table.insert(label, { icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity })
        --     end
        -- end
        if #labels > 0 then
            table.insert(labels, 1, " ")
            table.insert(labels, { "|" })
        end
        return labels
    end
    local function get_git_diff(props)
        local icons = { removed = "", changed = "", added = "" }
        local labels = {}
        -- local signs = vim.api.nvim_buf_get_var(props.buf, "gitsigns_status_dict")
        local success, signs = pcall(vim.api.nvim_buf_get_var, props.buf, "gitsigns_status_dict")
        if not success then
            return labels -- Return an empty table if gitsigns_status_dict is not found
        end
        -- local signs = vim.b.gitsigns_status_dict
        for name, icon in pairs(icons) do
            if tonumber(signs[name]) and signs[name] > 0 then
                table.insert(labels, { icon .. " " .. signs[name] .. " ", group = "Diff" .. name })
            end
        end
        if #labels > 0 then
            table.insert(labels, 1, " ")
            table.insert(labels, { "|" })
        end
        return labels
    end
    require("incline").setup({
        render = function(props)
            -- local bufnum = props.buf
            local buffullname = vim.api.nvim_buf_get_name(props.buf)
            local bufname_t = vim.fn.fnamemodify(buffullname, ":t")

            local path = buffullname or ""
            local filename = bufname_t -- vim.fn.fnamemodify(path, ":t")
            local tail = vim.fn.fnamemodify(path, ":p:h:t")
            local all_filenames = M.get_all_buffer_filenames()
            if all_filenames[filename] and all_filenames[filename] > 1 then
                bufname_t = tail .. "/" .. filename
            end

            -- local bufname_t = vim.fn.fnamemodify(buffullname, ":t")
            -- local bufname_t = M.name_formatter(props.buf)
            local bufname = (bufname_t and bufname_t ~= "") and bufname_t or "[No Name]"

            -- optional devicon
            local devicon = { " " }
            local success, nvim_web_devicons = pcall(require, "nvim-web-devicons")
            if success then
                local bufname_r = vim.fn.fnamemodify(buffullname, ":r")
                local bufname_e = vim.fn.fnamemodify(buffullname, ":e")
                local base = (bufname_r and bufname_r ~= "") and bufname_r or bufname
                local ext = (bufname_e and bufname_e ~= "") and bufname_e or vim.fn.fnamemodify(base, ":t")
                local ic, hl = nvim_web_devicons.get_icon(base, ext, { default = true })
                devicon = {
                    " ",
                    ic,
                    " ",
                    group = hl,
                }
            end
            -- buffer name
            local display_bufname = vim.tbl_extend("force", { bufname, " " }, field_format.name)
            -- modified indicator
            local modified_icon = {}
            if vim.api.nvim_get_option_value("modified", { buf = props.buf }) then
                modified_icon = vim.tbl_extend("force", { "● " }, field_format.modified)
                display_bufname.guifg = field_format.modified.guifg
            end

            -- buffer number
            -- local display_bufnum = vim.tbl_extend("force", { bufnum, " " }, field_format.num)

            -- example: █▓   incline-nvim.lua 13  ▓█
            return {
                -- start,
                { get_diagnostic_label(props) },
                { get_git_diff(props) },
                devicon,
                display_bufname,
                modified_icon,
                -- display_bufnum,
                -- stop,
            }
        end,

        window = {
            padding = {
                left = 0,
                right = 0,
            },
            margin = {
                horizontal = 0,
                vertical = 1,
            },
            placement = {
                horizontal = "right",
                vertical = "top",
            },
            winhighlight = {
                active = {
                    -- EndOfBuffer = "None",
                    Normal = "InclineActive", -- "Search", -- "InclineNormal",
                    -- Search = "None",
                },
                inactive = {
                    -- EndOfBuffer = "None",
                    Normal = "InclineInactive", -- "InclineNormalNC",
                    -- Search = "None",
                },
            },
        },
        highlight = {
            groups = {
                InclineNormal = { guibg = "#000000", gui = "bold" },
                InclineNormalNC = {
                    default = true,
                    group = "NormalFloat",
                },
                InclineActive = { guibg = "#000000", gui = "bold" },
                InclineInactive = {
                    default = true,
                    group = "NormalFloat",
                },
            },
        },
        hide = {
            cursorline = true, -- "focused_win",
        },
    })
end

-- ldelossa/nvim-ide
M.config_nvim_ide = function()
    -- local bufferlist = require("ide.components.bufferlist")
    local explorer = require("ide.components.explorer")
    local outline = require("ide.components.outline")
    local callhierarchy = require("ide.components.callhierarchy")
    local timeline = require("ide.components.timeline")
    local terminal = require("ide.components.terminal")
    -- local terminalbrowser = require("ide.components.terminal.terminalbrowser")
    local changes = require("ide.components.changes")
    local commits = require("ide.components.commits")
    local branches = require("ide.components.branches")
    local bookmarks = require("ide.components.bookmarks")

    require("ide").setup({
        icon_set = "default", -- "nerd", "codicon", "default"
        log_level = "info", -- "debug", "warn", "info", "error"
        -- Component specific configurations and default config overrides.
        components = {
            -- The global keymap is applied to all Components before construction.
            -- It allows common keymaps such as "hide" to be overridden, without having
            -- to make an override entry for all Components.
            --
            -- If a more specific keymap override is defined for a specific Component
            -- this takes precedence.
            global_keymaps = {
                -- example, change all Component's hide keymap to "h"
                -- hide = h
                close = "X",
                collapse = "zc",
                collapse_all = "zC",
                details = "d",
                expand = "zo",
                help = "?",
                hide = "<C-[>",
                jump = "<CR>",
            },
            Bookmarks = {
                default_height = nil,
                disabled_keymaps = false,
                hidden = false,
                keymaps = {
                    jump_split = "<c-x>",
                    jump_tab = "<c-t>",
                    jump_vsplit = "<c-v>",
                    remove_bookmark = "D",
                },
            },
            Branches = {
                keymaps = {
                    create_branch = "c",
                    refresh = "r",
                    pull = "p",
                    push = "P",
                    set_upstream = "s",
                    help = "?",
                },
            },
            Changes = {
                keymaps = {
                    add = "s",
                    amend = "a",
                    commit = "c",
                    diff = "<CR>",
                    diff_tab = "t",
                    edit = "e",
                    expand = "zo",
                    help = "?",
                    restore = "r",
                },
            },
            Commits = {
                keymaps = {
                    checkout = "c",
                    details_tab = "D",
                    diff = "<CR>",
                    diff_split = "s",
                    diff_tab = "t",
                    diff_vsplit = "v",
                    help = "?",
                    refresh = "r",
                },
            },
            Timeline = {
                keymaps = {
                    help = "?",
                    hide = "<C-[>",
                    jump = "<CR>",
                    jump_split = "<C-x>",
                    jump_tab = "<c-t>",
                    jump_vsplit = "<C-v>",
                },
            },
            Explorer = {
                keymaps = require("ide.components.explorer.presets").nvim_tree,
            },
            Outline = {
                keymaps = {
                    help = "?",
                    hide = "<C-[>",
                    jump = "<CR>",
                    jump_split = "<C-x>",
                    jump_tab = "<c-t>",
                    jump_vsplit = "<C-v>",
                },
            },
        },
        -- default panel groups to display on left and right.
        panels = {
            left = "explorer",
            right = "git",
        },
        -- panels defined by groups of components, user is free to redefine the defaults
        -- and/or add additional.
        panel_groups = {
            explorer = {
                explorer.Name,
                outline.Name,
                callhierarchy.Name,
                bookmarks.Name, -- bufferlist.Name,
                -- terminalbrowser.Name,
            },
            terminal = { terminal.Name },
            git = { changes.Name, commits.Name, timeline.Name, branches.Name },
        },
        -- workspaces config
        workspaces = {
            -- which panels to open by default, one of: 'left', 'right', 'both', 'none'
            auto_open = "left",
        },
        -- default panel sizes for the different positions
        panel_sizes = {
            left = 30,
            right = 30,
            bottom = 15,
        },
    })
end

-- folke/edgy.nvim
M.init_edgy = function()
    -- views can only be fully collapsed with the global statusline
    -- Default splitting will cause your main splits to jump when opening an edgebar.
    -- To prevent this, set `splitkeep` to either `screen` or `topline`.
    vim.opt.splitkeep = "screen"
end
M.opts_edgy = {
    keys = {
        -- close window
        ["<leader>qa"] = function(win)
            win:close()
        end,
        -- hide window
        ["<c-q>"] = function(win)
            win:hide()
        end,
        -- close sidebar
        ["<leader>Q"] = function(win)
            win.view.edgebar:close()
        end,
        -- next open window
        ["]w"] = function(win)
            win:next({
                visible = true,
                focus = true,
            })
        end,
        -- previous open window
        ["[w"] = function(win)
            win:prev({
                visible = true,
                focus = true,
            })
        end,
        -- next loaded window
        ["]W"] = function(win)
            win:next({
                pinned = false,
                focus = true,
            })
        end,
        -- prev loaded window
        ["[W"] = function(win)
            win:prev({
                pinned = false,
                focus = true,
            })
        end,
        -- increase width
        ["<c-w>>"] = function(win)
            win:resize("width", 2)
        end,
        -- decrease width
        ["<c-w><lt>"] = function(win)
            win:resize("width", -2)
        end,
        -- increase height
        ["<c-w>+"] = function(win)
            win:resize("height", 2)
        end,
        -- decrease height
        ["<c-w>-"] = function(win)
            win:resize("height", -2)
        end,
        -- reset all custom sizing
        ["<c-w>="] = function(win)
            win.view.edgebar:equalize()
        end,
    },
    bottom = { -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
        {
            ft = "toggleterm",
            size = {
                height = 0.2,
            },
            -- exclude floating windows
            filter = function(buf, win)
                return vim.api.nvim_win_get_config(win).relative == ""
            end,
        },
        {
            ft = "lazyterm",
            title = "LazyTerm",
            size = {
                height = 0.2,
            },
            filter = function(buf)
                return not vim.b[buf].lazyterm_cmd
            end,
        },
        "Trouble",
        {
            ft = "qf",
            title = "QuickFix",
        },
        {
            ft = "help",
            size = {
                height = 20,
            },
            -- only show help buffers
            filter = function(buf)
                return vim.bo[buf].buftype == "help"
            end,
        },
        {
            ft = "spectre_panel",
            size = {
                height = 0.2,
            },
        },
    },
    left = { -- Neo-tree filesystem always takes half the screen height
        {
            title = "Neo-Tree",
            ft = "neo-tree",
            filter = function(buf)
                return vim.b[buf].neo_tree_source == "filesystem"
            end,
            size = {
                height = 0.6,
            },
        },
        {
            ft = "Outline",
            pinned = true,
            open = "OutlineOpen", -- "AerialOpen!",-- "SymbolsOutlineOpen",
        },
        {
            title = "Neo-Tree Git",
            ft = "neo-tree",
            filter = function(buf)
                return vim.b[buf].neo_tree_source == "git_status"
            end,
            pinned = true,
            open = "Neotree position=right git_status",
        }, -- {
        --   title = "Neo-Tree Buffers",
        --   ft = "neo-tree",
        --   filter = function(buf)
        --     return vim.b[buf].neo_tree_source == "buffers"
        --   end,
        --   pinned = true,
        --   open = "Neotree position=top buffers",
        -- },
        -- any other neo-tree windows
        "neo-tree",
    },
}

-- xiyaowong/transparent.nvim
M.config_transparent = function()
    vim.cmd([[hi StatusLine ctermbg=0 cterm=NONE]])
    require("transparent").setup({ -- Optional, you don't have to run setup.
        -- groups = { -- table: default groups
        --     "Normal",
        --     "NormalNC",
        --      "Comment",
        --      "Constant",
        --      "Special",
        --      "Identifier",
        --      "Statement",
        --      "PreProc",
        --      "Type",
        --      "Underlined",
        --      "Todo",
        --      "String",
        --      "Function",
        --      "Conditional",
        --      "Repeat",
        --      "Operator",
        --      "Structure",
        --      "LineNr",
        --      "NonText",
        --      "SignColumn",
        --      "CursorLineNr",
        --      "EndOfBuffer",
        --      "InsertEnter",
        --  },
        extra_groups = { "CursorLine", "NormalFloat", "TablineFill" }, -- table: additional groups that should be cleared
        exclude_groups = {}, -- table: groups you don't want to clear
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
        routes = {
            {
                view = "notify",
                filter = {
                    event = "msg_showmode",
                },
            },
        },
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = false, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true, -- add a border to hover docs and signature help
        },
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
            -- Set to false to disable the vim.ui.input implementation
            enabled = true,

            -- Default prompt string
            default_prompt = "Input:",

            -- Can be 'left', 'right', or 'center'
            title_pos = "left",

            -- When true, <Esc> will close the modal
            insert_only = true,

            -- When true, input will start in insert mode.
            start_in_insert = true,

            -- These are passed to nvim_open_win
            border = "rounded",
            -- 'editor' and 'win' will default to being centered
            relative = "cursor",

            -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            prefer_width = 40,
            width = nil,
            -- min_width and max_width can be a list of mixed types.
            -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
            max_width = { 140, 0.9 },
            min_width = { 20, 0.2 },

            buf_options = {},
            win_options = {
                -- Disable line wrapping
                wrap = false,
                -- Indicator for when text exceeds window
                list = true,
                listchars = "precedes:…,extends:…",
                -- Increase this for more context when text scrolls off the window
                sidescrolloff = 0,
            },

            -- Set to `false` to disable
            mappings = {
                n = {
                    ["<Esc>"] = "Close",
                    ["<CR>"] = "Confirm",
                },
                i = {
                    ["<C-c>"] = "Close",
                    ["<CR>"] = "Confirm",
                    ["<Up>"] = "HistoryPrev",
                    ["<Down>"] = "HistoryNext",
                },
            },

            override = function(conf)
                -- This is the config that will be passed to nvim_open_win.
                -- Change values here to customize the layout
                return conf
            end,

            -- see :help dressing_get_config
            get_config = nil,
        },
        select = {
            -- Set to false to disable the vim.ui.select implementation
            enabled = true,

            -- Priority list of preferred vim.select implementations
            backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

            -- Trim trailing `:` from prompt
            trim_prompt = true,

            -- Options for telescope selector
            -- These are passed into the telescope picker directly. Can be used like:
            -- telescope = require('telescope.themes').get_ivy({...})
            telescope = nil,

            -- Options for fzf selector
            fzf = {
                window = {
                    width = 0.5,
                    height = 0.4,
                },
            },

            -- Options for fzf-lua
            fzf_lua = {
                -- winopts = {
                --   height = 0.5,
                --   width = 0.5,
                -- },
            },

            -- Options for nui Menu
            nui = {
                position = "50%",
                size = nil,
                relative = "editor",
                border = {
                    style = "rounded",
                },
                buf_options = {
                    swapfile = false,
                    filetype = "DressingSelect",
                },
                win_options = {
                    winblend = 0,
                },
                max_width = 80,
                max_height = 40,
                min_width = 40,
                min_height = 10,
            },
            -- Options for built-in selector
            builtin = {
                -- Display numbers for options and set up keymaps
                show_numbers = true,
                -- These are passed to nvim_open_win
                border = "rounded",
                -- 'editor' and 'win' will default to being centered
                relative = "editor",
                buf_options = {},
                win_options = {
                    cursorline = true,
                    cursorlineopt = "both",
                },
                -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                -- the min_ and max_ options can be a list of mixed types.
                -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
                width = nil,
                max_width = { 140, 0.8 },
                min_width = { 40, 0.2 },
                height = nil,
                max_height = 0.9,
                min_height = { 10, 0.2 },
                -- Set to `false` to disable
                mappings = {
                    ["<Esc>"] = "Close",
                    ["<C-c>"] = "Close",
                    ["<CR>"] = "Confirm",
                },
                override = function(conf)
                    -- This is the config that will be passed to nvim_open_win.
                    -- Change values here to customize the layout
                    return conf
                end,
            },
            -- Used to override format_item. See :help dressing-format
            format_item_override = {},
            -- see :help dressing_get_config
            get_config = nil,
        },
    })
end

-- petertriho/nvim-scrollbar
M.config_nvim_scrollbar = function()
    require("scrollbar").setup({
        -- handle = {
        -- 	color = colors.bg_highlight,
        -- },
        -- marks = {
        -- 	Search = { color = colors.orange },
        -- 	Error = { color = colors.error },
        -- 	Warn = { color = colors.warning },
        -- 	Info = { color = colors.info },
        -- 	Hint = { color = colors.hint },
        -- 	Misc = { color = colors.purple },
        -- },
    })
    require("scrollbar.handlers.search").setup({
        -- hlslens config overrides
    })
    -- require("hlslens").setup({
    -- build_position_cb = function(plist, _, _, _)
    -- 	require("scrollbar.handlers.search").handler.show(plist.start_pos)
    -- end,
    -- })
    -- vim.cmd([[
    --        augroup scrollbar_search_hide
    --            autocmd!
    --            autocmd CmdlineLeave : lua require('scrollbar.handlers.search').handler.hide()
    --        augroup END
    --    ]])
    require("scrollbar.handlers.gitsigns").setup()
end

return M
