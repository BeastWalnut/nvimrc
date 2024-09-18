local M = {
    "alker0/chezmoi.vim",
}

M.lazy = false
M.init = function()
    -- This option is required.
    vim.g["chezmoi#use_tmp_buffer"] = true
    -- add other options here if needed.
end

return M
