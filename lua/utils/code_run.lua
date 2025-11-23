local M = {}

M.has_cmake_files = function()
    local current_dir = vim.fn.getcwd()
    local has_cmake_file = vim.fn.findfile("CMakeLists.txt", current_dir) ~= ""
    local has_cmakelists_file = vim.fn.findfile("cmakelists.txt", current_dir) ~= ""
    return has_cmake_file or has_cmakelists_file
end

local scratch = {
    name = "*cmake-tools*",
    buffer = nil,
}

M.scratch_create = function(executor, runner)
    if M.has_cmake_files() then
        scratch.buffer = vim.api.nvim_create_buf(true, true) -- can be search, and is a scratch buffer
        vim.api.nvim_buf_set_name(scratch.buffer, scratch.name)
        vim.api.nvim_buf_set_lines(scratch.buffer, 0, 0, false, {
            "THIS IS A SCRATCH BUFFER FOR cmake-tools.nvim, YOU CAN SEE WHICH COMMAND THIS PLUGIN EXECUTES HERE.",
            "EXECUTOR: " .. executor .. " RUNNER: " .. runner,
        })
    end
end

M.scratch_append = function(cmd)
    if M.has_cmake_files() then
        vim.api.nvim_buf_set_lines(scratch.buffer, -1, -1, false, { cmd })
    end
end

return M
