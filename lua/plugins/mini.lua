local M = require("plugin_config.mini")
-- enabled = not vim.g.only_text_editor,


return {
    {
        'nvim-mini/mini.surround',
        version = '*',
        event = { "BufReadPost", "VeryLazy" },
        config = M.config_mini_surround,
    }
}
