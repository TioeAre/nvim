local M = {}

M.find_compile_commands = function()
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

return M
