local M = require("plugin_config.telescope")

return {
    -- find files or strings
    {
        "nvim-telescope/telescope.nvim",
        -- enabled = not vim.g.only_text_editor,
        -- lazy = false,
        -- tag = '0.1.4',
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- "cljoly/telescope-repo.nvim",
            "xiyaowong/telescope-emoji.nvim",
            "bi0ha2ard/telescope-ros.nvim",
            "lpoto/telescope-docker.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            "jemag/telescope-diff.nvim",
            "s1n7ax/nvim-window-picker",
            "olimorris/persisted.nvim",
            "FabianWirth/search.nvim",
        },
        cmd = "Telescope",
        event = { "VeryLazy" },
        config = M.config_telescope,
    },
    -- -- 选项卡
    -- {
    --     "tiagovla/scope.nvim",
    --     config = M.config_scope
    -- }
}
