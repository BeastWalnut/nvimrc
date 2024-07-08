local mason = {
    "williamboman/mason.nvim",
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    },
}

local servers = {
    lua_ls = {
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                    keywordSnippet = "Disable",
                },
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
}

local mason_lspconfig = {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
        automatic_installation = true,
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
            function(name)
                local server = servers[name] or {}
                server.capabilities = require("cmp_nvim_lsp").default_capabilities()
                require("lspconfig")[name].setup(server)
            end,
        },
    },
}

return {
    "hrsh7th/cmp-nvim-lsp",
    mason_lspconfig,
    mason,
}
