local M = {}
local W = require("utils.windows_ignore")

-- stevearc/conform.nvim
M.config_conform = function()
	local conform = require("conform")
	conform.setup({
		formatters_by_ft = {
			sh = { "beautysh" }, -- { "shfmt" },
			zsh = { "beautysh" }, -- { "shfmt" },
			c = { "clang_format" },
			cpp = { "clang_format" },
			objc = { "clang_format" },
			objcpp = { "clang_format" },
			cuda = { "clang_format" },
			proto = { "clang_format" },
			cmake = { "cmake_format" },
			html = { "prettier" },
			json = { "prettier" },
			xml = { "xmlformatter" },
			xsd = { "xmlformatter" },
			xsl = { "xmlformatter" },
			xslt = { "xmlformatter" },
			svg = { "xmlformatter" },
			bib = { "latexindent" },
			gitcommit = { "latexindent" },
			markdown = {},
			org = { "latexindent" },
			plaintex = { "latexindent" },
			rnoweb = { "latexindent" },
			tex = { "latexindent" },
			pandoc = { "latexindent" },
			quarto = { "latexindent" },
			rmd = { "latexindent" },
			rst = { "latexindent" },
			lua = { "stylua" },
			python = { "autopep8" },
			yaml = { "prettier" },

			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			svelte = { "prettier" },
			css = { "prettier" },
			graphql = { "prettier" },
		},
		-- format_on_save = {
		--     lsp_fallback = true,
		--     async = false,
		--     timeout_ms = 1000
		-- }
	})
end

-- mfussenegger/nvim-lint
M.config_lint = function()
	local lint = require("lint")

	lint.linters_by_ft = {
		sh = { "shellcheck" },
		c = { "clangtidy" },
		cpp = { "clangtidy" },
		objc = { "clangtidy" },
		objcpp = { "clangtidy" },
		cuda = { "clangtidy" },
		proto = { "clangtidy" },
		cmake = { "cmakelint" },
		dockerfile = { "hadolint" },
		html = { "htmlhint" },
		json = { "jsonlint" },
		bib = {},
		gitcommit = {},
		markdown = {}, -- "write_good"
		org = {},
		plaintex = {},
		rnoweb = {},
		tex = {},
		pandoc = {},
		quarto = {},
		rmd = {},
		rst = {},
		lua = W.windows_ignore_dict({ "luacheck" }),
		python = { "flake8" },
		-- yaml = { "yamllint" },
	}

	local function find_compile_commands()
		local current_dir = vim.fn.getcwd()
		local home_dir = os.getenv("HOME") -- vim.fn.expand("~")
		local file_names = { "compile_commands.json", "build/compile_commands.json" }
		local max_levels = 2
		local level = 0
		while current_dir ~= home_dir and level < max_levels do
			for _, file_name in ipairs(file_names) do
				local file_path = current_dir .. "/" .. file_name
				if vim.fn.filereadable(file_path) == 1 then
					return file_path
				end
			end
			current_dir = vim.fn.fnamemodify(current_dir, ":h")
			level = level + 1
		end
		return nil
	end
	local compile_commands_path = find_compile_commands()
	if compile_commands_path then
		local clangtidy = require("lint.linters.clangtidy")
		print("clang-tidy: found compile_commands.json at: " .. compile_commands_path)
		clangtidy.args = { "-p", compile_commands_path }
	end

	require("lint.linters.flake8").args = { "--config=~/.flake8" }

	local lint_augroup = vim.api.nvim_create_augroup("lint", {
		clear = true,
	})
	vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
		group = lint_augroup,
		callback = function()
			lint.try_lint()
		end,
	})

	local wk = require("which-key")
	wk.add({
		{ -- <leader> t
			-- nvim-treesitter/nvim-treesitter
			{
				"<leader>ta",
				desc = "treesitter incremental selection",
			},
			-- mfussenegger/nvim-lint
			{
				"<leader>tl",
				function()
					lint.try_lint()
				end,
				desc = "lint current file",
			},
		},
	})
end

return M
