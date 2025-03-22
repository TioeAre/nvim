local M = require("plugin_config.lsp")

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "williamboman/mason.nvim",
                dependencies = {
                    {
                        "williamboman/mason-lspconfig.nvim",
                        opts = M.opts_mason_lspconfig,
                        config = M.config_mason_lspconfig,
                    },
                    "WhoIsSethDaniel/mason-tool-installer.nvim",
                },
                cmd = "Mason",
                event = { "VeryLazy" },
                config = M.config_mason,
            },
            {
                "nvimdev/lspsaga.nvim",
                dependencies = { "lewis6991/gitsigns.nvim" },
            },
            -- {
            --     'ray-x/navigator.lua',
            --     dependencies = {
            --         {
            --             'ray-x/guihua.lua',
            --             build = 'cd lua/fzy && make'
            --         },
            --     },
            -- },
            {
                "barreiroleo/ltex_extra.nvim",
                ft = { "markdown", "tex", "text" },
                dependencies = { "neovim/nvim-lspconfig" },
            },
        },
        event = { "BufReadPost", "VeryLazy" }, -- BufReadPost
        config = M.config_lspconfig,
    },
    -- 显示文内函数引用, 定义等
    {
        "VidocqH/lsp-lens.nvim",
        event = { "VeryLazy" },
        config = M.config_lsp_lens,
    },
    -- lsp lens virtual text
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        event = { "VeryLazy" },
        config = M.config_whynothugo_lsp_lens,
    },
    -- lsp glance document flow like vscode
    -- {
    -- 	"dnlhc/glance.nvim",
    -- 	cmd = "Glance",
    -- 	dependencies = {
    -- 		"neovim/nvim-lspconfig",
    -- 	},
    -- 	config = M.config_glance,
    -- },
}
