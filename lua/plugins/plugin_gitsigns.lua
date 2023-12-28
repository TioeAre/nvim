local M = require("plugin_config.plugin_gitsigns")

return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    config = M.config_gitsigns,
}
