local M = require("plugin_config.autotag_pairs")

return {
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        config = M.config_autotag,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = M.opts_auto_pairs, -- this is equal to setup({}) function
        -- require('nvim-autopairs').setup({ })
    },
}
