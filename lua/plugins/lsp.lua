local M = require("plugin_config.lsp")

return { -- mason, mason-lspconfig, nvim-lspconfig, efmls-configs-nvim
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
		cmd = "Mason",
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
		config = M.config_mason,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
		opts = M.opts_mason_lspconfig,
		config = M.config_mason_lspconfig,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"windwp/nvim-autopairs",
			"hrsh7th/nvim-cmp",
			-- "hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			-- 'creativenull/efmls-configs-nvim',
			{
				"j-hui/fidget.nvim",
				tag = "legacy",
			},
			{
				"nvimdev/lspsaga.nvim",
				dependencies = { "lewis6991/gitsigns.nvim" },
			},
			{ "ray-x/lsp_signature.nvim" },
		},
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
		config = M.config_lspconfig,
	},
	-- 显示文内函数引用, 定义等
	{
		"VidocqH/lsp-lens.nvim",
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
		config = M.config_lsp_lens,
	},
	-- lsp lens virtual text
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
		config = M.config_whynothugo_lsp_lens,
	},
	-- lsp glance like vscode
	{
		"dnlhc/glance.nvim",
		cmd = "Glance",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = M.config_glance,
	},
}
