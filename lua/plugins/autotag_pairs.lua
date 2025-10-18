local M = require("plugin_config.autotag_pairs")

return {
    {
        "windwp/nvim-ts-autotag",
        event = { "VeryLazy" }, -- "InsertEnter",
        config = M.config_autotag,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "windwp/nvim-autopairs",
        event = { "VeryLazy" },   -- "InsertEnter",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = M.opts_auto_pairs,
        config = M.config_auto_pairs,
    },
}
