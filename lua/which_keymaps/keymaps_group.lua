local wk = require("which-key")

wk.add({
    {
        "B",
        desc = "color choose background",
    },
    -- folke/trouble.nvim
    {
        "c",
        desc = "open code href trouble",
    },
    {
        "d",
        desc = "delete dap ui breakpoint",
    },
    {
        "e",
        desc = "edit dap ui breakpoint",
    },
    {
        "E",
        desc = "color export",
    },
    { -- neovim/nvim-lspconfig
        "g",
        group = "goto lsp ...",
    },
    {
        "h",
        desc = "color decrement values",
    },
    {
        "H",
        desc = "color decrement bigger",
    },
    {
        "j",
        desc = "jump next trouble item",
    },
    {
        "k",
        desc = "previous trouble item",
    },
    {
        "K",
        desc = "hover trouble/lsp show documentation",
    },
    { -- max397574/colortils.nvim
        "l",
        desc = "color increment values",
    },
    {
        "L",
        desc = "color increment bigger",
    },
    { -- echasnovski/mini.surround
        "m",
        desc = "mini.surround",
    },
    {
        "o",
        desc = "jump and close trouble/dap open ui breakpoint",
    },
    {
        "P",
        desc = "toggle auto preview trouble",
    },
    {
        "q",
        desc = "close trouble list",
    },
    { -- folke/flash.nvim
        "r",
        function()
            require("flash").remote()
        end,
        desc = "remote flash",
        mode = { "o" },
    },
    {
        "R",
        function()
            require("flash").treesitter_search()
        end,
        desc = "treesitter search",
        mode = { "x", "o" },
    },
    {
        "s",
        function()
            require("flash").jump()
        end,
        desc = "flash",
        mode = { "n", "x", "o" },
    },
    {
        "S",
        function()
            require("flash").treesitter()
        end,
        desc = "flash treesitter",
        mode = { "n", "x", "o" },
    },
    { -- rcarriga/nvim-dap-ui
        "t",
        desc = "toggle dap ui breakpoint",
    },
    {
        "z",
        group = "toggle fold",
    },
    {
        "<esc>",
        desc = "cancel trouble preview",
    },
    {
        "?",
        desc = "help trouble",
    },
})

wk.add({
    mode = "n",
    {
        "<leader>b",
        group = "bufferline switch/dap breakpoint/buffer manager",
    },
    {
        "<leader>c",
        group = "close bufferline|window/code action/create docs",
    },
    {
        "<leader>d",
        group = "diagnostics/type_definition/dap",
    },
    {
        "<leader>D",
        desc = "lsp type_definition_preview",
    },
    {
        "<leader>f",
        group = "find telescope/todo/undo/buffer/project/dap configurations/lsp",
    },
    {
        "<leader>fp",
        group = "telescope project/persisted",
    },
    {
        "<leader>g",
        group = "git",
    },
    {
        "<leader>h",
        group = "history, memento",
    },
    {
        "<leader>l",
        group = "list trouble/todo/toggle lsp_lens",
    },
    {
        "<leader>m",
        group = "markdown/messages/swap shift window",
    },
    {
        "<leader>n",
        group = "no highlight",
    },
    {
        "<leader>o",
        group = "open layout/outline/gitgraph/session",
    },
    {
        "<leader>oc",
        group = "cclshierarchy callings",
        mode = "n",
    },
    {
        "<leader>os",
        group = "open symbols",
    },
    {
        "<leader>p",
        group = "pick window/project add/preview makrdown/peek lsp",
    },
    {
        "<leader>r",
        group = "rename/remove/ros/run cmake|task/restart lsp",
    },
    -- Civitasv/cmake-tools.nvim
    {
        "<leader>rc",
        group = "cmake",
    },
    {
        "<leader>rcs",
        group = "cmake select",
    },
    {
        "<leader>rp",
        group = "ros picker",
    },
    {
        "<leader>s",
        group = "split/search|replace/sessions/switch trouble filter",
    },
    {
        "<leader>t",
        group = "tree/trigger linting/treesitter selection/show path of current buffer",
    },
    {
        "<leader>v",
        group = "venv",
    },
    {
        "<leader>w",
        group = "save|quit/lsp worksapce",
    },
})

wk.add({
    mode = "v",
    -- nvim-treesitter/nvim-treesitter-textobjects
    {
        "a",
        group = "treesitter @function.outer",
    },
    {
        "<leader>s",
        group = "search",
    },
})
