local opt = vim.opt

-- relative line number
opt.relativenumber = true
opt.number = true
opt.termguicolors = true -- enable more colors
opt.colorcolumn = "120"
opt.signcolumn = "yes"   -- sign column, e.g. git status
opt.cmdheight = 1
opt.scrolloff = 5        -- minimum number of lines to keep above and below the cursor when moving
-- indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- long lines wrap
opt.wrap = true

-- cursor line
opt.cursorline = true

-- enable mouse
opt.mouse:append("a")

-- system clipboard
opt.clipboard:append("unnamedplus")

-- default new window to the right and below
opt.splitright = true
opt.splitbelow = true

-- search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true -- search as characters are entered
opt.hlsearch = true  -- highlight search results

-- others
opt.completeopt = "menuone,noinsert,noselect"
opt.backspace = "indent,eol,start"
opt.autochdir = false     -- change working directory with file switch
opt.iskeyword:append("-") -- recognize '-' as part of a word
opt.modifiable = true     -- whether buffer is modifiable
opt.encoding = "UTF-8"
opt.autoread = true
opt.updatetime = 50
opt.undofile = true
opt.undodir = vim.fn.expand("$HOME/.local/share/nvim/undo")
opt.exrc = true

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
vim.opt.spell = false
vim.opt.spelllang = "en"
vim.opt.spelloptions = "camel"
