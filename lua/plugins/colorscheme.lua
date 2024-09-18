local OneDark = { "olimorris/onedarkpro.nvim", name = "onedarkpro" }
local Catppuccin = { "catppuccin/nvim", name = "catppuccin" }
local RosePine = { "rose-pine/neovim", name = "rose-pine" }
RosePine.opts = {
    groups = { comment = "DarkCyan" },
    highlight_groups = {
        Normal = { bg = "none" },
        NormalNC = { bg = "#232136" },
        Todo = { fg = "iris" },
        ["@comment.todo"] = { link = "Todo" },
        ["@comment.note"] = { link = "@text.note" },
        ["@constant.macro"] = { link = "Macro" },
    },
}

return {
    OneDark,
    Catppuccin,
    RosePine,
    lazy = false,
}
