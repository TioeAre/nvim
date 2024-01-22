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
    -- nvim-treesitter/nvim-treesitter
    require("nvim-treesitter.configs").setup({
        autotag = {
            enable = true,
            enable_rename = true,
            enable_close = true,
            enable_close_on_slash = true,
            filetypes = filetypes,
            skip_tags = skip_tags,
        },
    })
end

-- windwp/nvim-autopairs
M.opts_auto_pairs = {}
M.config_auto_pairs = function()
    require('nvim-autopairs').setup({
        check_ts = true,
        enable_check_bracket_line = false
      })
end

return M
