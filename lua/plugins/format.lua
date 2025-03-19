local M = require("plugin_config.format")

return {
	{
		"stevearc/conform.nvim",
		-- dependencies = {
		-- 	"emileferreira/nvim-strict",
		-- },
		lazy = true,
		event = { "BufReadPost" }, -- to disable, comment this out
		config = M.config_conform,
	},
	{
		"mfussenegger/nvim-lint",
		dependencies = {
			"Joakker/lua-json5",
		},
		event = { "BufReadPost" },
		config = M.config_lint,
	},
}
