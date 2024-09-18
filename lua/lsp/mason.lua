local servers = {
    jsonls = {},
    tsserver = {},
    lua_ls = {},
}
servers.lua_ls.settings = {
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
}

local Mason = { "williamboman/mason.nvim" }
Mason.opts = {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
}

local MasonLsp = { "williamboman/mason-lspconfig.nvim" }
MasonLsp.lazy = false
MasonLsp.opts = {
    automatic_installation = true,
    ensure_installed = vim.tbl_keys(servers),
    handlers = {
        function(name)
            local server = servers[name] or {}
            server.capabilities = require("cmp_nvim_lsp").default_capabilities()
            require("lspconfig")[name].setup(server)
        end,
    },
}

return {
    "hrsh7th/cmp-nvim-lsp",
    MasonLsp,
    Mason,
}
