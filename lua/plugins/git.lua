local M = require("plugin_config.git")

return {
    {
        "sindrets/diffview.nvim",
        enabled = not vim.g.if_text_editor,
        -- event = "VeryLazy",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh", "DiffviewFileHistory" },
        config = M.config_diffview,
    },
    {
        "rbong/vim-flog",
        enabled = not vim.g.if_text_editor,
        cmd = { "Flog", "Flogsplit", "Floggit" },
        dependencies = {
            "tpope/vim-fugitive",
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        enabled = not vim.g.if_text_editor,
        event = { "BufReadPost", "VeryLazy" },
        config = M.config_gitsigns,
    },
}
