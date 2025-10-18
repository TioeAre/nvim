local M = require("plugin_config.debug")

return {
    {
        "mfussenegger/nvim-dap",
        enabled = not vim.g.only_text_editor,
        event = { "VeryLazy" },
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-telescope/telescope-dap.nvim",
            "mfussenegger/nvim-dap-python",
            "Weissle/persistent-breakpoints.nvim",
            "Joakker/lua-json5",
            "nvim-neotest/nvim-nio",
            "jay-babu/mason-nvim-dap.nvim",
        },
        config = M.config_dap,
    }
}
