return {
    "williamboman/mason.nvim",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    opts = {
        lua_ls = {
            settings = {
                Lua = {
                    diagnostics = {
                        neededFileStatus = { ["no-unkown"] = "Opened" },
                        groupSeverity = {
                            duplicate = "Error",
                            ambiguity = "Error",
                            strong = "Error",
                            ["type-check"] = "Error",
                        },
                        severity = { ["ambiguity-1"] = "Warning!" },
                        unusedLocalExclude = { "_*" },
                    },
                },
            },
        },
        jsonls = {},
        tsserver = {},
    },
    config = function(_, servers)
        local mason = require("mason")
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({
            automatic_installation = true,
            ensure_installed = vim.tbl_keys(servers),
        })

        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_lsp.default_capabilities()
        mason_lspconfig.setup_handlers({
            function(name)
                local server = servers[name] or {}
                server.capabilities = capabilities
                require("lspconfig")[name].setup(server)
            end,
        })
        require("mason-tool-installer").setup({
            ensure_installed = {
                "prettierd",
                "prettier",
                "stylua",
                "eslint_d",
            },
        })
    end,
}
