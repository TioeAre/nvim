local M = require("plugin_config.plugin_lspsaga")

return {
    "nvimdev/lspsaga.nvim",
    -- lazy = false,
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    config = M.config_lspsaga,
    dependencies = {
        "nvim-treesitter/nvim-treesitter", -- optional
        "nvim-tree/nvim-web-devicons", -- optional
    },
}
