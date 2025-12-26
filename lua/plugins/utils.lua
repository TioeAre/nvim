local M = require("plugin_config.utils")
local W = require("utils.windows_ignore")

return {
	-- 查找按键
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = M.init_which_key,
		opts = M.opts_which_key,
		config = function()
			require("which_keymaps.keymaps")
		end,
	},
	-- 添加注释
	{
		"numToStr/Comment.nvim",
		event = { "VeryLazy", "InsertEnter" }, -- InsertEnter
		config = M.config_comment,
	},
	-- 彩虹色括号
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = { "BufReadPost", "VeryLazy" },
		config = M.config_rainbow_delimiters,
	},
	-- 高亮选中词汇
	{
		"RRethy/vim-illuminate",
		event = { "VeryLazy" },
		config = M.config_vim_illuminate,
	},
	-- smart yank
	{
		"ibhagwan/smartyank.nvim",
		dependencies = { "AckslD/nvim-neoclip.lua" },
		event = { "VeryLazy" },
		config = M.config_smartyank,
	},
	{
		"johnfrankmorgan/whitespace.nvim",
		event = { "TextChanged", "VeryLazy" },
		config = M.config_whitespace,
	},
	-- auto save
	{
		"okuuva/auto-save.nvim",
		cmd = "ASToggle", -- optional for lazy loading on command
		event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
		config = M.config_auto_save,
	},
	-- 底部error栏
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = { "VeryLazy" },
		opts = M.opts_trouble,
		keys = M.keys_trouble,
	},
	-- todo trees
	{
		"folke/todo-comments.nvim",
		event = { "VeryLazy" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = M.opts_todo_comments,
		keys = M.keys_todo_comments,
	},
	-- 暗色显示没有使用的代码
	{
		"folke/twilight.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		cmd = "Twilight",
		event = { "VeryLazy" },
		opts = M.opts_twilight,
	},
	-- 保存上一次关闭时的工作区
	{
		"olimorris/persisted.nvim",
		event = { "BufReadPre" },
		opts = M.opts_persisted,
		config = M.config_persisted,
	},
	-- 打开文件时恢复上次光标位置
	{
		"farmergreg/vim-lastplace",
		event = { "BufReadPre", "VeryLazy" },
		config = M.config_lastplace,
	},
	-- flatten 同一nvim打开文件
	{
		"willothy/flatten.nvim",
		config = M.config_flatten,
		lazy = false,
		priority = 1001,
	},
	-- 换行自动添加tab
	{
		"vidocqh/auto-indent.nvim",
		event = { "InsertEnter" },
		opts = M.opts_auto_indent,
	},
	{
		-- fold scope
		"chrisgrieser/nvim-origami",
		event = "VeryLazy",
		config = M.config_origami,
		init = function()
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
		end,
	},
	-- 跳转光标位置
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			search = {
				exclude = { "bigfile" },
			},
		},
		keys = M.keys_flash,
	},
	-- 跳转窗口
	{
		"s1n7ax/nvim-window-picker",
		name = "window-picker",
		event = "VeryLazy",
		-- version = "2.*",
		config = M.config_nvim_window_picker,
	},
	-- json5
	{
		"Joakker/lua-json5",
		enabled = not vim.g.only_text_editor,
		build = W.windows_selectNO2string("./install.sh", "powershell ./install.ps1"),
		event = "VeryLazy",
	},
	-- window spilt and switch
	{
		"mrjones2014/smart-splits.nvim",
		lazy = false,
		build = W.windows_selectNO2string("./kitty/install-kittens.bash", "powershell"),
		config = M.config_smart_splits,
	},
	-- move windows
	{
		"sindrets/winshift.nvim",
		event = "VeryLazy",
		config = M.config_winshift,
	},
	-- max window
	{
		"anuvyklack/windows.nvim",
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		event = { "VeryLazy" },
		-- lazy = false,
		config = M.config_windows,
	},
	-- markdown
	{
		"ellisonleao/glow.nvim",
		config = M.config_glow,
		cmd = "Glow",
	},
	-- sudo
	{
		"lambdalisue/suda.vim",
		cmd = { "SudaRead", "SudaWrite" },
	},
	-- -- 匹配if else与括号
	{
		"andymass/vim-matchup",
		event = { "VeryLazy" },
		config = M.config_vim_matchup,
	},
	-- tmux
	{
		"aserowy/tmux.nvim",
		event = { "VeryLazy" },
		config = M.config_tmux,
	},
	-- stickybuf
	{
		"stevearc/stickybuf.nvim",
		opts = M.opts_stickybuf,
		config = M.config_stickybuf,
	},
	{
		"MagicDuck/grug-far.nvim",
		event = { "VeryLazy" },
		config = M.config_grug_far,
	},
	-- askfiy/nvim-picgo
	-- {
	-- 	"askfiy/nvim-picgo",
	-- 	enabled = not vim.g.only_text_editor,
	-- 	event = { "VeryLazy" },
	-- 	config = function()
	-- 		require("nvim-picgo").setup()
	-- 	end,
	-- },
	-- mbbill/undotree
	{
		"mbbill/undotree",
		event = { "VeryLazy" },
		config = M.config_undotree,
	},
}
