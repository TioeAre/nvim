local M = require("plugin_config.debug")

return {
    "mfussenegger/nvim-dap",
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    -- lazy = false,
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-telescope/telescope-dap.nvim",
        "mfussenegger/nvim-dap-python",
        "Weissle/persistent-breakpoints.nvim",
    },
    config = M.config_dap,
}
