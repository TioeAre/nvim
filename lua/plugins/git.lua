local M = require("plugin_config.git")

return {
    -- {
    --     "kdheepak/lazygit.nvim",
    --     event = { "VeryLazy", "BufReadPost", "BufNewFile" },
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
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufNewFile", "VeryLazy" },
        config = M.config_gitsigns,
    },
}
