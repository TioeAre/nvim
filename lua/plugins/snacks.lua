local M = require("plugin_config.snacks")

return {
    {
        -- folke/snacks.nvim
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = M.opt_snacks,
        keys = M.keys_snacks,
        -- init = M.init_snacks,
    }
}
