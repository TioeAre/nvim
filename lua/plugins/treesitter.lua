local M = require("plugin_config.treesitter")

return {
    {
        "nvim-treesitter/nvim-treesitter",
        -- enabled = not vim.g.only_text_editor,
        -- lazy = false,
        event = { "VeryLazy", "BufNewFile" },
        config = M.config_treesitter,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "andymass/vim-matchup",
            -- "kevinhwang91/nvim-ufo",
            "nvim-treesitter/nvim-treesitter-refactor",
        },
    },
    { -- 显示向下翻页时仍函数名
        "nvim-treesitter/nvim-treesitter-context",
        -- enabled = not vim.g.only_text_editor,
        event = { "BufReadPost", "VeryLazy" },
        config = M.config_treesitter_context,
    },
    { -- 自动生成c++类函数实现
        "eriks47/generate.nvim",
        enabled = not vim.g.only_text_editor,
        cmd = "Generate implementations",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    { -- breadcrumbs下拉
        "Bekaboo/dropbar.nvim",
        -- enabled = not vim.g.only_text_editor,
        -- optional, but required for fuzzy finder support
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        event = { "BufReadPost", "VeryLazy" },
    },
}
