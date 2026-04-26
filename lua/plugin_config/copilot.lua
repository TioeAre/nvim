local M = {}

-- zbirenbaum/copilot.lua
function M.config_copilot()
	require("copilot").setup({
		suggestion = { enabled = true },
		panel = {
			enabled = false,
			layout = {
				position = "right", -- | top | left | right | bottom |
				ratio = 0.4,
			},
		},
		nes = {
			enabled = true, -- requires copilot-lsp as a dependency
			auto_trigger = true,
		},
		filetypes = {
			yaml = true,
			markdown = true,
			gitcommit = true,
			gitrebase = true,
			["."] = false,
		},
		-- copilot_model = "gpt-5-mini",
		server_opts_overrides = {},
	})
end

-- zbirenbaum/copilot-cmp
function M.config_copilot_cmp()
	require("copilot_cmp").setup()
end

M.opts_copilot_chat = {
	model = "gpt-4.1", -- AI model to use
	-- temperature = 0.1, -- Lower = focused, higher = creative
	-- window = {
	-- 	layout = "vertical", -- 'vertical', 'horizontal', 'float'
	-- 	width = 0.5, -- 50% of screen width
	-- },
	-- auto_insert_mode = true, -- Enter insert mode when opening
}

return M
