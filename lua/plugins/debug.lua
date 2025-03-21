local M = require("plugin_config.debug")

return {
    {
        "mfussenegger/nvim-dap",
        event = { "VeryLazy" },
        -- lazy = false,
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-telescope/telescope-dap.nvim",
            "mfussenegger/nvim-dap-python",
            "Weissle/persistent-breakpoints.nvim",
            "Joakker/lua-json5",
            "nvim-neotest/nvim-nio",
        },
        config = M.config_dap,
    }
}
