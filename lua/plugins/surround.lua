local M = { "kylechui/nvim-surround" }

M.event = "InsertEnter"
M.config = function(_, opts)
    require("nvim-surround").setup(opts)
end

return M
