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
    -- local group = vim.api.nvim_create_augroup("colorizer", {})
    -- vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
    --     pattern = "*",
    --     group = group,
    --     callback = function()
    --         vim.cmd("ColorizerAttachToBuffer")
    --     end,
    -- })
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

-- ziontee113/color-picker.nvim
M.config_color_picker = function()
    require("color-picker").setup({ -- for changing icons & mappings
        -- ["icons"] = { "ﱢ", "" },
        -- ["icons"] = { "ﮊ", "" },
        -- ["icons"] = { "", "ﰕ" },
        -- ["icons"] = { "", "" },
        -- ["icons"] = { "", "" },
        ["icons"] = { "█", "█" },
        ["border"] = "rounded", -- none | single | double | rounded | solid | shadow
        ["keymap"] = { -- mapping example:
            ["T"] = "<Plug>ColorPickerToggleTransparency",
            -- ["U"] = "<Plug>ColorPickerSlider5Decrease",
            -- ["O"] = "<Plug>ColorPickerSlider5Increase",
        },
        ["background_highlight_group"] = "Normal", -- default
        ["border_highlight_group"] = "FloatBorder", -- default
        ["text_highlight_group"] = "Normal", --default
    })
end

-- uga-rosa/ccc.nvim
M.config_ccc = function()
    vim.opt.termguicolors = true
    local ccc = require("ccc")
    local mapping = ccc.mapping
    local ColorInput = require("ccc.input")
    local convert = require("ccc.utils.convert")

    local RgbHslCmykInput = setmetatable({
        name = "RGB/HSL/CMYK",
        max = { 1, 1, 1, 360, 1, 1, 1, 1, 1, 1 },
        min = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        delta = { 1 / 255, 1 / 255, 1 / 255, 1, 0.01, 0.01, 0.005, 0.005, 0.005, 0.005 },
        bar_name = { "R", "G", "B", "H", "S", "L", "C", "M", "Y", "K" },
    }, { __index = ColorInput })
    function RgbHslCmykInput.format(n, i)
        if i <= 3 then
            -- RGB
            n = n * 255
        elseif i == 5 or i == 6 then
            -- S or L of HSL
            n = n * 100
        elseif i >= 7 then
            -- CMYK
            return ("%5.1f%%"):format(math.floor(n * 200) / 2)
        end
        return ("%6d"):format(n)
    end
    function RgbHslCmykInput.from_rgb(RGB)
        local HSL = convert.rgb2hsl(RGB)
        local CMYK = convert.rgb2cmyk(RGB)
        local R, G, B = unpack(RGB)
        local H, S, L = unpack(HSL)
        local C, M, Y, K = unpack(CMYK)
        return { R, G, B, H, S, L, C, M, Y, K }
    end
    function RgbHslCmykInput.to_rgb(value)
        return { value[1], value[2], value[3] }
    end
    function RgbHslCmykInput:_set_rgb(RGB)
        self.value[1] = RGB[1]
        self.value[2] = RGB[2]
        self.value[3] = RGB[3]
    end
    function RgbHslCmykInput:_set_hsl(HSL)
        self.value[4] = HSL[1]
        self.value[5] = HSL[2]
        self.value[6] = HSL[3]
    end
    function RgbHslCmykInput:_set_cmyk(CMYK)
        self.value[7] = CMYK[1]
        self.value[8] = CMYK[2]
        self.value[9] = CMYK[3]
        self.value[10] = CMYK[4]
    end
    function RgbHslCmykInput:callback(index, new_value)
        self.value[index] = new_value
        local v = self.value
        if index <= 3 then
            local RGB = { v[1], v[2], v[3] }
            local HSL = convert.rgb2hsl(RGB)
            local CMYK = convert.rgb2cmyk(RGB)
            self:_set_hsl(HSL)
            self:_set_cmyk(CMYK)
        elseif index <= 6 then
            local HSL = { v[4], v[5], v[6] }
            local RGB = convert.hsl2rgb(HSL)
            local CMYK = convert.rgb2cmyk(RGB)
            self:_set_rgb(RGB)
            self:_set_cmyk(CMYK)
        else
            local CMYK = { v[7], v[8], v[9], v[10] }
            local RGB = convert.cmyk2rgb(CMYK)
            local HSL = convert.rgb2hsl(RGB)
            self:_set_rgb(RGB)
            self:_set_hsl(HSL)
        end
    end

    ccc.setup({
        auto_close = true,
        default_color = "#d95466",
        -- preserve = true,
        inputs = {
            RgbHslCmykInput,
        },
        highlighter = {
            auto_enable = true,
            lsp = true,
        },
        mappings = {
        -- Disable only 'q' (|ccc-action-quit|)
        -- w = mapping.none,
        -- w = mapping.increase5()
    }
    })
end

return M
