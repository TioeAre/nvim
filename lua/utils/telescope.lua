local M = {}

M.select_window_split = function(prompt_bufnr, split_type)
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local entry = action_state.get_selected_entry()
	local filename_with_position = entry.value
	local filename, lnum, col = filename_with_position:match("([^:]+):?(%d*):?(%d*):?.*")
	if filename and vim.fn.filereadable(filename) == 1 then
		lnum = tonumber(lnum) or 1
		col = tonumber(col) or 0
		actions.close(prompt_bufnr)
		local picked_window_id = require("window-picker").pick_window()
		if picked_window_id then
			vim.api.nvim_set_current_win(picked_window_id)
			local cmd = split_type == "vsplit" and "vsplit" or "split"
			vim.cmd(cmd)
			vim.cmd("edit " .. filename)
			if lnum and col then
				vim.api.nvim_win_set_cursor(0, { lnum, col })
			end
		end
	end
end

M.select_window = function(prompt_bufnr)
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local entry = action_state.get_selected_entry()
	local filename_with_position = entry.value
	local filename, lnum, col = filename_with_position:match("([^:]+):?(%d*):?(%d*):?.*")
	if filename and vim.fn.filereadable(filename) == 1 then
		lnum = tonumber(lnum) or 1
		col = tonumber(col) or 0
		actions.close(prompt_bufnr)
		local picked_window_id = require("window-picker").pick_window()
		if picked_window_id then
			local bufnr = vim.fn.bufadd(filename)
			vim.api.nvim_win_set_buf(picked_window_id, bufnr)
			if lnum and col then
				vim.api.nvim_win_set_cursor(0, { lnum, col })
			end
		end
	end
end

return M
