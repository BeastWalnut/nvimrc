return {
    "norcalli/nvim-colorizer.lua",
    ft = { "markdown", "json" },
    cmd = "ColorizerAttachToBuffer",
    name = "colorizer",
    opts = {
        mode = "foreground",
    },
    config = function(_, opts)
        require("colorizer").setup({
            "markdown",
            "json",
        }, opts)
    end,
}
