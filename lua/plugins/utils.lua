local M = require("plugin_config.utils")
local W = require("utils.windows_ignore")

return {
    -- 查找按键
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = M.init_which_key,
        opts = M.opts_which_key,
        config = function()
            -- which keymap
            require("which_keymaps.keymaps")
        end
    },
    -- 添加注释
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPost", "InsertEnter" }, -- InsertEnter
        config = M.config_comment,
    },
    -- 彩虹色括号
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = { "BufReadPost" },
        config = M.config_rainbow_delimiters,
    },
    -- 彩色缩进
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost" },
        main = "ibl",
        opts = M.opts_indent_blankline,
        config = M.config_indent_blankline,
    },
    -- 高亮选中词汇
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPost", "VeryLazy" },
        config = M.config_vim_illuminate,
    },
    -- smart yank
    {
        "ibhagwan/smartyank.nvim",
        dependencies = { "AckslD/nvim-neoclip.lua" },
        event = { "BufReadPost", "VeryLazy" },
        config = M.config_smartyank,
    },
    -- 高亮行尾空格, 保存时去除空格
    -- {
    --     "emileferreira/nvim-strict",
    --     dependencies = {
    --         "stevearc/conform.nvim",
    --     },
    --     event = { "InsertLeave", "TextChanged", "BufReadPost" },
    --     config = M.config_strict,
    -- },
    {
        "johnfrankmorgan/whitespace.nvim",
        -- dependencies = {
        --     "stevearc/conform.nvim",
        -- },
        event = { "InsertLeave", "TextChanged", "BufReadPost" },
        config = M.config_whitespace,
    },
    -- auto save
    {
        "okuuva/auto-save.nvim",
        cmd = "ASToggle",                         -- optional for lazy loading on command
        event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
        config = M.config_auto_save,
    },
    -- 底部error栏
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = { "BufReadPost", "VeryLazy" },
        opts = M.opts_trouble,
        keys = M.keys_trouble,
    },
    -- todo trees
    {
        "folke/todo-comments.nvim",
        -- lazy = false,
        event = { "VeryLazy" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = M.opts_todo_comments,
        keys = M.keys_todo_comments,
    },
    -- 暗色显示没有使用的代码
    {
        "folke/twilight.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        cmd = "Twilight",
        event = { "BufReadPost" },
        opts = M.opts_twilight,
    },
    -- 保存上一次关闭时的工作区
    {
        "olimorris/persisted.nvim",
        -- lazy = false, -- this will only start session saving when an actual file was opened
        event = { "BufReadPre" },
        opts = M.opts_persisted,
        config = M.config_persisted,
    },
    -- buffers history
    {
        "gaborvecsei/memento.nvim",
        event = { "VeryLazy" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = M.config_memento,
    },
    -- 打开文件时恢复上次光标位置
    {
        "ethanholz/nvim-lastplace",
        event = { "BufReadPre", "VeryLazy" },
        config = M.config_lastplace,
    },
    -- flatten 同一nvim打开文件
    {
        "willothy/flatten.nvim",
        config = M.config_flatten,
        lazy = false,
        priority = 1001,
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
        event = { "InsertEnter" },
        opts = M.opts_auto_indent,
    },
    -- 折叠代码块
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
            "nvim-treesitter/nvim-treesitter",
            "luukvbaal/statuscol.nvim",
        },
        event = { "BufReadPost" },
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
        -- version = "2.*",
        config = M.config_nvim_window_picker,
    },
    -- json5
    {
        "Joakker/lua-json5",
        build = W.windows_selectNO2string("./install.sh", "powershell ./install.ps1"),
        -- lazy = false,
        event = "BufReadPost",
        -- event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    },
    -- window spilt and switch
    {
        "mrjones2014/smart-splits.nvim",
        -- event = "UIEnter",
        lazy = false,
        build = './kitty/install-kittens.bash',
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
        event = { "BufReadPost", "VeryLazy" },
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
        cmd = { "SudaRead", "SudaWrite" },
    },
    -- surround text
    -- {
    --     "kylechui/nvim-surround",
    --     version = "*", -- Use for stability; omit to use `main` branch for the latest features
    --     event = "VeryLazy",
    --     config = M.config_nvim_surround,
    -- },
    {
        "echasnovski/mini.surround",
        event = { "BufReadPost" },
        version = false,
        config = M.config_mini_surround,
    },
    -- 匹配if else与括号
    {
        "andymass/vim-matchup",
        event = { "BufReadPost" },
        config = M.config_vim_matchup,
    },
    -- big file
    {
        "LunarVim/bigfile.nvim",
        event = { "VeryLazy", "FileReadPre" },
        config = M.config_bigfile,
    },
    -- tmux
    {
        "aserowy/tmux.nvim",
        event = { "VeryLazy" },
        config = M.config_tmux,
    },
    -- kitty
    -- {
    --     "knubie/vim-kitty-navigator",
    --     dependencies = { "edluffy/hologram.nvim" },
    --     event = { "VeryLazy" },
    --     enabled = true,
    --     build = "cp ./*.py ~/.config/kitty/",
    --     config = M.config_vim_kitty_navigator,
    -- },
    -- stickybuf
    {
        "stevearc/stickybuf.nvim",
        opts = M.opts_stickybuf,
        config = M.config_stickybuf,
    },
    -- find and replace
    {
        "nvim-pack/nvim-spectre",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = { "BufReadPost", "VeryLazy" },
        config = M.config_nvim_spectre,
    },
    -- Chinese words spilt
    -- {
    --     'noearc/jieba.nvim',
    --     dependencies = {
    --         'noearc/jieba-lua',
    --     },
    --     event = { "BufReadPost", },
    --     -- config = true,
    -- },
}
