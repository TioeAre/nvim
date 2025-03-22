local M = {}

-- folke/snacks.nvim
M.opt_snacks = {
    bigfile = {                  -- create `bigfile` filetype
        notify = true,
        size = 10 * 1024 * 1024, -- 10 MB
        line_length = 100000,    -- average line length (useful for minified files)
    },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    image = { -- Snacks.image.hover(), Show the image at the cursor in a floating window
        doc = {
            enabled = true,
            inline = true,
            float = true,
            max_width = 80,
            max_height = 40,
        },
        img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments", ".assets" },
    },
    indent = {
        indent = {
            priority = 1,
            enabled = true,
            char = "▏", -- ⡇, ⡆, ⠇, ▎, ▏, │
            only_scope = false,
            only_current = false,
            hl = "SnacksIndent",
            -- hl = {
            --     "SnacksIndent1",
            --     "SnacksIndent2",
            --     "SnacksIndent3",
            --     "SnacksIndent4",
            --     "SnacksIndent5",
            --     "SnacksIndent6",
            --     "SnacksIndent7",
            --     "SnacksIndent8",
            -- },
        },
        -- style "out"|"up_down"|"down"|"up"
        animate = {
            style = "out",
            easing = "linear",
            duration = {
                step = 10,   -- ms per step
                total = 200, -- maximum duration
            },
        },
        scope = {
            enabled = true, -- enable highlighting the current scope
            priority = 200,
            char = "▎", -- ▎,╎
            underline = true, -- underline the start of the scope
            only_current = false, -- only show scope in the current window
            hl = "SnacksIndentScope",
        },
        chunk = {
            -- when enabled, scopes will be rendered as chunks, except for the
            -- top-level scope which will be rendered as a scope.
            enabled = false,
            -- only show chunk scopes in the current window
            only_current = false,
            priority = 200,
            hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
            char = {
                -- corner_top = "┌",
                -- corner_bottom = "└",
                corner_top = "╭",
                corner_bottom = "╰",
                horizontal = "─",
                vertical = "│",
                arrow = ">",
            },
        },
        -- filter for buffers to enable indent guides
        filter = function(buf)
            return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
        end,
    },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    picker = { -- Snacks.picker(), Snacks.picker.pick({source = "files", ...})
        -- layout = {
        --     cycle = true,
        --     preset = "vscode",
        --     layout = {
        --         position = "right",
        --     }
        -- },
        matcher = {
            fuzzy = true,          -- use fuzzy matching
            smartcase = true,      -- use smartcase
            ignorecase = true,     -- use ignorecase
            sort_empty = false,    -- sort results when the search string is empty
            filename_bonus = true, -- give bonus for matching file names (last part of the path)
            file_pos = true,       -- support patterns like `file:line:col` and `file:line`
            -- the bonusses below, possibly require string concatenation and path normalization,
            -- so this can have a performance impact for large lists and increase memory usage
            cwd_bonus = false,     -- give bonus for matching files in the cwd
            frecency = false,      -- frecency bonus
            history_bonus = false, -- give more weight to chronological order
        },
    },
    profiler = { enable = false }, -- only can be used to profile `autocmd`
    quickfile = { exclude = {}, },
    rename = { enabled = false },
    scope = { enabled = true },
    scratch = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    terminal = { enabled = true },
    words = { enabled = true },
}
M.keys_snacks = {
}

M.init_snacks = function()
end

return M
