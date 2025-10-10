local M = require("plugin_config.snacks")

return {
    {
        -- folke/snacks.nvim
        "folke/snacks.nvim",
        enabled = not vim.g.if_text_editor,
        priority = 1000,
        lazy = false,
        opts = M.opt_snacks,
        keys = M.keys_snacks,
        -- init = M.init_snacks,
    }
}
