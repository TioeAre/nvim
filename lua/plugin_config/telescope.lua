local M = {}

-- nvim-telescope/telescope.nvim
M.config_telescope = function()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local function select_window_split(prompt_bufnr, split_type)
        local entry = action_state.get_selected_entry()
        local filename_with_position = entry.value
        local filename, lnum, col = filename_with_position:match("([^:]+):?(%d*):?(%d*):?.*")
        if filename and vim.fn.filereadable(filename) == 1 then
            lnum = tonumber(lnum) or 1
            col = tonumber(col) or 0
            actions.close(prompt_bufnr)
            local picked_window_id = require("window-picker").pick_window()
            if picked_window_id then
                vim.api.nvim_set_current_win(picked_window_id)
                local cmd = split_type == "vsplit" and "vsplit" or "split"
                vim.cmd(cmd)
                vim.cmd("edit " .. filename)
                if lnum and col then
                    vim.api.nvim_win_set_cursor(0, { lnum, col })
                end
            end
        end
    end

    local function select_window(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        local filename_with_position = entry.value
        local filename, lnum, col = filename_with_position:match("([^:]+):?(%d*):?(%d*):?.*")
        if filename and vim.fn.filereadable(filename) == 1 then
            lnum = tonumber(lnum) or 1
            col = tonumber(col) or 0
            actions.close(prompt_bufnr)
            local picked_window_id = require("window-picker").pick_window()
            if picked_window_id then
                local bufnr = vim.fn.bufadd(filename)
                vim.api.nvim_win_set_buf(picked_window_id, bufnr)
                if lnum and col then
                    vim.api.nvim_win_set_cursor(0, { lnum, col })
                end
            end
        end
    end

    local telescope = require("telescope")
    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ["<C-j>"] = "move_selection_next",
                    ["<C-k>"] = "move_selection_previous",
                    ["<cr>"] = "select_default",
                    ["<c-o>"] = select_window,
                    ["<C-x>"] = function(prompt_bufnr)
                        select_window_split(prompt_bufnr, "split")
                    end,
                    ["<C-v>"] = function(prompt_bufnr)
                        select_window_split(prompt_bufnr, "vsplit")
                    end,
                },
                n = {
                    ["<cr>"] = "select_default",
                    ["o"] = select_window,
                    ["<c-o>"] = select_window,
                    ["<C-x>"] = function(prompt_bufnr)
                        select_window_split(prompt_bufnr, "split")
                    end,
                    ["<C-v>"] = function(prompt_bufnr)
                        select_window_split(prompt_bufnr, "vsplit")
                    end,
                },
            },
            file_ignore_patterns = {
                "^.git/",
                -- ".git/",
                "^scratch/",
                -- "%.npz",
                "^.history/",
                "^.cache/",
                "^.idea/",
                "^build/",
                "^devel/",
                "^cmake-build-debug/",
                "**/cmake-build-debug/**",
                "^cmake-build-release/",
                "**/cmake-build-release/**",
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
            colorscheme = {
                enable_preview = true,
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
                mappings = {
                    i = {
                        ["<cr>"] = require("telescope-undo.actions").yank_additions,
                        ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                        ["<C-cr>"] = require("telescope-undo.actions").restore,
                        -- alternative defaults, for users whose terminals do questionable things with modified <cr>
                        ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
                        ["<C-r>"] = require("telescope-undo.actions").restore,
                    },
                    n = {
                        ["y"] = require("telescope-undo.actions").yank_additions,
                        ["Y"] = require("telescope-undo.actions").yank_deletions,
                        ["u"] = require("telescope-undo.actions").restore,
                    },
                },
            },
            fzf = {
                fuzzy = true,                   -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true,    -- override the file sorter
                case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
            persisted = {
                -- olimorris/persisted.nvim
                layout_config = { width = 0.55, height = 0.55 },
            },
            -- stevearc/aerial.nvim
            -- aerial = {
            --     -- Display symbols as <root>.<parent>.<symbol>
            --     show_nesting = {
            --         ["_"] = false, -- This key will be the default
            --         json = true, -- You can set the option for specific filetypes
            --         yaml = true,
            --     },
            -- },
        },
    })

    -- require("telescope").load_extension("scope")
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("undo")
    require("telescope").load_extension("emoji")
    -- require("telescope").load_extension("repo")
    require("telescope").load_extension("ros")
    require("telescope").load_extension("docker")
    require("telescope").load_extension("diff")
    require("telescope").load_extension("persisted")
    -- require("telescope").load_extension("lazygit")
    -- require("telescope").extensions.docker.containers({
    --     env = {
    --         DOCKER_HOST = "ssh://...."
    --     }
    -- })
end

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
