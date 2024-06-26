return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufRead", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/playground",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
        playground = { enable = true },
        ensure_installed = {
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
        },
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        textobjects = {
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
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
