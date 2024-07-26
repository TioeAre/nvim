local wk = require("which-key")
local conform = require("conform")
local lint = require("lint")

wk.add({ -- echasnovski/mini.surround
	{
		"m",
		desc = "mini.surround",
	}, -- folke/trouble.nvim
	{
		"q",
		desc = "close trouble list",
	},
	{
		"<esc>",
		desc = "cancel trouble preview",
	},
	{
		"o",
		desc = "jump and close trouble/dap open ui breakpoint",
	},
	{
		"P",
		desc = "toggle auto preview trouble",
	},
	{
		"?",
		desc = "help trouble",
	},
	{
		"j",
		desc = "jump next trouble item",
	},
	{
		"k",
		desc = "previous trouble item",
	},
	{
		"K",
		desc = "hover trouble/lsp show documentation",
	},
	{
		"c",
		desc = "open code href trouble",
	},
	{
		"z",
		group = "toggle fold",
	},
	{
		"za",
		desc = "toggle fold of current trouble file",
	},
	{
		"zA",
		desc = "toggle fold of current trouble file",
	}, -- kevinhwang91/nvim-ufo
	{
		"zo",
		"<cmd>lua require('ufo').openFoldsExceptKinds()<cr>",
		desc = "ufo/trouble open fold",
	},
	{
		"zc",
		"<cmd>lua require('ufo').closeFoldsWith()<cr>",
		desc = "ufo/trouble close fold",
	},
	{
		"zO",
		"<cmd>lua require('ufo').openAllFolds()<cr>",
		desc = "ufo/trouble open all folds",
	},
	{
		"zC",
		"<cmd>lua require('ufo').closeAllFolds()<cr>",
		desc = "ufo/trouble close all folds",
	}, -- folke/flash.nvim
	{
		"s",
		function()
			require("flash").jump()
		end,
		desc = "flash",
		mode = { "n", "x", "o" },
	},
	{
		"S",
		function()
			require("flash").treesitter()
		end,
		desc = "flash treesitter",
		mode = { "n", "x", "o" },
	},
	{
		"r",
		function()
			require("flash").remote()
		end,
		desc = "remote flash",
		mode = { "o" },
	},
	{
		"R",
		function()
			require("flash").treesitter_search()
		end,
		desc = "treesitter search",
		mode = { "x", "o" },
	}, -- neovim/nvim-lspconfig
	{
		"g",
		group = "goto lsp ...",
	},
	{
		"gD",
		desc = "goto declaration",
	},
	{
		"gd",
		desc = "goto definition",
	},
	{
		"gi",
		desc = "goto implementation",
	},
	{
		"gr",
		desc = "goto references",
	}, -- max397574/colortils.nvim
	{
		"l",
		desc = "color increment values",
	},
	{
		"h",
		desc = "color decrement values",
	},
	{
		"L",
		desc = "color increment bigger",
	},
	{
		"H",
		desc = "color decrement bigger",
	},
	{
		"g<cr>",
		desc = "replace color with format",
	},
	{
		"m<cr>",
		desc = "replace color with default format",
	},
	{
		"E",
		desc = "color export",
	},
	{
		"B",
		desc = "color choose background",
	}, -- rcarriga/nvim-dap-ui
	{
		"e",
		desc = "edit dap ui breakpoint",
	},
	{
		"d",
		desc = "delete dap ui breakpoint",
	},
	{
		"t",
		desc = "toggle dap ui breakpoint",
	},
    {
        "zg",
        desc = "add word to ignore-spellcheck",
    },
    {
        "zG",
        desc = "add word to temp ignore-spellcheck",
    },
    {
        "zw",
        desc = "remove word from ignore-spellcheck",
    },
    {
        "zW",
        desc = "remove word from temp ignore-spellcheck",
    },
})

-- plugin keymap
-- leader
wk.add({
	{
		"<leader>s",
		group = "search",
		mode = "v",
	},
	{
		"<leader>sw",
		"<esc><cmd> lua require('spectre').open_visual() <cr>",
		desc = "search current word",
		mode = "v",
	},
})
wk.add({
	{
		"<leader>s",
		group = "split/search|replace/sessions/switch trouble filter",
		mode = "n",
	},
	{
		mode = "n",
		{
			"<leader>sv",
			"<C-w>v",
			desc = "split windows v (trouble)",
		},
		{
			"<leader>sh",
			"<C-w>s",
			desc = "split windows h (trouble)",
		},
		-- olimorris/persisted.nvim
		{
			"<leader>sq",
			"<cmd>SessionStop<cr>",
			desc = "stop session",
		},
		{
			"<leader>sp",
			"<cmd>SessionSave<cr>",
			desc = "save session",
		},
		{
			"<leader>sd",
			"<cmd>SessionDelete<cr>",
			desc = "delete session",
		},
		-- folke/trouble.nvim
		{
			"<leader>ss",
			desc = "switch trouble severity filter",
		},
		-- nvim-pack/nvim-spectre
		{
			"<leader>so",
			"<cmd>lua require('spectre').toggle()<cr>",
			desc = "search open spectre",
		},
		{
			"<leader>sw",
			"<cmd>lua require('spectre').open_visual({select_word=true})<cr>",
			desc = "search current word",
		},
		{
			"<leader>sc",
			"<cmd>lua require('spectre').open_file_search({select_word=true})<cr>",
			desc = "search word current file",
		},
		{
			"<leader>sl",
			"<cmd>lua require('spectre').resume_last_search()<cr>",
			desc = "search last",
		},
	},
	{
		"<leader>n",
		group = "no highlight",
		mode = "n",
	},
	{
		mode = "n",
		{
			"<leader>nh",
			"<cmd> nohl <cr>",
			desc = "no highlight",
		},
	},
	{
		"<leader>w",
		group = "save|quit/lsp worksapce",
		mode = "n",
	},
	{
		mode = "n",
		{
			"<leader>wq",
			"<cmd>x<cr>",
			desc = "save quit this",
		},
		{
			"<leader>we",
			"<cmd>wa<cr>",
			desc = "save all",
		},
		{
			"<leader>ws",
			"<cmd>wqa<cr>",
			desc = "save quit all",
		},
		{
			"<leader>wp",
			"<cmd>qa<cr>",
			desc = "quit all",
		},
		-- neovim/nvim-lspconfig
		{
			"<leader>wa",
			desc = "lsp workspace add folder",
		},
		{
			"<leader>wr",
			desc = "lsp workspace remove folder",
		},
		{
			"<leader>wl",
			desc = "lsp workspace list folder",
		},
	},
	{
		"<leader>l",
		group = "list trouble/todo/toggle lsp_lens",
		mode = "n",
	}, -- folke/trouble.nvim
	{
		"<leader>ld",
		"<cmd>TroubleToggle document_diagnostics<cr>",
		desc = "open trouble document_diagnostics",
	},
	{
		"<leader>lw",
		"<cmd>TroubleToggle workspace_diagnostics<cr>",
		desc = "open trouble workspace_diagnostics",
	},
	{
		"<leader>lr",
		"<cmd>TroubleToggle lsp_references<cr>",
		desc = "open trouble lsp_references",
	},
	{
		"<leader>ls",
		"<cmd>TroubleToggle lsp_definitions<cr>",
		desc = "open trouble lsp_definitions",
	},
	{
		"<leader>lq",
		"<cmd>TroubleToggle quickfix<cr>",
		desc = "open trouble quickfix",
	},
	{
		"<leader>ll",
		"<cmd>TroubleToggle loclist<cr>",
		desc = "open trouble loclist",
	}, -- folke/todo-comments.nvim
	{
		"<leader>lt",
		"<cmd>TodoTrouble<cr>",
		desc = "open trouble todo",
	}, -- ~whynothugo/lsp_lines.nvim
	{
		"<leader>lm",
		"<cmd>lua require('lsp_lines').toggle()<cr>",
		desc = "toggle lsp_lens",
	},
	{
		"<leader>f",
		group = "find telescope/todo/undo/buffer/project/dap configurations/lsp",
		mode = "n",
	}, -- folke/todo-comments.nvim
	{
		"<leader>ft",
		"<cmd>TodoTelescope<cr>",
		desc = "telescope find todo",
	}, -- nvim-telescope/telescope.nvim
	{
		"<leader>ff",
		"<cmd>Telescope find_files<cr>",
		desc = "telescope find files",
	},
	{
		"<leader>fs",
		"<cmd>Telescope grep_string<cr>",
		desc = "telescope grep string",
	},
	{
		"<leader>fg",
		"<cmd>Telescope live_grep<cr>",
		desc = "telescope live grep string",
	},
	{
		"<leader>fr",
		"<cmd>Telescope resume<cr>",
		desc = "telescope resume last search window",
	},
	{
		"<leader>fb",
		"<cmd>lua require('telescope.builtin').buffers()<cr>",
		desc = "telescope find buffers",
	},
	{
		"<leader>fp",
		group = "telescope project/persisted",
	},
	{
		"<leader>fpp",
		"<cmd>lua require'telescope'.extensions.projects.projects()<cr>",
		desc = "telescope find projects",
	}, -- olimorris/persisted.nvim
	{
		"<leader>fps",
		"<cmd>Telescope persisted<cr>",
		desc = "telescope find persisted sessions",
	}, -- ussenegger/nvim-dap
	{
		"<leader>fd",
		function()
			require("telescope").extensions.dap.configurations({})
		end,
		desc = "telescope dap configurations",
	}, -- jemag/telescope-diff.nvim
	{
		"<leader>fn",
		function()
			require("telescope").extensions.diff.diff_files({
				hidden = true,
			})
		end,
		desc = "telescope diff 2 files",
	},
	{
		"<leader>fc",
		function()
			require("telescope").extensions.diff.diff_current({
				hidden = true,
			})
		end,
		desc = "telescope diff current",
	},
	{
		"<leader>fu",
		"<cmd> Telescope undo <cr>",
		desc = "telescope find undo",
	},
	{
		"<leader>fl",
		desc = "lsp find def+ref+imp",
	},
	{
		"<leader>fo",
		"<cmd> Telescope oldfiles <cr>",
		desc = "telescope find recent files",
	},
	{
		"<leader>fh",
		function()
			local results = {}
			local search_pattern = vim.fn.getreg("/")
			if search_pattern ~= "" then
				for line_nr = 1, vim.api.nvim_buf_line_count(0) do
					local line = vim.api.nvim_buf_get_lines(0, line_nr - 1, line_nr, false)[1]
					if line:match(search_pattern) then
						table.insert(results, line_nr .. ": " .. line)
					end
				end
				require("telescope.pickers")
					.new({}, {
						prompt_title = "Search Results",
						finder = require("telescope.finders").new_table({
							results = results,
						}),
						sorter = require("telescope.sorters").get_generic_fuzzy_sorter(),
					})
					:find()
			end
		end,
		desc = "telescope find highlights",
	}, -- AckslD/nvim-neoclip.lua
	{
		"<leader>fv",
		"<cmd> Telescope neoclip <cr>",
		desc = "telescope find clipboard",
	},
	{
		"<leader>h",
		group = "history memento",
		mode = "n",
	}, -- gaborvecsei/memento.nvim
	{
		"<leader>hb",
		"<cmd> lua require('memento').toggle() <cr>",
		desc = "toggle memento buffer history",
	},
	{
		"<leader>hc",
		"<cmd> lua require('memento').clear_history() <cr>",
		desc = "clear memento buffer history",
	},
	{
		"<leader>o",
		group = "open layout/outline/gitgraph/session",
		mode = "n",
	}, -- olimorris/persisted.nvim
	{
		"<leader>op",
		"<cmd> SessionLoad <cr>",
		desc = "current dir session layout",
	},
	{
		"<leader>ol",
		"<cmd> SessionLoadLast <cr>",
		desc = "last session layout",
	},
	{
		"<leader>oi",
		desc = "PyrightOrganizeImports",
	}, -- simrat39/symbols-outline.nvim
	-- o = { "<cmd>SymbolsOutline <cr>", "open symbols outline" },
	-- -- stevearc/aerial.nvim
	-- o = {"<cmd>AerialToggle!<cr>", "open aerial symbols outline"},
	-- "hedyhli/outline.nvim"
	{
		"<leader>oo",
		"<cmd> Outline <cr>",
		desc = "open symbols outline",
	}, -- nvim-neo-tree/neo-tree.nvim
	-- t = { "<cmd>Neotree document_symbols <cr>", "open neotree outline"},
	-- rbong/vim-flog
	{
		"<leader>og",
		"<cmd> Flog <cr>",
		desc = "open git graph g? for keymap gq to quit",
	},
	{
		"<leader>os",
		group = "symbols",
		mode = "n",
	},
	{
		"<leader>osd",
		desc = "open treesitter document_symbols",
	},
	{
		"<leader>osw",
		desc = "open treesitter workspace_symbols",
	},
	{
		"<leader>osl",
		desc = "open lsp document_symbols",
	},
	{
		"<leader>osg",
		desc = "find lsp workspace_symbols",
	},
	{
		"<leader>oc",
		group = "cclshierarchy callings",
		mode = "n",
	},
	{
		"<leader>ost",
		"<cmd> Calltree <cr>",
		desc = "calltrees",
	},
	{
		"<leader>osi",
		desc = "incoming_calls",
	},
	{
		"<leader>oso",
		desc = "outgoing_calls",
	},
	{
		"<leader>t",
		group = "tree/trigger linting/treesitter selection/show path of current buffer",
		mode = "n",
	},
	{
		"<leader>tn",
		"<cmd> echo expand('%:p') <cr>",
		desc = "show the path of current buffer",
	},
	{
		"<leader>ty",
		function()
			local current_buffer_path = vim.fn.expand("%:p")
			vim.fn.setreg('"', current_buffer_path)
			print("copied path to clipboard: " .. current_buffer_path)
		end,
		desc = "yank current buffer path",
	}, -- nvim-tree/nvim-tree.lua
	{
		"<leader>tt",
		"<cmd> NvimTreeToggle <cr>",
		desc = "toggle nvim-tree",
	},
	{
		"<leader>tf",
		"<cmd> NvimTreeFindFile <cr>",
		desc = "cursor to current bufname",
	},
	{
		"<leader>tr",
		"<cmd> NvimTreeRefresh <cr>",
		desc = "refresh nvim-tree",
	},
	{
		"<leader>tc",
		"<cmd> NvimTreeCollapse <cr>",
		desc = "collapses nvim-tree recursively",
	}, -- nvim-neo-tree/neo-tree.nvim
	-- t = { "<cmd>Neotree toggle <cr>", "open close the tree" },
	-- f = { "<cmd>Neotree focus <cr>", "cursor to current bufname" },
	-- g = { "<cmd>Neotree float git_status <cr>", "neotree git status" },
	-- u = {"neotree unstage file",},
	-- o = {"neotree add file",},
	-- r = {"neotree revert file",},
	-- c = {"neotree commit file",},
	-- p = {"neotree push file",},
	-- stevearc/conform.nvim
	{
		"<leader>tl",
		function()
			lint.try_lint()
		end,
		desc = "lint current file",
	}, -- nvim-treesitter/nvim-treesitter
	{
		"<leader>ta",
		desc = "treesitter incremental selection",
	}, -- nvim-neo-tree/neo-tree.nvim
	-- A = { "neotree git add all" },
	{
		"<leader>b",
		group = "bufferline switch/dap breakpoint/buffer manager",
		mode = "n",
	}, -- akinsho/bufferline.nvim
	{
		"<leader>bn",
		"<cmd> BufferLineCycleNext <cr>",
		desc = "switch to next buffer",
	},
	{
		"<leader>bm",
		"<cmd> BufferLineCyclePrev <cr>",
		desc = "switch to previous buffer",
	},
	{
		"<leader>bg",
		"<cmd> BufferLinePick <cr>",
		desc = "switch to certain buffer",
	},
	{
		"<leader>bd",
		"<cmd> BufferLinePickClose <cr>",
		desc = "close certain buffer",
	},
	{
		"<leader>bc",
		"<cmd> bd <cr>",
		desc = "close current buffer",
	},
	{
		"<leader>bp",
		"<cmd> BufferLineTogglePin <cr>",
		desc = "pin buffer",
	},
	{
		"<leader>bj",
		"<cmd> BufferLineMovePrev <cr>",
		desc = "buffer move previous",
	},
	{
		"<leader>bk",
		"<cmd> BufferLineMoveNext <cr>",
		desc = "buffer move next",
	}, -- mfussenegger/nvim-dap
	{
		"<leader>bb",
		"<cmd>lua require('dap').toggle_breakpoint()<cr>",
		desc = "dap toggle breakpoint",
	},
	{
		"<leader>ba",
		"<cmd>lua require('dap').set_breakpoint()<cr>",
		desc = "dap set breakpoint",
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
	}, -- j-morano/buffer_manager.nvim
	{
		"<leader>bf",
		"<cmd> lua require('buffer_manager.ui').toggle_quick_menu() <cr>",
		desc = "toggle buffer manager",
	},
	{
		"<leader>c",
		group = "close bufferline|window/code action/create docs",
		mode = "n",
	}, -- akinsho/bufferline.nvim
	{
		"<leader>cr",
		"<cmd> BufferLineCloseRight <cr>",
		desc = "close right buffers",
	},
	{
		"<leader>cf",
		"<cmd> BufferLineCloseLeft <cr>",
		desc = "close left buffers",
	},
	{
		"<leader>co",
		"<cmd> BufferLineCloseOthers <cr>",
		desc = "close other buffers",
	}, -- neovim/nvim-lspconfig
	{
		"<leader>ca",
		desc = "available code actions",
	}, -- s1n7ax/nvim-window-picker
	{
		"<leader>cw",
		function()
			local window_number = require("window-picker").pick_window()
			if window_number then
				vim.api.nvim_win_close(window_number, false)
			end
		end,
		desc = "close window",
	}, -- danymat/neogen
	{
		"<leader>cg",
		"<cmd> Neogen <cr>",
		desc = "neogen generate docs",
	}, -- neovim/nvim-lspconfig
	{
		"<leader>d",
		group = "diagnostics/type_definition/dap",
		mode = "n",
	},
	{
		"<leader>da",
		desc = "diagnostics",
	}, -- mfussenegger/nvim-dap
	{
		"<leader>dr",
		function()
			require("dap").repl.open()
		end,
		desc = "dap repl open",
	},
	{
		"<leader>dl",
		function()
			require("dap").run_last()
		end,
		desc = "dap run last",
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
		"<leader>dp",
		function()
			require("dap.ui.widgets").preview()
		end,
		desc = "dap widgets preview",
		mode = { "n", "v" },
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
		"<leader>ds",
		function()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.scopes)
		end,
		desc = "dap widgets scopes",
	},
	{
		"<leader>dd",
		"<cmd> DapTerminate <cr>",
		desc = "dap terminate",
	},
	{
		"<leader>D",
		desc = "type_definition_preview",
	},
	{
		"<leader>r",
		group = "rename/remove/ros/run cmake|task/restart lsp",
		mode = "n",
	},
	{
		"<leader>rl",
		"<cmd> LspRestart <cr>",
		desc = "restart lsp service",
	},
	{
		"<leader>rn",
		desc = "lsp smart rename",
	}, -- thibthib18/ros-nvim
	{
		"<leader>rs",
		"<cmd> lua require('ros-nvim.telescope.package').search_package() <cr>",
		desc = "ros search package",
	},
	{
		"<leader>rg",
		"<cmd> lua require('ros-nvim.telescope.package').grep_package() <cr>",
		desc = "ros grep package",
	},
	{
		"<leader>rp",
		group = "ros picker",
	},
	{
		"<leader>rpt",
		"<cmd> lua require('ros-nvim.telescope.pickers').topic_picker() <cr>",
		desc = "ros pick topics",
	},
	{
		"<leader>rpn",
		"<cmd> lua require('ros-nvim.telescope.pickers').node_picker() <cr>",
		desc = "ros pick nodes",
	},
	{
		"<leader>rps",
		"<cmd> lua require('ros-nvim.telescope.pickers').service_picker() <cr>",
		desc = "ros pick services",
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
		"<leader>rpp",
		"<cmd> lua require('ros-nvim.telescope.pickers').param_picker() <cr>",
		desc = "ros pick params",
	},
	{
		"<leader>rm",
		"<cmd> lua require('ros-nvim.build').catkin_make() <cr>",
		desc = "ros catkin_make",
	},
	{
		"<leader>rk",
		"<cmd> lua require('ros-nvim.build').catkin_make_pkg() <cr>",
		desc = "ros catkin_make_pkg",
	},
	{
		"<leader>rt",
		"<cmd> lua require('ros-nvim.test').rostest() <cr>",
		desc = "ros exec test",
	}, -- Civitasv/cmake-tools.nvim
	{
		"<leader>rc",
		group = "cmake",
	},
	{
		"<leader>rcc",
		"<cmd> CMakeGenerate <cr>",
		desc = "cmake ..",
	},
	{
		"<leader>rcb",
		"<cmd> CMakeBuild <cr>",
		desc = "cmake build",
	},
	{
		"<leader>rcr",
		"<cmd> CMakeRun <cr>",
		desc = "cmake run",
	},
	{
		"<leader>rcs",
		group = "cmake select",
	},
	{
		"<leader>rcst",
		"<cmd> CMakeSelectBuildType <cr>",
		desc = "cmake select build type",
	},
	{
		"<leader>rcsl",
		"<cmd> CMakeSelectLaunchTarget <cr>",
		desc = "cmake select launch target",
	},
	{
		"<leader>rcsa",
		"<cmd> CMakeSelectBuildTarget <cr>",
		desc = "cmake select build target",
	},
	{
		"<leader>rcsk",
		"<cmd> CMakeSelectKit <cr>",
		desc = "cmake select kit",
	},
	{
		"<leader>rcsc",
		"<cmd> CMakeSelectCwd <cr>",
		desc = "cmake select main CMakeLists.txt",
	},
	{
		"<leader>rcsb",
		"<cmd> CMakeSelectBuildDir <cr>",
		desc = "cmake select dir build",
	},
	{
		"<leader>rv",
		group = "vscode task",
	},
	{
		"<leader>rvt",
		"<cmd> lua require('telescope').extensions.vstask.tasks() <cr>",
		desc = "vstask open list",
	},
	{
		"<leader>rvi",
		"<cmd> lua require('telescope').extensions.vstask.inputs() <cr>",
		desc = "vstask open input list",
	},
	{
		"<leader>rvh",
		"<cmd> lua require('telescope').extensions.vstask.history() <cr>",
		desc = "vstask search history tasks",
	},
	{
		"<leader>rvc",
		"<cmd> lua require('telescope').extensions.vstask.close() <cr>",
		desc = "vstask close runnning task",
	},
	{
		"<leader>p",
		group = "pick window/project add/preview makrdown/peek lsp",
		mode = "n",
	}, -- s1n7ax/nvim-window-picker
	{
		"<leader>pp",
		function()
			local window_number = require("window-picker").pick_window()
			if window_number then
				vim.api.nvim_set_current_win(window_number)
			end
		end,
		desc = "pick window",
	},
	{
		"<leader>ps",
		function()
			local window_picker = require("window-picker")
			local picked_win_id = window_picker.pick_window()

			if picked_win_id then
				local bufnr = vim.api.nvim_win_get_buf(picked_win_id)
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
				local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")

				print("Picked window buffer name:", bufname)
				print("Filetype:", filetype)
				print("Buftype:", buftype)
			else
				print("No window was picked")
			end
		end,
		desc = "show pick window",
	}, -- ahmedkhalf/project.nvim
	{
		"<leader>pa",
		"<cmd> lua require('project_nvim.project').add_project_manually() <cr>",
		desc = "project add",
	}, -- ellisonleao/glow.nvim
	{
		"<leader>pm",
		"<cmd> Glow <cr>",
		desc = "markdown Glow preview",
	},
	{
		"<leader>pf",
		desc = "treesitter peek function start",
	},
	{
		"<leader>pF",
		desc = "treesitter peek class start",
	},
	{
		"<leader>m",
		group = "markdown/messages/swap shift window",
		mode = "n",
	}, -- toppair/peek.nvim
	{
		"<leader>mo",
		"<cmd> lua require('peek').open() <cr>",
		desc = "peek open markdown preview",
	},
	{
		"<leader>mc",
		"<cmd> lua require('peek').close() <cr>",
		desc = "peek close markdown preview",
	}, -- folke/noice.nvim
	{
		"<leader>mm",
		"<cmd> message <cr>",
		desc = "messages show",
	},
	{
		"<leader>mn",
		"<cmd> Noice telescope <cr>",
		desc = "noice messages telescope",
	}, -- sindrets/winshift.nvim
	{
		"<leader>mw",
		"<cmd> WinShift <cr>",
		desc = "winshift move",
	}, -- mode = { "n", "t" }
	-- h = {
	--     "<cmd>WinShift right <cr>",
	--     "winshift switch right",
	-- },
	-- j = {
	--     "<cmd>WinShift down <cr>",
	--     "winshift switch down",
	-- },
	-- k = {
	--     "<cmd>WinShift up <cr>",
	--     "winshift switch up",
	-- },
	-- l = {
	--     "<cmd>WinShift left <cr>",
	--     "winshift switch left",
	-- },
	-- anuvyklack/windows.nvim
	{
		"<leader>ma",
		"<cmd> WindowsMaximize <cr>",
		desc = "windows max",
	}, -- mode = { "n", "t" }
	{
		"<leader>mh",
		"<cmd> WindowsMaximizeHorizontally <cr>",
		desc = "windows max horizontally",
	}, -- mode = { "n", "t" }
	{
		"<leader>mv",
		"<cmd> WindowsMaximizeVertically <cr>",
		desc = "windows max vertically",
	}, -- mode = { "n", "t" }
	{
		"<leader>me",
		"<cmd> WindowsEqualize <cr>",
		desc = "windows equalize",
	}, -- mode = { "n", "t" }
	{
		"<leader>mt",
		"<cmd> WindowsToggleAutowidth <cr>",
		desc = "windows toggle auto width",
	}, -- mode = { "n", "t" }
	-- kdheepak/lazygit.nvim
	{
		"<leader>g",
		group = "git",
		mode = "n",
	},
	{
		"<leader>gg",
		function()
			require("toggleterm.terminal").Terminal
				:new({
					cmd = "lazygit",
					hidden = true,
					direction = "float",
					float_opts = {
						border = "rounded",
					},
				})
				:toggle()
		end,
		desc = "lazygit toggle",
	},
	{
		"<leader>gh",
		"<cmd> DiffviewFileHistory <cr>",
		desc = "diff file history",
	},
	{
		"<leader>v",
		group = "venv",
		mode = "n",
	}, -- s = {
	-- 	"<cmd>lua require('swenv.api').pick_venv()<cr>",
	-- 	"python swenv venv pick",
	-- },
	{
		"<leader>vs",
		"<cmd> VenvSelect <cr>",
		desc = "python venv selevt",
	},
	{
		"<leader>vc",
		"<cmd> VenvSelectCached <cr>",
		desc = "python venv selevt from cache",
	},
})

wk.add({ -- ussenegger/nvim-dap
	{
		"<F5>",
		function()
			require("telescope").extensions.dap.configurations({})
		end,
		desc = "telescope dap configurations",
	},
	{
		"<F10>",
		function()
			require("dap").step_over()
		end,
		desc = "dap step over",
	},
	{
		"<F11>",
		function()
			require("dap").step_into()
		end,
		desc = "dap step into",
	},
	{
		"<F12>",
		function()
			require("dap").step_out()
		end,
		desc = "dap step out",
	}, -- mrjones2014/smart-splits.nvim
	{
		"<C-Up>",
		"<cmd> lua require('smart-splits').resize_up(2) <cr>",
		desc = "Resize window",
		mode = { "n", "t" },
	},
	{
		"<C-Down>",
		"<cmd> lua require('smart-splits').resize_down(2) <cr>",
		desc = "Resize window",
		mode = { "n", "t" },
	},
	{
		"<C-Left>",
		"<cmd> lua require('smart-splits').resize_left(2) <cr>",
		desc = "Resize window",
		mode = { "n", "t" },
	},
	{
		"<C-Right>",
		"<cmd> lua require('smart-splits').resize_right(2) <cr>",
		desc = "Resize window",
		mode = { "n", "t" },
	},
	{
		"<A-h>",
		"<cmd> lua require('smart-splits').move_cursor_left() <cr>",
		desc = "move to left window",
		mode = { "n", "t" },
	},
	{
		"<A-j>",
		"<cmd> lua require('smart-splits').move_cursor_down() <cr>",
		desc = "move to down window",
		mode = { "n", "t" },
	},
	{
		"<A-k>",
		"<cmd> lua require('smart-splits').move_cursor_up() <cr>",
		desc = "move to up window",
		mode = { "n", "t" },
	},
	{
		"<A-l>",
		"<cmd> lua require('smart-splits').move_cursor_right() <cr>",
		desc = "move to right window",
		mode = { "n", "t" },
	}, -- numToStr/Comment.nvim
	{
		"<C-_>",
		desc = "toggle comment",
	}, -- akinsho/toggleterm.nvim
	{
		"<C-\\>",
		"<cmd> ToggleTerm <cr>",
		desc = "toggle term",
		mode = { "n", "t" },
	}, -- folke/flash.nvim
	{
		"<A-s>",
		function()
			require("flash").toggle()
		end,
		desc = "toggle flash",
		mode = { "c" },
	}, -- neovim/nvim-lspconfig
	{
		"<C-h>",
		desc = "tlsp peek definition",
	},
	{
		"<C-k>",
		desc = "Signature Documentation/cmp previous",
	}, -- hrsh7th/nvim-cmp
	{
		"<C-j>",
		desc = "cmp next",
	},
	{
		"<C-Space>",
		desc = "cmp commplete",
	},
	{
		"<C-e>",
		desc = "cmp abort",
	}, -- ahmedkhalf/project.nvim
	{
		"<C-f>",
		desc = "project find files",
	},
	{
		"<C-b>",
		desc = "project browse files",
	},
	{
		"<C-d>",
		desc = "project delete",
	},
	{
		"<C-s>",
		desc = "project search in files",
	},
	{
		"<C-r>",
		desc = "project recent files",
	},
	{
		"<C-w>",
		desc = "project change working directory",
	}, -- akinsho/toggleterm.nvim
	{
		"<A-h>",
		"<cmd> wincmd h <cr>",
		desc = "move to left window",
		mode = { "t" },
	},
	{
		"<A-j>",
		"<cmd> wincmd j <cr>",
		desc = "move to down window",
		mode = { "t" },
	},
	{
		"<A-k>",
		"<cmd> wincmd k <cr>",
		desc = "move to up window",
		mode = { "t" },
	},
	{
		"<A-l>",
		"<cmd> wincmd l <cr>",
		desc = "move to right window",
		mode = { "t" },
	}, -- stevearc/conform.nvim
	{
		"<C-A-l>",
		function()
			local strict = require("strict")
			strict.convert_tabs_to_spaces()
			-- strict.remove_trailing_whitespace()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end,
		desc = "format file or range",
		mode = { "n", "v" },
	}, -- danymat/neogen
	{
		"<C-A-g>",
		"<cmd> Neogen <cr>",
		desc = "neogen generate docs",
		mode = { "n", "i" },
	},
	{
		"<C-A-n>",
		function()
			local file_path = vim.fn.expand("%:p") -- Get the full path of the current file
			if term == "screen-256color" then
				-- Open in new tmux window
				vim.cmd("silent !tmux new-window nvim " .. file_path)
			elseif term == "xterm-256color" then
				-- Open in new kitty tab
				vim.cmd("silent !kitty @ launch --type=tab nvim " .. file_path)
			end
		end,
		desc = "open current file in new tab/window(kitty/tmux)",
	}, -- folke/todo-comments.nvim
	{
		"]t",
		function()
			require("todo-comments").jump_next()
		end,
		desc = "Next todo comment",
	},
	{
		"[t",
		function()
			require("todo-comments").jump_prev()
		end,
		desc = "Previous todo comment",
	}, -- nvim-treesitter/nvim-treesitter-textobjects
	{
		"]m",
		desc = "treesitter goto next start @function.outer",
	},
	{
		"]M",
		desc = "treesitter goto next end @function.outer",
	},
	{
		"[m",
		desc = "treesitter goto prev start @function.outer",
	},
	{
		"[M",
		desc = "treesitter goto prev end @function.outer",
	},
	{
		"]o",
		desc = "treesitter goto next start @loop.inner",
	},
	{
		"]O",
		desc = "treesitter goto next end @loop.inner",
	},
	{
		"[o",
		desc = "treesitter goto prev start @loop.inner",
	},
	{
		"[O",
		desc = "treesitter goto prev end @loop.inner",
	},
	{
		"]z",
		desc = "treesitter goto next start @fold",
	},
	{
		"]Z",
		desc = "treesitter goto next end @fold",
	},
	{
		"[z",
		desc = "treesitter goto prev start @fold",
	},
	{
		"[Z",
		desc = "treesitter goto prev end @fold",
	},
	{ "]]", "treesitter goto next start @class.outer" },
	{ "][", "treesitter goto next end @class.outer" },
	{ "[[", "treesitter goto prev start @class.outer" },
	{ "[]", "treesitter goto prev end @class.outer" },

	{ "]d", "treesitter goto next @conditional.outer" },
	{ "[d", "treesitter goto prev @conditional.outer" },
})

-- nvim-treesitter/nvim-treesitter-textobjects
wk.add({
	mode = "v",
	{
		"a",
		group = "treesitter @function.outer",
	},
	{
		"af",
		desc = "select @function.outer",
	},
	{
		"ac",
		desc = "select @class.outer",
	},
	{
		"as",
		desc = "select @scope",
	},
	{
		"i",
		group = "treesitter @function.inner",
	},
	{
		"if",
		desc = "select @function.inner",
	},
	{
		"ic",
		desc = "select @class.inner",
	},
	-- nvim-pack/nvim-spectre
	{
		"sw",
		"<esc><cmd> lua require('spectre').open_visual() <cr>",
		desc = "search current word",
	},
})
