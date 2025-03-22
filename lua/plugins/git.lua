local M = require("plugin_config.git")

return {
    {
        "sindrets/diffview.nvim",
        -- event = "VeryLazy",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh", "DiffviewFileHistory" },
        config = M.config_diffview,
    },
    {
        "rbong/vim-flog",
        cmd = { "Flog", "Flogsplit", "Floggit" },
        dependencies = {
            "tpope/vim-fugitive",
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "VeryLazy" },
        config = M.config_gitsigns,
    },
}
