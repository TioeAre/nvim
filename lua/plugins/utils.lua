local M = require("plugin_config.utils")

return {
    -- 查找按键
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = M.init_which_key,
        opts = M.opts_which_key,
    },
    -- 添加注释
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" }, -- InsertEnter
        config = M.config_comment,
    },
    -- 彩虹色括号
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = M.config_rainbow_delimiters,
    },
    -- 彩色缩进
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPre", "BufNewFile" },
        main = "ibl",
        opts = M.opts_indent_blankline,
        config = M.config_indent_blankline,
    },
    -- 高亮选中词汇
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPre", "BufNewFile" },
        config = M.config_vim_illuminate,
    },
    -- 高亮复制内容
    {
        "machakann/vim-highlightedyank",
        event = { "BufReadPre", "BufNewFile" },
    },
    -- 高亮行尾空格, 保存时去除空格
    {
        "emileferreira/nvim-strict",
        event = { "InsertLeave", "TextChanged", "BufReadPre", "BufNewFile" },
        config = M.config_strict,
    },
    -- auto save
    {
        "okuuva/auto-save.nvim",
        cmd = "ASToggle", -- optional for lazy loading on command
        event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
        opts = M.opts_auto_save,
    },
    -- 底部error栏
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = { "BufReadPre", "BufNewFile" },
        opts = M.opts_trouble,
        keys = M.keys_trouble,
    },
    -- todo trees
    {
        "folke/todo-comments.nvim",
        lazy = false,
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = M.opts_todo_comments,
        keys = M.keys_todo_comments,
    },
    -- 暗色显示没有使用的代码
    {
        "folke/twilight.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = { "BufReadPre", "BufNewFile" },
        opts = M.opts_twilight,
    },
    -- 保存上一次关闭时的工作区
    {
        "folke/persistence.nvim",
        lazy = false, -- this will only start session saving when an actual file was opened
        opts = M.opts_persistence,
    },
    -- 打开文件时恢复上次光标位置
    {
        "ethanholz/nvim-lastplace",
        event = { "BufReadPre" },
        config = M.config_lastplace,
    },
    -- 命令行
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        cmd = "ToggleTerm",
        opts = M.opts_toggleterm,
    },
    -- 换行自动添加tab
    {
        "vidocqh/auto-indent.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = M.opts_auto_indent,
    },
    -- 折叠代码块
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        event = { "BufReadPre", "BufNewFile" },
        config = M.config_ufo,
    },
    -- 跳转光标位置
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        keys = M.keys_flash,
    },
    -- 跳转窗口
    {
        "s1n7ax/nvim-window-picker",
        name = "window-picker",
        event = "VeryLazy",
        version = "2.*",
        config = M.config_nvim_window_picker,
        opts = M.opts_nvim_window_picker,
    },
    -- json5
    {
        "Joakker/lua-json5",
        build = "bash install.sh",
        lazy = false,
    },
    -- markdown
    -- {
    --     "toppair/peek.nvim",
    --     event = { "VeryLazy" },
    --     build = "deno task --quiet build:fast",
    --     config = M.config_peek
    -- },
}
