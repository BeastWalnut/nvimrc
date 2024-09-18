local M = { "rust-lang/rust.vim" }

M.ft = "rust"
M.init = function()
    vim.g.rust_recommended_style = 0
    vim.g.rustfmt_autosave = 1
end

return M
