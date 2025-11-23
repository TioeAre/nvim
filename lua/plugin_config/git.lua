local M = {}

-- sindrets/diffview.nvim
M.config_diffview = function()
    require("diffview").setup({
        enhanced_diff_hl = true,
        hooks = {
            diff_buf_read = function(bufnr)
                vim.opt_local.foldlevel = 99
                vim.opt_local.foldenable = false
            end,
            diff_buf_win_enter = function(bufnr)
                vim.opt_local.foldlevel = 99
                vim.opt_local.foldenable = false
            end,
        }
    })
end

-- lewis6991/gitsigns.nvim
M.config_gitsigns = function()
    require("gitsigns").setup({
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
            virt_text_priority = 2,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 2,
        update_debounce = 100,
        status_formatter = nil,  -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
    })
end

return M
