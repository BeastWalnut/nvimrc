local M = { "nvim-treesitter/nvim-treesitter" }

M.build = ":TSUpdate"
M.event = { "BufReadPre", "BufNewFile" }
M.dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" }
M.opts = {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    auto_install = true,
    indent = { enable = true },
}
M.opts.ensure_installed = {
    "c",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "comment",
    "javascript",
    "typescript",
    "java",
    "rust",
}
M.opts.textobjects = {
    select = {
        enable = true,
        lookahead = true,
        keymaps = {
            ["af"] = { query = "@function.outer", desc = "a func def" },
            ["if"] = { query = "@function.inner", desc = "a func def" },
            ["ac"] = { query = "@call.outer", desc = "a func call" },
            ["ic"] = { query = "@call.inner", desc = "a func call" },
            ["at"] = { query = "@class.outer", desc = "a class" },
            ["it"] = { query = "@class.inner", desc = "a class" },
        },
    },
}
M.config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
end

return M
