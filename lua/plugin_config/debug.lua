local M = {}

-- mfussenegger/nvim-dap
M.config_dap = function()
    -- require("dap").setup()
    require("nvim-dap-virtual-text").setup()
    require("dapui").setup()
    require("dap.ext.vscode").json_decode = require("json5").parse

    require("persistent-breakpoints").setup({
        save_dir = vim.fn.stdpath("data") .. "/nvim_checkpoints",
        nest_if_no_args = true,
        window = {
            open = "alternate",
        },
        load_breakpoints_event = "BufReadPost",
        perf_record = false,
        on_load_breakpoint = nil,
    })
    -- nvim-telescope/telescope.nvim
    require("telescope").load_extension("dap")
    require("neodev").setup({
        library = {
            plugins = { "nvim-dap-ui" },
            types = true,
        },
    })
    require("mason-nvim-dap").setup({
        ensure_installed = { "bash-debug-adapter", "cpptools", "debugpy", "mockdebug" },
    })
end

return M
