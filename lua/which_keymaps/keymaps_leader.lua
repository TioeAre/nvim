local wk = require("which-key")

wk.add({
	{ -- <leader> b
		-- mfussenegger/nvim-dap
		{
			"<leader>ba",
			"<cmd>lua require('dap').set_breakpoint()<cr>",
			desc = "dap set breakpoint",
		},
		{
			"<leader>bb",
			"<cmd>lua require('dap').toggle_breakpoint()<cr>",
			desc = "dap toggle breakpoint",
		},
		{
			"<leader>bl",
			"<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
			desc = "dap set log point message",
		},
		{
			"<leader>bq",
			"<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>",
			desc = "dap clear all breakpoints",
		},
	},
	{ -- <leader> c
		-- neovim/nvim-lspconfig
		{
			"<leader>ca",
			desc = "available code actions",
		},
	},
	{ -- <leader> d
		{
			"<leader>da",
			desc = "lsp diagnostic_jump_prev",
		},
		{
			"<leader>dd",
			"<cmd> DapTerminate <cr>",
			desc = "dap terminate",
		},
		{
			"<leader>df",
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end,
			desc = "dap widgets frames",
		},
		{
			"<leader>dh",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "dap widgets hover",
			mode = { "n", "v" },
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "dap run last",
		},
		{
			"<leader>dp",
			function()
				require("dap.ui.widgets").preview()
			end,
			desc = "dap widgets preview",
			mode = { "n", "v" },
		},
		-- mfussenegger/nvim-dap
		{
			"<leader>dr",
			function()
				require("dap").repl.open()
			end,
			desc = "dap repl open",
		},
		{
			"<leader>ds",
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end,
			desc = "dap widgets scopes",
		},
		-- neovim/nvim-lspconfig
		{
			"<leader>dt",
			"<cmd>lua require('snacks').picker.diagnostics() <cr>",
			desc = "snacks diagnostics",
		},
		{
			"<leader>dw",
			desc = "lsp diagnostic_jump_next",
		},
	},
	{ -- <leader> f
		{
			"<leader>fc",
			"<cmd>lua require('snacks').picker.git_diff() <cr>",
			desc = "snacks diff current",
		},
		-- ussenegger/nvim-dap
		{
			"<leader>fd",
			function()
				require("telescope").extensions.dap.configurations({})
			end,
			desc = "telescope dap configurations",
		},
		{ -- NOTE
			"<leader>fh",
			-- function()
			--     local results = {}
			--     local search_pattern = vim.fn.getreg("/")
			--     if search_pattern ~= "" then
			--         for line_nr = 1, vim.api.nvim_buf_line_count(0) do
			--             local line = vim.api.nvim_buf_get_lines(0, line_nr - 1, line_nr, false)[1]
			--             if line:match(search_pattern) then
			--                 table.insert(results, line_nr .. ": " .. line)
			--             end
			--         end
			--         require("telescope.pickers")
			--             .new({}, {
			--                 prompt_title = "Search Results",
			--                 finder = require("telescope.finders").new_table({
			--                     results = results,
			--                 }),
			--                 sorter = require("telescope.sorters").get_generic_fuzzy_sorter(),
			--             })
			--             :find()
			--     end
			-- end,
			"<cmd>lua require('snacks').picker.highlights() <cr>",
			desc = "snacks find highlights",
		},
		{
			"<leader>fl",
			desc = "lsp find def+ref+imp",
		},
		-- jemag/telescope-diff.nvim
		{
			"<leader>fn",
			function()
				require("telescope").extensions.diff.diff_files({
					hidden = true,
				})
			end,
			desc = "telescope diff 2 files",
		},
		{ -- NOTE
			"<leader>fa",
			"<cmd>lua require('snacks').picker.grep_word() <cr>",
			desc = "snacks grep string",
		},
		-- folke/todo-comments.nvim
		{
			"<leader>ft",
			"<cmd>lua require('snacks').picker.todo_comments() <cr>",
			desc = "snacks find todo",
		},
	},
	{
		"<leader>gh",
		"<cmd> DiffviewFileHistory <cr>",
		desc = "diff file history",
	},
	{ -- <leader> l
		-- stevearc/conform.nvim
		{
			"<leader>lf",
			function()
				require("whitespace-nvim").trim()
				require("conform").format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				})
			end,
			desc = "format file or range",
			mode = { "n", "v" },
		},
		-- folke/trouble.nvim
		{
			"<leader>ll",
			"<cmd>Trouble loclist toggle focus=true<cr>",
			desc = "open trouble loclist",
		},
		-- whynothugo/lsp_lines.nvim
		{
			"<leader>lm",
			"<cmd>lua require('lsp_lines').toggle()<cr>",
			desc = "toggle lsp_lens",
		},
		{
			"<leader>lq",
			"<cmd>Trouble quickfix toggle focus=true<cr>",
			desc = "open trouble quickfix",
		},
		{
			"<leader>lr",
			"<cmd>Trouble lsp_references toggle focus=true<cr>",
			desc = "open trouble lsp_references",
		},
		{
			"<leader>ls",
			"<cmd>Trouble lsp_definitions toggle focus=true<cr>",
			desc = "open trouble lsp_definitions",
		},
	},
	{ -- <leader> o
		{
			"<leader>oi",
			desc = "PyrightOrganizeImports",
		},
		{
			"<leader>oo",
			"<cmd> Outline <cr>",
			desc = "open symbols outline",
		},
		{
			"<leader>osd",
			desc = "open treesitter document_symbols",
		},
		{
			"<leader>osg",
			desc = "find lsp workspace_symbols",
		},
		{
			"<leader>osi",
			desc = "incoming_calls",
		},
		{
			"<leader>osl",
			desc = "open lsp document_symbols",
		},
		{
			"<leader>oso",
			desc = "outgoing_calls",
		},
		{
			"<leader>ost",
			"<cmd> Calltree <cr>",
			desc = "calltrees",
		},
		{
			"<leader>osw",
			desc = "open treesitter workspace_symbols",
		},
	},
	{ -- <leader> p
		-- ahmedkhalf/project.nvim
		{
			"<leader>pa",
			"<cmd> lua require('project_nvim.project').add_project_manually() <cr>",
			desc = "project add",
		},
		{
			"<leader>pf",
			desc = "treesitter peek function start",
		},
		{
			"<leader>pF",
			desc = "treesitter peek class start",
		},
		-- ellisonleao/glow.nvim
		{
			"<leader>pm",
			"<cmd> Glow <cr>",
			desc = "markdown Glow preview",
		},
	},
	{ -- <leader> r
		{
			"<leader>rcb",
			"<cmd> CMakeBuild <cr>",
			desc = "cmake build",
		},
		{
			"<leader>rcc",
			"<cmd> CMakeGenerate <cr>",
			desc = "cmake ..",
		},
		{
			"<leader>rcr",
			"<cmd> CMakeRun <cr>",
			desc = "cmake run",
		},
		{
			"<leader>rcsa",
			"<cmd> CMakeSelectBuildTarget <cr>",
			desc = "cmake select build target",
		},
		{
			"<leader>rcsb",
			"<cmd> CMakeSelectBuildDir <cr>",
			desc = "cmake select dir build",
		},
		{
			"<leader>rcsc",
			"<cmd> CMakeSelectCwd <cr>",
			desc = "cmake select main CMakeLists.txt",
		},
		{
			"<leader>rcsk",
			"<cmd> CMakeSelectKit <cr>",
			desc = "cmake select kit",
		},
		{
			"<leader>rcsl",
			"<cmd> CMakeSelectLaunchTarget <cr>",
			desc = "cmake select launch target",
		},
		{
			"<leader>rcst",
			"<cmd> CMakeSelectBuildType <cr>",
			desc = "cmake select build type",
		},
		{
			"<leader>rg",
			"<cmd> lua require('ros-nvim.telescope.package').grep_package() <cr>",
			desc = "ros grep package",
		},
		{
			"<leader>rk",
			"<cmd> lua require('ros-nvim.build').catkin_make_pkg() <cr>",
			desc = "ros catkin_make_pkg",
		},

		{
			"<leader>rl",
			"<cmd> LspRestart <cr>",
			desc = "restart lsp service",
		},
		{
			"<leader>rm",
			"<cmd> lua require('ros-nvim.build').catkin_make() <cr>",
			desc = "ros catkin_make",
		},
		{
			"<leader>rn",
			desc = "lsp smart rename",
		},
		{
			"<leader>rpd",
			"<cmd> lua require('ros-nvim.telescope.pickers').srv_picker() <cr>",
			desc = "ros pick service definitions",
		},
		{
			"<leader>rpm",
			"<cmd> lua require('ros-nvim.telescope.pickers').msg_picker() <cr>",
			desc = "ros pick messages",
		},
		{
			"<leader>rpn",
			"<cmd> lua require('ros-nvim.telescope.pickers').node_picker() <cr>",
			desc = "ros pick nodes",
		},
		{
			"<leader>rpp",
			"<cmd> lua require('ros-nvim.telescope.pickers').param_picker() <cr>",
			desc = "ros pick params",
		},
		{
			"<leader>rps",
			"<cmd> lua require('ros-nvim.telescope.pickers').service_picker() <cr>",
			desc = "ros pick services",
		},
		{
			"<leader>rpt",
			"<cmd> lua require('ros-nvim.telescope.pickers').topic_picker() <cr>",
			desc = "ros pick topics",
		},
		-- thibthib18/ros-nvim
		{
			"<leader>rs",
			"<cmd> lua require('ros-nvim.telescope.package').search_package() <cr>",
			desc = "ros search package",
		},
		{
			"<leader>rt",
			"<cmd> lua require('ros-nvim.test').rostest() <cr>",
			desc = "ros exec test",
		},
		{
			"<leader>rv",
			group = "vscode task",
		},
		{
			"<leader>rvc",
			"<cmd> lua require('telescope').extensions.vstask.close() <cr>",
			desc = "vstask close runnning task",
		},
		{
			"<leader>rvh",
			"<cmd> lua require('telescope').extensions.vstask.history() <cr>",
			desc = "vstask search history tasks",
		},
		{
			"<leader>rvi",
			"<cmd> lua require('telescope').extensions.vstask.inputs() <cr>",
			desc = "vstask open input list",
		},
		{
			"<leader>rvt",
			"<cmd> lua require('telescope').extensions.vstask.tasks() <cr>",
			desc = "vstask open list",
		},
	},
	{ -- <leader> s
		{ -- NOTE
			-- MagicDuck/grug-far.nvim
			"<leader>sc",
			-- "<cmd>lua require('spectre').open_file_search({select_word=true})<cr>",
			"<cmd> lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>'), paths = vim.fn.expand('%') } }) <cr>",
			desc = "search word current file",
		},
		-- {
		-- 	"<leader>sl",
		-- 	"<cmd>lua require('spectre').resume_last_search()<cr>",
		-- 	desc = "search last",
		-- },
		-- nvim-pack/nvim-spectre
		{
			"<leader>so",
			-- "<cmd>lua require('spectre').toggle()<cr>",
			"<cmd> lua require('grug-far').open() <cr>",
			desc = "search open spectre",
		},
		{ -- NOTE
			"<leader>sw",
			-- "<cmd>lua require('spectre').open_visual({select_word=true})<cr>",
			-- "<cmd>lua require('snacks').picker.grep_word() <cr>",
			"<cmd> lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } }) <cr>",
			-- function()
			-- 	require("snacks").picker.grep_word({
			-- 		preset = "sidebar",
			-- 		layout = { position = "right" },
			-- 	})
			-- end,
			desc = "search current word",
		},
	},
	{ -- <leader> t
		-- nvim-treesitter/nvim-treesitter
		{
			"<leader>ta",
			desc = "treesitter incremental selection",
		},
		-- mfussenegger/nvim-lint
		{
			"<leader>tl",
			-- function()
			-- 	lint.try_lint()
			-- end,
			desc = "lint current file",
		},
		-- mbbill/undotree
		{
			"<leader>tu",
			"<cmd> UndotreeToggle <cr>",
			desc = "toggle undotree",
		},
	},
	{ -- <leader> v
		{ -- AckslD/swenv.nvim linux-cultist/venv-selector.nvim
			"<leader>vs",
			-- "<cmd> lua require('swenv.api').pick_venv() <cr>",
			"<cmd> VenvSelect <cr>",
			desc = "python venv select",
		},
		-- {
		-- 	"<leader>vc",
		-- 	"<cmd> lua require('swenv.api').auto_venv() <cr>",
		-- 	desc = "python venv auto select",
		-- },
	},
	{ -- <leader> w
		-- neovim/nvim-lspconfig
		{
			"<leader>wa",
			desc = "lsp workspace add folder",
		},
		{
			"<leader>wl",
			desc = "lsp workspace list folder",
		},
		{
			"<leader>wr",
			desc = "lsp workspace remove folder",
		},
	},
})

wk.add({
	mode = "v",
	{ -- <leader> s
		"<leader>sw",
		-- "<esc><cmd> lua require('spectre').open_visual() <cr>",
		"<cmd> lua require('grug-far').with_visual_selection() <cr>",
		desc = "search current word",
	},
})
