local M = {}

-- zbirenbaum/copilot.lua
function M.config_copilot()
	require("copilot").setup({
		suggestion = { enabled = false },
		panel = { enabled = false },
		filetypes = {
			yaml = true,
			markdown = true,
			gitcommit = true,
			gitrebase = true,
			["."] = false,
		},
		server_opts_overrides = {},
	})
end

-- zbirenbaum/copilot-cmp
function M.config_copilot_cmp()
	require("copilot_cmp").setup()
end

return M
