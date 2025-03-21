local M = require("plugin_config.git")

return {
    -- {
    --     "kdheepak/lazygit.nvim",
    --     event = { "BufReadPost" },
    --     cmd = {
    --         "LazyGit",
    --         "LazyGitCurrentFile",
    --         "LazyGitConfig",
    --         "LazyGitFilter",
    --         "LazyGitFilterCurrentFile"
    --     },
    --     dependencies = {
    --         "nvim-lua/plenary.nvim", -- required
    --         "sindrets/diffview.nvim", -- optional - Diff integration
    --         "nvim-telescope/telescope.nvim", -- optional
    --         "ibhagwan/fzf-lua", -- optional
    --     },
    --     config = M.config_lazygit,
    -- },
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
        event = { "BufReadPost" },
        config = M.config_gitsigns,
    },
}
