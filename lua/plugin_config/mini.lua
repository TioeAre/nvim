local M = {}

-- nvim-mini/mini.surround
M.config_mini_surround = function()
	require("mini.surround").setup({
		custom_surroundings = nil,
		-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
		highlight_duration = 500,
		-- Module mappings. Use `''` (empty string) to disable one.
		mappings = {
			add = "ma", -- Add surrounding in Normal and Visual modes
			delete = "md", -- Delete surrounding
			find = "mf", -- Find surrounding (to the right)
			find_left = "mF", -- Find surrounding (to the left)
			highlight = "mh", -- Highlight surrounding
			replace = "mr", -- Replace surrounding
			update_n_lines = "mn", -- Update `n_lines`
			suffix_last = "l", -- Suffix to search with "prev" method
			suffix_next = "n", -- Suffix to search with "next" method
		},
		-- Number of lines within which surrounding is searched
		n_lines = 200,
	})
end

return M
