local M = require("plugin_config.cmp")

return {
    {
        "hrsh7th/nvim-cmp",
        -- lazy = false,
        event = "VeryLazy",
        config = M.config_cmp,
        dependencies = {
            "onsails/lspkind.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-calc",
            "f3fora/cmp-spell",
            "kdheepak/cmp-latex-symbols",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            {
                "saadparwaiz1/cmp_luasnip",
                dependencies = {
                    "L3MON4D3/LuaSnip",
                    -- follow latest release.
                    version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                    -- install jsregexp (optional!).
                    build = "make install_jsregexp",
                    dependencies = "rafamadriz/friendly-snippets",
                },
            },
            {
                "ray-x/cmp-treesitter",
            },
            "andersevenrud/cmp-tmux",
        },
    },
    -- docs
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = M.config_neogen,
        event = {"BufReadPost", "BufNewFile", "BufReadPre"},
        -- Uncomment next line if you want to follow only stable versions
        version = "*",
    },
}
