local M = {}
local filetype = require("utils.filetype")

-- folke/which-key.nvim
M.init_which_key = function()
	vim.o.timeout = true
	vim.o.timeoutlen = 700
end
M.opts_which_key = {}

-- numToStr/Comment.nvim
M.config_comment = function()
	local comment = require("Comment")
	comment.setup({
		ignore = "^$",
		padding = true,
		sticky = true,
		toggler = {
			line = "<C-_>",
			block = "gbc",
		},
		opleader = {
			line = "<C-_>",
			block = "gbc",
		},
		comment_empty = false,
	})
end

-- HiPhish/rainbow-delimiters.nvim
M.config_rainbow_delimiters = function()
	require("rainbow-delimiters.setup").setup({})
end

-- RRethy/vim-illuminate
M.config_vim_illuminate = function()
	require("illuminate").configure({
		delay = 100,
		filetypes_denylist = filetype.excluded_filetypes,
		large_file_cutoff = 10000,
	})
	vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "IlluminatedWordWrite" })
	vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "IlluminatedWordRead" })
	vim.api.nvim_set_hl(0, "LspReferenceText", { link = "IlluminatedWordText" })
	-- vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#4e306e" })
	-- vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#58268c" })
	-- vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#4e306e" })
end

-- ibhagwan/smartyank.nvim
M.config_smartyank = function()
	require("smartyank").setup({
		highlight = {
			timeout = 1500,
		},
		osc52 = {
			enabled = true,
			-- escseq = 'tmux',     -- use tmux escape sequence, only enable if
			ssh_only = false, -- false to OSC52 yank also in local sessions
		},
		validate_yank = false,
	})
	require("neoclip").setup()
end

-- johnfrankmorgan/whitespace.nvim
M.config_whitespace = function()
	require("whitespace-nvim").setup({
		highlight = "DiffDelete",
		ignored_filetypes = filetype.excluded_filetypes,
		ignore_terminal = true,
		return_cursor = true,
	})
	local group = vim.api.nvim_create_augroup("autosave", {})
	vim.api.nvim_create_autocmd("User", {
		pattern = "AutoSaveWritePre",
		group = group,
		callback = function(opts)
			if
				opts.data.saved_buffer ~= nil
				and not filetype.is_value_in_list(opts.data.saved_buffer, filetype.excluded_buftypes)
			then
				require("whitespace-nvim").trim()
			end
		end,
	})
end

-- okuuva/auto-save.nvim
M.config_auto_save = function()
	require("auto-save").setup({
		enabled = true,
		trigger_events = {
			immediate_save = { "FocusLost" },
			defer_save = { "BufLeave" },
		},
		condition = function(buf)
			local fn = vim.fn
			if fn.getbufvar(buf, "&buftype") ~= "" then
				return false
			end
			return true
		end,
		debounce_delay = 700,
	})
	local group = vim.api.nvim_create_augroup("autosave", {})
	vim.api.nvim_create_autocmd("User", {
		pattern = "AutoSaveWritePost",
		group = group,
		callback = function(opts)
			if opts.data.saved_buffer ~= nil then
				local filename = vim.api.nvim_buf_get_name(opts.data.saved_buffer)
				print("AutoSave: saved " .. filename .. " at " .. vim.fn.strftime("%H:%M:%S"))
			end
		end,
	})
end

-- folke/trouble.nvim
M.opts_trouble = {
	position = "bottom",
	height = 10,
	width = 50,
	mode = "workspace_diagnostics",
	group = true, -- group results by file
	padding = true, -- add an extra new line on top of the list
	cycle_results = true, -- cycle item list when reaching beginning or end of list
	multiline = true, -- render multi-line messages
	auto_preview = false,
	auto_jump = { "lsp_references", "lsp_implementations", "lsp_definitions" },
	use_diagnostic_signs = true,
	action_keys = {
		close = "q", -- close the list
		cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
		refresh = "r", -- manually refresh
		jump = { "<cr>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
		open_split = { "<c-x>" }, -- <c-x> open buffer in new split
		open_vsplit = { "<c-v>" }, -- <c-v> open buffer in new vsplit
		open_tab = { "<c-t>" }, -- open buffer in new tab
		jump_close = { "o" }, -- jump to the diagnostic and close the list
		toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
		switch_severity = "<leader>ss", -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
		toggle_preview = "P", -- toggle auto_preview
		hover = "K", -- opens a small popup with the full multiline message
		preview = "p", -- preview the diagnostic location
		open_code_href = "c", -- if present, open a URI with more information about the diagnostic error
		close_folds = { "zc", "zC" }, -- close all folds
		open_folds = { "zo", "zO" }, -- open all folds
		toggle_fold = { "za", "zA", "<tab>" }, -- toggle fold of current file
		next = "j", -- next item
		previous = "<c-h>", -- previous item
		help = "?", -- help menu
	},
}
M.keys_trouble = {}

-- folke/todo-comments.nvim
M.opts_todo_comments = {
	highlight = {
		exclude = filetype.excluded_filetypes,
	},
}
M.keys_todo_comments = {}

-- folke/twilight.nvim
M.opts_twilight = {
	expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
		"function",
		"method",
		"table",
		"if_statement",
	},
	exclude = { "markdown" }, -- exclude these filetypes
}

-- olimorris/persisted.nvim
M.opts_persisted = {
	autosave = true,
}
M.config_persisted = function()
	vim.o.sessionoptions = "buffers,curdir,folds,tabpages,winpos,winsize"
	require("persisted").setup({
		save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
		use_git_branch = true,
		default_branch = "main",
		autoload = true,
		on_autoload_no_session = nil,
		ignored_dirs = {
			{ "/", exact = true },
			{ "~", exact = true },
			{ "os.getenv('HOME')", exact = true },
			{ "/home/linuxbrew/", exact = true },
			{ "/home/Systemback/", exact = true },
		}, -- table of dirs that are ignored when auto-saving and auto-loading
	})
end

-- farmergreg/vim-lastplace
M.config_lastplace = function()
end

-- willothy/flatten.nvim
M.config_flatten = function()
	require("flatten").setup({
		nest_if_no_args = true,
		window = {
			open = "alternate",
		},
	})
end

-- vidocqh/auto-indent.nvim
M.opts_auto_indent = {
	indentexpr = function(lnum)
		return require("nvim-treesitter.indent").get_indent(lnum)
	end, -- Use vim.bo.indentexpr by default, see 'Custom Indent Evaluate Method'
	ignore_filetype = filetype.excluded_filetypes, -- e.g. ignore_filetype = { 'javascript' }
}

-- chrisgrieser/nvim-origami
M.config_origami = function()
	require("origami").setup({
		pauseFoldsOnSearch = true,
		foldtext = {
			enabled = true,
			padding = 3,
			lineCount = {
				template = "%d lines", -- `%d` is replaced with the number of folded lines
				hlgroup = "Comment",
			},
			diagnosticsCount = true, -- uses hlgroups and icons from `vim.diagnostic.config().signs`
			gitsignsCount = true, -- requires `gitsigns.nvim`
		},
		autoFold = {
			enabled = false,
			kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
		},
		foldKeymaps = {
			setup = false, -- modifies `h` and `l`
			hOnlyOpensOnFirstColumn = false,
		},
	})
end

-- folke/flash.nvim
M.keys_flash = {
	{
		"s",
		mode = { "n", "x", "o" },
		function()
			require("flash").jump()
		end,
		desc = "Flash",
	},
	{
		"S",
		mode = { "n", "x", "o" },
		function()
			require("flash").treesitter()
		end,
		desc = "Flash Treesitter",
	},
	{
		"r",
		mode = "o",
		function()
			require("flash").remote()
		end,
		desc = "Remote Flash",
	},
	{
		"R",
		mode = { "o", "x" },
		function()
			require("flash").treesitter_search()
		end,
		desc = "Treesitter Search",
	},
	{
		"<c-s>",
		mode = { "c" },
		function()
			require("flash").toggle()
		end,
		desc = "Toggle Flash Search",
	},
}

-- s1n7ax/nvim-window-picker
M.config_nvim_window_picker = function()
	require("window-picker").setup({
		hint = "floating-big-letter",
		filter_rules = {
			include_current_win = true,
			bo = {
				filetype = filetype.excluded_filetypes,
				buftype = filetype.excluded_buftypes,
			},
		},
	})
end

-- mrjones2014/smart-splits.nvim
M.config_smart_splits = function()
	require("smart-splits").setup({})
end

-- sindrets/winshift.nvim
M.config_winshift = function()
	require("winshift").setup({})
end

-- anuvyklack/windows.nvim
M.config_windows = function()
	vim.o.winwidth = 10
	vim.o.winminwidth = 1
	vim.o.equalalways = false
	require("windows").setup({
		autowidth = { -- |windows.autowidth|
			enable = true,
			-- winwidth = 10, -- |windows.winwidth|
			filetype = { -- |windows.autowidth.filetype|
				help = 2,
			},
		},
		ignore = { -- |windows.ignore|
			buftype = filetype.excluded_buftypes,
			filetype = filetype.excluded_filetypes,
		},
		animation = {
			enable = true,
			duration = 200,
			fps = 45,
			easing = "in_out_sine",
		},
	})
end

-- ellisonleao/glow.nvim
M.config_glow = function()
	require("glow").setup({
		border = "shadow", -- floating window border config
		style = "dark", -- light filled automatically with your current editor background, you can override using glow json style
		pager = false,
		width = 80,
		height = 100,
		width_ratio = 0.7, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
		height_ratio = 0.7,
	})
end

-- andymass/vim-matchup
M.config_vim_matchup = function()
	vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
	vim.g.matchup_matchparen_deferred = 1
	vim.g.matchup_matchparen_hi_surround_always = 1
	vim.g.matchup_matchparen_deferred_show_delay = 20
	vim.g.matchup_matchparen_deferred_hide_delay = 20
	vim.cmd([[
        hi MatchParen ctermfg=DarkRed guifg=#a80000 guibg=##2F2F4A cterm=underline gui=underline
        hi MatchWord ctermfg=DarkRed guifg=#a80000 guibg=##2F2F4A cterm=underline gui=underline
        hi MatchParenCur ctermfg=DarkRed guifg=#a80000 guibg=##2F2F4A cterm=underline gui=underline
        hi MatchWordCur ctermfg=DarkRed guifg=#a80000 guibg=##2F2F4A cterm=underline gui=underline
    ]])
	-- vim.g.matchup_matchparen_timeout = 6000000
	-- vim.g.matchup_matchparen_insert_timeout = 6000000
	vim.g.loaded_matchit = 1
end

-- aserowy/tmux.nvim
M.config_tmux = function()
	require("tmux").setup({
		copy_sync = {
			enable = false,
		},
		navigation = {
			enable_default_keybindings = false,
		},
		resize = {
			enable_default_keybindings = false,
			resize_step_x = 2,
			resize_step_y = 2,
		},
	})
end

-- knubie/vim-kitty-navigator
M.config_vim_kitty_navigator = function()
	vim.g.kitty_navigator_no_mappings = 1
end

-- stevearc/stickybuf.nvim
M.opts_stickybuf = {}
M.config_stickybuf = function()
	require("stickybuf").setup()
end

-- nvim-pack/nvim-spectre
M.config_nvim_spectre = function()
	require("plugin_config.user_spectre")
end

-- MagicDuck/grug-far.nvim
M.config_grug_far = function()
	require("grug-far").setup({
		disableBufferLineNumbers = false,
		startInInsertMode = false,
		wrap = true,
		keymaps = {
			replace = { n = "<localleader>r" },
			qflist = { n = "<localleader>q" },
			syncLocations = { n = "<localleader>s" },
			syncLine = { n = "<localleader>l" },
			close = { n = "<localleader>c" },
			historyOpen = { n = "<localleader>t" },
			historyAdd = { n = "<localleader>a" },
			refresh = { n = "<localleader>f" },
			openLocation = { n = "<localleader>o" },
			openNextLocation = { n = "<down>" },
			openPrevLocation = { n = "<up>" },
			gotoLocation = { n = "<enter>" },
			pickHistoryEntry = { n = "<enter>" },
			abort = { n = "<localleader>b" },
			help = { n = "g?" },
			toggleShowCommand = { n = "<localleader>w" },
			swapEngine = { n = "<localleader>e" },
			previewLocation = { n = "<localleader>i" },
			swapReplacementInterpreter = { n = "<localleader>x" },
			applyNext = { n = "<localleader>j" },
			applyPrev = { n = "<localleader>k" },
			syncNext = { n = "<localleader>n" },
			syncPrev = { n = "<localleader>p" },
			syncFile = { n = "<localleader>v" },
			nextInput = { n = "<tab>" },
			prevInput = { n = "<s-tab>" },
		},
	})
end

-- mbbill/undotree
M.config_undotree = function()
	vim.g.undotree_WindowLayout = 4
end

return M
