local ensure_installed = {
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

local textobjects = {
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

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
        require("nvim-treesitter.configs").setup({
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            auto_install = true,
            ensure_installed = ensure_installed,
            textobjects = textobjects,
            indent = { enable = true },
        })
    end,
}
