local M = { "numToStr/Comment.nvim" }

M.event = { "BufReadPre", "BufNewFile" }
M.config = function()
    require("Comment").setup()
end

return M
