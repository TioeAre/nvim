| lsp                             | language              | Linter     | Format                     |
| ------------------------------- | --------------------- | ---------- | ------------------------neo-tree-- |
| bashls                          | bash                  | shellcheck | shfmt                      |
| clangd                          | c,c++                 | clangtidy  | clang-format(clang_format) |
| cmake                           | cmake                 | cmakelint  | cmakeformat                |
| docker_compose_language_service | docker                | hadolint   |                            |
| dockerls                        | docker                | hadolint   |                            |
| html                            | html                  | djlint     | prettier                   |
| jsonls                          | json                  | jsonlint   | prettier                   |
| lemminx                         | xml                   |            | xmlformatter               |
| ltex                            | text, markdown, latex | vale       | latexindent                |
| lua_ls                          | lua                   | luacheck   | stylua                     |
| marksman                        | markdown              | vale       | prettier                   |
| matlab_ls                       | Matlab                |            |                            |
| pyright                         | python                | flake8     | docformatter, autopep8     |
| yamlls                          | yaml                  | yamllint   | prettier                   |



dap: bash-debug-adapter, cpptools, debugpy, mockdebug

-   codelldb



```lua
filetypes = {
            'c',
            'cpp',
            'cmake',
            'docker',
            'html',
            "json",
            'xml',
            "markdown",
            'latex',
            "lua",
            'matlab',
            "python",
            "sh",
        },

    local shellcheck = require("efmls-configs.linters.shellcheck")
    local cmake_lint = require("efmls-configs.linters.cmake_lint")
    local hadolint = require("efmls-configs.linters.hadolint")
    local djlint = require("efmls-configs.linters.djlint")
    local vale = require("efmls-configs.linters.vale")
    local yamllint = require("efmls-configs.linters.yamllint")
    local flake8 = require("efmls-configs.linters.flake8")
    local yamllint = require("efmls-configs.linters.yamllint")

    local shfmt = require("efmls-configs.formatters.shfmt")
    local clang_format = require("efmls-configs.formatters.clang_format")
    -- local cmakelang = require("efmls-configs.formatters.cmakelang")
    local prettier = require("efmls-configs.formatters.prettier")
    -- local xmlformatter = require("efmls-configs.formatters.xmlformatter")
    local latexindent = require("efmls-configs.formatters.latexindent")
    local stylua = require("efmls-configs.formatters.stylua")
    -- local docformatter = require("efmls-configs.formatters.docformatter")
    local autopep8 = require("efmls-configs.formatters.autopep8")
```

