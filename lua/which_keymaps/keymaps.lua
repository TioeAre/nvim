local wk = require("which-key")
local conform = require("conform")
local lint = require("lint")

wk.register({
	-- folke/trouble.nvim
	q = "close trouble list",
	["<esc>"] = "cancel trouble preview",
	o = "jump and close trouble/dap open ui breakpoint",
	P = "toggle auto preview trouble",
	["?"] = "help trouble",
	j = "jump next trouble item",
	k = "previous trouble item",
	K = "hover trouble/lsp show documentation",
	c = "open code href trouble",
	z = {
		a = "toggle fold of current trouble file",
		A = "toggle fold of current trouble file",
		-- kevinhwang91/nvim-ufo
		o = { "<cmd>lua require('ufo').openFoldsExceptKinds()<cr>", "ufo/trouble open fold" },
		c = { "<cmd>lua require('ufo').closeFoldsWith()<cr>", "ufo/trouble close fold" },
		O = { "<cmd>lua require('ufo').openAllFolds()<cr>", "ufo/trouble open all folds" },
		C = { "<cmd>lua require('ufo').closeAllFolds()<cr>", "ufo/trouble close all folds" },
	},
	-- folke/flash.nvim
	s = {
		function()
			require("flash").jump()
		end,
		"flash",
		mode = { "n", "x", "o" },
	},
	S = {
		function()
			require("flash").treesitter()
		end,
		"flash treesitter",
		mode = { "n", "x", "o" },
	},
	r = {
		function()
			require("flash").remote()
		end,
		"remote flash",
		mode = { "o" },
	},
	R = {
		function()
			require("flash").treesitter_search()
		end,
		"treesitter search",
		mode = { "x", "o" },
	},
	-- neovim/nvim-lspconfig
	g = {
		D = "go to declaration",
		d = "go to definition",
		i = "go to implementation",
		r = "go to references",
	},
	-- max397574/colortils.nvim
	l = "color increment values",
	h = "color decrement values",
	L = "color increment bigger",
	H = "color decrement bigger",
	["g<cr>"] = "replace color with format",
	["m<cr>"] = "replace color with default format",
	E = "color export",
	B = "color choose background",
	-- rcarriga/nvim-dap-ui
	e = "edit dap ui breakpoint",
	d = "delete dap ui breakpoint",
	t = "toggle dap ui breakpoint",
})

-- plugin keymap
-- leader
wk.register({
	["<leader>"] = {
		-- overall
		s = {
			mode = "n",
			name = "split/show/switch/stop",
			v = { "<C-w>v", "split windows v (trouble)" },
			h = { "<C-w>s", "split windows h (trouble)" },
			-- folke/persistence.nvim
			q = { "<cmd>lua require('persistence').stop()<cr>", "stop persistence" },
			-- folke/trouble.nvim
			s = "switch trouble severity filter",
		},
		n = {
			mode = "n",
			name = "no/next",
			h = { "<cmd>nohl<cr>", "no highlight" },
		},
		w = {
			mode = "n",
			name = "save",
			q = { "<cmd>x<cr>", "save quit this" },
			e = { "<cmd>wa<cr>", "save all" },
			s = { "<cmd>wqa<cr>", "save quit all" },
			p = { "<cmd>qa<cr>", "quit all" },
			-- neovim/nvim-lspconfig
			a = "lsp workspace add folder",
			r = "lsp workspace remove folder",
			l = "lsp workspace list folder",
		},
		-- plugins
		l = {
			name = "list",
			-- folke/trouble.nvim
			s = { "<cmd>TroubleToggle document_diagnostics<cr>", "open trouble document_diagnostics" },
			w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "open trouble workspace_diagnostics" },
			p = { "<cmd>TroubleToggle lsp_references<cr>", "open trouble lsp_references" },
			d = { "<cmd>TroubleToggle lsp_definitions<cr>", "open trouble lsp_definitions" },
			q = { "<cmd>TroubleToggle quickfix<cr>", "open trouble quickfix" },
			-- folke/todo-comments.nvim
			t = { "<cmd>TodoTrouble<cr>", "open trouble todo" },
		},
		f = {
			name = "find telescope/todo/undo/buffer/project/dap configurations",
			-- folke/todo-comments.nvim
			t = { "<cmd>TodoTelescope<cr>", "telescope todo" },
			-- nvim-telescope/telescope.nvim
			f = { "<cmd>Telescope find_files<cr>", "telescope files" },
			s = { "<cmd>Telescope grep_string<cr>", "telescope grep string" },
			g = { "<cmd>Telescope live_grep<cr>", "telescope live grep string" },
			r = { "<cmd>Telescope resume<cr>", "telescope resume last search window" },
			b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "telescope find buffers" },
			p = { "<cmd>lua require'telescope'.extensions.projects.projects{} <cr>", "telescope find projects" },
			-- ussenegger/nvim-dap
			d = {
				function()
					require("telescope").extensions.dap.configurations({})
				end,
				"telescope dap configurations",
			},
			-- jemag/telescope-diff.nvim
			n = {
				function()
					require("telescope").extensions.diff.diff_files({ hidden = true })
				end,
				"telescope diff 2 files",
			},
			c = {
				function()
					require("telescope").extensions.diff.diff_current({ hidden = true })
				end,
				"telescope diff current",
			},
			u = {
				"<cmd>Telescope undo<cr>",
				"telescope find undo",
			}
		},
		o = {
			name = "open",
			-- folke/persistence.nvim
			p = { "<cmd>lua require('persistence').load()<cr>", "open layout" },
			l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "restore layout" },
			i = "PyrightOrganizeImports",
			-- simrat39/symbols-outline.nvim
			o = { "<cmd>SymbolsOutline <cr>", "open symbols outline" },
			-- nvim-neo-tree/neo-tree.nvim
			-- t = { "<cmd>Neotree document_symbols <cr>", "open neotree outline"},
		},
		t = {
			name = "tree/trigger linting",
			-- nvim-tree/nvim-tree.lua
			t = { "<cmd>NvimTreeToggle<cr>", "open close the tree" },
			f = { "<cmd>NvimTreeFindFile<cr>", "cursor to current bufname" },
			r = { "<cmd>NvimTreeRefresh<cr>", "refresh the tree" },
			c = { "<cmd>NvimTreeCollapse<cr>", "collapses nvim-tree recursively" },
			-- nvim-neo-tree/neo-tree.nvim
			-- t = { "<cmd>Neotree toggle <cr>", "open close the tree" },
			-- f = { "<cmd>Neotree focus <cr>", "cursor to current bufname" },
			-- g = { "<cmd>Neotree float git_status <cr>", "neotree git status" },
			-- u = {"neotree unstage file",},
			-- o = {"neotree add file",},
			-- r = {"neotree revert file",},
			-- c = {"neotree commit file",},
			-- p = {"neotree push file",},
			-- stevearc/conform.nvim
			l = {
				function()
					lint.try_lint()
				end,
				"trigger linting for current file",
			},
			-- nvim-treesitter/nvim-treesitter
			a = "treesitter incremental selection",
		},
		-- nvim-neo-tree/neo-tree.nvim
		-- A = { "neotree git add all" },
		b = {
			name = "bufferline switch/breakpoint",
			-- akinsho/bufferline.nvim
			n = { "<cmd>BufferLineCycleNext<cr>", "switch to next buffer" },
			m = { "<cmd>BufferLineCyclePrev<cr>", "switch to preview buffer" },
			g = { "<cmd>BufferLinePick<cr>", "switch to certain buffer" },
			d = { "<cmd>BufferLinePickClose<cr>", "close certain buffer" },
			c = { "<cmd>bd<cr>", "close current buffer" },
			p = { "<cmd>BufferLinePick<cr>", "pick buffer line" },
			-- mfussenegger/nvim-dap
			a = {
				function()
					require("dap").toggle_breakpoint()
				end,
				"dap toggle breakpoint",
			},
			b = {
				function()
					require("dap").set_breakpoint()
				end,
				"dap set breakpoint",
			},
			l = {
				function()
					require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
				end,
				"dap set log point message",
			},
			q = {
				"<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>",
				"dap clear all breakpoints",
			},
		},
		c = {
			-- akinsho/bufferline.nvim
			name = "close bufferline/code action",
			r = { "<cmd>BufferLineCloseRight<cr>", "close right buffers" },
			f = { "<cmd>BufferLineCloseLeft<cr>", "close left buffers" },
			o = { "<cmd>BufferLineCloseOthers<cr>", "close other buffers" },
			-- neovim/nvim-lspconfig
			a = "see available code actions",
			-- s1n7ax/nvim-window-picker
			w = {
				function()
					local window_number = require("window-picker").pick_window()
					if window_number then
						vim.api.nvim_win_close(window_number, false)
					end
				end,
				"close window",
			},
		},
		-- neovim/nvim-lspconfig
		d = {
			name = "diagnostics/type_definition/dap",
			a = "diagnostics",
			-- mfussenegger/nvim-dap
			r = {
				function()
					require("dap").repl.open()
				end,
				"dap repl open",
			},
			l = {
				function()
					require("dap").run_last()
				end,
				"dap run last",
			},
			h = {
				function()
					require("dap.ui.widgets").hover()
				end,
				"dap widgets hover",
				mode = { "n", "v" },
			},
			p = {
				function()
					require("dap.ui.widgets").preview()
				end,
				"dap widgets preview",
				mode = { "n", "v" },
			},
			f = {
				function()
					local widgets = require("dap.ui.widgets")
					widgets.centered_float(widgets.frames)
				end,
				"dap widgets frames",
			},
			s = {
				function()
					local widgets = require("dap.ui.widgets")
					widgets.centered_float(widgets.scopes)
				end,
				"dap widgets scopes",
			},
			d = { "<cmd>DapTerminate<cr>", "dap terminate" },
		},
		D = "type definition",
		r = {
			name = "rename/remove/ros",
			n = "smart rename",
			-- thibthib18/ros-nvim
			s = { "<cmd>lua require('ros-nvim.telescope.package').search_package()<cr>", "ros search package" },
			g = { "<cmd>lua require('ros-nvim.telescope.package').grep_package()<cr>", "ros grep package" },
			p = {
				name = "ros picker",
				t = { "<cmd>lua require('ros-nvim.telescope.pickers').topic_picker()<cr>", "ros pick topics" },
				n = { "<cmd>lua require('ros-nvim.telescope.pickers').node_picker()<cr>", "ros pick nodes" },
				s = { "<cmd>lua require('ros-nvim.telescope.pickers').service_picker()<cr>", "ros pick services" },
				d = {
					"<cmd>lua require('ros-nvim.telescope.pickers').srv_picker()<cr>",
					"ros pick service definitions",
				},
				m = { "<cmd>lua require('ros-nvim.telescope.pickers').msg_picker()<cr>", "ros pick messages" },
				p = { "<cmd>lua require('ros-nvim.telescope.pickers').param_picker()<cr>", "ros pick params" },
			},
			-- Civitasv/cmake-tools.nvim
			c = {
				name = "cmake",
				c = {
					"<cmd>CMakeGenerate <cr>",
					"cmake ..",
				},
				b = {
					"<cmd>CMakeBuild <cr>",
					"cmake build",
				},
				r = {
					"<cmd>CMakeRun <cr>",
					"cmake run",
				},
			},
			v = {
				name = "vscode task",
				t = {
					"<cmd>lua require('telescope').extensions.vstask.tasks() <cr>",
					"vstask open list",
				},
				i = {
					"<cmd>lua require('telescope').extensions.vstask.inputs() <cr>",
					"vstask open input list",
				},
				h = {
					"<cmd>lua require('telescope').extensions.vstask.history() <cr>",
					"vstask search history tasks",
				},
				c = {
					"<cmd>lua require('telescope').extensions.vstask.close() <cr>",
					"vstask close runnning task",
				},
			},
		},
		-- s1n7ax/nvim-window-picker
		p = {
			name = "pick",
			w = {
				function()
					local window_number = require("window-picker").pick_window()
					if window_number then
						vim.api.nvim_set_current_win(window_number)
					end
				end,
				"pick window",
			},
		},
		-- toppair/peek.nvim
		m = {
			name = "markdown/messages",
			o = { "<cmd>lua require('peek').open() <cr>", "peek open markdown preview" },
			c = { "<cmd>lua require('peek).close() <cr>", "peek close markdown preview" },
			-- folke/noice.nvim
			m = { "<cmd>Noice history <cr>", "noice messages show" },
			-- sindrets/winshift.nvim
			w = {
				"<cmd>WinShift <cr>",
				"winshift move",
				-- mode = { "n", "t" },
			},
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
			a = {
				"<cmd>WindowsMaximize <cr>",
				"windows max",
				-- mode = { "n", "t" },
			},
			h = {
				"<cmd>WindowsMaximizeHorizontally <cr>",
				"windows max horizontally",
				-- mode = { "n", "t" },
			},
			v = {
				"<cmd>WindowsMaximizeVertically <cr>",
				"windows max vertically",
				-- mode = { "n", "t" },
			},
			e = {
				"<cmd>WindowsEqualize <cr>",
				"windows equalize",
				-- mode = { "n", "t" },
			},
			t = {
				"<cmd>WindowsToggleAutowidth <cr>",
				"windows toggle auto width",
				-- mode = { "n", "t" },
			},
		},
		-- kdheepak/lazygit.nvim
		g = {
			name = "git",
			-- c = {
			-- 	"<cmd>lua require('neogit').open({'commit', kind='tab'}) <cr>",
			-- 	-- "<cmd>lua require('neogit').action('commit', 'commit', {}) <cr>",
			-- 	"git open commit",
			-- },
			-- l = {
			-- 	"<cmd>Neogit log <cr>",
			-- 	"git log",
			-- },
			g = {
				"<cmd>LazyGit <cr>",
				"lazygit open",
			},
			f = {
				"<cmd>lua require('telescope').extensions.lazygit.lazygit() <cr>",
				"telescope find git repo",
			},
			-- d = {
			--     "<cmd>DiffviewToggleFiles <cr>",
			--     "diff toggle file",
			-- },
			h = {
				"<cmd>DiffviewFileHistory <cr>",
				"diff file history",
			},
		},
	},
	-- ussenegger/nvim-dap
	["<F5>"] = {
		function()
			require("telescope").extensions.dap.configurations({})
		end,
		"telescope dap configurations",
	},
	["<F10>"] = {
		function()
			require("dap").step_over()
		end,
		"dap step over",
	},
	["<F11>"] = {
		function()
			require("dap").step_into()
		end,
		"dap step into",
	},
	["<F12>"] = {
		function()
			require("dap").step_out()
		end,
		"dap step out",
	},
})

-- other
wk.register({
	-- mrjones2014/smart-splits.nvim
	["<C-Up>"] = {
		-- "<cmd>resize -2<CR>",
		"<cmd>lua require('smart-splits').resize_up() <cr>",
		"Resize window",
		-- mode = { "n" },
		mode = { "n", "t" },
	},
	["<C-Down>"] = {
		-- "<cmd>resize +2<CR>",
		"<cmd>lua require('smart-splits').resize_down() <cr>",
		"Resize window",
		-- mode = { "n" },
		mode = { "n", "t" },
	},
	["<C-Left>"] = {
		-- "<cmd>vertical resize -2<CR>",
		"<cmd>lua require('smart-splits').resize_left() <cr>",
		"Resize window",
		-- mode = { "n" },
		mode = { "n", "t" },
	},
	["<C-Right>"] = {
		-- "<cmd>vertical resize +2<CR>",
		"<cmd>lua require('smart-splits').resize_right() <cr>",
		"Resize window",
		-- mode = { "n" },
		mode = { "n", "t" },
	},
	-- numToStr/Comment.nvim
	["<C-_>"] = "make this line to comments",
	-- akinsho/toggleterm.nvim
	["<C-\\>"] = {
		"<cmd> ToggleTerm<CR>",
		"toggle term",
		mode = { "n", "t" },
	},
	-- folke/flash.nvim
	["<C-s>"] = {
		function()
			require("flash").toggle()
		end,
		"toggle flash search",
		mode = { "c" },
	},
	-- neovim/nvim-lspconfig hrsh7th/nvim-cmp
	["<c-k>"] = "Signature Documentation/cmp previous",
	-- hrsh7th/nvim-cmp
	["<c-j>"] = "cmp next",
	["<c-Space>"] = "cmp commplete",
	["<c-e>"] = "cmp abort",
	-- ahmedkhalf/project.nvim
	["<c-f>"] = "project find files",
	["<c-b>"] = "project browse files",
	["<c-d>"] = "project delete",
	["<c-s>"] = "project search in files",
	["<c-r>"] = "project recent files",
	["<c-w>"] = "project change working directory",
})

wk.register({
	["<A-h>"] = {
		"<C-w>h",
		"move to left window",
		mode = { "n" },
	},
	["<A-j>"] = {
		"<C-w>j",
		"move to down window",
		mode = { "n" },
	},
	["<A-k>"] = {
		"<C-w>k",
		"move to up window",
		mode = { "n" },
	},
	["<A-l>"] = {
		"<C-w>l",
		"move to right window",
		mode = { "n" },
	},
})
-- akinsho/toggleterm.nvim
wk.register({
	["<A-h>"] = {
		"<cmd>wincmd h<cr>",
		"move to left window",
		mode = { "t" },
	},
	["<A-j>"] = {
		"<cmd>wincmd j<cr>",
		"move to down window",
		mode = { "t" },
	},
	["<A-k>"] = {
		"<cmd>wincmd k<cr>",
		"move to up window",
		mode = { "t" },
	},
	["<A-l>"] = {
		"<cmd>wincmd l<cr>",
		"move to right window",
		mode = { "t" },
	},
})

wk.register({
	-- stevearc/conform.nvim
	["<C-A-l>"] = {
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
		"format file or range",
		mode = { "n", "v" },
	},
	-- danymat/neogen
	["<C-A-g>"] = {
		"<cmd>lua require('neogen').generate() <cr>",
		"generate docs",
		mode = { "n", "i" },
	},
})

-- folke/todo-comments.nvim
wk.register({
	["[t"] = {
		function()
			require("todo-comments").jump_next()
		end,
		"Next todo comment",
		name = "next",
	},
	["]t"] = {
		function()
			require("todo-comments").jump_prev()
		end,
		"Previous todo comment",
		name = "previous",
	},
})
