return {
    "folke/which-key.nvim",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
    config = function(_, opts)
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

        local key_opts = {
            "n",
            prefix = "<leader>",
        }

        wk.register(keymap, key_opts)
    end,
}
