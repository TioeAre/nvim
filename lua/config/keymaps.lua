-- some command that only one key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local keymap = vim.keymap

-- normal
local opts = { noremap = true, silent = true }

-- ################# insert mode #################

-- ################# vision mode #################
-- shift+j/k single or multiple lines up and down together
keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)
-- Hint: start visual mode with the same area as the previous area and the same mode
keymap.set("v", "<Tab>", ">gv", opts)
keymap.set("v", "<S-Tab>", "<gv", opts)

-- ################# normal mode #################
-- leader+sv/sh split window
keymap.set("n", "<c-F11>", ":MaximizerToggle<cr>", opts)
-- move in wrap lines
keymap.set({ "n", "v" }, "j", [[v:count ? 'j' : 'gj']], { noremap = true, expr = true })
keymap.set({ "n", "v" }, "k", [[v:count ? 'k' : 'gk']], { noremap = true, expr = true })
keymap.set({ "n", "v" }, "<Up>", [[v:count ? 'j' : 'gk']], { noremap = true, expr = true })
keymap.set({ "n", "v" }, "<Down>", [[v:count ? 'k' : 'gj']], { noremap = true, expr = true })
-- switch between buffers
keymap.set("n", "<A-Tab>", "<cmd>bNext<cr>", opts)
keymap.set("n", "<c-Tab>", "<cmd>bprevious<cr>", opts)
