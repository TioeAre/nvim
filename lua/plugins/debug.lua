local M = require("plugin_config.debug")

return {
    "mfussenegger/nvim-dap",
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    -- lazy = false,
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-telescope/telescope-dap.nvim",
        "mfussenegger/nvim-dap-python",
    },
    config = M.config_dap,
}
