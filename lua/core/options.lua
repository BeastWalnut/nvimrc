local opt = vim.opt

vim.g.mapleader = " "
opt.updatetime = 50
opt.title = true

-- Line numbers and wrap
opt.number = true
opt.relativenumber = true
opt.wrap = false

-- Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 0
opt.expandtab = true
opt.smartindent = false

-- Spelling and word detection
opt.ignorecase = true
opt.smartcase = true

opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.undofile = true
opt.swapfile = false

-- Search highlights
opt.incsearch = true
opt.hlsearch = false

-- GUI
opt.guifont = "JetBrainsMonoNL NFM15"
opt.listchars = {
    trail = "#",
    tab = "│ ",
    eol = "↲",
}
opt.list = true

opt.termguicolors = true
opt.signcolumn = "yes"
opt.hidden = true

opt.isfname:append("@-@")

opt.splitright = true
opt.backspace = "indent,eol,start"
opt.scrolloff = 8

local autocmd = vim.api.nvim_create_autocmd
local opt_group = vim.api.nvim_create_augroup("PersonalGroup", { clear = true })

autocmd("BufEnter", {
    group = opt_group,
    callback = function()
        vim.opt.formatoptions:remove({ "r", "o" })
        vim.opt_local.formatoptions:remove({ "r", "o" })
    end,
})

autocmd("TextYankPost", {
    group = opt_group,
    callback = function()
        vim.highlight.on_yank({
            higroup = "Visual",
            timeout = 250,
        })
    end,
})
