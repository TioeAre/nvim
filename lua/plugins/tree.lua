local M = require("plugin_config.tree")

return {
	-- tree explore
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = { "VeryLazy" },
		cmd = { "NvimTreeToggle" },
		config = M.config_nvim_tree,
	},
	{
		"hedyhli/outline.nvim",
		cmd = { "Outline", "OutlineOpen" },
		opts = M.opts_outline,
		config = M.config_outline,
	},
	-- project in trees
	{
		"ahmedkhalf/project.nvim",
		event = { "VeryLazy" },
		config = M.config_project,
	},
	-- {
	-- 	"AckslD/swenv.nvim",
	-- 	-- enabled = not vim.g.only_text_editor,
	-- 	dependencies = { "nvim-lua/plenary.nvim", }
	-- },
	{
		"linux-cultist/venv-selector.nvim",
		event = "VeryLazy",
		cmd = { "VenvSelect", "VenvSelectCached" },
		config = M.config_venv,
	},
	-- buffer manager
	{
		"j-morano/buffer_manager.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = { "VeryLazy" },
		config = M.config_buffer_manager,
	},
}
