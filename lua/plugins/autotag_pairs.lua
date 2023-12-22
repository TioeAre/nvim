local config_autotag = function()
    local filetypes = {'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx',
                       'jsx', 'rescript', 'xml', 'php', 'markdown', 'astro', 'glimmer', 'handlebars', 'hbs'}
    local skip_tags = {'area', 'base', 'br', 'col', 'command', 'embed', 'hr', 'img', 'slot', 'input', 'keygen', 'link',
                       'meta', 'param', 'source', 'track', 'wbr', 'menuitem'}
    require'nvim-treesitter.configs'.setup {
        autotag = {
            enable = true,
            enable_rename = true,
            enable_close = true,
            enable_close_on_slash = true,
            filetypes = {"html", "xml"}
        }
    }
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = {
            spacing = 5,
            severity_limit = 'Warning'
        },
        update_in_insert = true
    })
end

return {{
    "windwp/nvim-ts-autotag",
    lazy = false,
    config = config_autotag,
    dependencies = {"nvim-treesitter/nvim-treesitter"}
}, {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}, -- this is equal to setup({}) function
    -- require('nvim-autopairs').setup({ })
}}
