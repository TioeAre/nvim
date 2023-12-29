local M = require("plugin_config.git")

return {
    {
        "NeogitOrg/neogit",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "sindrets/diffview.nvim", -- optional - Diff integration
            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim", -- optional
            "ibhagwan/fzf-lua", -- optional
        },
        config = M.config_neogit,
    },
    {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
        config = M.config_diffview,
    },
    {
        "rbong/vim-flog",
        event = "VeryLazy",
        cmd = { "Flog", "Flogsplit", "Floggit" },
        dependencies = {
            "tpope/vim-fugitive",
        },
    },
}
