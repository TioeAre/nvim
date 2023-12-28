local M = require("plugin_config.ros")

return {
    {
        "tadachs/ros-nvim",
        config = M.config_ros_nvim_tadachs,
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
    },
    {
        "thibthib18/ros-nvim",
        config = M.config_ros_nvim_thibthib18,
        event = "VeryLazy",
    },
}
