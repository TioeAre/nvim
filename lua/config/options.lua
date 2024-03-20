local opt = vim.opt

-- 行号
opt.relativenumber = true
opt.number = true
opt.termguicolors = true -- 启用更多色彩
opt.colorcolumn = "120"
opt.signcolumn = "yes" -- 标志列, 如git状态
opt.cmdheight = 1
opt.scrolloff = 10 -- 光标移动时距离上下界的最小行数

-- 缩进
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- 过长拆行
opt.wrap = true

-- 光标行
opt.cursorline = true

-- 启用鼠标
opt.mouse:append("a")

-- 系统剪贴板
opt.clipboard:append("unnamedplus")

-- 默认新窗口右和下
opt.splitright = true
opt.splitbelow = true

-- 搜索
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true -- search as characters are entered
opt.hlsearch = true -- 高亮搜索

-- others
opt.completeopt = "menuone,noinsert,noselect"
opt.backspace = "indent,eol,start"
opt.autochdir = false -- 随文件切换更改缓存区
opt.iskeyword:append("-") -- 识别'-'为一个词
opt.modifiable = true -- 缓存区是否能够修改
opt.encoding = "UTF-8"
opt.autoread = true
opt.updatetime = 50
opt.undofile = true
opt.undodir = vim.fn.expand("$HOME/.local/share/nvim/undo")
opt.exrc = true

-- 主题
-- vim.cmd[[colorscheme tokyonight-moon]]

-- autocmd for changed files
vim.api.nvim_exec(
    [[
  augroup AutoRefresh
    autocmd!
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * silent! checktime
    autocmd FileChangedShellPost * echohl InfoMsg | echo "File changed on disk. Buffer reloaded." | echohl None | checktime
  augroup END
]],
    false
)

vim.g.python3_host_prog = "python3"

vim.opt.laststatus = 3

-- swap file
vim.opt.swapfile = false

-- spell check
vim.opt.spell = true
vim.opt.spelllang = "en"
vim.opt.spelloptions = "camel"

