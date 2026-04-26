local M = require("plugin_config.copilot")

return {
	-- {
	-- 	"github/copilot.vim",
	-- 	event = { "BufReadPost" }, -- "InsertEnter",
	-- },
	{
		"zbirenbaum/copilot.lua",
		enabled = not vim.g.only_text_editor,
		cmd = "Copilot",
		event = "InsertEnter",
		config = M.config_copilot,
		dependencies = {
			{
				"zbirenbaum/copilot-cmp",
				config = M.config_copilot_cmp,
				event = { "InsertEnter", "LspAttach" }, -- "LspAttach"
				fix_pairs = true,
			},
			"copilotlsp-nvim/copilot-lsp",
		},
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
        event = "VeryLazy",
		build = "make tiktoken",
		opts = M.opts_copilot_chat,
	},
}
