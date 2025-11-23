local M = {}
local format_utils = require("utils.format")
local format_vars = require("variables.format")

-- stevearc/conform.nvim
M.config_conform = function()
	local conform = require("conform")
	conform.setup({
		formatters_by_ft = format_vars.formatters_by_ft,
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

	lint.linters_by_ft = format_vars.linters_by_ft
	local compile_commands_path = format_utils.find_compile_commands()
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
end

return M
