local M = {}
local filetype = require("utils.filetype")

-- catgoose/nvim-colorizer.lua
M.config_colorizer = function()
    require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
            RRGGBBAA = true, -- #RRGGBBAA hex codes
            rgb_fn = true,       -- CSS rgb() and rgba() functions
            hsl_fn = true,   -- CSS hsl() and hsla() functions
        },
        buftypes = {},
    })
end

-- max397574/colortils.nvim
M.config_colortils = function()
    require("colortils").setup({
        color_preview = "█ %s",
        mappings = {
            transparency = "t",
            choose_background = "b",
        },
    })
end

-- uga-rosa/ccc.nvim
M.config_ccc = function()
    require("ccc").setup({
        highlighter = {
            auto_enable = true,
            lsp = true,
        }
    })
end

return M
