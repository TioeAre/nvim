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
        event = { "BufReadPost", "BufNewFile", "VeryLazy" }, -- InsertEnter
        config = M.config_comment,
    },
    -- 彩虹色括号
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = { "BufReadPre", "BufNewFile", "VeryLazy" },
        config = M.config_rainbow_delimiters,
    },
    -- 彩色缩进
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPre", "BufNewFile", "VeryLazy" },
        main = "ibl",
        opts = M.opts_indent_blankline,
        config = M.config_indent_blankline,
    },
    -- 高亮选中词汇
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPost", "BufNewFile", "VeryLazy" },
        config = M.config_vim_illuminate,
    },
    -- smart yank
    {
        "ibhagwan/smartyank.nvim",
        event = { "BufReadPost", "BufNewFile", "VeryLazy" },
        config = M.config_smartyank,
    },
    -- 高亮行尾空格, 保存时去除空格
    {
        "emileferreira/nvim-strict",
        event = { "InsertLeave", "TextChanged", "BufReadPre", "BufNewFile", "VeryLazy" },
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
        event = { "BufReadPre", "BufNewFile", "VeryLazy" },
        opts = M.opts_trouble,
        keys = M.keys_trouble,
    },
    -- todo trees
    {
        "folke/todo-comments.nvim",
        -- lazy = false,
        event = {"VeryLazy"},
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = M.opts_todo_comments,
        keys = M.keys_todo_comments,
    },
    -- 暗色显示没有使用的代码
    {
        "folke/twilight.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = { "BufReadPost", "BufNewFile", "VeryLazy" },
        opts = M.opts_twilight,
    },
    -- 保存上一次关闭时的工作区
    {
        "folke/persistence.nvim",
        -- lazy = false, -- this will only start session saving when an actual file was opened
        event = {"BufReadPost", "VeryLazy"},
        opts = M.opts_persistence,
    },
    -- 打开文件时恢复上次光标位置
    {
        "ethanholz/nvim-lastplace",
        event = { "BufReadPre", "VeryLazy" },
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
        event = { "BufReadPost", "BufNewFile", "VeryLazy" },
        opts = M.opts_auto_indent,
    },
    -- 折叠代码块
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        event = { "BufReadPost", "BufNewFile", "VeryLazy" },
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
        -- event = "VeryLazy",
        -- event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    },
    -- window spilt and switch
    {
        "mrjones2014/smart-splits.nvim",
        event = "VeryLazy",
        config = M.config_smart_splits,
    },
    -- move windows
    {
        "sindrets/winshift.nvim",
        event = "VeryLazy",
        config = M.config_winshift,
    },
    -- max window
    {
        "anuvyklack/windows.nvim",
        dependencies = {
            "anuvyklack/middleclass",
            "anuvyklack/animation.nvim",
        },
        event = "VeryLazy",
        -- lazy = false,
        config = M.config_windows,
    },
    -- markdown
    {
        "ellisonleao/glow.nvim",
        config = M.config_glow,
        cmd = "Glow",
    },
    -- sudo
    {
        "lambdalisue/suda.vim",
        cmd = {"SudaRead", "SudaWrite"},
    },
    -- surround text
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = M.config_nvim_surround
    },
    -- big file
    {
        "LunarVim/bigfile.nvim",
        event = {"VeryLazy", "BufReadPre"},
        config = M.config_bigfile,
    },
}
