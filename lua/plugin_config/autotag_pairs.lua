local M = {}

-- windwp/nvim-ts-autotag
M.config_autotag = function()
    local filetypes = {
        "html",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "svelte",
        "vue",
        "tsx",
        "jsx",
        "rescript",
        "xml",
        "php",
        "markdown",
        "astro",
        "glimmer",
        "handlebars",
        "hbs",
        "launch",
    }
    local skip_tags = {
        "area",
        "base",
        "br",
        "col",
        "command",
        "embed",
        "hr",
        "img",
        "slot",
        "input",
        "keygen",
        "link",
        "meta",
        "param",
        "source",
        "track",
        "wbr",
        "menuitem",
    }
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
    local filetype = require("utils.filetype")
    require('nvim-autopairs').setup({
        check_ts = true,
        enable_check_bracket_line = false,
        disable_filetype = filetype.excluded_filetypes,
    })
end

return M
