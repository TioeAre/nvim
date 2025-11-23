local M = require("plugin_config.color_inline")

return {
    {
        "catgoose/nvim-colorizer.lua",
        event = { "BufReadPost", "VeryLazy" },
        config = M.config_colorizer,
    },
    {
        "max397574/colortils.nvim",
        cmd = "Colortils",
        config = M.config_colortils,
    },
}
