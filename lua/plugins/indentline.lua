return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPre" },
    opts = {
        indent = { char = "|", highlight = "NonText" },
        scope = { enabled = false },
    },
}
