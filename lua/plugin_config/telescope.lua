local M = {}

-- nvim-telescope/telescope.nvim
M.config_telescope = function()
    local telescope = require("telescope")
    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ["<C-j>"] = "move_selection_next",
                    ["<C-k>"] = "move_selection_previous",
                },
            },
        },
        pickers = {
            find_files = {
                -- theme = 'dropdown',
                -- previewer = false
                -- hidden = true
            },
            live_grep = {
                -- theme = 'dropdown',
                -- previewer = false
            },
            find_buffers = {
                -- theme = 'dropdown',
                -- previewer = false
            },
        },
        extensions = {
            docker = {
                -- These are the default values
                theme = "ivy",
                binary = "docker", -- in case you want to use podman or something
                compose_binary = "docker compose",
                buildx_binary = "docker buildx",
                machine_binary = "docker-machine",
                log_level = vim.log.levels.INFO,
                init_term = "tabnew", -- "vsplit new", "split new", ...
                -- a command, a table of env. variables and cwd as input.
                -- This is intended only for advanced use, in case you want
                -- to send the env. and command to a tmux terminal or floaterm
                -- or something other than a built in terminal.
            },
            undo = {
                -- telescope-undo.nvim config, see below
            },
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
        },
    })

    -- require("telescope").load_extension("scope")
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("undo")
    require("telescope").load_extension("emoji")
    require("telescope").load_extension("projects")
    require("telescope").load_extension("repo")
    require("telescope").load_extension("ros")
    require("telescope").load_extension("docker")
    require("telescope").load_extension("dap")

    -- require("telescope").extensions.docker.containers({
    --     env = {
    --         DOCKER_HOST = "ssh://...."
    --     }
    -- })
end
M.key_telescope = {
    -- {
    --     "<leader>ff",
    --     ":Telescope find_files<cr>",
    --     desc = "find files"
    -- }, {
    --     "<leader>fs",
    --     ":Telescope grep_string<cr>",
    --     desc = "grep string"
    -- }, {
    --     "<leader>fg",
    --     ":Telescope live_grep<cr>",
    --     desc = "live grep string"
    -- }, {
    --     "<leader>fr",
    --     ":Telescope resume<cr>",
    --     desc = "resume last search window"
    -- }
}

-- tiagovla/scope.nvim
M.config_scope = function()
    vim.opt.sessionoptions = { "buffers", "tabpages", "globals" } -- required
    require("scope").setup({
        hooks = {
            pre_tab_enter = function()
                -- Your custom logic to run before entering a tab
            end,
        },
    })
end

return M
