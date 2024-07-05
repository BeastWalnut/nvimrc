require("core")

local colorscheme = "rose-pine"
if not pcall(vim.cmd.colorscheme, colorscheme) then
    print("could not load " .. colorscheme)
end
