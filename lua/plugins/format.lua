local M = require("plugin_config.format")

return {
    {
        "stevearc/conform.nvim",
        lazy = true,
        event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
        config = M.config_conform,
    },
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = M.config_lint,
    },
}
