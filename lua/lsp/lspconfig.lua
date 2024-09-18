local function on_attach(e)
    local opts = {
        name = "LSP",
        noremap = true,
        buffer = e.buf,
    }

    local extend = function(...)
        return vim.tbl_extend("force", opts, ...)
    end

    Set_map({
        ["<M-q>"] = { vim.lsp.buf.format, "Format" },
        ["K"] = { vim.lsp.buf.hover, "Open Docs" },
    }, opts)

    Set_map({
        ["<C-h>"] = { vim.lsp.buf.signature_help, "Open Help" },
    }, extend({ mode = "i" }))

    Set_map(
        { rn = { vim.lsp.buf.rename, "[R]ename" } },
        extend({
            mode = { "n", "v" },
            prefix = "<leader>",
        })
    )

    local diagnostic = extend({
        mode = "n",
        name = "Diagnostic",
    })

    Set_map({
        ["]d"] = { vim.diagnostic.goto_next, "Next" },
        ["[d"] = { vim.diagnostic.goto_prev, "Previous" },
    }, diagnostic)

    diagnostic.prefix = "g"
    Set_map({
        D = { vim.lsp.buf.declaration, "[G]o [D]eclaration" },
        I = { vim.lsp.buf.implementation, "[G]o [I]mplementation" },
        r = { vim.lsp.buf.references, "Peek [R]eferences" },
        d = { "<cmd>Telescope lsp_definitions<CR>", "Peek [D]eclarations" },
        i = { "<cmd>Telescope lsp_implementations<CR>", "Peek [I]mplementations" },
    }, diagnostic)

    Set_map(
        {
            ca = { vim.lsp.buf.code_action, "[C]ode [A]ctions" },
            e = { vim.diagnostic.open_float, "Open Float" },
        },
        extend({
            name = diagnostic.name,
            mode = { "n", "v" },
            prefix = "<leader>",
        })
    )

    local lsp_format = vim.api.nvim_create_augroup("LspFormat", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = lsp_format,
        buffer = e.buf,
        callback = function()
            vim.lsp.buf.format()
        end,
    })
end

local M = { "neovim/nvim-lspconfig" }

M.event = { "BufReadPre", "BufNewFile" }
M.config = function()
    local lsp_attach = vim.api.nvim_create_augroup("LspOnAttach", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
        group = lsp_attach,
        callback = on_attach,
    })
end

return M
