local M = require("plugin_config.format")

return {
	{
		"stevearc/conform.nvim",
		event = { "VeryLazy" },
		config = M.config_conform,
	},
	{
		"mfussenegger/nvim-lint",
		enabled = not vim.g.only_text_editor,
		dependencies = {
			"Joakker/lua-json5",
		},
		event = { "VeryLazy" },
		config = M.config_lint,
	},
}
