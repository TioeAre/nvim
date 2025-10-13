local M = require("plugin_config.code_run")

return {
    {
        "Civitasv/cmake-tools.nvim",
        -- enabled = not vim.g.only_text_editor,
        -- lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = M.config_cmake_tools,
        event = "VeryLazy",
    },
    {
        "michaelb/sniprun",
        enabled = not vim.g.only_text_editor, -- rust
        branch = "master",
        build = "sh install.sh 1",
        config = M.config_sniprun,
        event = "VeryLazy",
    },
    {
        "EthanJWright/vs-tasks.nvim",
        enabled = not vim.g.only_text_editor, -- json5
        dependencies = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "Joakker/lua-json5",
            -- {
            --     "ThePrimeagen/harpoon",
            --     branch = "harpoon2",
            --     dependencies = { "nvim-lua/plenary.nvim" },
            -- },
        },
        event = { "VeryLazy" },
        config = M.config_vs_task,
    },
}
