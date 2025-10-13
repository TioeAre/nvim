local M = {}

-- Helper function to check if a list contains a value
M.is_value_in_list = function(value, list)
	if not list then
		return false
	end                         -- Handle nil list case
	for _, item in ipairs(list) do -- Use ipairs for sequential lists
		if item == value then
			return true
		end
	end
	return false
end

-- echo &filetype
M.excluded_filetypes = {
	"aerial",
	"alpha",
	"buffer_manager",
	"cmp_docs",
	"cmp_menu",
	"dap-repl",
	"dashboard",
	"fidget",
	"floggraph",
	"guihua",
	"guihua_rust",
	"clap_input",
	"gundo",
	"help",
	"incline",
	"lazy",
	"lsp",
	"mason",
	"neo-tree",
	"neo-tree-popup",
	"noice",
	"notify",
	"NvimTree",
	"outline",
	"Outline",
	"sagafinder",
	"sagaoutline",
	"scrollbar",
	"spectre_panel",
	"symbols-outline",
	"SymbolsOutline",
	"TelescopePrompt",
	"toggleterm",
	"trouble",
	"Trouble",
	"undotree",
	"bigfile",
	"grug-far",
	"grug-far-history",
	"grug-far-help",
}
-- echo &buftype
M.excluded_buftypes = {
	"directory",
	"help",
	"nofile",
	"prompt",
	"quickfix",
	"scratch",
	"terminal",
	"unlisted",
}

M.exclude_dirs = {
	"**/src/**",
	"**/lua/**",
	"**/scripts/**",
	"**/build/**",
	"**/devel/**",
	os.getenv("HOME"),
	"/home/tioeare",
	"/home/linuxbrew/",
	"/home/Systemback/",
}

M.project_patterns = {
	".git",
	-- "_darcs",
	-- ".hg",
	-- ".bzr",
	-- ".svn", -- "Makefile",
	-- "package.json",
	-- "CMakeLists.txt", -- "makefile",
	-- "cmakelists.txt",
	-- "MAKEFILE",
	-- ".vscode",
	".idea", -- "venv",
	"requirements.txt",
	"devel",
	"build",
	"readme.md",
	"README",
	"README.md",
	"readme.txt",
	"README.txt",
	"main.*",
	".gitignore",
	".history",
}

-- M.function = function (buf)
-- local fn = vim.fn
--     local utils = require("auto-save.utils.data")

--     -- don't save for `sql` file types
--     -- if utils.not_in(fn.getbufvar(buf, "&filetype"), {'sql'}) then

--     --   return true
--     -- end
--     -- return false
-- end

-- M.condition = function(buf)
-- 	local fn = vim.fn

-- 	-- don't save for special-buffers
-- 	if fn.getbufvar(buf, "&buftype") ~= "" then
-- 		return false
-- 	end
-- 	return true
-- end

return M
