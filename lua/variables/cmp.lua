local M = {}

M.sources = {
	-- lsp
	{
		name = "nvim_lsp",
	},
	-- lsp function help
	{
		name = "nvim_lsp_signature_help",
	},
	-- snippets
	{
		name = "luasnip",
	},
	-- text within current buffer
	{
		name = "buffer",
	},
	-- file system paths
	{
		name = "path",
	},
	-- calc
	{
		name = "calc",
	},
	-- spell
	{
		name = "spell",
	},
	-- latex
	{
		name = "latex_symbols",
		option = {
			strategy = 0, -- 0-mixed 1-julia 2-latex
		},
	},
	-- nvim lua grammar
	{
		name = "nvim_lua",
	},
	{
		name = "tmux",
	},
	{
		name = "treesitter",
	},
	{
		name = "copilot",
	},
}

return M
