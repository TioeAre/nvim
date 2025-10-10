return {
    {
        "folke/neoconf.nvim", -- setup in lsp.lua
        enabled = not vim.g.if_text_editor,
        lazy = false,
        cmd = "Neoconf",
    },
    {
        "folke/neodev.nvim",
        enabled = not vim.g.if_text_editor,
        event = "VeryLazy",
    },
}
