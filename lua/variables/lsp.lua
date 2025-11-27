local M = {}

M.clangd_root_files = {
	"build/compile_commands.json",
	"compile_commands.json",
	".clangd",
	".clang-tidy",
	".clang-format", -- "build",
	"compile_flags.txt",
	"configure.ac", -- AutoTools
	-- "CMakeLists.txt",
	-- "Makefile",
	-- ".catkin_workspace",
	-- "devel",
	-- ".vscode",
}

M.cmake_root_files = {
	"build/compile_commands.json",
	"compile_commands.json",
	"src/CMakeLists.txt",
	"devel",
	"build",
	"CMakeLists.txt", -- ".vscode",
}

local util = vim.lsp.config.util
M.user_lspconfig_servers = {
	clangd = {
		root_dir = function(fname)
			return util.root_pattern(unpack(M.clangd_root_files))(fname) -- or util.find_git_ancestor(fname)
		end,
		cmd = {
			"clangd",
			"--compile-commands-dir=./build",
		},
	},
	neocmake = {
		default_config = {
			cmd = { "neocmakelsp", "--stdio" },
			filetypes = { "cmake" },
			root_dir = function(fname)
				return util.root_pattern(unpack(M.cmake_root_files))(fname) or util.find_git_ancestor(fname)
				-- return vim.lsp.config.util.find_git_ancestor(fname)
			end,
			single_file_support = true, -- suggested
			init_options = {
				format = {
					enable = false,
				},
				scan_cmake_in_package = true, -- default is true
			},
		},
	},
	docker_compose_language_service = {},
	lemminx = {},
	bashls = {},
	pyright = {},
	lua_ls = {
		settings = {
			Lua = {
				telemetry = { enable = false },
				-- make the language server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	},
	dockerls = {},
	html = {},
	jsonls = {},
	yamlls = {},
}

M.navigator_servers = {
	bashls = {},
	dockerls = {},
	pyright = {},
	lua_ls = {
		settings = {
			Lua = {
				telemetry = { enable = false },
				-- make the language server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	},
	html = {},
	jsonls = {},
	yamlls = {},

	clangd = {
		root_dir = function(fname)
			return util.root_pattern(unpack(M.clangd_root_files))(fname) -- or util.find_git_ancestor(fname)
		end,
		cmd = {
			"clangd",
			"--compile-commands-dir=./build",
		},
	},
	neocmake = {
		default_config = {
			cmd = { "neocmakelsp", "--stdio" },
			filetypes = { "cmake" },
			root_dir = function(fname)
				return util.root_pattern(unpack(M.cmake_root_files))(fname) or util.find_git_ancestor(fname)
				-- return vim.lsp.config.util.find_git_ancestor(fname)
			end,
			single_file_support = true, -- suggested
			init_options = {
				format = {
					enable = false,
				},
				scan_cmake_in_package = true, -- default is true
			},
		},
	},
	docker_compose_language_service = {},
	lemminx = {},
}

M.diagnostic_signs = {
	Error = " ",
	Warn = " ",
	Hint = "❃",
	Info = "",
}

return M
