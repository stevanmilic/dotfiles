require("bufferline").setup({
    options = {
        view = "default",
        show_buffer_close_icons = false,
        show_close_icon = false,
        sort_by = "tabs",
        max_name_length=50,
        name_formatter = function(buf)
            if next(vim.fn.win_findbuf(buf.bufnr)) == nil then
                return "ℍ  " .. buf.name
            end
            if buf.bufnr == vim.api.nvim_get_current_buf() then
                return vim.fn.expand('%:~:.')
            end
            return buf.name
        end,
    },
})

require("close_buffers").setup({
    preserve_window_layout = { "this" },
    next_buffer_cmd = function(windows)
        require("bufferline").cycle(1)
        local bufnr = vim.api.nvim_get_current_buf()

        for _, window in ipairs(windows) do
            vim.api.nvim_win_set_buf(window, bufnr)
        end
    end,
})

vim.api.nvim_set_keymap(
    "n",
    "<leader>su",
    [[<CMD>lua require('close_buffers').delete({type = 'hidden', force = true})<CR>]],
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>sb",
    [[<CMD>lua require('close_buffers').delete({type = 'this', force = true})<CR>]],
    { noremap = true, silent = true }
)
