local M = {}

M.toggle_move = function()
    if vim.v.count > 0 then
        -- this does not work (yet?)
        -- require('harpoon.ui').nav_file(vim.v.count)
        return '<cmd>lua require("harpoon.ui").nav_file(vim.v.count)<CR>'
    else
        require('harpoon.mark').toggle_file()
    end
end

M.toggle_move_or_quick_menu = function()
    if vim.v.count > 0 then
        return '<cmd>vsplit | lua require("harpoon.ui").nav_file(vim.v.count)<CR>'
    else
        require('harpoon.ui').toggle_quick_menu()
    end
end

return M
