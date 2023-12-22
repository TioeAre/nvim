local keymap = vim.keymap

local config_telescope = function()
    local telescope = require('telescope')
    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ['<C-j>'] = 'move_selection_next',
                    ['<C-k>'] = 'move_selection_previous'
                }
            }
        },
        pickers = {
            find_files = {
                theme = 'dropdown',
                previewer = false
                -- hidden = true
            },
            live_grep = {
                theme = 'dropdown',
                previewer = false
            },
            find_buffers = {
                theme = 'dropdown',
                previewer = false
            }
        },
        extensions = {
            -- NOTE: this setup is optional
            docker = {
                -- These are the default values
                theme = "ivy",
                binary = "docker", -- in case you want to use podman or something
                compose_binary = "docker compose",
                buildx_binary = "docker buildx",
                machine_binary = "docker-machine",
                log_level = vim.log.levels.INFO,
                init_term = "tabnew" -- "vsplit new", "split new", ...
                -- NOTE: init_term may also be a function that receives
                -- a command, a table of env. variables and cwd as input.
                -- This is intended only for advanced use, in case you want
                -- to send the env. and command to a tmux terminal or floaterm
                -- or something other than a built in terminal.
            },
            undo = {
                -- telescope-undo.nvim config, see below
            }
        }
    })

    -- require("telescope").load_extension("scope")
    require("telescope").load_extension("undo")
    require("telescope").load_extension("emoji")
    require('telescope').load_extension('projects')
    require('telescope').load_extension('repo')
    require('telescope').load_extension('ros')
    require("telescope").load_extension("docker")
    -- require("telescope").extensions.docker.containers({
    --     env = {
    --         DOCKER_HOST = "ssh://...."
    --     }
    -- })
end

local key_telescope = {
{
    "<leader>ff",
    ":Telescope find_files<cr>",
    desc = "find files"
}, {
    "<leader>fs",
    ":Telescope grep_string<cr>",
    desc = "grep string"
}, {
    "<leader>fg",
    ":Telescope live_grep<cr>",
    desc = "live grep string"
}, {
    "<leader>fr",
    ":Telescope resume<cr>",
    desc = "resume last search window"
}}

local config_scope = function()
    vim.opt.sessionoptions = {"buffers", "tabpages", "globals"} -- required
    require("scope").setup({
        hooks = {
            pre_tab_enter = function()
                -- Your custom logic to run before entering a tab
            end
        }
    })
end

-------------------------------------------------------------------------------
return {{
    'nvim-telescope/telescope.nvim', -- find files or strings
    -- lazy = false,
    -- tag = '0.1.4',
    dependencies = {'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter', 'cljoly/telescope-repo.nvim',
                    "xiyaowong/telescope-emoji.nvim", "bi0ha2ard/telescope-ros.nvim", "lpoto/telescope-docker.nvim",
                    "debugloop/telescope-undo.nvim"},
    cmd = "Telescope",
    config = config_telescope,
    defaults = {
        file_ignore_patterns = {'node_modules', '.git'}
    },
    keys = key_telescope
} -- {
--     "tiagovla/scope.nvim",   -- 选项卡
--     config = config_scope
-- }
}
