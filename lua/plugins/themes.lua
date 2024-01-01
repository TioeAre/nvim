local M = require("plugin_config.themes")

return {
    -- 主题
    {

        "folke/tokyonight.nvim",
        dependencies = {
            "EdenEast/nightfox.nvim",
            { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
            {
                "olimorris/onedarkpro.nvim",
                priority = 1000,
            },
        },
        lazy = false,
        priority = 1000,
        config = M.theme_config,
    },
    -- 底部状态栏
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        config = M.config_lualine,
    },
    -- tab栏状态
    {
        "akinsho/bufferline.nvim",
        lazy = false,
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = M.config_bufferline,
        keys = M.keys_bufferline,
    },
    -- 封面
    {
        "goolord/alpha-nvim",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = M.config_alpha,
    },
    {-- 分屏显示文件名
        "b0o/incline.nvim",
        lazy = false,
        config = M.config_incline,
    },
    -- ui
    -- {
    --     "ldelossa/nvim-ide",
    --     lazy = false,
    --     -- event = {"VeryLazy"},
    --     config = M.config_nvim_ide,
    -- },
    -- ui
    -- { -- can't work
    --     "folke/edgy.nvim",
    --     event = "VeryLazy",
    --     -- lazy = false,
    --     init = M.init_edgy,
    --     opts = M.opts_edgy,
    --     config = function()
    --         require("edgy").setup(M.opts_edgy)
    --     end,
    -- },
    -- 界面半透明
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        config = M.config_transparent,
    },
    -- noice
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = M.opt_noice,
        dependencies = { -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim", -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            -- {
            --     "rcarriga/nvim-notify",
            --     config = M.config_notify,
            -- },
        }
    },
}
