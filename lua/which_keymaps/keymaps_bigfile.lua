local wk = require("which-key")

wk.add({
	-- echasnovski/mini.surround
	{
		"m",
		desc = "mini.surround",
	},
	-- kevinhwang91/nvim-ufo
	{
		"za",
		desc = "ufo/trouble toggle current fold",
	},
	{
		"zA",
		desc = "ufo/trouble toggle current folds of this file",
	},
	{
		"zc",
		"<cmd>lua require('ufo').closeFoldsWith()<cr>",
		desc = "ufo/trouble close fold",
	},
	{
		"zC",
		"<cmd>lua require('ufo').closeAllFolds()<cr>",
		desc = "ufo/trouble close all folds",
	},
	{
		"zo",
		"<cmd>lua require('ufo').openFoldsExceptKinds()<cr>",
		desc = "ufo/trouble open fold",
	},
	{
		"zO",
		"<cmd>lua require('ufo').openAllFolds()<cr>",
		desc = "ufo/trouble open all folds",
	},
})

wk.add({
	mode = "n",
	{ -- <leader> b
		-- folke/snacks.nvim
		{
			"<leader>bc",
			-- "<cmd> bd <cr>",
			"<cmd> lua require('snacks').bufdelete() <cr>", -- bufdelete.all(), bufdelete.other(), bufdelete.delete()
			desc = "close current buffer",
		},
		{
			"<leader>bd",
			"<cmd> BufferLinePickClose <cr>",
			desc = "close certain buffer",
		},
		-- j-morano/buffer_manager.nvim
		{
			"<leader>bf",
			"<cmd> lua require('buffer_manager.ui').toggle_quick_menu() <cr>",
			desc = "toggle buffer manager",
		},
		{
			"<leader>bg",
			"<cmd> BufferLinePick <cr>",
			desc = "switch to certain buffer",
		},
		{
			"<leader>bj",
			"<cmd> BufferLineMovePrev <cr>",
			desc = "buffer move previous",
		},
		{
			"<leader>bk",
			"<cmd> BufferLineMoveNext <cr>",
			desc = "buffer move next",
		},
		{
			"<leader>bm",
			"<cmd> BufferLineCyclePrev <cr>",
			desc = "switch to previous buffer",
		},
		{
			"<leader>bn",
			"<cmd> BufferLineCycleNext <cr>",
			desc = "switch to next buffer",
		},
		{
			"<leader>bp",
			"<cmd> BufferLineTogglePin <cr>",
			desc = "pin buffer",
		},
	},
	{ -- <leader> c
		{
			"<leader>cf",
			"<cmd> BufferLineCloseLeft <cr>",
			desc = "close left buffers",
		},
		-- danymat/neogen
		{
			"<leader>cg",
			"<cmd> Neogen <cr>",
			desc = "neogen generate docs",
		},
		{
			"<leader>co",
			"<cmd> BufferLineCloseOthers <cr>",
			desc = "close other buffers",
		},
		{
			"<leader>cr",
			"<cmd> BufferLineCloseRight <cr>",
			desc = "close right buffers",
		},
		-- s1n7ax/nvim-window-picker
		{
			"<leader>cw",
			function()
				local window_number = require("window-picker").pick_window()
				if window_number then
					vim.api.nvim_win_close(window_number, false)
				end
			end,
			desc = "close window",
		},
	},
	{ -- <leader> f
		{
			"<leader>fb",
			"<cmd>lua require('snacks').picker.buffers() <cr>",
			desc = "snacks find buffers",
		},
		{
			"<leader>ff",
			"<cmd>lua require('snacks').picker.smart() <cr>",
			desc = "snacks find files",
		},
		{
			"<leader>fg",
			"<cmd>lua require('snacks').picker.grep() <cr>",
			desc = "snacks live grep string",
		},
		{
			"<leader>fo",
			"<cmd> Telescope oldfiles <cr>",
			desc = "telescope find recent files",
		},
		{
			"<leader>fpp",
			"<cmd>lua require('snacks').picker.projects() <cr>",
			desc = "snacks find projects",
		},
		-- olimorris/persisted.nvim
		{
			"<leader>fps",
			"<cmd>Telescope persisted<cr>",
			desc = "telescope find persisted sessions",
		},
		-- nvim-telescope/telescope.nvim
		{
			"<leader>fr",
			"<cmd>Telescope resume<cr>",
			desc = "telescope resume last search window",
		},
		{
			"<leader>fs",
			"<cmd>lua require('snacks').picker.resume() <cr>",
			desc = "snacks resume last search window",
		},
		{
			"<leader>fu",
			"<cmd>lua require('snacks').picker.undo() <cr>",
			desc = "snacks find undo",
		},
		-- AckslD/nvim-neoclip.lua
		{
			"<leader>fv",
			"<cmd>lua require('snacks').picker.registers() <cr>",
			desc = "snacks find clipboard",
		},
	},
	{
		"<leader>gg",
		-- function()
		-- 	require("toggleterm.terminal").Terminal
		-- 		:new({
		-- 			cmd = "lazygit",
		-- 			hidden = true,
		-- 			direction = "float",
		-- 			float_opts = {
		-- 				border = "rounded",
		-- 			},
		-- 		})
		-- 		:toggle()
		-- end,
		"<cmd> lua require('snacks').lazygit() <cr>", -- lazygit.open(), lazygit.log(), lazygit.log_file()
		desc = "snacks lazygit toggle",
	},
	{ -- <leader> h
		-- gaborvecsei/memento.nvim
		{
			"<leader>hb",
			"<cmd> lua require('memento').toggle() <cr>",
			desc = "toggle memento buffer history",
		},
		{
			"<leader>hc",
			"<cmd> lua require('memento').clear_history() <cr>",
			desc = "clear memento buffer history",
		},
	},
	{ -- <leader> l
		{
			"<leader>ld",
			"<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
			desc = "open trouble document_diagnostics",
		},
		{
			"<leader>lt",
			"<cmd>TodoTrouble<cr>",
			desc = "open trouble todo",
		},
		-- folke/todo-comments.nvim
		{
			"<leader>lw",
			"<cmd>Trouble diagnostics toggle focus=true<cr>",
			desc = "open trouble workspace_diagnostics",
		},
	},
	{ -- <leader> m
		{
			"<leader>ma",
			"<cmd> WindowsMaximize <cr>",
			desc = "windows max",
		}, -- mode = { "n", "t" }
		{
			"<leader>me",
			"<cmd> WindowsEqualize <cr>",
			desc = "windows equalize",
		}, -- mode = { "n", "t" }
		{
			"<leader>mh",
			"<cmd> WindowsMaximizeHorizontally <cr>",
			desc = "windows max horizontally",
		}, -- mode = { "n", "t" }
		-- folke/noice.nvim
		{
			"<leader>mm",
			"<cmd> message <cr>",
			desc = "messages show",
		},
		{
			"<leader>mn",
			"<cmd>lua require('snacks').picker.notifications() <cr>",
			desc = "noice messages snacks",
		},
		{
			"<leader>mt",
			"<cmd> WindowsToggleAutowidth <cr>",
			desc = "windows toggle auto width",
		}, -- mode = { "n", "t" }
		{
			"<leader>mv",
			"<cmd> WindowsMaximizeVertically <cr>",
			desc = "windows max vertically",
		}, -- mode = { "n", "t" }
		-- sindrets/winshift.nvim
		{
			"<leader>mw",
			"<cmd> WinShift <cr>",
			desc = "winshift move",
		},
	},
	{ -- <leader> n
		{
			"<leader>nh",
			"<cmd> nohl <cr>",
			desc = "no highlight",
		},
	},
	{ -- <leader> o
		{
			"<leader>og",
			"<cmd> Flog <cr>",
			desc = "open git graph g? for keymap gq to quit",
		},
		{
			"<leader>ol",
			"<cmd> SessionLoadLast <cr>",
			desc = "last session layout",
		},
		-- olimorris/persisted.nvim
		{
			"<leader>op",
			"<cmd> SessionLoad <cr>",
			desc = "current dir session layout",
		},
	},
	{ -- <leader> p
		{
			"<leader>ph",
			"<cmd> lua require('snacks').toggle.profiler_highlights() <cr>",
			desc = "Toggle the snacks profiler highlights",
		},
		{
			"<leader>pz",
			"<cmd> lua require('snacks').toggle.profiler() <cr>",
			desc = "Toggle the snacks profiler",
		},
		{
			"<leader>pp",
			function()
				local window_number = require("window-picker").pick_window()
				if window_number then
					vim.api.nvim_set_current_win(window_number)
				end
			end,
			desc = "pick window",
		},
		{
			"<leader>ps",
			function()
				local window_picker = require("window-picker")
				local picked_win_id = window_picker.pick_window()

				if picked_win_id then
					local bufnr = vim.api.nvim_win_get_buf(picked_win_id)
					local bufname = vim.api.nvim_buf_get_name(bufnr)
					local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
					local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")

					print("Picked window buffer name:", bufname)
					print("Filetype:", filetype)
					print("Buftype:", buftype)
				else
					print("No window was picked")
				end
			end,
			desc = "show pick window",
		},
	},
	{ -- <leader> s
		-- olimorris/persisted.nvim
		{
			"<leader>sd",
			"<cmd>SessionDelete<cr>",
			desc = "delete session",
		},
		{
			"<leader>sh",
			"<C-w>s",
			desc = "split windows h (trouble)",
		},
		{
			"<leader>sp",
			"<cmd>SessionSave<cr>",
			desc = "save session",
		},
		{
			"<leader>sq",
			"<cmd>SessionStop<cr>",
			desc = "stop session",
		},
		-- folke/trouble.nvim
		{
			"<leader>ss",
			desc = "switch trouble severity filter",
		},
		{
			"<leader>sv",
			"<C-w>v",
			desc = "split windows v (trouble)",
		},
		{
			"<leader>S",
			"<cmd> lua require('snacks').scratch.select() <cr>",
			desc = "Select snacks Scratch Buffer",
		},
	},
	{ -- <leader> t
		-- nvim-tree/nvim-tree.lua
		{
			"<leader>tc",
			"<cmd> NvimTreeCollapse <cr>",
			desc = "collapses nvim-tree recursively",
		},
		{
			"<leader>tf",
			"<cmd> NvimTreeFindFile <cr>",
			desc = "cursor to current bufname",
		},
		{
			"<leader>tn",
			"<cmd> echo expand('%:p') <cr>",
			desc = "show the path of current buffer",
		},
		{
			"<leader>tr",
			"<cmd> NvimTreeRefresh <cr>",
			desc = "refresh nvim-tree",
		},
		{
			"<leader>tt",
			"<cmd> NvimTreeToggle <cr>",
			desc = "toggle nvim-tree",
		},
		{
			"<leader>ty",
			function()
				local current_buffer_path = vim.fn.expand("%:p")
				vim.fn.setreg('"', current_buffer_path)
				print("copied path to clipboard: " .. current_buffer_path)
			end,
			desc = "yank current buffer path",
		},
	},
	{ -- <leader> u
		{
			"<leaderuc>",
			"<cmd>lua require'nvim-picgo'.upload_clipboard() <cr>",
			desc = "picgo upload clipboard image",
		},
		{
			"<leaderuf>",
			"<cmd>lua require'nvim-picgo'.upload_imagefile() <cr>",
			desc = "picgo upload file image",
		},
	},
	{ -- <leader> w
		{
			"<leader>we",
			"<cmd>wa<cr>",
			desc = "save all",
		},
		{
			"<leader>wp",
			"<cmd>qa<cr>",
			desc = "quit all",
		},
		{
			"<leader>wq",
			"<cmd>x<cr>",
			desc = "save quit this",
		},
		{
			"<leader>ws",
			"<cmd>wqa<cr>",
			desc = "save quit all",
		},
	},
	{
		"<leader>.",
		"<cmd> lua require('snacks').scratch() <cr>",
		desc = "Toggle snacks Scratch Buffer",
	},
})

wk.add({
	-- mrjones2014/smart-splits.nvim
	{
		"<A-h>",
		"<cmd> lua require('smart-splits').move_cursor_left() <cr>",
		desc = "move to left window",
		mode = { "n", "t" },
	},
	{
		"<A-j>",
		"<cmd> lua require('smart-splits').move_cursor_down() <cr>",
		desc = "move to down window",
		mode = { "n", "t" },
	},
	{
		"<A-k>",
		"<cmd> lua require('smart-splits').move_cursor_up() <cr>",
		desc = "move to up window",
		mode = { "n", "t" },
	},
	{
		"<A-l>",
		"<cmd> lua require('smart-splits').move_cursor_right() <cr>",
		desc = "move to right window",
		mode = { "n", "t" },
	},
	-- akinsho/toggleterm.nvim
	{
		"<A-h>",
		"<cmd> wincmd h <cr>",
		desc = "move to left window",
		mode = { "t" },
	},
	{
		"<A-j>",
		"<cmd> wincmd j <cr>",
		desc = "move to down window",
		mode = { "t" },
	},
	{
		"<A-k>",
		"<cmd> wincmd k <cr>",
		desc = "move to up window",
		mode = { "t" },
	},
	{
		"<A-l>",
		"<cmd> wincmd l <cr>",
		desc = "move to right window",
		mode = { "t" },
	},
	-- ahmedkhalf/project.nvim
	{
		"<C-b>",
		desc = "project browse files",
	},
	{
		"<C-d>",
		desc = "project delete",
	},
	{
		"<C-f>",
		desc = "project find files",
	},
	{
		"<C-r>",
		desc = "project recent files",
	},
	{
		"<C-s>",
		desc = "project search in files",
	},
	{
		"<C-w>",
		desc = "project change working directory",
	},
	{
		"<C-Up>",
		"<cmd> lua require('smart-splits').resize_up(2) <cr>",
		desc = "Resize window",
		mode = { "n", "t" },
	},
	{
		"<C-Down>",
		"<cmd> lua require('smart-splits').resize_down(2) <cr>",
		desc = "Resize window",
		mode = { "n", "t" },
	},
	{
		"<C-Left>",
		"<cmd> lua require('smart-splits').resize_left(2) <cr>",
		desc = "Resize window",
		mode = { "n", "t" },
	},
	{
		"<C-Right>",
		"<cmd> lua require('smart-splits').resize_right(2) <cr>",
		desc = "Resize window",
		mode = { "n", "t" },
	},
	-- numToStr/Comment.nvim
	{
		"<C-_>",
		desc = "toggle comment",
	},
	-- akinsho/toggleterm.nvim
	{
		"<C-\\>",
		-- "<cmd> ToggleTerm <cr>",
		"<cmd>lua require('snacks').terminal.toggle() <cr>",
		desc = "toggle term",
		mode = { "n", "t" },
	},
	-- danymat/neogen
	{
		"<C-A-g>",
		"<cmd> Neogen <cr>",
		desc = "neogen generate docs",
		mode = { "n", "i" },
	},
	{
		"<C-A-n>",
		function()
			local file_path = vim.fn.expand("%:p") -- Get the full path of the current file
			if term == "screen-256color" then
				-- Open in new tmux window
				vim.cmd("silent !tmux new-window nvim " .. file_path)
			elseif term == "xterm-256color" then
				-- Open in new kitty tab
				vim.cmd("silent !kitty @ launch --type=tab nvim " .. file_path)
			end
		end,
		desc = "open current file in new tab/window(kitty/tmux)",
	},
	{
		"]]",
		"<cmd> lua require('snacks').words.jump(vim.v.count1) <cr>",
		desc = "Next Reference",
		mode = { "n", "t" },
	},
	{
		"[[",
		"<cmd> lua require('snacks').words.jump(-vim.v.count1) <cr>",
		desc = "Prev Reference",
		mode = { "n", "t" },
	},
})
