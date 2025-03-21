local M = require("plugin_config.treesitter")

return {
    {
        "nvim-treesitter/nvim-treesitter",
        -- lazy = false,
        event = { "VeryLazy", "BufNewFile" },
        config = M.config_treesitter,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "andymass/vim-matchup",
            "kevinhwang91/nvim-ufo",
            "nvim-treesitter/nvim-treesitter-refactor",
        },
    },
    { -- 显示向下翻页时仍函数名
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPost", "VeryLazy" },
        config = M.config_treesitter_context,
    },
    { -- 自动生成c++类函数实现
        "eriks47/generate.nvim",
        cmd = "Generate implementations",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    { -- breadcrumbs下拉
        "Bekaboo/dropbar.nvim",
        -- optional, but required for fuzzy finder support
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        event = { "BufReadPost", "VeryLazy" },
    },
}
