local M = {}
local W = require("utils.windows_ignore")
local code_run_utils = require("utils.code_run")

-- Civitasv/cmake-tools.nvim
M.config_cmake_tools = function()
	require("cmake-tools.scratch").create = code_run_utils.scratch_create
	require("cmake-tools.scratch").append = code_run_utils.scratch_append

	require("cmake-tools").setup({
		cmake_regenerate_on_save = true, -- auto generate when save CMakeLists.txt
		cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- this will be passed when invoke `CMakeGenerate`
		cmake_build_options = { "-j10" }, -- this will be passed when invoke `CMakeBuild`
		cmake_kits_path = W.windows_selectNO2home(
			"/.config/nvim/config/CMakeKits.json",
			"\\nvim\\config\\CMakeKits.json"
		), -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
		cmake_executor = { -- executor to use
			default_opts = { -- a list of default and possible values for executors
				quickfix = {
					show = "only_on_error", -- "always", "only_on_error"
				},
			},
		},
		cmake_runner = { -- runner to use
			default_opts = { -- a list of default and possible values for runners
				overseer = {
					new_task_opts = {
						strategy = {
							quit_on_exit = false, -- "success",
						},
					}, -- options to pass into the `overseer.new_task` command
				},
			},
		},
	})
end

-- michaelb/sniprun
M.config_sniprun = function()
	require("sniprun").setup({})
end

-- EthanJWright/vs-tasks.nvim
M.config_vs_task = function()
	require("vstask").setup({
		telescope_keys = { -- change the telescope bindings used to launch tasks
			vertical = "<C-v>",
			split = "<C-x>",
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
		},
		-- json_parser = "vim.fn.json_decode",
		json_parser = require("json5").parse,
	})
	-- nvim-telescope/telescope.nvim
	require("telescope").load_extension("vstask")
end

return M
