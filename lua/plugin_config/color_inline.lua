local M = {}

-- norcalli/nvim-colorizer.lua
-- NvChad/nvim-colorizer.lua
M.config_colorizer = function()
    require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
            RGB = true, -- #RGB hex codes
            RRGGBB = true, -- #RRGGBB hex codes
            names = true, -- "Name" codes like Blue or blue
            RRGGBBAA = true, -- #RRGGBBAA hex codes
            AARRGGBB = false, -- 0xAARRGGBB hex codes
            rgb_fn = true, -- CSS rgb() and rgba() functions
            hsl_fn = true, -- CSS hsl() and hsla() functions
            css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
            -- Available modes for `mode`: foreground, background,  virtualtext
            mode = "background", -- Set the display mode.
            -- Available methods are false / true / "normal" / "lsp" / "both"
            -- True is same as normal
            tailwind = false, -- Enable tailwind colors
            -- parsers can contain values used in |user_default_options|
            sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
            virtualtext = "■",
            -- update color values even if buffer is not focused
            -- example use: cmp_menu, cmp_docs
            always_update = false,
        },
        -- all the sub-options of filetypes apply to buftypes
        buftypes = {},
    })
    local group = vim.api.nvim_create_augroup("colorizer", {})
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
        pattern = "*",
        group = group,
        callback = function()
            vim.cmd("ColorizerAttachToBuffer")
        end,
    })
end

-- max397574/colortils.nvim
M.config_colortils = function()
    require("colortils").setup({
        -- Register in which color codes will be copied
        register = "+",
        -- Preview for colors, if it contains `%s` this will be replaced with a hex color code of the color
        color_preview = "█ %s",
        -- The default in which colors should be saved
        -- This can be hex, hsl or rgb
        default_format = "hex",
        -- Border for the float
        border = "rounded",
        -- Some mappings which are used inside the tools
        mappings = {
            -- increment values
            increment = "l",
            -- decrement values
            decrement = "h",
            -- increment values with bigger steps
            increment_big = "L",
            -- decrement values with bigger steps
            decrement_big = "H",
            -- set values to the minimum
            min_value = "0",
            -- set values to the maximum
            max_value = "$",
            -- save the current color in the register specified above with the format specified above
            set_register_default_format = "<cr>",
            -- save the current color in the register specified above with a format you can choose
            set_register_cjoose_format = "g<cr>",
            -- replace the color under the cursor with the current color in the format specified above
            replace_default_format = "<m-cr>",
            -- replace the color under the cursor with the current color in a format you can choose
            replace_choose_format = "g<m-cr>",
            -- export the current color to a different tool
            export = "E",
            -- set the value to a certain number (done by just entering numbers)
            set_value = "c",
            -- toggle transparency
            transparency = "t",
            -- choose the background (for transparent colors)
            choose_background = "b",
        },
    })
end

return M
