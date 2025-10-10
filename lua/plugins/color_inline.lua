local M = require("plugin_config.color_inline")

return {
    {
        -- "norcalli/nvim-colorizer.lua",
        "NvChad/nvim-colorizer.lua",
        -- enabled = not vim.g.only_text_editor,
        event = { "BufReadPost", "VeryLazy" },
        config = M.config_colorizer,
    },
    {
        "nvim-colortils/colortils.nvim",
        -- enabled = not vim.g.only_text_editor,
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
        -- enabled = not vim.g.only_text_editor,
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
