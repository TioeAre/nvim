local M = {}
local filetype = require("utils.filetype")

-- folke/snacks.nvim
M.opt_snacks = {
	bigfile = {           -- create `bigfile` filetype
		notify = true,
		size = 5 * 1024 * 1024, -- 10 MB
		line_length = 10000, -- average line length (useful for minified files)
	},
	dashboard = {
		enabled = true,
		preset = {
			header = [[
  ⠀⠀⠀⠀⠔⣨⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢉⣼⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣶⣦⣉⠐
 ⠀⠀⠀⠸⠔⣱⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢋⣠⣴⣿⣿⣿⣿⣿⣟⣧⢿⣿⣷⢌⠙⢿⣿⣿⣿⣿⣦⡄
  ⠀⠀⡔⢁⣼⢯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢛⣩⣶⣿⣿⣿⣿⣿⣿⣿⣿⡿⢹⣦⠹⣿⣾⣿⣦⡙⠿⣿⣿⣿⡇⠀⠀
  ⠀⠀⡇⠸⢣⣿⡿⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣯⣵⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⢸⣿⣷⡈⢷⣿⣿⣿⣦⡘⢿⣿⣇⠀⠀
  ⠀⢀⡴⢂⣾⡿⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⢸⣿⣿⣿⣄⢹⣿⣿⣿⣽⣦⣹⡿⠀⠀
  ⠀⣿⡇⢸⡟⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢫⣿⣿⢟⣿⠋⣾⣿⣿⠋⣼⣿⡟⠀⢠⢢⣿⣿⣿⣿⣧⢿⣿⡿⣷⢹⣧⠑⡀⢸
  ⠀⠉⠛⠸⢀⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⡿⠟⢋⣀⣴⠿⠋⠁⡾⠃⣸⣿⠟⠁⣼⣿⠏⢀⣴⣿⠈⣿⣿⡏⣿⣿⣾⣿⣧⣿⠘⣿⡆⠐⡈
    ⠉⡀⡘⣼⣿⣿⣿⣿⣿⡟⢡⡿⠁⠀⠠⠚⠋⠁⠉⠀⠺⠡⢀⣿⠏⢀⣾⡿⣃⣴⣿⢏⡇⠃⢸⣿⠇⢹⣿⣿⣿⣿⢸⠀⣿⣷⠀⠘⡀
    ⣃⢧⢡⣿⣿⣿⣿⣿⣿⠃⣼⠷⡛⣿⡿⠒⠢⢀⠀⠄⠃⠀⠀⣟⣴⣿⣽⣾⣿⡿⠃⣼⣈⣀⢸⣿⠀⢈⣿⣿⣿⡟⢸⢸⡇⣿⠀⠀⡇
    ⣷⠀⣸⣿⣿⣿⣿⣿⣿⠀⠁⠀⣷⡈⠁⠀⠀⠈⠈⠂⢄⠀⠤⡿⠟⠛⢉⠵⠋⠀⡼⠋⠀⠀⣸⣃⡀⠀⣿⡿⢻⡇⠈⣸⡇⣿⠀⠀⣧
⠀⠀⠀⠀⢰⡄⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⡛⢿⣥⣤⡤⠀⠀⠀⠀⠀⠀⠃⠀⠈⠀⠀⠀⠈⠠⣄⡖⠉⠁⠈⠙⣦⠟⢁⣿⢃⣶⡟⡇⡏⠀⢠
   ⠀⢸⠀⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠑⠂⠀⠀⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣤⣀⠀⠀⠀⠸⣢⣾⣟⢬⣿⣻⠷⠀⢀
⠀⠀⠀⠀⢸⠀⣿⣿⣿⣿⣿⣿⣿⠰⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠛⣉⠀⠄⠀⣼⣿⣿⡏⣿⣿⡞⡀⣠
⠀⠀⠀⠀⢸⠀⣿⣿⣿⣿⣿⣿⣿⣄⡀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⡠⠂⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣣
⠀⠀⠀⠀⠘⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢺⣿⣿⣿⣿⣿⣿⣷
⠀⠀⠀⠀⠀⠁⢼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣄⠀⠀⠀⠀⠀⠀⠉⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣾⣿⣿⣿⣿⣿⣿
⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠿⣿⣿⣏⠩⠉⣉⠛⡛⠈⠀⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⣾⣿⣿⣿⣿⣿⣿⡟⠉⠉
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠛⠆⠀⠀⠐⠀⡀⠀⠀⠁⠢⢀⠀⠀⠀⠀⢀⠀⢤⣶⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⡇
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠁⠀⠀⠀⠀⠀⠒⠠⢈⠢⡀⠀⠀⠀⠈⠀⠂⠁⠀⠂⢸⣿⣿⣦⣌⡛⢏⡟⣿⣿⣿⣿⣷
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣀⣄⡄⢀⠀⠀⠀⠀⠀⠀⠀⠈⠂⠄⡀⠀⠀⣆⠐⠀⠀⠩⣿⣿⣿⣿⣿⡆⣿⠿⣿⣿⣿⣿
⠀⠀⠀⠀⠀⠀⠀⠀⡠⠊⠁⠈⢿⣄⠻⣷⣦⣤⣀⣀⣀⣀⣀⣀⣠⠕⡀⠀⠃⣀⣀⣤⡿⣿⣿⣿⣿⡗⢃⠀⣿⣿⣿⣿⠀⠀⠇
⠀⠀⠀⠀⠀⠀⠀⠂⠀⠀⠀⠀⠀⠙⢦⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠐⠀⠀⢹⣿⣿⣷⢱⠙⣿⣿⡇⠄⢰⠭⠭⠭⠭⢥⠐⠢⠄
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⢢⠀⢸⣿⣿⣿⣜⡶⠘⠛⠃⡏⣘⡛⠛⠛⠛⠋⠀⢀⠀]],
			keys = {
				{ icon = " ", key = "l", desc = "Restore Session", action = ":SessionLoadLast" },
				{ icon = " ", key = "s", desc = "Find Sessions", action = ":Telescope persisted" },
				{ icon = " ", key = "p", desc = "Find Projects", action = ":lua require'telescope'.extensions.projects.projects{}" },
				{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
				{ icon = " ", key = "e", desc = "New File", action = ":ene | startinsert" },
				{ icon = " ", key = "f", desc = "Find files", action = ":lua Snacks.dashboard.pick('files')" },
				{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
			},
		},
		sections = {
			{ section = "header" },
			{ pane = 2, section = "keys", indent = 2, padding = 1 },
			{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
			{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
			{
				pane = 2,
				icon = " ",
				title = "Git Status",
				section = "terminal",
				enabled = function()
					return Snacks.git.get_root() ~= nil
				end,
				cmd = "git status --short --branch --renames",
				height = 5,
				padding = 1,
				ttl = 5 * 60,
				indent = 3,
			},
			{ pane = 2, section = "startup" },
		},
	},
	explorer = { enabled = false },
	-- image = { -- Snacks.image.hover(), Show the image at the cursor in a floating window
	--     doc = {
	--         enabled = true,
	--         inline = true,
	--         float = true,
	--         max_width = 80,
	--         max_height = 40,
	--     },
	--     img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments", ".assets" },
	-- },
	image = { enabled = false },
	indent = {
		indent = {
			priority = 1,
			enabled = true,
			char = "▏", -- ⡇, ⡆, ⠇, ▎, ▏, │
			only_scope = false,
			only_current = false,
			-- hl = "SnacksIndent",
			hl = {
				"SnacksIndent1",
				"SnacksIndent2",
				"SnacksIndent3",
				"SnacksIndent4",
				"SnacksIndent5",
				"SnacksIndent6",
				"SnacksIndent7",
				"SnacksIndent8",
			},
		},
		-- style "out"|"up_down"|"down"|"up"
		animate = {
			enabled = false,
		},
		scope = {
			enabled = true, -- enable highlighting the current scope
			priority = 1,
			char = "▎", -- ▎,╎
			underline = true, -- underline the start of the scope
			only_current = false, -- only show scope in the current window
			hl = "SnacksIndentScope",
		},
		chunk = {
			-- when enabled, scopes will be rendered as chunks, except for the
			-- top-level scope which will be rendered as a scope.
			enabled = false,
			-- only show chunk scopes in the current window
			only_current = false,
			priority = 200,
			hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
			char = {
				-- corner_top = "┌",
				-- corner_bottom = "└",
				corner_top = "╭",
				corner_bottom = "╰",
				horizontal = "─",
				vertical = "│",
				arrow = ">",
			},
		},
		filter = function(buf)
			return vim.g.snacks_indent ~= false
				and vim.b[buf].snacks_indent ~= false
				and not filetype.is_value_in_list(vim.bo[buf].buftype, filetype.excluded_buftypes)
				and not filetype.is_value_in_list(vim.bo[buf].filetype, filetype.excluded_filetypes)
		end,
	},
	input = { enabled = true },
	lazygit = { enabled = true },
	notifier = {
		level = vim.log.levels.WARN,
		refresh = 50, -- refresh at most every 50ms
	},
	picker = {
		matcher = {
			fuzzy = true,
			smartcase = true,
			ignorecase = false,
			sort_empty = false,
			filename_bonus = true,
			file_pos = true,
			cwd_bonus = false,
			frecency = false,
			history_bonus = false,
		},
		win = {
			input = {
				keys = {
					["<c-x>"] = { "edit_split", mode = { "i", "n" } },
				},
			},
			list = {
				keys = {
					["<c-x>"] = { "edit_split", mode = { "i", "n" } },
				},
			},
		},
	},
	profiler = { enable = false }, -- only can be used to profile `autocmd`
	quickfile = { enable = false }, -- { exclude = {}, },
	rename = { enabled = false },
	scope = { enabled = true },
	scratch = { enabled = true },
	scroll = { enabled = false },
	statuscolumn = { enabled = true },
	terminal = { enabled = true },
	words = { enabled = true },
}
M.keys_snacks = {}

M.init_snacks = function() end

return M
