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
        sh = { "shellcheck" },
        c = { "clangtidy" },
        cpp = { "clangtidy" },
        objc = { "clangtidy" },
        objcpp = { "clangtidy" },
        cuda = { "clangtidy" },
        proto = { "clangtidy" },
        cmake = { "cmakelint" },
        dockerfile = { "hadolint" },
        html = { "djlint" },
        json = { "jsonlint" },
        bib = { "vale" },
        gitcommit = { "vale" },
        markdown = { "vale" },
        org = { "vale" },
        plaintex = { "vale" },
        rnoweb = { "vale" },
        tex = { "vale" },
        pandoc = { "vale" },
        quarto = { "vale" },
        rmd = { "vale" },
        rst = { "vale" },
        lua = { "luacheck" },
        python = { "flake8" },
        yaml = { "yamllint" },
    }

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
