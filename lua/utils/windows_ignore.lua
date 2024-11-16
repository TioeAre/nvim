local M = {}

local is_windows = package.config:sub(1, 1) == "\\"

function M.windows_ignore_list(...)
	local args = { ... }
	if is_windows then
		-- print("Ignoring plugin on windows: ", args[1])
		return nil
	else
		return args
	end
end

function M.windows_ignore_dict(dict1)
	if is_windows then
		-- print("Ignoring plugin on windows: ", args[1])
		return nil
	else
		return dict1
	end
end

function M.windows_selectNO2home(path1, path2)
	if is_windows then
		return os.getenv("LOCALAPPDATA") .. path2
	else
		return os.getenv("HOME") .. path1
	end
end

function M.windows_selectNO2string(path1, path2)
	if is_windows then
		return path2
	else
		return path1
	end
end

return M
