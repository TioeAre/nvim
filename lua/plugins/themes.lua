local config_lualine = function()
    require("lualine").setup({
        options = {
            theme = "modus-vivendi",
            globalstatus = true,
            component_separators = {
                left = ">",
                right = "<"
            },
            section_separators = {
                left = "",
                right = ""
            }
        },
        sections = {
            lualine_a = {"mode"},
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {"buffers"},

            lualine_x = {"encoding", "fileformat", "filetype", "filesize"},
            lualine_y = {"progress"},
            lualine_z = {"location"}
        },
        tabline = {}
    })
end

local config_bufferline = function()
    require("bufferline").setup({
        options = {
            color_icons = true,
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_tab_indicators = false,
            show_duplicate_prefix = true,
            always_show_bufferline = true,
            hover = {
                enabled = true,
                delay = 200,
                reveal = {'close'}
            },
            numbers = function(opts)
                return string.format('%s|%s', opts.id, opts.raise(opts.ordinal))
            end,
            groups = {
                items = {
                    require('bufferline.groups').builtin.pinned:with({ icon = "" })
                }
            },
            offsets = {
                {
                    filetype = "NvimTree",
                    text = function()
                        return vim.fn.getcwd()
                    end,
                    highlight = "Directory",
                    separator = true -- use a "true" to enable the default, or set your own character
                }
            }
        }
    })
    vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {}, vim.tbl_map(function(v)
        return v.hl_group
    end, vim.tbl_values(require('bufferline.config').highlights)))
end

local keys_bufferline = {
    {
        "<leader>bn",
        ":BufferLineCycleNext<cr>", -- 切换到下一个buffer
        desc = "change to next buffer"
    }, {
        "<leader>bm",
        ":BufferLineCyclePrev<cr>",   -- 切换到上一个buffer
        desc = "change to preview buffer"
    },
    {
        "<leader>bcr",
        ":BufferLineCloseRight<cr>",
        desc = "close right buffers"
    }, {
        "<leader>bcf",
        ":BufferLineCloseLeft<cr>",
        desc = "close left buffers"
    }, {
        "<leader>bco",
        ":BufferLineCloseOthers<cr>",
        desc = "close other buffers"
    },
    {
        "<leader>bg",
        ":BufferLinePick<cr>",
        desc = "go to certain buffer"
    },
    {
        "<leader>bD",
        ":BufferLinePickClose<cr>",
        desc = "close certain buffer"
    }
}


-------------------------------------------------------------------------------
return {{
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 999,
    config = function()
        vim.cmd('colorscheme nightfox')
    end
}, {
    "nvim-lualine/lualine.nvim", -- 底部状态栏
    lazy = false,
    config = config_lualine
}, {
    'akinsho/bufferline.nvim', -- tab栏状态
    lazy = false,
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = config_bufferline,
    keys = keys_bufferline,
}}
