local M = require("plugin_config.format")

return {
	{
		"stevearc/conform.nvim",
		-- dependencies = {
		-- 	"emileferreira/nvim-strict",
		-- },
		lazy = true,
		event = { "VeryLazy" }, -- to disable, comment this out
		config = M.config_conform,
	},
	{
		"mfussenegger/nvim-lint",
		dependencies = {
			"Joakker/lua-json5",
		},
		event = { "VeryLazy" },
		config = M.config_lint,
	},
}
