local M = {}

-- tadachs/ros-nvim
M.config_ros_nvim_tadachs = function()
    require("ros-nvim").setup({
        only_workspace = true,
        lazy_load_package_list = true,
        telescope = false,
        -- {
        --     ws_filter = "current",
        -- },
        treesitter = {
            enabled = true,
        },
        commands = {
            enabled = true,
        },
        autocmds = {
            enabled = true,
        },
    })
end

-- thibthib18/ros-nvim
M.config_ros_nvim_thibthib18 = function()
    require("ros-nvim").setup({
        catkin_ws_path = "./",
        catkin_program = "catkin build", -- "catkin_make"
        terminal_height = 8,
    })
end

return M
