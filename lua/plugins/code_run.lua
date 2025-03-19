local M = require("plugin_config.code_run")

return {
    {
        "Civitasv/cmake-tools.nvim",
        -- lazy = true,
        config = M.config_cmake_tools,
        event = "VeryLazy",
    },
    {
        "michaelb/sniprun",
        branch = "master",
        build = "sh install.sh 1",
        config = M.config_sniprun,
        event = "VeryLazy",
    },
    {
        "EthanJWright/vs-tasks.nvim",
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
        event = "BufReadPost",
        config = M.config_vs_task,
    },
}
