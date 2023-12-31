local M = require("plugin_config.color_inline")

return {
    {
        -- "norcalli/nvim-colorizer.lua",
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile", "BufAdd" },
        config = M.config_colorizer,
    },
    {
        "max397574/colortils.nvim",
        cmd = "Colortils",
        config = M.config_colortils,
    },
}
