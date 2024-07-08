return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local augroup = vim.api.nvim_create_augroup
        local autocmd = vim.api.nvim_create_autocmd
        local lsp_format = augroup("LspFormat", {})
        vim.api.nvim_create_autocmd("LspAttach", {
            group = augroup("LspOnAttach", {}),
            callback = function(e)
                local map_opts = {
                    name = "LSP",
                    noremap = true,
                    buffer = e.buf,
                }

                Set_map({
                    ["<M-q>"] = { vim.lsp.buf.format, "Format" },
                    K = { vim.lsp.buf.hover, "Open Docs" },
                }, map_opts)

                map_opts.mode = "i"
                Set_map({
                    ["<C-h>"] = { vim.lsp.buf.signature_help, "Open Help" },
                }, map_opts)

                map_opts.mode = { "n", "v" }
                map_opts.prefix = "<leader>"
                Set_map({
                    rn = { vim.lsp.buf.rename, "[R]ename" },
                }, map_opts)

                map_opts.mode = "n"
                map_opts.name = "Diagnostic"
                map_opts.prefix = nil
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

                Set_map({
                    d = { "<cmd>Telescope lsp_definitions<CR>", "Peek [D]eclarations" },
                    i = { "<cmd>Telescope lsp_implementations<CR>", "Peek [I]mplementations" },
                }, map_opts)

                map_opts.mode = { "n", "v" }
                map_opts.prefix = "<leader>"
                Set_map({
                    ca = { vim.lsp.buf.code_action, "[C]ode [A]ctions" },
                    e = { vim.diagnostic.open_float, "Open Float" },
                }, map_opts)

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
