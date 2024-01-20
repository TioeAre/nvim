local M = {}

-- stevearc/conform.nvim
M.config_conform = function()
    local conform = require("conform")
    conform.setup({
        formatters_by_ft = {
            sh = { "shfmt" },
            c = { "clang_format" },
            cpp = { "clang_format" },
            objc = { "clang_format" },
            objcpp = { "clang_format" },
            cuda = { "clang_format" },
            proto = { "clang_format" },
            cmake = { "cmake_format" },
            html = { "prettier" },
            json = { "prettier" },
            xml = { "xmlformatter" },
            xsd = { "xmlformatter" },
            xsl = { "xmlformatter" },
            xslt = { "xmlformatter" },
            svg = { "xmlformatter" },
            bib = { "latexindent" },
            gitcommit = { "latexindent" },
            markdown = { "latexindent" },
            org = { "latexindent" },
            plaintex = { "latexindent" },
            rnoweb = { "latexindent" },
            tex = { "latexindent" },
            pandoc = { "latexindent" },
            quarto = { "latexindent" },
            rmd = { "latexindent" },
            rst = { "latexindent" },
            lua = { "stylua" },
            python = { "autopep8" },
            yaml = { "prettier" },

            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            svelte = { "prettier" },
            css = { "prettier" },
            graphql = { "prettier" },
        },
        -- format_on_save = {
        --     lsp_fallback = true,
        --     async = false,
        --     timeout_ms = 1000
        -- }
    })
    -- vim.keymap.set({"n", "v"}, "<C-A-l>", function()
    --     conform.format({
    --         lsp_fallback = true,
    --         async = false,
    --         timeout_ms = 5000
    --     })
    -- end, {
    --     desc = "Format file or range (in visual mode)"
    -- })
end

-- mfussenegger/nvim-lint
M.config_lint = function()
    local lint = require("lint")

    lint.linters_by_ft = {
        sh = { "shellcheck", "typos" },
        c = { "clangtidy", "typos" },
        cpp = { "clangtidy", "typos" },
        objc = { "clangtidy", "typos" },
        objcpp = { "clangtidy", "typos" },
        cuda = { "clangtidy", "typos" },
        proto = { "clangtidy", "typos" },
        cmake = { "cmakelint", "typos" },
        dockerfile = { "hadolint", "typos" },
        html = { "htmlhint", "typos" },
        json = { "jsonlint", "typos" },
        bib = { "vale" },
        gitcommit = { "vale" },
        markdown = { "vale", "write_good" },
        org = { "vale" },
        plaintex = { "vale" },
        rnoweb = { "vale" },
        tex = { "vale" },
        pandoc = { "vale" },
        quarto = { "vale" },
        rmd = { "vale" },
        rst = { "vale" },
        lua = { "luacheck" },
        python = { "flake8", "typos" },
        yaml = { "yamllint", "typos" },
    }

    -- local function get_cur_file_extension(bufnr)
    --     bufnr = bufnr or 0
    --     return "." .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":e")
    -- end
    local vale = require("lint.linters.vale")
    vale.args = {
        --     -- "--no-exit",
        --     -- "--output",
        --     -- "JSON",
        --     -- "--ext",
        --     -- get_cur_file_extension,
        --     "--config",
        "~/vale.ini",
    }

    local function find_compile_commands()
        local current_dir = vim.fn.getcwd()
        local home_dir = os.getenv('HOME') -- vim.fn.expand("~")
        local file_names = { "compile_commands.json", "build/compile_commands.json" }
        while current_dir ~= home_dir do
            for _, file_name in ipairs(file_names) do
                local file_path = current_dir .. "/" .. file_name
                if vim.fn.filereadable(file_path) == 1 then
                    return file_path
                end
            end
            current_dir = vim.fn.fnamemodify(current_dir, ":h")
        end
        return nil
    end
    local compile_commands_path = find_compile_commands()
    if compile_commands_path then
        local clangtidy = require("lint.linters.clangtidy")
        print("clang-tidy: found compile_commands.json at: " .. compile_commands_path)
        clangtidy.args = { "-p", compile_commands_path }
    end

    -- local cmakelint = require("lint.linters.cmakelint")
    -- cmakelint.cmd = "cmake-lint"
    -- local cmakelint_file = os.getenv('HOME') .. "/.cmakelintrc"
    -- cmakelint.args = {
    --     "-c",
    --     cmakelint_file,
    -- }



    local lint_augroup = vim.api.nvim_create_augroup("lint", {
        clear = true,
    })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
            lint.try_lint()
        end,
    })
    -- vim.keymap.set("n", "<leader>tl", function()
    --     lint.try_lint()
    -- end, {
    --     desc = "trigger linting for current file"
    -- })
end

return M
