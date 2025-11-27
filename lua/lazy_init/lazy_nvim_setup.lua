-- if there are rust and node.js
-- true: will disable some plugins required them
-- false: will enable all ide plugins
vim.g.only_text_editor = true
vim.g.only_text_editor = false

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

-- require("lazy").setup("plugins", opts)
local all_plugins = require("plugins")
local enabled_plugins = {}
for _, plugin in ipairs(all_plugins) do
	if plugin.enabled == nil or plugin.enabled == true then
		table.insert(enabled_plugins, plugin)
	end
end

require("lazy").setup(enabled_plugins, opts)
