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
            block = "gbc",
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
        vim.api.nvim_set_hl(0, "RainbowRed", {
            fg = "#e5c2c5",
        })
        vim.api.nvim_set_hl(0, "RainbowYellow", {
            fg = "#deceb0",
        })
        vim.api.nvim_set_hl(0, "RainbowBlue", {
            fg = "#86acca",
        })
        vim.api.nvim_set_hl(0, "RainbowOrange", {
            fg = "#cab4a0",
        })
        vim.api.nvim_set_hl(0, "RainbowGreen", {
            fg = "#bacbaf",
        })
        vim.api.nvim_set_hl(0, "RainbowViolet", {
            fg = "#cbb0d4",
        })
        vim.api.nvim_set_hl(0, "RainbowCyan", {
            fg = "#a1c0c4",
        })
    end)
    vim.g.rainbow_delimiters = {
        highlight = highlight,
    }
    require("ibl").setup({
        indent = {
            char = "▏", -- ⡇, ⡆, ⠇, ▎, ▏, │
            highlight = highlight,
            smart_indent_cap = true,
        },
        scope = {
            char = "▎", -- ▎,╎
            highlight = highlight,
        },
    })
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

-- RRethy/vim-illuminate
M.config_vim_illuminate = function()
    require("illuminate").configure({
        -- providers: provider used to get references in the buffer, ordered by priority
        providers = {
            "lsp",
            "treesitter",
            "regex",
        },
        -- delay: delay in milliseconds
        delay = 100,
        -- filetype_overrides: filetype specific overrides.
        -- The keys are strings to represent the filetype while the values are tables that
        -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
        filetype_overrides = {},
        -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
        filetypes_denylist = {
            "dirbuf",
            "dirvish",
            "fugitive",
        },
        -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
        -- You must set filetypes_denylist = {} to override the defaults to allow filetypes_allowlist to take effect
        filetypes_allowlist = {},
        -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
        -- See `:help mode()` for possible values
        modes_denylist = {},
        -- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
        -- See `:help mode()` for possible values
        modes_allowlist = {},
        -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_denylist = {},
        -- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_allowlist = {},
        -- under_cursor: whether or not to illuminate under the cursor
        under_cursor = true,
        -- large_file_cutoff: number of lines at which to use large_file_config
        -- The `under_cursor` option is disabled when this cutoff is hit
        large_file_cutoff = nil,
        -- large_file_config: config to use for large files (based on large_file_cutoff).
        -- Supports the same keys passed to .configure
        -- If nil, vim-illuminate will be disabled for large files.
        large_file_overrides = nil,
        -- min_count_to_highlight: minimum number of matches required to perform highlighting
        min_count_to_highlight = 1,
        -- should_enable: a callback that overrides all other settings to
        -- enable/disable illumination. This will be called a lot so don't do
        -- anything expensive in it.
        should_enable = function(bufnr)
            return true
        end,
        -- case_insensitive_regex: sets regex case sensitivity
        case_insensitive_regex = false,
    })
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#4e306e" })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#58268c" })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#4e306e" })
end

-- ibhagwan/smartyank.nvim
M.config_smartyank = function()
    require("smartyank").setup({
        highlight = {
            enabled = true, -- highlight yanked text
            higroup = "IncSearch", -- highlight group of yanked text
            timeout = 1500, -- timeout for clearing the highlight
        },
        clipboard = {
            enabled = true,
        },
        tmux = {
            enabled = true,
            -- remove `-w` to disable copy to host client's clipboard
            cmd = { "tmux", "set-buffer", "-w" },
        },
        osc52 = {
            enabled = true,
            -- escseq = 'tmux',     -- use tmux escape sequence, only enable if
            -- you're using tmux and have issues (see #4)
            ssh_only = true, -- false to OSC52 yank also in local sessions
            silent = false, -- true to disable the "n chars copied" echo
            echo_hl = "Directory", -- highlight group of the OSC52 echo message
        },
        -- By default copy is only triggered by "intentional yanks" where the
        -- user initiated a `y` motion (e.g. `yy`, `yiw`, etc). Set to `false`
        -- if you wish to copy indiscriminately:
        validate_yank = false,
        -- For advanced customization set to a lua function returning a boolean
        -- for example, the default condition is:
        -- validate_yank = function() return vim.v.operator == "y" end,

        -- TMUX
        -- One (of the many) advantages of using tmux is the ability to view the yank history by using <prefix># (by default <C-a>#).
        -- Using fzf-lua tmux_buffers we can fuzzy find the tmux paste buffers and by pressing <CR> copy the current selection into the "unnamed" register for easy pasting with p or P (similar functionality to what is achieved using nvim-neoclip.lua):
    })
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
                -- local filename = vim.api.nvim_buf_get_name(opts.data.saved_buffer)
                strict.convert_tabs_to_spaces()
                strict.remove_trailing_whitespace()
                -- require("conform").format({
                -- 	lsp_fallback = true,
                -- 	async = false,
                -- 	timeout_ms = 500,
                -- })
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
    icons = true,
    mode = "workspace_diagnostics",
    group = true, -- group results by file
    padding = true, -- add an extra new line on top of the list
    cycle_results = true, -- cycle item list when reaching beginning or end of list
    multiline = true, -- render multi-line messages
    auto_preview = false, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_jump = { "lsp_references", "lsp_implementations", "lsp_definitions" },
    use_diagnostic_signs = true,
    action_keys = {
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = { "<cr>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
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
        toggle_fold = { "za", "zA", "<tab>" }, -- toggle fold of current file
        next = "j", -- next item
        previous = "<c-h>", -- previous item
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

-- olimorris/persisted.nvim
M.opts_persisted = {}
M.config_persisted = function()
    vim.o.sessionoptions = "buffers,curdir,folds,tabpages,winpos,winsize"
    require("persisted").setup({
        save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
        silent = false, -- silent nvim message when sourcing session file
        use_git_branch = true, -- create session files based on the branch of a git enabled repository
        default_branch = "main", -- the branch to load if a session file is not found for the current branch
        autosave = true, -- automatically save session files when exiting Neovim
        should_autosave = nil, -- function to determine if a session should be autosaved
        autoload = true, -- automatically load the session for the cwd on Neovim startup
        on_autoload_no_session = nil, -- function to run when `autoload = true` but there is no session to load
        follow_cwd = true, -- change session file name to match current working directory if it changes
        allowed_dirs = nil, -- table of dirs that the plugin will auto-save and auto-load from
        ignored_dirs = {
            os.getenv("HOME"),
            "/home/tioeare/",
            "/home/linuxbrew/",
            "/home/Systemback/",
        }, -- table of dirs that are ignored when auto-saving and auto-loading
        telescope = {
            reset_prompt = true, -- Reset the Telescope prompt after an action?
        },
    })
    -- vim.api.nvim_create_autocmd({ "User" }, {
    -- 	pattern = "PersistedLoadPost",
    -- 	group = "persisted",
    -- 	callback = function(session)
    -- 		print(session.data.dir_path)
    -- 		print(session.data.branch)
    -- 	end,
    -- })
end

-- gaborvecsei/memento.nvim
M.config_memento = function()
    -- require("memento").setup({})
    vim.g.memento_history = 35
    vim.g.memento_shorten_path = true
    vim.g.memento_window_width = 50
    vim.g.memento_window_height = 15
end

-- ethanholz/nvim-lastplace
M.config_lastplace = function()
    require("nvim-lastplace").setup({})
end

-- willothy/flatten.nvim
M.opts_flatten = {
    -- nest_if_no_args = true,
    -- window = {
    --     open = "alternate",
    -- },
}
M.config_flatten = function()
    require("flatten").setup({
        nest_if_no_args = true,
        window = {
            open = "alternate",
        },
    })
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
    on_create = function(t)
        local bufnr = t.bufnr
        vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { buffer = bufnr })
    end,
    -- shell = vim.uv.os_uname().sysname == "Windows_NT" and "pwsh" or "zsh",
    float_opts = {
        border = "rounded",
    },
    winbar = {
        enabled = true,
    },
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
M.opts_ufo = {}
M.config_ufo = function(_, opts)
    vim.o.foldcolumn = "1" -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    vim.opt.viewoptions:remove("curdir")
    vim.api.nvim_create_augroup("RememberFolds", { clear = true })
    vim.api.nvim_create_autocmd("BufWinLeave", {
        group = "RememberFolds",
        pattern = "*.*",
        command = "mkview",
    })
    vim.api.nvim_create_autocmd("BufWinEnter", {
        group = "RememberFolds",
        pattern = "*.*",
        command = "silent! loadview",
    })

    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
        relculright = true,
        segments = {
            -- {
            -- 	sign = { name = { "Dap*" }, auto = true },
            -- 	click = "v:lua.ScSa",
            -- },
            { text = { "%s" } }, -- click = "v:lua.ScSa" },
            -- {
            -- 	sign = { name = { "Diagnostic" }, auto = true },
            -- 	-- click = "v:lua.ScSa",
            -- },
            -- -- { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            -- {
            -- 	sign = { namespace = { "gitsign*" } },
            -- 	-- click = "v:lua.ScSa",
            -- },
            { text = { builtin.lnumfunc, "" } }, -- click = "v:lua.ScLa" },
            { text = { builtin.foldfunc, " " } }, -- click = "v:lua.ScFa" },
        },
    })

    local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local totalLines = vim.api.nvim_buf_line_count(0)
        local foldedLines = endLnum - lnum
        local suffix = (" 󰁂 %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
                table.insert(newVirtText, chunk)
            else
                chunkText = truncate(chunkText, targetWidth - curWidth)
                local hlGroup = chunk[2]
                table.insert(newVirtText, { chunkText, hlGroup })
                chunkWidth = vim.fn.strdisplaywidth(chunkText)
                -- str width returned from truncate() may less than 2nd argument, need padding
                if curWidth + chunkWidth < targetWidth then
                    suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                end
                break
            end
            curWidth = curWidth + chunkWidth
        end
        -- local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
        -- suffix = (" "):rep(rAlignAppndx) .. suffix
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
    end
    -- opts["fold_virt_text_handler"] = handler
    require("ufo").setup({
        fold_virt_text_handler = handler,
        -- INFO: Uncomment to use treeitter as fold provider, otherwise nvim lsp is used
        provider_selector = function(bufnr, filetype, buftype)
            return { "treesitter", "indent" }
        end,
        open_fold_hl_timeout = 150,
        close_fold_kinds_for_ft = { "imports", "comment" },
        preview = {
            win_config = {
                border = { "", "─", "", "", "", "─", "", "" },
                winhighlight = "Normal:Folded",
                winblend = 0,
            },
            mappings = {
                scrollU = "<C-u>",
                scrollD = "<C-d>",
                -- jumpTop = "[",
                -- jumpBot = "]",
            },
        },
    })

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
end

-- folke/flash.nvim
M.keys_flash = {
    {
        "s",
        mode = { "n", "x", "o" },
        function()
            require("flash").jump()
        end,
        desc = "Flash",
    },
    {
        "S",
        mode = { "n", "x", "o" },
        function()
            require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
    },
    {
        "r",
        mode = "o",
        function()
            require("flash").remote()
        end,
        desc = "Remote Flash",
    },
    {
        "R",
        mode = { "o", "x" },
        function()
            require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
    },
    {
        "<c-s>",
        mode = { "c" },
        function()
            require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
    },
}

-- s1n7ax/nvim-window-picker
M.config_nvim_window_picker = function()
    require("window-picker").setup({
        hint = "floating-big-letter",
        filter_rules = {
            include_current_win = true,
            -- filter_func = function(window_ids)
            --     local filtered_windows = {}
            --     for _, win_id in ipairs(window_ids) do
            --         local bufnr = vim.api.nvim_win_get_buf(win_id)
            --         if vim.api.nvim_buf_is_loaded(bufnr) then
            --             table.insert(filtered_windows, win_id)
            --         end
            --     end
            --     return filtered_windows
            -- end,
            bo = {
                filetype = {
                    "fidget",
                    "neo-tree-popup",
                    "notify",
                    "incline",
                    "scrollbar",
                }, -- "nvim-tree", "symbols-outline", "neo-tree",
                buftype = { "nofile" },
            },
        },
    })
end
M.opts_nvim_window_picker = {}

-- mrjones2014/smart-splits.nvim
M.config_smart_splits = function()
    require("smart-splits").setup({
        ignored_filetypes = { "nofile", "quickfix", "prompt" },
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
        ignored_events = { "BufEnter", "WinEnter" },
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
                ---param winids integer[] # The list of selectable window IDs.
                ---return integer[] filtered # The filtered list of window IDs.
                filter_func = nil,
            })
        end,
    })
end

-- anuvyklack/windows.nvim
M.config_windows = function()
    vim.o.winwidth = 10
    vim.o.winminwidth = 1
    vim.o.equalalways = false
    require("windows").setup({
        autowidth = { --		       |windows.autowidth|
            enable = true,
            -- winwidth = 10, --		        |windows.winwidth|
            filetype = { --	      |windows.autowidth.filetype|
                help = 2,
            },
        },
        ignore = { --			  |windows.ignore|
            buftype = { "quickfix" },
            filetype = {
                "NvimTree",
                "neo-tree",
                "undotree",
                "gundo",
                "symbols-outline",
                "lsp",
                "SymbolsOutline",
                "Outline",
                "outline",
                "aerial",
            },
        },
        animation = {
            enable = true,
            duration = 200,
            fps = 45,
            easing = "in_out_sine",
        },
    })
    -- vim.cmd("WindowsDisableAutowidth")
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

-- kylechui/nvim-surround
M.config_nvim_surround = function()
    --     Old text                    Command         New text
    -- --------------------------------------------------------------------------------
    --     surr*ound_words             ysiw)           (surround_words)
    --     *make strings               ys$"            "make strings"
    --     [delete ar*ound me!]        ds]             delete around me!
    --     remove <b>HTML t*ags</b>    dst             remove HTML tags
    --     'change quot*es'            cs'"            "change quotes"
    --     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
    --     delete(functi*on calls)     dsf             function calls
end

-- echasnovski/mini.surround
M.config_mini_surround = function()
    require("mini.surround").setup({
        -- Add custom surroundings to be used on top of builtin ones. For more
        -- information with examples, see `:h MiniSurround.config`.
        custom_surroundings = nil,
        -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
        highlight_duration = 500,
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
            add = "\\a", -- Add surrounding in Normal and Visual modes
            delete = "\\d", -- Delete surrounding
            find = "\\f", -- Find surrounding (to the right)
            find_left = "\\F", -- Find surrounding (to the left)
            highlight = "\\h", -- Highlight surrounding
            replace = "\\r", -- Replace surrounding
            update_n_lines = "\\n", -- Update `n_lines`
            suffix_last = "l", -- Suffix to search with "prev" method
            suffix_next = "n", -- Suffix to search with "next" method
        },
        -- Number of lines within which surrounding is searched
        n_lines = 200,
        -- Whether to respect selection type:
        -- - Place surroundings on separate lines in linewise mode.
        -- - Place surroundings on each line in blockwise mode.
        respect_selection_type = false,
        -- How to search for surrounding (first inside current line, then inside
        -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
        -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
        -- see `:h MiniSurround.config`.
        search_method = "cover",
        silent = false,
    })
end

-- andymass/vim-matchup
M.config_vim_matchup = function()
    vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    vim.g.matchup_matchparen_deferred = 1
    vim.g.matchup_matchparen_hi_surround_always = 1
    vim.g.matchup_matchparen_deferred_show_delay = 20
    vim.g.matchup_matchparen_deferred_hide_delay = 20
    vim.cmd([[
        hi MatchParen ctermfg=DarkRed guifg=yellow guibg=##2F2F4A cterm=underline gui=underline
        hi MatchWord ctermfg=DarkRed guifg=yellow guibg=##2F2F4A cterm=underline gui=underline
        hi MatchParenCur ctermfg=DarkRed guifg=yellow guibg=##2F2F4A cterm=underline gui=underline
        hi MatchWordCur ctermfg=DarkRed guifg=yellow guibg=##2F2F4A cterm=underline gui=underline
    ]])
    -- vim.g.matchup_matchparen_timeout = 6000000
    -- vim.g.matchup_matchparen_insert_timeout = 6000000
    -- vim.g.loaded_matchit = 1
end

-- LunarVim/bigfile.nvim
M.config_bigfile = function()
    require("bigfile").setup({
        filesize = 10, -- size of the file in MiB, the plugin round file sizes to the closest MiB
        pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
        features = { -- features to disable
            "indent_blankline",
            "illuminate",
            "lsp",
            "treesitter",
            "syntax",
            "matchparen",
            "vimopts",
            "filetype",
        },
    })
end

-- aserowy/tmux.nvim
M.config_tmux = function()
    require("tmux").setup({
        copy_sync = {
            enable = false,
            ignore_buffers = { empty = false },
            -- TMUX >= 3.2: all yanks (and deletes) will get redirected to system
            -- clipboard by tmux
            redirect_to_clipboard = false,
            -- offset controls where register sync starts
            -- e.g. offset 2 lets registers 0 and 1 untouched
            register_offset = 0,
            -- overwrites vim.g.clipboard to redirect * and + to the system
            -- clipboard using tmux. If you sync your system clipboard without tmux,
            -- disable this option!
            sync_clipboard = true,
            -- synchronizes registers *, +, unnamed, and 0 till 9 with tmux buffers.
            sync_registers = true,
            -- syncs deletes with tmux clipboard as well, it is adviced to
            -- do so. Nvim does not allow syncing registers 0 and 1 without
            -- overwriting the unnamed register. Thus, ddp would not be possible.
            sync_deletes = true,
            -- syncs the unnamed register with the first buffer entry from tmux.
            sync_unnamed = true,
        },
        navigation = {
            -- cycles to opposite pane while navigating into the border
            cycle_navigation = true,

            -- enables default keybindings (C-hjkl) for normal mode
            enable_default_keybindings = false,
            -- prevents unzoom tmux when navigating beyond vim border
            persist_zoom = false,
        },
        resize = {
            -- enables default keybindings (A-hjkl) for normal mode
            enable_default_keybindings = false,
            -- sets resize steps for x axis
            resize_step_x = 2,
            -- sets resize steps for y axis
            resize_step_y = 2,
        },
    })
end

-- knubie/vim-kitty-navigator
M.config_vim_kitty_navigator = function()
    vim.g.kitty_navigator_no_mappings = 1
    -- local term = vim.fn.getenv("TERM")
    -- if term == "xterm-256color" then
    -- 	require("hologram").setup({
    -- 		auto_display = true, -- WIP automatic markdown image display, may be prone to breaking
    -- 	})
    -- end
end

-- stevearc/stickybuf.nvim
M.opts_stickybuf = {}
M.config_stickybuf = function()
    require("stickybuf").setup()
end

-- nvim-pack/nvim-spectre
M.config_nvim_spectre = function()
    require("plugin_config.user_spectre")
end

return M
