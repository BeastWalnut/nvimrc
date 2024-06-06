return {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
        vim.g.rust_recommended_style = 0
        vim.g.rustfmt_autosave = 1
    end,
}
