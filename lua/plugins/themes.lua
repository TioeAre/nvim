local M = require("plugin_config.themes")

return {
    -- 主题
    {
        "EdenEast/nightfox.nvim",
        lazy = false,
        priority = 999,
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
}
