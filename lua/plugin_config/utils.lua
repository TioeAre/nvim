local M = {}

-- folke/which-key.nvim
M.init_which_key = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 700
end
M.opts_which_key = {}

-- numToStr/Comment.nvim
M.config_comment = function()
    -- TODO: 添加选中多行注释后保留选中状态的功能
    local comment = require("Comment")
    comment.setup({
        ignore = "^$",
        padding = true,
        sticky = true,
        toggler = {
            line = "<C-_>",
            block = "gbc",
        },
        opleader = {
            line = "<C-_>",
            block = "gb",
        },
        comment_empty = false,
    })
end

-- HiPhish/rainbow-delimiters.nvim
M.config_rainbow_delimiters = function()
    require("rainbow-delimiters.setup").setup({})
end

-- lukas-reineke/indent-blankline.nvim
M.opts_indent_blankline = {}
M.config_indent_blankline = function()
    local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
    }
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#e5c2c5" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#deceb0" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#86acca" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#cab4a0" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#bacbaf" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#cbb0d4" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#a1c0c4" })
    end)
    vim.g.rainbow_delimiters = {
        highlight = highlight,
    }
    require("ibl").setup({
        indent = {
            char = "▏",
            highlight = highlight,
            smart_indent_cap = true,
        },
        scope = {
            char = "▎",
            highlight = highlight,
        },
    })
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

-- RRethy/vim-illuminate
M.config_vim_illuminate = function()
    require("illuminate").configure({})
end

-- emileferreira/nvim-strict
M.config_strict = function()
    require("strict").setup({
        -- included_filetypes = nil,
        excluded_filetypes = nil,
        excluded_buftypes = { "help", "nofile", "terminal", "prompt" },
        -- match_priority = -1,
        deep_nesting = {
            highlight = true,
            highlight_group = "DiffDelete",
            depth_limit = 8,
            ignored_trailing_characters = { ",", ";" },
            ignored_leading_characters = { "." },
        },
        trailing_whitespace = {
            highlight = true,
            highlight_group = "DiffDelete",
            remove_on_save = true,
        },
        todos = {
            highlight = true,
            highlight_group = "DiffAdd",
        },
        space_indentation = {
            highlight = false,
            highlight_group = "DiffDelete",
            convert_on_save = false,
        },
        tab_indentation = {
            highlight = false,
            highlight_group = "DiffDelete",
            convert_on_save = false,
        },
        overlong_lines = {
            highlight = false,
            highlight_group = "DiffDelete",
            length_limit = 120,
            split_on_save = false,
        },
        trailing_empty_lines = {
            highlight = false,
            highlight_group = "SpellBad",
            remove_on_save = false,
        },
    })
    -- auto save
    local group = vim.api.nvim_create_augroup("autosave", {})
    local strict = require("strict")
    vim.api.nvim_create_autocmd("User", {
        pattern = "AutoSaveWritePre",
        group = group,
        callback = function(opts)
            if opts.data.saved_buffer ~= nil then
                local filename = vim.api.nvim_buf_get_name(opts.data.saved_buffer)
                strict.convert_tabs_to_spaces()
                strict.remove_trailing_whitespace()
            end
        end,
    })
end

-- okuuva/auto-save.nvim
M.opts_auto_save = {
    enabled = true,
    execution_message = {
        enabled = true,
        message = function() -- message to print on save
            return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
        end,
        dim = 0.18, -- dim the color of `message`
        cleaning_interval = 500, -- milliseconds
    },
    trigger_events = { -- See :h events
        immediate_save = { "BufLeave" }, --  "FocusLost"
        defer_save = { "FocusLost" }, --  "InsertLeave", "TextChanged"
        cancel_defered_save = { "InsertEnter" },
    },
    condition = nil,
    write_all_buffers = false, -- write all buffers when the current one meets `condition`
    noautocmd = false, -- do not execute autocmds when saving
    debounce_delay = 300,
    debug = false,
}

-- folke/trouble.nvim
M.opts_trouble = {
    position = "bottom",
    height = 10,
    width = 50, -- width of the list when position is left or right
    action_keys = {
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = { "<cr>", "<tab>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" }, -- <c-x> open buffer in new split
        open_vsplit = { "<c-v>" }, -- <c-v> open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = { "o" }, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        switch_severity = "<leader>ss", -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        open_code_href = "c", -- if present, open a URI with more information about the diagnostic error
        close_folds = { "zc", "zC" }, -- close all folds
        open_folds = { "zo", "zO" }, -- open all folds
        toggle_fold = { "za", "zA" }, -- toggle fold of current file
        next = "j", -- next item
        previous = "k", -- previous item
        help = "?", -- help menu
    },
}
M.keys_trouble = {
    -- {
    --     "<leader>ls",
    --     ":TroubleToggle document_diagnostics<cr>", -- open trouble document_diagnostics
    --     desc = "open trouble document_diagnostics"
    -- }, {
    --     "<leader>lw",
    --     ":TroubleToggle workspace_diagnostics<cr>", -- open trouble workspace_diagnostics
    --     desc = "open trouble workspace_diagnostics "
    -- }, {
    --     "<leader>lp",
    --     ":TroubleToggle lsp_references<cr>", -- open trouble lsp_references
    --     desc = "open trouble lsp_references"
    -- }, {
    --     "<leader>ld",
    --     ":TroubleToggle lsp_definitions<cr>", -- open trouble lsp_definitions
    --     desc = "open trouble lsp_definitions"
    -- }, {
    --     "<leader>lq",
    --     ":TroubleToggle quickfix<cr>", -- open trouble quickfix
    --     desc = "open trouble quickfix"
    -- }
}

-- folke/todo-comments.nvim
M.opts_todo_comments = {
    -- vim.keymap.set("n", "]t", function()
    --     require("todo-comments").jump_next()
    -- end, { desc = "next todo comment" }),
    -- vim.keymap.set("n", "[t", function()
    --     require("todo-comments").jump_prev()
    -- end, { desc = "previous todo comment" }), -- You can also specify a list of valid jump keywords
}
M.keys_todo_comments = {
    -- {
    --     "<leader>lt",
    --     ":TodoTrouble<cr>", -- 打开trouble todo
    --     desc = "open trouble todo window"
    -- }, {
    --     "<leader>ft",
    --     ":TodoTelescope<cr>", -- find todo in telescope
    --     desc = "find todo in telescope"
    -- }
}

-- folke/twilight.nvim
M.opts_twilight = {
    dimming = {
        alpha = 0.25, -- amount of dimming
        -- we try to get the foreground from the highlight groups or fallback color
        color = { "Normal", "#ffffff" },
        term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
        inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
    },
    context = 10, -- amount of lines we will try to show around the current line
    treesitter = true, -- use treesitter when available for the filetype
    -- treesitter is used to automatically expand the visible text,
    -- but you can further control the types of nodes that should always be fully expanded
    expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        "function",
        "method",
        "table",
        "if_statement",
    },
    exclude = { "markdown" }, -- exclude these filetypes
}

-- folke/persistence.nvim
M.opts_persistence = {
    dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
    options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
    pre_save = nil, -- a function to call before saving the session
    save_empty = false, -- don't save if there are no open file buffers
    -- vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {}),
    -- -- restore the last session
    -- vim.api.nvim_set_keymap("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {}),
    -- -- stop Persistence => session won't be saved on exit
    -- vim.api.nvim_set_keymap("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]], {})
}

-- ethanholz/nvim-lastplace
M.config_lastplace = function()
    require("nvim-lastplace").setup({})
end

-- akinsho/toggleterm.nvim
M.opts_toggleterm = {
    size = function(term)
        if term.direction == "horizontal" then
            return math.floor(vim.o.lines * 0.2)
        elseif term.direction == "vertical" then
            return math.floor(vim.o.columns * 0.2)
        end
    end,
    direction = "horizontal",
    open_mapping = [[<c+\>]],
    hide_numbers = true,
    start_in_insert = true,
    shade_terminals = true,
    -- vim.api.nvim_set_keymap("n", "<C-\\>", "<cmd> ToggleTerm<CR>", { noremap = true, silent = true }),
    -- vim.api.nvim_set_keymap("t", "<C-\\>", "<cmd> ToggleTerm<CR>", { noremap = true, silent = true }),
    -- vim.api.nvim_set_keymap("t", "<A-l>", "<Cmd> wincmd l<CR>", { noremap = true, silent = true }),
    -- vim.api.nvim_set_keymap("t", "<A-h>", "<Cmd> wincmd h<CR>", { noremap = true, silent = true }),
    -- vim.api.nvim_set_keymap("t", "<A-j>", "<Cmd> wincmd j<CR>", { noremap = true, silent = true }),
    -- vim.api.nvim_set_keymap("t", "<A-k>", "<Cmd> wincmd k<CR>", { noremap = true, silent = true }),
}

-- vidocqh/auto-indent.nvim
M.opts_auto_indent = {
    lightmode = true, -- Lightmode assumes tabstop and indentexpr not change within buffer's lifetime
    indentexpr = function(lnum)
        return require("nvim-treesitter.indent").get_indent(lnum)
    end, -- Use vim.bo.indentexpr by default, see 'Custom Indent Evaluate Method'
    ignore_filetype = {}, -- e.g. ignore_filetype = { 'javascript' }
}

-- kevinhwang91/nvim-ufo
M.config_ufo = function()
    vim.o.foldcolumn = "1" -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    -- vim.keymap.set("n", "zo", require("ufo").openFoldsExceptKinds)
    -- vim.keymap.set("n", "zc", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
    -- vim.keymap.set("n", "zO", require("ufo").openAllFolds)
    -- vim.keymap.set("n", "zC", require("ufo").closeAllFolds)

    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities.textDocument.foldingRange = {
    --     dynamicRegistration = false,
    --     lineFoldingOnly = true,
    -- }
    -- local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
    -- for _, ls in ipairs(language_servers) do
    --     require("lspconfig")[ls].setup({
    --         capabilities = capabilities,
    --         -- you can add other fields for setting up lsp server in this table
    --     })
    -- end
    -- require("ufo").setup()
end

-- folke/flash.nvim
M.keys_flash = {
    -- { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
}

-- s1n7ax/nvim-window-picker
M.config_nvim_window_picker = function()
    require("window-picker").setup()
end
M.opts_nvim_window_picker = {
    filter_rules = {
        include_current_win = true,
        bo = {
            filetype = { "fidget", "neo-tree-popup", "notify" }, -- "nvim-tree", "symbols-outline", "neo-tree",
        },
    },
}

-- mrjones2014/smart-splits.nvim
M.config_smart_splits = function()
    require("smart-splits").setup({
        ignored_filetypes = {
            "nofile",
            "quickfix",
            "prompt",
        },
        ignored_buftypes = {}, -- "NvimTree"
        default_amount = 2,
        at_edge = "wrap",
        move_cursor_same_row = false,
        -- whether the cursor should follow the buffer when swapping
        -- buffers by default; it can also be controlled by passing
        -- `{ move_cursor = true }` or `{ move_cursor = false }`
        -- when calling the Lua function.
        cursor_follows_swapped_bufs = false,
        resize_mode = {
            quit_key = "<ESC>",
            resize_keys = { "h", "j", "k", "l" },
            silent = false,
            hooks = {
                on_enter = nil,
                on_leave = nil,
            },
        },
        ignored_events = {
            "BufEnter",
            "WinEnter",
        },
        disable_multiplexer_nav_when_zoomed = true,
        kitty_password = nil,
        log_level = "info",
    })
end

-- sindrets/winshift.nvim
M.config_winshift = function()
    require("winshift").setup({
        highlight_moving_win = true, -- Highlight the window being moved
        focused_hl_group = "Visual", -- The highlight group used for the moving window
        moving_win_options = {
            -- These are local options applied to the moving window while it's
            -- being moved. They are unset when you leave Win-Move mode.
            wrap = false,
            cursorline = false,
            cursorcolumn = false,
            colorcolumn = "",
        },
        keymaps = {
            disable_defaults = false, -- Disable the default keymaps
            win_move_mode = {
                ["h"] = "left",
                ["j"] = "down",
                ["k"] = "up",
                ["l"] = "right",
                ["H"] = "far_left",
                ["J"] = "far_down",
                ["K"] = "far_up",
                ["L"] = "far_right",
                ["<left>"] = "left",
                ["<down>"] = "down",
                ["<up>"] = "up",
                ["<right>"] = "right",
                ["<S-left>"] = "far_left",
                ["<S-down>"] = "far_down",
                ["<S-up>"] = "far_up",
                ["<S-right>"] = "far_right",
            },
        },
        ---A function that should prompt the user to select a window.
        ---The window picker is used to select a window while swapping windows with
        ---`:WinShift swap`.
        ---@return integer? winid # Either the selected window ID, or `nil` to
        ---   indicate that the user cancelled / gave an invalid selection.
        window_picker = function()
            return require("winshift.lib").pick_window({
                -- A string of chars used as identifiers by the window picker.
                picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                filter_rules = {
                    -- This table allows you to indicate to the window picker that a window
                    -- should be ignored if its buffer matches any of the following criteria.
                    cur_win = true, -- Filter out the current window
                    floats = true, -- Filter out floating windows
                    filetype = {}, -- List of ignored file types
                    buftype = {}, -- List of ignored buftypes
                    bufname = {}, -- List of vim regex patterns matching ignored buffer names
                },
                ---A function used to filter the list of selectable windows.
                ---@param winids integer[] # The list of selectable window IDs.
                ---@return integer[] filtered # The filtered list of window IDs.
                filter_func = nil,
            })
        end,
    })
end

-- anuvyklack/windows.nvim
M.config_windows = function()
    vim.o.winwidth = 5
    vim.o.winminwidth = 5
    vim.o.equalalways = false
    require("windows").setup()
    vim.cmd("WindowsDisableAutowidth")
end

-- toppair/peek.nvim
M.config_glow = function()
    require("glow").setup({
        border = "shadow", -- floating window border config
        style = "dark", -- light filled automatically with your current editor background, you can override using glow json style
        pager = false,
        width = 80,
        height = 100,
        width_ratio = 0.7, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
        height_ratio = 0.7,
    })
end

return M
