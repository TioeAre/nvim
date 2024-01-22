local M = require("plugin_config.color_inline")

return {
    {
        -- "norcalli/nvim-colorizer.lua",
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPost", "BufNewFile", "BufAdd", "VeryLazy" },
        config = M.config_colorizer,
    },
    {
        "nvim-colortils/colortils.nvim",
        cmd = "Colortils",
        config = M.config_colortils,
    },
    -- {
    --     "ziontee113/color-picker.nvim",
    --     cmd = {"PickColor", "PickColorInsert"},
    --     config = M.config_color_picker,
    -- },
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
