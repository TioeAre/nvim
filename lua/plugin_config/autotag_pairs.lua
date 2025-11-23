local M = {}
local filetype = require("utils.filetype")

-- windwp/nvim-ts-autotag
M.config_autotag = function()
    require('nvim-ts-autotag').setup({
        per_filetype = {
            ["bigfile"] = {
                enable_close = false
            }
        }
    })
end

-- windwp/nvim-autopairs
M.opts_auto_pairs = {}
M.config_auto_pairs = function()
    require('nvim-autopairs').setup({
        check_ts = true,
        enable_check_bracket_line = false,
        disable_filetype = filetype.excluded_filetypes,
    })
end

return M
