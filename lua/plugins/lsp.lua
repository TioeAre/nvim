local config_mason = function()
    require("mason").setup({
        ui = {
            icons = {
                width = 0.6,
                height = 0.7,
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        },
        pip = {
            upgrade_pip = false,
            install_args = {"--proxy", "http://127.0.0.1:7890"}
        }
    })
    -- red setup()
    require('neoconf').setup({})
    require("mason-lspconfig").setup({})
    require("lspconfig").lua_ls.setup({})
    require("lspconfig").rust_analyzer.setup({})
end

local opts_mason_lspconfig = {
    -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
    -- This setting has no relation with the `automatic_installation` setting.
    ---@type string[]
    ensure_installed = {
        'bashls',
        'clangd',
        'cmake',
        'dockerls',
        'docker_compose_language_service',
        'efm',
        'html',
        'jsonls',
        'ltex',
        'lua',
        'marksman',
        'pyright',
        'lemminx',
        'yamlls',
    },
    --   - { exclude: string[] }: { exclude = { "rust_analyzer", "solargraph" } }
    ---@type boolean
    automatic_installation = true,
    ---@type table<string, fun(server_name: string)>?
    handlers = nil
}

local config_lspconfig = function()
    local on_attach = require("utils.lsp").on_attach
    local diagnostic_signs = require("utils.lsp").diagnostic_signs

	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local lspconfig = require("lspconfig")
	for type, icon in pairs(diagnostic_signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end
	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- bash
	lspconfig.bashls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "sh" },
	})

    -- c/c++
    lspconfig.clangd.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", 'cc', 'h', 'hpp' },
        -- root_dir = root_pattern('.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git')
	})

    -- docker
    lspconfig.docker_compose_language_service.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
    lspconfig.dockerls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

    -- html
    lspconfig.html.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

    -- latex
    lspconfig.ltex.setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })

    -- json
	lspconfig.jsonls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "json", "jsonc" },
	})

	-- lua
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = { -- custom settings for lua
			Lua = {
				-- make the language server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})

    -- markdown
	lspconfig.marksman.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	-- python
	lspconfig.pyright.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			pyright = {
				disableOrganizeImports = false,
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	})

    -- xml
	lspconfig.lemminx.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

    -- yaml
	lspconfig.yamlls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

    local shellcheck = require("efmls-configs.linters.shellcheck")
    local cmake_lint = require("efmls-configs.linters.cmake_lint")
    local hadolint = require("efmls-configs.linters.hadolint")
    local djlint = require("efmls-configs.linters.djlint")
    local vale = require("efmls-configs.linters.vale")
    local luacheck = require("efmls-configs.linters.luacheck")
    local flake8 = require("efmls-configs.linters.flake8")
    local yamllint = require("efmls-configs.linters.yamllint")

	local shfmt = require("efmls-configs.formatters.shfmt")
    local clang_format = require("efmls-configs.formatters.clang_format")
    local gersemi = require("efmls-configs.formatters.gersemi")
    local prettier = require("efmls-configs.formatters.prettier")
    -- local xmlformatter = require("efmls-configs.formatters.xmlformatter")
    local latexindent = require("efmls-configs.formatters.latexindent")
    local stylua = require("efmls-configs.formatters.stylua")
    -- local docformatter = require("efmls-configs.formatters.docformatter")
    local autopep8 = require("efmls-configs.formatters.autopep8")

	-- configure efm server
	lspconfig.efm.setup({
		filetypes = {
            'c',
            'cpp',
            'cmake',
            'docker',
            'html',
			"json",
            "markdown",
            'latex',
            "lua",
            'matlab',
            "python",
			"sh",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
                -- check format
                sh = { shellcheck, shfmt },
                c = {clang_format},
                cmake = {cmake_lint, gersemi},
                docker = {hadolint, prettier},
                html = {djlint, prettier},
                json = {prettier},
                latex = {vale, latexindent},
				lua = { luacheck, stylua },
                markdown = { vale, prettier },
				python = { flake8, autopep8 },
                yaml = {yamllint, prettier}
			},
		},
	})
end

return { -- mason, mason-lspconfig, nvim-lspconfig,
{
    'williamboman/mason.nvim',
    dependencies = {"williamboman/mason-lspconfig.nvim", 'neovim/nvim-lspconfig'},
    cmd = "Mason",
    event = "BufReadPre",
    config = config_mason
}, {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {"williamboman/mason.nvim", "neovim/nvim-lspconfig"},
    event = "BufReadPre",
    opts = opts_mason_lspconfig,
    config = function()
        -- After setting up mason-lspconfig you may set up servers via lspconfig
        -- require("lspconfig").lua_ls.setup {}
        -- require("lspconfig").rust_analyzer.setup {}
    end
}, {
    'neovim/nvim-lspconfig',
    dependencies = {'williamboman/mason.nvim', "williamboman/mason-lspconfig.nvim", "windwp/nvim-autopairs",
                    "hrsh7th/nvim-cmp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", 'creativenull/efmls-configs-nvim'},
    event = "VeryLazy",
    config = config_lspconfig,
}, {
    'creativenull/efmls-configs-nvim',
    version = 'v1.x.x', -- version is optional, but recommended
    dependencies = { 'neovim/nvim-lspconfig' },
    event = 'BufReadPre',
}}
