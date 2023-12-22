local keymap = vim.keymap

local config_comment = function()
    -- TODO: 添加选中多行注释后保留选中状态的功能
    local comment = require('Comment')
    comment.setup({
        ignore = '^$',
        padding = true,
        sticky = true,
        toggler = {
            ---Line-comment toggle keymap
            line = '<C-_>',
            ---Block-comment toggle keymap
            block = 'gbc'
        },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
            ---Line-comment keymap
            line = '<C-_>',
            ---Block-comment keymap
            block = 'gb'
        },
        comment_empty = false
    })
end

local config_indent_blankline = function()
    local highlight = {"RainbowRed", "RainbowYellow", "RainbowBlue", "RainbowOrange", "RainbowGreen", "RainbowViolet",
                       "RainbowCyan"}
    local hooks = require "ibl.hooks"
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", {
            fg = "#e5c2c5"
        })
        vim.api.nvim_set_hl(0, "RainbowYellow", {
            fg = "#deceb0"
        })
        vim.api.nvim_set_hl(0, "RainbowBlue", {
            fg = "#86acca"
        })
        vim.api.nvim_set_hl(0, "RainbowOrange", {
            fg = "#cab4a0"
        })
        vim.api.nvim_set_hl(0, "RainbowGreen", {
            fg = "#bacbaf"
        })
        vim.api.nvim_set_hl(0, "RainbowViolet", {
            fg = "#cbb0d4"
        })
        vim.api.nvim_set_hl(0, "RainbowCyan", {
            fg = "#a1c0c4"
        })
    end)
    vim.g.rainbow_delimiters = {
        highlight = highlight
    }
    require("ibl").setup {
        indent = {
            char = '▏',
            highlight = highlight,
            smart_indent_cap = true
        },
        scope = {
            char = '▎',
            highlight = highlight
        }
    }
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

local config_strict = function()
    require('strict').setup({
        -- included_filetypes = nil,
        excluded_filetypes = nil,
        excluded_buftypes = {'help', 'nofile', 'terminal', 'prompt'},
        -- match_priority = -1,
        deep_nesting = {
            highlight = true,
            highlight_group = 'DiffDelete',
            depth_limit = 5,
            ignored_trailing_characters = {',', ';'},
            ignored_leading_characters = {'.'}
        },
        trailing_whitespace = {
            highlight = true,
            highlight_group = 'DiffDelete',
            remove_on_save = true
        },
        todos = {
            highlight = true,
            highlight_group = 'DiffAdd'
        },
        space_indentation = {
            highlight = false,
            highlight_group = 'DiffDelete',
            convert_on_save = true
        },
        tab_indentation = {
            highlight = false,
            highlight_group = 'DiffDelete',
            convert_on_save = false
        },
        overlong_lines = {
            highlight = false,
            highlight_group = 'DiffDelete',
            length_limit = 120,
            split_on_save = false
        },
        trailing_empty_lines = {
            highlight = false,
            highlight_group = 'SpellBad',
            remove_on_save = false
        }
    })
    -- auto save
    local group = vim.api.nvim_create_augroup('autosave', {})
    local strict = require('strict')
    vim.api.nvim_create_autocmd('User', {
        pattern = 'AutoSaveWritePre',
        group = group,
        callback = function(opts)
            if opts.data.saved_buffer ~= nil then
                local filename = vim.api.nvim_buf_get_name(opts.data.saved_buffer)
                strict.convert_tabs_to_spaces()
                strict.remove_trailing_whitespace()
            end
        end
    })
end

local opts_auto_save = {
    enabled = true,
    execution_message = {
        enabled = true,
        message = function() -- message to print on save
            return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
        end,
        dim = 0.18, -- dim the color of `message`
        cleaning_interval = 500 -- (milliseconds) automatically clean MsgArea after displaying `message`.
    },
    trigger_events = { -- See :h events
        immediate_save = {"BufLeave"}, --  "FocusLost"
        defer_save = {"FocusLost"}, --  "InsertLeave", "TextChanged"
        cancel_defered_save = {"InsertEnter"}
    },
    -- function that takes the buffer handle and determines whether to save the current buffer or not
    -- return true: if buffer is ok to be saved
    -- return false: if it's not ok to be saved
    -- if set to `nil` then no specific condition is applied
    condition = nil,
    write_all_buffers = false, -- write all buffers when the current one meets `condition`
    noautocmd = false, -- do not execute autocmds when saving
    debounce_delay = 10000,
    debug = false
}

local opts_trouble = {
    position = "bottom",
    height = 10,
    width = 50, -- width of the list when position is left or right
    action_keys = {
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = {"<cr>", "<tab>", "<2-leftmouse>"}, -- jump to the diagnostic or open / close folds
        open_split = {"<c-x>"}, -- open buffer in new split
        open_vsplit = {"<c-v>"}, -- open buffer in new vsplit
        open_tab = {"<c-t>"}, -- open buffer in new tab
        jump_close = {"o"}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        switch_severity = "s", -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        open_code_href = "c", -- if present, open a URI with more information about the diagnostic error
        close_folds = {"zM", "zm"}, -- close all folds
        open_folds = {"zR", "zr"}, -- open all folds
        toggle_fold = {"zA", "za"}, -- toggle fold of current file
        previous = "k", -- previous item
        next = "j", -- next item
        help = "?", -- help menu
    }
}
local keys_trouble = {
    {
        "<leader>ls",
        ":TroubleToggle document_diagnostics<cr>", -- open trouble document_diagnostics
        desc = "open trouble document_diagnostics"
    }, {
        "<leader>lw",
        ":TroubleToggle workspace_diagnostics<cr>", -- open trouble workspace_diagnostics
        desc = "open trouble workspace_diagnostics "
    }, {
        "<leader>lp",
        ":TroubleToggle lsp_references<cr>", -- open trouble lsp_references
        desc = "open trouble lsp_references"
    }, {
        "<leader>ld",
        ":TroubleToggle lsp_definitions<cr>", -- open trouble lsp_definitions
        desc = "open trouble lsp_definitions"
    }, {
        "<leader>lq",
        ":TroubleToggle quickfix<cr>", -- open trouble quickfix
        desc = "open trouble quickfix"
    }
}

local opts_todo_comments = {vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
end, {
    desc = "Next todo comment"
}), vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end, {
    desc = "Previous todo comment"
}) -- You can also specify a list of valid jump keywords
}
local keys_todo_comments = {{
    "<leader>lt",
    ":TodoTrouble<cr>", -- 打开trouble todo
    desc = "open trouble todo window"
}, {
    "<leader>ft",
    ":TodoTelescope<cr>", -- find todo in telescope
    desc = "find todo in telescope"
}}

local opts_twilight = {
    dimming = {
        alpha = 0.25, -- amount of dimming
        -- we try to get the foreground from the highlight groups or fallback color
        color = {"Normal", "#ffffff"},
        term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
        inactive = false -- when true, other windows will be fully dimmed (unless they contain the same buffer)
    },
    context = 10, -- amount of lines we will try to show around the current line
    treesitter = true, -- use treesitter when available for the filetype
    -- treesitter is used to automatically expand the visible text,
    -- but you can further control the types of nodes that should always be fully expanded
    expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
    "function", "method", "table", "if_statement"},
    exclude = {'markdown'} -- exclude these filetypes
}

local opts_persistence = {
    dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
    options = {"buffers", "curdir", "tabpages", "winsize"}, -- sessionoptions used for saving
    pre_save = nil, -- a function to call before saving the session
    save_empty = false, -- don't save if there are no open file buffers
    vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {}),
    -- restore the last session
    vim.api.nvim_set_keymap("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {}),
    -- stop Persistence => session won't be saved on exit
    vim.api.nvim_set_keymap("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]], {})
}

local init_edgy = function()
    -- views can only be fully collapsed with the global statusline
    vim.opt.laststatus = 3
    -- Default splitting will cause your main splits to jump when opening an edgebar.
    -- To prevent this, set `splitkeep` to either `screen` or `topline`.
    vim.opt.splitkeep = "screen"
end
local opts_edgy = {
    bottom = {{
        ft = "toggleterm",
        filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
        end
    },
    "Trouble", {
        ft = "qf",
        title = "QuickFix"
    }, {
        ft = "help",
        size = {
            height = 20
        },
        -- only show help buffers
        filter = function(buf)
            return vim.bo[buf].buftype == "help"
        end
    }, {
        ft = "spectre_panel",
        size = {
            height = 0.4
        }
    }},
    left = { -- Neo-tree filesystem always takes half the screen height
    }
}

local opts_toggleterm = {
    size = function(term)
        if term.direction == "horizontal" then
            return math.floor(vim.o.lines * 0.35)
        elseif term.direction == "vertical" then
            return math.floor(vim.o.columns * 0.3)
        end
    end,
    direction = "horizontal",
    open_mapping = [[<c+\>]],
    hide_numbers = true,
    start_in_insert = true,
    shade_terminals = true,
    -- {
    --     "<C-\>",
    --     "<cmd>ToggleTerm<cr>",
    --     desc = "Toggle terminal"
    -- },
    vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\>", {noremap = true, silent = true}),
    vim.api.nvim_set_keymap("t", "<C-l>", "<Cmd> wincmd l<CR>", {noremap = true, silent = true}),
    vim.api.nvim_set_keymap("t", "<C-h>", "<Cmd> wincmd h<CR>", {noremap = true, silent = true}),
    vim.api.nvim_set_keymap("t", "<C-j>", "<Cmd> wincmd j<CR>", {noremap = true, silent = true}),
    vim.api.nvim_set_keymap("t", "<C-k>", "<Cmd> wincmd k<CR>", {noremap = true, silent = true}),
}

local config_lsp_lens = function()
    require'lsp-lens'.setup({
        enable = true,
        include_declaration = false,      -- Reference include declaration
        sections = {                      -- Enable / Disable specific request, formatter example looks 'Format Requests'
            definition = false,
            references = true,
            implements = true,
            git_authors = true,
        },
        ignore_filetype = {},
        -- Target Symbol Kinds to show lens information
        target_symbol_kinds = { SymbolKind.Function, SymbolKind.Method, SymbolKind.Interface },
        -- Symbol Kinds that may have target symbol kinds as children
        wrapper_symbol_kinds = { SymbolKind.Class, SymbolKind.Struct },
    })
end

local opts_auto_indent = {
    lightmode = true,        -- Lightmode assumes tabstop and indentexpr not change within buffer's lifetime
    indentexpr = function(lnum)
        return require("nvim-treesitter.indent").get_indent(lnum)
      end,        -- Use vim.bo.indentexpr by default, see 'Custom Indent Evaluate Method'
    ignore_filetype = {},    -- Disable plugin for specific filetypes, e.g. ignore_filetype = { 'javascript' }
}

local config_ufo = function()
    vim.o.foldcolumn = '1' -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.keymap.set('n', 'zo', require('ufo').openFoldsExceptKinds)
    vim.keymap.set('n', 'zc', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
    vim.keymap.set('n', 'zO', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zC', require('ufo').closeAllFolds)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }
    local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
    for _, ls in ipairs(language_servers) do
        require('lspconfig')[ls].setup({
            capabilities = capabilities
            -- you can add other fields for setting up lsp server in this table
        })
    end
    require('ufo').setup()
end

return
    { -- which_key, Comment, rainbow_delimiters, indent_blankline, illuminate, highlightedyank, lualine, highlight_whitespace
    {
        "folke/which-key.nvim",
        event = 'VeryLazy',
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 700
        end,
        opts = {}
    }, { -- 添加注释
        'numToStr/Comment.nvim',
        lazy = false,
        config = config_comment
    }, { -- 彩虹色括号
        "HiPhish/rainbow-delimiters.nvim",
        lazy = false,
        config = function()
            require('rainbow-delimiters.setup').setup({
                -- strategy = {
                -- },
                -- query = {
                -- highlight = {
                -- }
            })
        end
    }, { -- 彩色缩进
        "lukas-reineke/indent-blankline.nvim",
        lazy = false,
        main = "ibl",
        opts = {},
        config = config_indent_blankline
    }, { -- 高亮选中词汇
        "RRethy/vim-illuminate",
        lazy = false,
        config = function()
            require("illuminate").configure({})
        end
    }, { -- 高亮复制内容
        "machakann/vim-highlightedyank",
        lazy = false
    }, { -- 高亮行尾空格, 保存时去除空格
        'emileferreira/nvim-strict',
        lazy = false,
        event = {"InsertLeave", "TextChanged"},
        config = config_strict
    }, { -- auto save
        "okuuva/auto-save.nvim",
        lazy = false,
        cmd = "ASToggle", -- optional for lazy loading on command
        event = {"InsertLeave", "TextChanged"}, -- optional for lazy loading on trigger events
        opts = opts_auto_save
    }, { -- 底部error栏
        "folke/trouble.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        event = 'BufReadPre',
        opts = opts_trouble,
        keys = keys_trouble,
    }, { -- todo trees
        "folke/todo-comments.nvim",
        event = 'BufReadPre',
        dependencies = {"nvim-lua/plenary.nvim"},
        opts = opts_todo_comments,
        keys = keys_todo_comments
    }, { -- 暗色显示没有使用的代码
        "folke/twilight.nvim",
        dependencies = {"nvim-treesitter/nvim-treesitter"},
        event = 'BufReadPre',
        opts = opts_twilight
    }, { -- 保存上一次关闭时的工作区
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        opts = opts_persistence,
    },
    -- { -- 窗口管理 TODO:
    --     "folke/edgy.nvim",
    --     event = "VeryLazy",
    --     init = init_edgy,
    --     opts = opts_edgy
    -- },
    { -- 命令行
        'akinsho/toggleterm.nvim',
        version = "*",
        cmd = 'ToggleTerm',
        opts = opts_toggleterm,
    },
    { -- 显示函数引用
        'VidocqH/lsp-lens.nvim',
        config = config_lsp_lens,
    },
    { -- 换行自动添加tab
        'vidocqh/auto-indent.nvim',
        opts = opts_auto_indent,
    },
    { -- 折叠代码块
        'kevinhwang91/nvim-ufo',
        dependencies = {
            'kevinhwang91/promise-async',
        },
        event = 'BufReadPre',
        config = config_ufo,
    }
}
