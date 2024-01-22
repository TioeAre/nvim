local M = require("plugin_config.treesitter")

return {
    {
        "nvim-treesitter/nvim-treesitter",
        -- lazy = false,
        event = { "BufReadPost", "BufNewFile", "VeryLazy" },
        config = M.config_treesitter,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "andymass/vim-matchup",
            "kevinhwang91/nvim-ufo",
        }
    },
    { -- 显示向下翻页时仍函数名
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPost", "BufNewFile", "VeryLazy" },
        config = M.config_treesitter_context,
    },
    { -- 自动生成c++类函数实现
        "eriks47/generate.nvim",
        cmd = "Generate implementations",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
}
