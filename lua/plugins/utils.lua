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
			-- which keymap
			require("which_keymaps.keymaps")
		end,
	},
	-- 添加注释
	{
		"numToStr/Comment.nvim",
		-- enabled = not vim.g.only_text_editor,
		event = { "VeryLazy", "InsertEnter" }, -- InsertEnter
		config = M.config_comment,
	},
	-- 彩虹色括号
	{
		"HiPhish/rainbow-delimiters.nvim",
		-- enabled = not vim.g.only_text_editor,
		event = { "BufReadPost", "VeryLazy" },
		config = M.config_rainbow_delimiters,
	},
	-- -- 彩色缩进
	-- {
	--     "lukas-reineke/indent-blankline.nvim",
	--     event = { "VeryLazy" },
	--     main = "ibl",
	--     opts = M.opts_indent_blankline,
	--     config = M.config_indent_blankline,
	-- },
	-- 高亮选中词汇
	{
		"RRethy/vim-illuminate",
		-- enabled = not vim.g.only_text_editor,
		event = { "VeryLazy" },
		config = M.config_vim_illuminate,
	},
	-- smart yank
	{
		"ibhagwan/smartyank.nvim",
		-- enabled = not vim.g.only_text_editor,
		dependencies = { "AckslD/nvim-neoclip.lua" },
		event = { "VeryLazy" },
		config = M.config_smartyank,
	},
	-- 高亮行尾空格, 保存时去除空格
	-- {
	--     "emileferreira/nvim-strict",
	--     dependencies = {
	--         "stevearc/conform.nvim",
	--     },
	--     event = { "InsertLeave", "TextChanged", "BufReadPost" },
	--     config = M.config_strict,
	-- },
	{
		"johnfrankmorgan/whitespace.nvim",
		-- enabled = not vim.g.only_text_editor,
		-- dependencies = {
		--     "stevearc/conform.nvim",
		-- },
		event = { "TextChanged", "VeryLazy" },
		config = M.config_whitespace,
	},
	-- auto save
	{
		"okuuva/auto-save.nvim",
		-- enabled = not vim.g.only_text_editor,
		cmd = "ASToggle", -- optional for lazy loading on command
		event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
		config = M.config_auto_save,
	},
	-- 底部error栏
	{
		"folke/trouble.nvim",
		-- enabled = not vim.g.only_text_editor,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = { "VeryLazy" },
		opts = M.opts_trouble,
		keys = M.keys_trouble,
	},
	-- todo trees
	{
		"folke/todo-comments.nvim",
		-- enabled = not vim.g.only_text_editor,
		-- lazy = false,
		event = { "VeryLazy" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = M.opts_todo_comments,
		keys = M.keys_todo_comments,
	},
	-- 暗色显示没有使用的代码
	{
		"folke/twilight.nvim",
		-- enabled = not vim.g.only_text_editor,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		cmd = "Twilight",
		event = { "VeryLazy" },
		opts = M.opts_twilight,
	},
	-- 保存上一次关闭时的工作区
	{
		"olimorris/persisted.nvim",
		-- enabled = not vim.g.only_text_editor,
		-- lazy = false, -- this will only start session saving when an actual file was opened
		event = { "BufReadPre" },
		opts = M.opts_persisted,
		config = M.config_persisted,
	},
	-- buffers history
	{
		"gaborvecsei/memento.nvim",
		-- enabled = not vim.g.only_text_editor,
		event = { "VeryLazy" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = M.config_memento,
	},
	-- 打开文件时恢复上次光标位置
	{
		"ethanholz/nvim-lastplace",
		-- enabled = not vim.g.only_text_editor,
		event = { "BufReadPre", "VeryLazy" },
		config = M.config_lastplace,
	},
	-- flatten 同一nvim打开文件
	{
		"willothy/flatten.nvim",
		-- enabled = not vim.g.only_text_editor,
		config = M.config_flatten,
		lazy = false,
		priority = 1001,
	},
	-- 命令行
	{
		"akinsho/toggleterm.nvim",
		-- enabled = not vim.g.only_text_editor,
		version = "*",
		cmd = "ToggleTerm",
		opts = M.opts_toggleterm,
	},
	-- 换行自动添加tab
	{
		"vidocqh/auto-indent.nvim",
		-- enabled = not vim.g.only_text_editor,
		event = { "InsertEnter" },
		opts = M.opts_auto_indent,
	},
	-- 折叠代码块
	-- {
	-- 	"kevinhwang91/nvim-ufo",
	-- 	dependencies = {
	-- 		"kevinhwang91/promise-async",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"luukvbaal/statuscol.nvim",

	-- 		{
	-- 			"chrisgrieser/nvim-origami",
	-- 			config = M.config_origami,
	-- 		},
	-- 	},
	-- 	event = { "VeryLazy" },
	-- 	config = M.config_ufo,
	-- },
	-- 跳转光标位置
	{
		"folke/flash.nvim",
		-- enabled = not vim.g.only_text_editor,
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
		-- enabled = not vim.g.only_text_editor,
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
		-- lazy = false,
		event = "VeryLazy",
		-- event = { "BufReadPre", "BufNewFile", "VeryLazy" },
	},
	-- window spilt and switch
	{
		"mrjones2014/smart-splits.nvim",
		-- enabled = not vim.g.only_text_editor,
		-- event = "UIEnter",
		lazy = false,
		build = "./kitty/install-kittens.bash",
		config = M.config_smart_splits,
	},
	-- move windows
	{
		"sindrets/winshift.nvim",
		-- enabled = not vim.g.only_text_editor,
		event = "VeryLazy",
		config = M.config_winshift,
	},
	-- max window
	{
		"anuvyklack/windows.nvim",
		-- enabled = not vim.g.only_text_editor,
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
		-- enabled = not vim.g.only_text_editor,
		config = M.config_glow,
		cmd = "Glow",
	},
	-- sudo
	{
		"lambdalisue/suda.vim",
		-- enabled = not vim.g.only_text_editor,
		cmd = { "SudaRead", "SudaWrite" },
	},
	-- surround text
	-- {
	--     "kylechui/nvim-surround",
	--     version = "*", -- Use for stability; omit to use `main` branch for the latest features
	--     event = "VeryLazy",
	--     config = M.config_nvim_surround,
	-- },
	{
		"echasnovski/mini.surround",
		-- enabled = not vim.g.only_text_editor,
		event = { "VeryLazy" },
		version = false,
		config = M.config_mini_surround,
	},
	-- 匹配if else与括号
	{
		"andymass/vim-matchup",
		-- enabled = not vim.g.only_text_editor,
		event = { "VeryLazy" },
		config = M.config_vim_matchup,
	},
	-- big file
	{
		"LunarVim/bigfile.nvim",
		-- enabled = not vim.g.only_text_editor,
		event = { "VeryLazy", "FileReadPre" },
		config = M.config_bigfile,
	},
	-- tmux
	{
		"aserowy/tmux.nvim",
		-- enabled = not vim.g.only_text_editor,
		event = { "VeryLazy" },
		config = M.config_tmux,
	},
	-- kitty
	-- {
	--     "knubie/vim-kitty-navigator",
	--     dependencies = { "edluffy/hologram.nvim" },
	--     event = { "VeryLazy" },
	--     enabled = true,
	--     build = "cp ./*.py ~/.config/kitty/",
	--     config = M.config_vim_kitty_navigator,
	-- },
	-- stickybuf
	{
		"stevearc/stickybuf.nvim",
		-- enabled = not vim.g.only_text_editor,
		opts = M.opts_stickybuf,
		config = M.config_stickybuf,
	},
	-- find and replace
	-- {
	-- 	"nvim-pack/nvim-spectre",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	event = { "VeryLazy" },
	-- 	config = M.config_nvim_spectre,
	-- },
    -- MagicDuck/grug-far.nvim
    {
        "MagicDuck/grug-far.nvim",
		-- enabled = not vim.g.only_text_editor,
        event = {"VeryLazy"},
        config = M.config_grug_far,
    },
	-- Chinese words spilt
	-- {
	--     'noearc/jieba.nvim',
	--     dependencies = {
	--         'noearc/jieba-lua',
	--     },
	--     event = { "BufReadPost", },
	--     -- config = true,
	-- },
	-- askfiy/nvim-picgo
	{
		"askfiy/nvim-picgo",
		-- enabled = not vim.g.only_text_editor,
		event = { "VeryLazy" },
		config = function()
			-- it doesn't require you to do any configuration
			require("nvim-picgo").setup()
		end,
	},
}
