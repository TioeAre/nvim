local M = {}
local W = require("utils.windows_ignore")

-- Civitasv/cmake-tools.nvim
M.config_cmake_tools = function()
	local function has_cmake_files()
		local current_dir = vim.fn.getcwd()
		local has_cmake_file = vim.fn.findfile("CMakeLists.txt", current_dir) ~= ""
		local has_cmakelists_file = vim.fn.findfile("cmakelists.txt", current_dir) ~= ""
		return has_cmake_file or has_cmakelists_file
	end
	local scratch = {
		name = "*cmake-tools*",
		buffer = nil,
	}
	require("cmake-tools.scratch").create = function(executor, runner)
		if has_cmake_files() then
			scratch.buffer = vim.api.nvim_create_buf(true, true) -- can be search, and is a scratch buffer
			vim.api.nvim_buf_set_name(scratch.buffer, scratch.name)
			vim.api.nvim_buf_set_lines(scratch.buffer, 0, 0, false, {
				"THIS IS A SCRATCH BUFFER FOR cmake-tools.nvim, YOU CAN SEE WHICH COMMAND THIS PLUGIN EXECUTES HERE.",
				"EXECUTOR: " .. executor .. " RUNNER: " .. runner,
			})
		end
	end
	require("cmake-tools.scratch").append = function(cmd)
		if has_cmake_files() then
			vim.api.nvim_buf_set_lines(scratch.buffer, -1, -1, false, { cmd })
		end
	end

	require("cmake-tools").setup({
		cmake_command = "cmake",                                    -- this is used to specify cmake command path
		ctest_command = "ctest",                                    -- this is used to specify ctest command path
		cmake_regenerate_on_save = true,                            -- auto generate when save CMakeLists.txt
		cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- this will be passed when invoke `CMakeGenerate`
		cmake_build_options = { "-j10" },                           -- this will be passed when invoke `CMakeBuild`
		-- support macro expansion:
		--       ${kit}
		--       ${kitGenerator}
		--       ${variant:xx}
		cmake_build_directory = "build",                                                                             -- /${variant:buildTypffe}",
		-- this is used to specify generate directory for cmake, allows macro expansion, relative to vim.loop.cwd()
		cmake_soft_link_compile_commands = false,                                                                    -- this will automatically make a soft link from compile commands file to project root dir
		cmake_compile_commands_from_lsp = false,                                                                     -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
		cmake_kits_path = W.windows_selectNO2home("/.config/nvim/config/CMakeKits.json", "\\nvim\\config\\CMakeKits.json"), -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
		cmake_variants_message = {
			short = { show = true },                                                                                 -- whether to show short message
			long = { show = true, max_length = 0 },                                                                  -- whether to show long message
		},
		cmake_dap_configuration = {                                                                                  -- debug settings for cmake
			name = "cpp",
			type = "codelldb",
			request = "launch",
			stopOnEntry = false,
			runInTerminal = true,
			console = "integratedTerminal",
		},
		cmake_executor = {           -- executor to use
			name = "quickfix",       -- name of the executor
			opts = {},               -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
			default_opts = {         -- a list of default and possible values for executors
				quickfix = {
					show = "only_on_error", -- "always", "only_on_error"
					position = "belowright", -- "vertical", "horizontal", "leftabove", "aboveleft", "rightbelow", "belowright", "topleft", "botright", use `:h vertical` for example to see help on them
					size = 10,
					encoding = "utf-8", -- if encoding is not "utf-8", it will be converted to "utf-8" using `vim.fn.iconv`
					auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
				},
				overseer = {
					new_task_opts = {
						strategy = {
							"toggleterm",
							direction = "horizontal",
							autos_croll = true,
							quit_on_exit = "success",
						},
					}, -- options to pass into the `overseer.new_task` command
					on_new_task = function(task)
						require("overseer").open({ enter = false, direction = "right" })
					end, -- a function that gets overseer.Task when it is created, before calling `task:start`
				},
				terminal = {
					name = "Main Terminal",
					prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
					split_direction = "horizontal", -- "horizontal", "vertical"
					split_size = 11,

					-- Window handling
					single_terminal_per_instance = true, -- Single viewport, multiple windows
					single_terminal_per_tab = true, -- Single viewport per tab
					keep_terminal_static_location = true, -- Static location of the viewport if avialable

					-- Running Tasks
					start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
					focus = false, -- Focus on terminal when cmake task is launched.
					do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
				},               -- terminal executor uses the values in cmake_terminal
			},
		},
		cmake_runner = {      -- runner to use
			name = "terminal", -- name of the runner
			opts = {},        -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
			default_opts = {  -- a list of default and possible values for runners
				quickfix = {
					show = "always", -- "always", "only_on_error"
					position = "belowright", -- "bottom", "top"
					size = 10,
					encoding = "utf-8",
					auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
				},
				overseer = {
					new_task_opts = {
						strategy = {
							"toggleterm",
							direction = "horizontal",
							autos_croll = true,
							quit_on_exit = false, -- "success",
						},
					},                 -- options to pass into the `overseer.new_task` command
					on_new_task = function(task) end, -- a function that gets overseer.Task when it is created, before calling `task:start`
				},
				terminal = {
					name = "Main Terminal",
					prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
					split_direction = "horizontal", -- "horizontal", "vertical"
					split_size = 11,

					-- Window handling
					single_terminal_per_instance = true, -- Single viewport, multiple windows
					single_terminal_per_tab = true, -- Single viewport per tab
					keep_terminal_static_location = true, -- Static location of the viewport if avialable

					-- Running Tasks
					start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
					focus = false, -- Focus on terminal when cmake task is launched.
					do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
				},
			},
		},
		cmake_notifications = {
			runner = { enabled = true },
			executor = { enabled = true },
			spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
			refresh_rate_ms = 100, -- how often to iterate icons
		},
	})
	-- vim.cmd("CMakeSelectBuildType Debug")
	-- vim.api.nvim_exec(
	--     [[
	--         augroup AutoCMakeGenerate
	--             autocmd!
	--             autocmd BufWritePost CMakeLists.txt,cmakelists.txt CMakeGenerate
	--         augroup END
	--     ]],
	--     false
	-- )
end

-- michaelb/sniprun
M.config_sniprun = function()
	require("sniprun").setup({
		-- your options
	})
end

-- EthanJWright/vs-tasks.nvim
M.config_vs_task = function()
	require("vstask").setup({
		cache_json_conf = true, -- don't read the json conf every time a task is ran
		cache_strategy = "last", -- can be "most" or "last" (most used / last used)
		config_dir = ".vscode", -- directory to look for tasks.json and launch.json
		use_harpoon = false, -- true, -- use harpoon to auto cache terminals
		telescope_keys = { -- change the telescope bindings used to launch tasks
			vertical = "<C-v>",
			split = "<C-x>",
			tab = "<C-t>",
			current = "<CR>",
		},
		autodetect = { -- auto load scripts
			npm = "on",
		},
		terminal = "toggleterm",
		term_opts = {
			vertical = {
				direction = "vertical",
				size = "65",
			},
			horizontal = {
				direction = "horizontal",
				size = "12",
			},
			current = {
				direction = "float",
			},
			tab = {
				direction = "tab",
			},
		},
		-- json_parser = "vim.fn.json_decode",
		json_parser = require("json5").parse,
	})
	-- local harpoon = require("harpoon")
	-- REQUIRED
	-- harpoon:setup()
	-- REQUIRED
	-- nvim-telescope/telescope.nvim
	require("telescope").load_extension("vstask")
end

return M
