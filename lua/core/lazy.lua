local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "plugins" },
    { import = "lsp" },
}, {
    defaults = { lazy = true },
    change_detection = { notify = false },
    install = { colorscheme = { "rose-pine", "nightfly", "onedark" } },
    ui = {
        border = "rounded",
        icons = {
            require = "",
            lazy = "💤",
            ft = "📂",
            plugin = "",
        },
    },
    rocks = { enabled = false },
})
