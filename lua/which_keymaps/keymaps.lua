local wk = require("which-key")
local conform = require("conform")
local lint = require("lint")

wk.register({
    -- echasnovski/mini.surround
    ["\\"] = "mini.surround",
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
        s = {
            mode = "v",
            name = "search",
            w = {
                "<esc><cmd>lua require('spectre').open_visual()<CR>",
                "search current word",
            },
        },
    },
})
wk.register({
    ["<leader>"] = {
        -- overall
        s = {
            mode = "n",
            name = "split/search|replace/sessions/switch trouble filter",
            v = { "<C-w>v", "split windows v (trouble)" },
            h = { "<C-w>s", "split windows h (trouble)" },
            -- olimorris/persisted.nvim
            q = { "<cmd>SessionStop<cr>", "stop session" },
            p = { "<cmd>SessionSave<cr>", "save session" },
            d = { "<cmd>SessionDelete<cr>", "delete session" },
            -- folke/trouble.nvim
            s = "switch trouble severity filter",
            -- nvim-pack/nvim-spectre
            o = {
                "<cmd>lua require('spectre').toggle()<CR>",
                "search open spectre",
            },
            w = {
                "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
                "search current word",
            },
            c = {
                "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>",
                "search current file",
            },
            l = {
                "<cmd>lua require('spectre').resume_last_search()<CR>",
                "search last",
            },
        },
        n = {
            mode = "n",
            name = "no highlight",
            h = { "<cmd>nohl<cr>", "no highlight" },
        },
        w = {
            mode = "n",
            name = "save/lsp worksapce",
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
            name = "list trouble/todo/toggle lsp_lens",
            -- folke/trouble.nvim
            d = { "<cmd>TroubleToggle document_diagnostics<cr>", "open trouble document_diagnostics" },
            w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "open trouble workspace_diagnostics" },
            r = { "<cmd>TroubleToggle lsp_references<cr>", "open trouble lsp_references" },
            s = { "<cmd>TroubleToggle lsp_definitions<cr>", "open trouble lsp_definitions" },
            q = { "<cmd>TroubleToggle quickfix<cr>", "open trouble quickfix" },
            l = { "<cmd>TroubleToggle loclist<cr>", "open trouble loclist" },
            -- folke/todo-comments.nvim
            t = { "<cmd>TodoTrouble<cr>", "open trouble todo" },
            -- ~whynothugo/lsp_lines.nvim
            m = { "<cmd>lua require('lsp_lines').toggle()<cr>", "toggle lsp_lens" },
        },
        f = {
            name = "find telescope/todo/undo/buffer/project/dap configurations/lsp",
            -- folke/todo-comments.nvim
            t = { "<cmd>TodoTelescope<cr>", "telescope todo" },
            -- nvim-telescope/telescope.nvim
            f = { "<cmd>Telescope find_files<cr>", "telescope files" },
            s = { "<cmd>Telescope grep_string<cr>", "telescope grep string" },
            g = { "<cmd>Telescope live_grep<cr>", "telescope live grep string" },
            r = { "<cmd>Telescope resume<cr>", "telescope resume last search window" },
            b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "telescope find buffers" },
            p = {
                name = "project/persisted",
                p = {
                    "<cmd>lua require'telescope'.extensions.projects.projects{} <cr>",
                    "telescope find projects",
                },
                -- olimorris/persisted.nvim
                s = {
                    "<cmd>Telescope persisted<cr>",
                    "telescope find persisted sessions",
                },
            },
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
            },
            l = {
                "lsp find def+ref+imp",
            },
            o = {
                "<cmd>Telescope oldfiles<cr>",
                "telescope find recent files",
            },
            h = {
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
                "telescope find highlights",
            },
        },
        h = {
            name = "history memento",
            -- gaborvecsei/memento.nvim
            b = { "<cmd>lua require('memento').toggle()<cr>", "toggle memento buffer history" },
            c = { "<cmd>lua require('memento').clear_history()<cr>", "clear memento history" },
        },
        o = {
            name = "open layout/outline/gitgraph/session",
            -- olimorris/persisted.nvim
            p = { "<cmd>SessionLoad<cr>", "current dir session layout" },
            l = { "<cmd>SessionLoadLast<cr>", "last session layout" },
            i = "PyrightOrganizeImports",

            -- simrat39/symbols-outline.nvim
            -- o = { "<cmd>SymbolsOutline <cr>", "open symbols outline" },
            -- -- stevearc/aerial.nvim
            -- o = {"<cmd>AerialToggle!<cr>", "open aerial symbols outline"},

            -- "hedyhli/outline.nvim"
            o = { "<cmd>Outline <cr>", "open symbols outline" },

            -- nvim-neo-tree/neo-tree.nvim
            -- t = { "<cmd>Neotree document_symbols <cr>", "open neotree outline"},
            -- rbong/vim-flog
            g = { "<cmd>Flog<cr>", "open git graph g? for keymap gq to quit" },
            s = {
                name = "symbols",
                d = "open treesitter document_symbols",
                w = "open treesitter workspace_symbols",
                l = "open lsp document_symbols",
                g = "find lsp workspace_symbols",
            },
            c = {
                name = "cclshierarchy callings",
                t = {
                    "<cmd>Calltree<cr>",
                    "calltrees",
                },
                i = "incoming_calls",
                o = "outgoing_calls",
            },
        },
        t = {
            name = "tree/trigger linting/treesitter selection/show path of current buffer",
            n = { ":echo expand('%:p') <cr>", "show the path of current buffer" },
            y = {
                function()
                    local current_buffer_path = vim.fn.expand("%:p")
                    vim.fn.setreg('"', current_buffer_path)
                    print("copied path to clipboard: " .. current_buffer_path)
                end,
                "yank current buffer path",
            },
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
            name = "bufferline switch/dap breakpoint/buffer manager",
            -- akinsho/bufferline.nvim
            n = { "<cmd>BufferLineCycleNext<cr>", "switch to next buffer" },
            m = { "<cmd>BufferLineCyclePrev<cr>", "switch to previous buffer" },
            g = { "<cmd>BufferLinePick<cr>", "switch to certain buffer" },
            d = { "<cmd>BufferLinePickClose<cr>", "close certain buffer" },
            c = { "<cmd>bd<cr>", "close current buffer" },
            p = { "<cmd>BufferLineTogglePin<cr>", "pin buffer" },
            j = { "<cmd>BufferLineMovePrev<cr>", "buffer move previous" },
            k = { "<cmd>BufferLineMoveNext<cr>", "buffer move next" },
            -- mfussenegger/nvim-dap
            b = {
                function()
                    require("dap").toggle_breakpoint()
                end,
                "dap toggle breakpoint",
            },
            a = {
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
            -- j-morano/buffer_manager.nvim
            f = {
                "<cmd>lua require('buffer_manager.ui').toggle_quick_menu()<cr>",
                "buffer manager toggle",
            },
        },
        c = {
            -- akinsho/bufferline.nvim
            name = "close bufferline|window/code action/create docs",
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
            -- danymat/neogen
            g = {
                "<cmd>Neogen <cr>",
                "neogen generate docs",
                mode = { "n" },
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
        D = "type_definition_preview",
        r = {
            name = "rename/remove/ros/run cmake|task/restart lsp",
            l = { "<cmd>LspRestart <cr>", "restart lsp service" },
            n = "lsp smart rename",
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
            m = { "<cmd>lua require('ros-nvim.build').catkin_make()<cr>", "ros catkin_make" },
            k = { "<cmd>lua require('ros-nvim.build').catkin_make_pkg()<cr>", "ros catkin_make_pkg" },
            t = { "<cmd>lua require('ros-nvim.test').rostest()<cr>", "ros exec test" },

            -- taDachs/ros-nvim
            -- p = {
            -- 	name = "ros pick",
            -- 	t = { "<cmd>Telescope ros ros<cr>", "ros pick telescope" },
            -- 	l = {
            -- 		function()
            -- 			require("ros-nvim.ros").open_launch_include()
            -- 		end,
            -- 		"ros open launch links",
            -- 	},
            -- 	d = {
            -- 		function()
            -- 			require("ros-nvim.ros").show_interface_definition()
            -- 		end,
            -- 		"ros show messages/services definitions",
            -- 	},
            -- },

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
                s = {
                    name = "cmake select",
                    t = { "<cmd>CMakeSelectBuildType <cr>", "cmake select build type" },
                    l = { "<cmd>CMakeSelectLaunchTarget <cr>", "cmake select launch target" },
                    a = { "<cmd>CMakeSelectBuildTarget <cr>", "cmake select build target" },
                    k = { "<cmd>CMakeSelectKit <cr>", "cmake select kit" },
                    c = { "<cmd>CMakeSelectCwd <cr>", "cmake select main CMakeLists.txt" },
                    b = { "<cmd>CMakeSelectBuildDir <cr>", "cmake select dir build" },
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
            name = "pick window/project add/preview makrdown/peek lsp",
            p = {
                function()
                    local window_number = require("window-picker").pick_window()
                    if window_number then
                        vim.api.nvim_set_current_win(window_number)
                    end
                end,
                "pick window",
            },
            s = {
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
                "show pick window",
            },
            -- ahmedkhalf/project.nvim
            a = {
                "<cmd>lua require('project_nvim.project').add_project_manually()<cr>",
                "project add",
            },
            -- ellisonleao/glow.nvim
            m = {
                "<cmd>Glow<cr>",
                "markdown Glow preview",
            },
            f = "treesitter peek function start",
            F = "treesitter peek class start",
        },
        -- toppair/peek.nvim
        m = {
            name = "markdown/messages/swap shift window",
            o = { "<cmd>lua require('peek').open() <cr>", "peek open markdown preview" },
            c = { "<cmd>lua require('peek).close() <cr>", "peek close markdown preview" },
            -- folke/noice.nvim
            m = { "<cmd>message <cr>", "messages show" },
            n = { "<cmd>Noice telescope <cr>", "noice messages telescope" },
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
                -- "<cmd>LazyGitCurrentFile<cr>",
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
                "lazygit toggle",
            },
            -- f = {
            -- 	"<cmd>lua require('telescope').extensions.lazygit.lazygit() <cr>",
            -- 	"telescope find git repo",
            -- },
            -- d = {
            --     "<cmd>DiffviewToggleFiles <cr>",
            --     "diff toggle file",
            -- },
            h = {
                "<cmd>DiffviewFileHistory <cr>",
                "diff file history",
            },
        },
        v = {
            name = "venv",
            p = {
                "<cmd>lua require('swenv.api').pick_venv()<cr>",
                "python swenv venv pick",
            }
        }
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
local term = vim.fn.getenv("TERM")

if term == "screen-256color" then
    wk.register({
        -- aserowy/tmux.nvim
        ["<C-Up>"] = {
            "<cmd>lua require('tmux').resize_top()<cr>",
            "Resize window",
            -- mode = { "n" },
            mode = { "n", "t" },
        },
        ["<C-Down>"] = {
            "<cmd>lua require('tmux').resize_bottom()<cr>",
            "Resize window",
            -- mode = { "n" },
            mode = { "n", "t" },
        },
        ["<C-Left>"] = {
            "<cmd>lua require('tmux').resize_left()<cr>",
            "Resize window",
            -- mode = { "n" },
            mode = { "n", "t" },
        },
        ["<C-Right>"] = {
            "<cmd>lua require('tmux').resize_right()<cr>",
            "Resize window",
            -- mode = { "n" },
            mode = { "n", "t" },
        },
    })
else
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
    })
end
if term == "screen-256color" then
    wk.register({
        -- aserowy/tmux.nvim
        ["<A-h>"] = {
            -- "<C-w>h",
            "<cmd>lua require('tmux').move_left()<cr>",
            "move to left window",
            mode = { "n", "t" },
        },
        ["<A-j>"] = {
            -- "<C-w>j",
            "<cmd>lua require('tmux').move_bottom()<cr>",
            "move to down window",
            mode = { "n", "t" },
        },
        ["<A-k>"] = {
            -- "<C-w>k",
            "<cmd>lua require('tmux').move_top()<cr>",
            "move to up window",
            mode = { "n", "t" },
        },
        ["<A-l>"] = {
            -- "<C-w>l",
            "<cmd>lua require('tmux').move_right()<cr>",
            "move to right window",
            mode = { "n", "t" },
        },
    })
elseif term == "xterm-256color" then
    wk.register({
        -- knubie/vim-kitty-navigator
        ["<A-h>"] = {
            -- "<C-w>h",
            "<cmd>KittyNavigateLeft<cr>",
            "move to left window",
            mode = { "n", "t" },
        },
        ["<A-j>"] = {
            -- "<C-w>j",
            "<cmd>KittyNavigateDown<cr>",
            "move to down window",
            mode = { "n", "t" },
        },
        ["<A-k>"] = {
            -- "<C-w>k",
            "<cmd>KittyNavigateUp<cr>",
            "move to up window",
            mode = { "n", "t" },
        },
        ["<A-l>"] = {
            -- "<C-w>l",
            "<cmd>KittyNavigateRight<cr>",
            "move to right window",
            mode = { "n", "t" },
        },
    })
else
    wk.register({
        ["<A-h>"] = {
            "<C-w>h",
            "move to left window",
            mode = { "n", "t" },
        },
        ["<A-j>"] = {
            "<C-w>j",
            "move to down window",
            mode = { "n", "t" },
        },
        ["<A-k>"] = {
            "<C-w>k",
            "move to up window",
            mode = { "n", "t" },
        },
        ["<A-l>"] = {
            "<C-w>l",
            "move to right window",
            mode = { "n", "t" },
        },
    })
end

wk.register({
    -- numToStr/Comment.nvim
    ["<C-_>"] = "make this line to comments",
    -- akinsho/toggleterm.nvim
    ["<C-\\>"] = {
        "<cmd> ToggleTerm<CR>",
        "toggle term",
        mode = { "n", "t" },
    },
    -- folke/flash.nvim
    ["<A-s>"] = {
        function()
            require("flash").toggle()
        end,
        "toggle flash search",
        mode = { "c" },
    },
    -- neovim/nvim-lspconfig hrsh7th/nvim-cmp
    ["<c-h>"] = "lsp peek definition",
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
        "<cmd>Neogen <cr>",
        "neogen generate docs",
        mode = { "n", "i" },
    },
    ["<C-A-n>"] = {
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
        "open current file in new tab/window(kitty/tmux)",
    },
})

-- folke/todo-comments.nvim
wk.register({
    ["]t"] = {
        function()
            require("todo-comments").jump_next()
        end,
        "Next todo comment",
        name = "next",
    },
    ["[t"] = {
        function()
            require("todo-comments").jump_prev()
        end,
        "Previous todo comment",
        name = "previous",
    },
    -- nvim-treesitter/nvim-treesitter-textobjects
    ["]m"] = "treesitter goto next start @function.outer",
    ["]M"] = "treesitter goto next end @function.outer",
    ["[m"] = "treesitter goto prev start @function.outer",
    ["[M"] = "treesitter goto prev end @function.outer",

    ["]o"] = "treesitter goto next start @loop.inner",
    ["]O"] = "treesitter goto next end @loop.inner",
    ["[o"] = "treesitter goto prev start @loop.inner",
    ["[O"] = "treesitter goto prev end @loop.inner",

    -- ["]s"] = "treesitter goto next start @scope",
    -- ["]S"] = "treesitter goto next end @scope",
    -- ["[s"] = "treesitter goto prev start @scope",
    -- ["[S"] = "treesitter goto prev end @scope",

    ["]z"] = "treesitter goto next start @fold",
    ["]Z"] = "treesitter goto next end @fold",
    ["[z"] = "treesitter goto prev start @fold",
    ["[Z"] = "treesitter goto prev end @fold",

    ["]]"] = "treesitter goto next start @class.outer",
    ["]["] = "treesitter goto next end @class.outer",
    ["[["] = "treesitter goto prev start @class.outer",
    ["[]"] = "treesitter goto prev end @class.outer",

    ["]d"] = "treesitter goto next @conditional.outer",
    ["[d"] = "treesitter goto prev @conditional.outer",
})

-- nvim-treesitter/nvim-treesitter-textobjects
wk.register({
    mode = "v",
    a = {
        name = "treesitter @function.outer",
        f = "select @function.outer",
        c = "select @class.outer",
        s = "select @scope",
    },
    i = {
        name = "treesitter @function.inner",
        f = "select @function.inner",
        c = "select @class.inner",
    },
    -- nvim-pack/nvim-spectre
    s = {
        w = {
            "<esc><cmd>lua require('spectre').open_visual()<CR>",
            "search current word",
        },
    },
})
