-- some command that only one key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local keymap = vim.keymap

-- normal 不执行递归映射, 不输出命令消息
local opts = { noremap = true, silent = true }

-- ################# insert mode #################

-- ################# vision mode #################
-- shift+j/k 单行或多行一起上下移动
keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)
-- Hint: start visual mode with the same area as the previous area and the same mode
keymap.set("v", "<Tab>", ">gv", opts)
keymap.set("v", "<S-Tab>", "<gv", opts)

-- ################# normal mode #################
-- leader+sv/sh 水平/垂直新增窗口
-- keymap.set("n", "<leader>sv", "<C-w>v", opts)
-- keymap.set("n", "<leader>sh", "<C-w>s", opts)
keymap.set("n", "<c-F11>", ":MaximizerToggle<cr>", opts)
-- leader+nh 取消高亮
-- keymap.set("n", "<leader>nh", ":nohl<CR>", opts)
-- alt+h/j/k/l 移动光标所在窗口
-- keymap.set("n", "<A-h>", "<C-w>h", opts)
-- keymap.set("n", "<A-j>", "<C-w>j", opts)
-- keymap.set("n", "<A-k>", "<C-w>k", opts)
-- keymap.set("n", "<A-l>", "<C-w>l", opts)
-- 长文换行时上下移动与跳转行数
keymap.set({ "n", "v" }, "j", [[v:count ? 'j' : 'gj']], { noremap = true, expr = true })
keymap.set({ "n", "v" }, "k", [[v:count ? 'k' : 'gk']], { noremap = true, expr = true })
keymap.set({ "n", "v" }, "<Up>", [[v:count ? 'j' : 'gk']], { noremap = true, expr = true })
keymap.set({ "n", "v" }, "<Down>", [[v:count ? 'k' : 'gj']], { noremap = true, expr = true })
-- Resize with arrows
-- delta: 2 lines
-- keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
-- keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
-- keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
-- keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)
-- 切换buffer
keymap.set("n", "<A-Tab>", "<cmd>bNext<cr>", opts)
-- 保存文件
-- keymap.set('n', '<Leader>we', ':wa<cr>', opts)
-- keymap.set('n', '<Leader>wq', ':wa<CR>:wq<CR>', opts)
-- keymap.set('n', '<Leader>ws', ':wa<CR>:wqa<CR>', opts)
