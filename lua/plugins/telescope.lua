local M = require("plugin_config.telescope")

return {
    -- find files or strings
    {
        "nvim-telescope/telescope.nvim",
        -- lazy = false,
        -- tag = '0.1.4',
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "cljoly/telescope-repo.nvim",
            "xiyaowong/telescope-emoji.nvim",
            "bi0ha2ard/telescope-ros.nvim",
            "lpoto/telescope-docker.nvim",
            "debugloop/telescope-undo.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            "jemag/telescope-diff.nvim",
        },
        cmd = "Telescope",
        event = { "VeryLazy" },
        config = M.config_telescope,
        defaults = {
            file_ignore_patterns = { "node_modules", ".git" },
        },
        keys = M.key_telescope,
        build = ":TSUpdate",
    },
    -- -- 选项卡
    -- {
    --     "tiagovla/scope.nvim",
    --     config = M.config_scope
    -- }
}
