local M = {}

-- mfussenegger/nvim-dap
M.config_dap = function()
    local dap, dapui = require("dap"), require("dapui")
    require("nvim-dap-virtual-text").setup()
    require("dapui").setup()
    require("dap.ext.vscode").json_decode = require("json5").parse

    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end

    -- adapters config
    -- c/cpp
    dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
    }
    dap.configurations.c = dap.configurations.cpp
    -- python
    require("dap-python").setup("./venv/bin/python")
    dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
    }
    -- bash
    dap.adapters.bashdb = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
        name = "bashdb",
    }

    require("dap.ext.vscode").load_launchjs() -- (".vscode/launch.json")
    vim.fn.sign_define("DapBreakpoint", {
        text = "🛑",
        texthl = "",
        linehl = "",
        numhl = "",
    })
    vim.fn.sign_define("DapBreakpointCondition", {
        text = "🔵",
        texthl = "",
        linehl = "",
        numhl = "",
    })
    vim.fn.sign_define("DapLogPoint", {
        text = "📜",
        texthl = "",
        linehl = "",
        numhl = "",
    })
    vim.fn.sign_define("DapStopped", {
        text = "⏩",
        texthl = "",
        linehl = "",
        numhl = "",
    })
    -- -- dap.configurations.cpp = {
    -- -- 	{
    -- -- 		name = "Launch file",
    -- -- 		type = "cppdbg",
    -- -- 		request = "launch",
    -- -- 		program = function()
    -- -- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    -- -- 		end,
    -- -- 		cwd = "${workspaceFolder}",
    -- -- 		stopAtEntry = true,
    -- -- 	},
    -- -- 	{
    -- -- 		name = "Attach to gdbserver :1234",
    -- -- 		type = "cppdbg",
    -- -- 		request = "launch",
    -- -- 		MIMode = "gdb",
    -- -- 		miDebuggerServerAddress = "localhost:1234",
    -- -- 		miDebuggerPath = "/usr/bin/gdb",
    -- -- 		cwd = "${workspaceFolder}",
    -- -- 		program = function()
    -- -- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    -- -- 		end,
    -- -- 	},
    -- -- }
    require("persistent-breakpoints").setup({
        save_dir = vim.fn.stdpath("data") .. "/nvim_checkpoints",
        -- when to load the breakpoints? "BufReadPost" is recommanded.
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
