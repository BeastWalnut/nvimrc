local M = { "folke/which-key.nvim" }

M.init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
end
M.config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    local keymap = {
        a = { name = "Automata" },
        t = { name = "Trouble" },
        h = { name = "Harpoon" },
        u = { name = "Undo" },
        f = { name = "Find" },
        c = { name = "Lsp" },
    }

    keymap.mode = "c"
    keymap.prefix = "<leader>"

    wk.add(keymap)
end

return M
