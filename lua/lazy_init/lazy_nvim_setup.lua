-- if there are rust and node.js
-- true: will disable some plugins required them
-- false: will enable all ide plugins
vim.g.only_text_editor = true

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
-- vim.g.mapleader = " "

-- lazy default configs
local opts = {
    defaults = {
        lazy = true,
    },
    install = {
        colorscheme = { "nightfox" },
    },
    rtp = {
        disabled_plugins = {
            "gzip",
            "matchit",
            "matchparen",
            "netrw",
            "netrwPlugin",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
        },
        change_detection = {
            notify = true,
        },
    },
}

require("lazy").setup("plugins", opts)
