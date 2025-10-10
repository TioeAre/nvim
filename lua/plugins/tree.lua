local M = require("plugin_config.tree")

return {
	-- tree explore
	{
		"nvim-tree/nvim-tree.lua",
		enabled = not vim.g.if_text_editor,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- lazy = false,
		event = { "VeryLazy" },
		cmd = { "NvimTreeToggle" },
		config = M.config_nvim_tree,
	},
	{
		"hedyhli/outline.nvim",
		enabled = not vim.g.if_text_editor,
		cmd = { "Outline", "OutlineOpen" },
		opts = M.opts_outline,
		config = M.config_outline,
	},
	-- project in trees
	{
		"ahmedkhalf/project.nvim",
		enabled = not vim.g.if_text_editor,
		event = { "VeryLazy" },
		config = M.config_project,
	},
	{
		"AckslD/swenv.nvim",
		enabled = not vim.g.if_text_editor,
		dependencies = { "nvim-lua/plenary.nvim", }
	},
	-- {
	-- 	"linux-cultist/venv-selector.nvim",
	-- 	dependencies = {
	-- 		-- "neovim/nvim-lspconfig",
	-- 		"nvim-telescope/telescope.nvim",
	-- 		-- "mfussenegger/nvim-dap-python",
	-- 	},
	-- 	event = "VeryLazy",
	-- 	branch = "regexp",
	-- 	cmd = { "VenvSelect", "VenvSelectCached" },
	-- 	config = M.config_venv,
	-- },
	-- buffer manager
	{
		"j-morano/buffer_manager.nvim",
		enabled = not vim.g.if_text_editor,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = { "VeryLazy" },
		config = M.config_buffer_manager,
	},
}
