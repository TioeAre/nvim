local wk = require("which-key")

wk.add({
	-- neovim/nvim-lspconfig
	{
		"gD",
		desc = "goto declaration",
	},
	{
		"gd",
		desc = "goto definition",
	},
	{
		"gi",
		desc = "goto implementation",
	},
	{
		"gr",
		desc = "goto references",
	},
	{
		"g<cr>",
		desc = "replace color with format",
	},
	{
		"m<cr>",
		desc = "replace color with default format",
	},
})

wk.add({
	-- ussenegger/nvim-dap
	{
		"<F5>",
		function()
			require("telescope").extensions.dap.configurations({})
		end,
		desc = "telescope dap configurations",
	},
	{
		"<F10>",
		function()
			require("dap").step_over()
		end,
		desc = "dap step over",
	},
	{
		"<F11>",
		function()
			require("dap").step_into()
		end,
		desc = "dap step into",
	},
	{
		"<F12>",
		function()
			require("dap").step_out()
		end,
		desc = "dap step out",
	},
	-- folke/flash.nvim
	{
		"<A-s>",
		function()
			require("flash").toggle()
		end,
		desc = "toggle flash",
		mode = { "c" },
	},
	{
		"<C-e>",
		desc = "cmp abort",
	},
	-- neovim/nvim-lspconfig
	{
		"<C-h>",
		desc = "lsp peek definition",
	},
	{
		"<C-j>",
		desc = "cmp next",
	},
	{
		"<C-k>",
		desc = "Signature Documentation/cmp previous",
	},
	-- hrsh7th/nvim-cmp
	{
		"<C-Space>",
		desc = "cmp commplete",
	},
	-- stevearc/conform.nvim
	{
		"<C-A-l>",
		function()
			require("whitespace-nvim").trim()
			require("conform").format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end,
		desc = "format file or range",
		mode = { "n", "v" },
	},
	-- folke/todo-comments.nvim
	{
		"]t",
		function()
			require("todo-comments").jump_next()
		end,
		desc = "Next todo comment",
	},
	{
		"[t",
		function()
			require("todo-comments").jump_prev()
		end,
		desc = "Previous todo comment",
	},
	-- nvim-treesitter/nvim-treesitter-textobjects
	{
		"]m",
		desc = "treesitter goto next start @function.outer",
	},
	{
		"]M",
		desc = "treesitter goto next end @function.outer",
	},
	{
		"[m",
		desc = "treesitter goto prev start @function.outer",
	},
	{
		"[M",
		desc = "treesitter goto prev end @function.outer",
	},
	{
		"]o",
		desc = "treesitter goto next start @loop.inner",
	},
	{
		"]O",
		desc = "treesitter goto next end @loop.inner",
	},
	{
		"[o",
		desc = "treesitter goto prev start @loop.inner",
	},
	{
		"[O",
		desc = "treesitter goto prev end @loop.inner",
	},
	{
		"]z",
		desc = "treesitter goto next start @fold",
	},
	{
		"]Z",
		desc = "treesitter goto next end @fold",
	},
	{
		"[z",
		desc = "treesitter goto prev start @fold",
	},
	{
		"[Z",
		desc = "treesitter goto prev end @fold",
	},
	{ "]'", "treesitter goto next start @class.outer" },
	{ "][", "treesitter goto next end @class.outer" },
	{ "[;", "treesitter goto prev start @class.outer" },
	{ "[]", "treesitter goto prev end @class.outer" },

	{ "]d", "treesitter goto next @conditional.outer" },
	{ "[d", "treesitter goto prev @conditional.outer" },
})

-- nvim-treesitter/nvim-treesitter-textobjects
wk.add({
	mode = "v",
	{
		"ac",
		desc = "select @class.outer",
	},
	{
		"af",
		desc = "select @function.outer",
	},
	{
		"as",
		desc = "select @scope",
	},
	{
		"i",
		group = "treesitter @function.inner",
	},
	{
		"ic",
		desc = "select @class.inner",
	},
	{
		"if",
		desc = "select @function.inner",
	},
	-- MagicDuck/grug-far.nvim
	{
		"sw",
		"<cmd> lua require('grug-far').with_visual_selection() <cr>",
		desc = "search current word",
	},
})
