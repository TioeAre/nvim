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
	{
		"neolooong/whichpy.nvim",
		enabled = not vim.g.only_text_editor,
		event = "VeryLazy",
		opts = M.config_whichpy,
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
