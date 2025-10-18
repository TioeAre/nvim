local M = require("plugin_config.color_inline")

return {
    {
        -- "norcalli/nvim-colorizer.lua",
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPost", "VeryLazy" },
        config = M.config_colorizer,
    },
    {
        "nvim-colortils/colortils.nvim",
        cmd = "Colortils",
        config = M.config_colortils,
    },
    {
        "uga-rosa/ccc.nvim",
        cmd = {
            "CccPick",
            "CccConvert",
            "CccHighlighterToggle",
            "CccHighlighterEnable",
            "CccHighlighterDisable",
        },
        config = M.config_ccc,
    },
}
