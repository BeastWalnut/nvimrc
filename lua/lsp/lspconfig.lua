return {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local augroup = vim.api.nvim_create_augroup
        local autocmd = vim.api.nvim_create_autocmd
        vim.api.nvim_create_autocmd("LspAttach", {
            group = augroup("LspOnAttach", {}),
            callback = function(e)
                local map_opts = {
                    noremap = true,
                    buffer = e.buf,
                }

                Set_map({
                    ["<M-q>"] = { vim.lsp.buf.format, "Code Format" },
                    K = { vim.lsp.buf.hover, "Cursor Doc" },
                }, map_opts)

                map_opts.mode = "i"
                Set_map({
                    ["<C-h>"] = { vim.lsp.buf.signature_help, "Open lsp help" },
                }, map_opts)

                map_opts.mode = "n"
                map_opts.name = "Diagnostic"
                Set_map({
                    ["]d"] = { vim.diagnostic.goto_next, "Next" },
                    ["[d"] = { vim.diagnostic.goto_prev, "Previous" },
                }, map_opts)

                map_opts.prefix = "g"
                Set_map({
                    D = { vim.lsp.buf.declaration, "[G]o [D]eclaration" },
                    I = { vim.lsp.buf.implementation, "[G]o [I]mplementation" },
                    r = { vim.lsp.buf.references, "Peek [R]eferences" },
                }, map_opts)

                if vim.g.loaded_telescope then
                    Set_map({
                        d = { "<cmd>Telescope lsp_definitions<CR>", "Peek [D]eclaration" },
                        i = { "<cmd>Telescope lsp_implementations<CR>", "Peek [I]mplementation" },
                    }, map_opts)
                end

                map_opts.mode = { "n", "v" }
                map_opts.prefix = "<leader>"
                Set_map({
                    ca = { vim.lsp.buf.code_action, "[C]ode [A]ctions" },
                    rn = { vim.lsp.buf.rename, "Cursor [R]ename" },
                    e = { vim.diagnostic.open_float, "Cursor Diagnostic" },
                }, map_opts)

                local lsp_format = augroup("LspFormat", {})
                vim.api.nvim_clear_autocmds({ group = lsp_format, buffer = e.buf })
                autocmd("BufWritePre", {
                    group = lsp_format,
                    buffer = e.buf,
                    callback = function()
                        vim.lsp.buf.format()
                    end,
                })
            end,
        })
    end,
}
