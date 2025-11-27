local M = {}
local telescope_utils = require("utils.telescope")
local telescope_vars = require("variables.telescope")

-- nvim-telescope/telescope.nvim
M.config_telescope = function()
	require("telescope").setup({
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
					["<cr>"] = "select_default",
					["<c-o>"] = telescope_utils.select_window,
					["<C-x>"] = function(prompt_bufnr)
						telescope_utils.select_window_split(prompt_bufnr, "split")
					end,
					["<C-v>"] = function(prompt_bufnr)
						telescope_utils.select_window_split(prompt_bufnr, "vsplit")
					end,
				},
				n = {
					["<cr>"] = "select_default",
					["o"] = telescope_utils.select_window,
					["<c-o>"] = telescope_utils.select_window,
					["<C-x>"] = function(prompt_bufnr)
						telescope_utils.select_window_split(prompt_bufnr, "split")
					end,
					["<C-v>"] = function(prompt_bufnr)
						telescope_utils.select_window_split(prompt_bufnr, "vsplit")
					end,
				},
			},
			file_ignore_patterns = telescope_vars.file_ignore_patterns,
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
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
			persisted = {
				-- olimorris/persisted.nvim
				layout_config = { width = 0.55, height = 0.55 },
			},
		},
	})

	-- require("telescope").load_extension("scope")
	require("telescope").load_extension("fzf")
	require("telescope").load_extension("emoji")
	require("telescope").load_extension("ros")
	require("telescope").load_extension("docker")
	require("telescope").load_extension("diff")
	require("telescope").load_extension("persisted")
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
