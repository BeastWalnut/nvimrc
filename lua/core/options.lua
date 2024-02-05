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
opt.softtabstop = 0
opt.shiftwidth = 0
opt.expandtab = false
opt.smartindent = true
opt.copyindent = true

-- Spelling and word detection
opt.ignorecase = true
opt.smartcase = true
-- opt.spell = true

opt.undodir = vim.fn.stdpath("data") .. "\\undo"
opt.undofile = true
opt.swapfile = false
opt.backup = false

-- Search highlights
opt.incsearch = true
opt.hlsearch = false

-- GUI
-- opt.listchars = "leadmultispace:»   ,eol:↲"
opt.listchars = {
	tab = "│ ",
	trail = "«",
	space = "·",
	eol = "↲"
}
opt.list = true
opt.guifont = "JetBrainsMonoNL NFM15"

opt.termguicolors = true
opt.signcolumn = "yes"
opt.hidden = true

opt.isfname:append("@-@")

opt.splitright = true
opt.backspace = "indent,eol,start"
opt.scrolloff = 8

local autocmd = vim.api.nvim_create_autocmd
local personal_group = vim.api.nvim_create_augroup("PersonalGroup", {})

autocmd("BufEnter", {
	group = personal_group,
	callback = function()
		vim.opt.formatoptions:remove({ "r", "o" })
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

autocmd("TextYankPost", {
	group = personal_group,
	callback = function()
		vim.highlight.on_yank({
			higroup = "Visual",
			timeout = 300,
		})
	end,
})
autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.snippets",
	callback = function(ev)
		vim.cmd [[set filetype=snippets]]
	end
})
