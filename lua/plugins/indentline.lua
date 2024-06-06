return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufRead" },
    opts = {
        indent = { char = "|", highlight = "NonText" },
        scope = { enabled = false },
    },
}
