-- File: ~/.config/nvim/lua/plugins/init.lua

local plugins = {}
-- ~/.config/nvim
local plugins_dir = vim.fn.fnamemodify(vim.fn.expand("<sfile>"), ":h")
local current_file_path = vim.fs.joinpath(plugins_dir, "lua", "plugins") -- plugins_dir .. "lua/plugins"

for name, file_type in vim.fs.dir(current_file_path) do
	if file_type == "file" and name:match("%.lua$") and name ~= "init.lua" then
		local module_name = "plugins." .. name:gsub("%.lua$", "")
		local ok, plugin_spec = pcall(require, module_name)
		if ok and type(plugin_spec) == "table" then
			for _, plugin in ipairs(plugin_spec) do
				table.insert(plugins, plugin)
			end
		elseif not ok then
			vim.notify("Error loading plugin spec from: " .. module_name .. "\n" .. plugin_spec, vim.log.levels.ERROR)
		end
	end
end

return plugins
