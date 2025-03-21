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

    -- local function close_nvim_ide_panels()
    --     if pcall(require, 'ide') then
    --         local ws = require('ide.workspaces.workspace_registry').get_workspace(vim.api.nvim_get_current_tabpage())
    --         if ws ~= nil then
    --             ws.close_panel(require('ide.panels.panel').PANEL_POS_BOTTOM)
    --             ws.close_panel(require('ide.panels.panel').PANEL_POS_LEFT)
    --             ws.close_panel(require('ide.panels.panel').PANEL_POS_RIGHT)
    --         end
    --     end
    -- end
    -- dap.listeners.after.event_initialized["dapui_config"] = function()
    --     dapui.open()
    --     close_nvim_ide_panels()
    -- end
    -- dap.listeners.before.event_terminated["dapui_config"] = function()
    --     dapui.close()
    -- end
    -- dap.listeners.before.event_exited["dapui_config"] = function()
    --     dapui.close()
    -- end

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
        -- record the performance of different function. run :lua require('persistent-breakpoints.api').print_perf_data() to see the result.
        perf_record = false,
        -- perform callback when loading a persisted breakpoint
        --- param opts DAPBreakpointOptions options used to create the breakpoint ({condition, logMessage, hitCondition})
        --- param buf_id integer the buffer the breakpoint was set on
        --- param line integer the line the breakpoint was set on

        on_load_breakpoint = nil,
    })
    -- nvim-telescope/telescope.nvim
    require("telescope").load_extension("dap")
end

return M
