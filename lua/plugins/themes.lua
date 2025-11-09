local M = require("plugin_config.themes")

return {
    -- 主题
    {
        -- "folke/tokyonight.nvim",
        -- "catppuccin/nvim",
        -- name = "catppuccin",
        'sharpchen/Eva-Theme.nvim',
        build = ':EvaCompile',
        lazy = false,
        priority = 1000,
        config = M.theme_config,
    },
    -- 底部状态栏
    {
        "nvim-lualine/lualine.nvim",
        event = { "UIEnter" },
        config = M.config_lualine,
    },
    -- tab栏状态
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        event = { "BufReadPre" },
        config = M.config_bufferline,
    },
    { -- 分屏显示文件名
        "b0o/incline.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim",
        },
        event = { "VeryLazy" },
        -- lazy = false,
        config = M.config_incline,
    },
    -- 界面半透明
    {
        "xiyaowong/transparent.nvim",
        -- lazy = false,
        event = { "VimEnter" },
        config = M.config_transparent,
    },
    -- noice
    {
        "folke/noice.nvim",
        event = { "VeryLazy" },
        opts = M.opt_noice,
        config = M.config_noice,
        dependencies = { -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
        },
    },
    -- select ui
    {
        "stevearc/dressing.nvim",
        event = { "VeryLazy" },
        opts = M.opts_dressing,
        config = M.config_dressing,
    },
    -- scrollbar
    {
        "petertriho/nvim-scrollbar",
        event = { "VeryLazy" },
        config = M.config_nvim_scrollbar,
        dependencies = {
            "kevinhwang91/nvim-hlslens",
            "lewis6991/gitsigns.nvim",
        },
    },
}
