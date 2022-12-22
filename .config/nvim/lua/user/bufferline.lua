require("bufferline").setup({
	highlights = {
		buffer_selected = {
			italic = false,
		},
	},
	options = {
		view = "default",
		show_buffer_close_icons = false,
		show_close_icon = false,
		sort_by = "tabs",
		max_name_length = 55,
		name_formatter = function(buf)
			if next(vim.fn.win_findbuf(buf.bufnr)) == nil then
				return "ℍ  " .. buf.name
			end
			if buf.bufnr == vim.api.nvim_get_current_buf() then
				local name = vim.fn.expand("%:~:.")
				if name:len() > 50 then
					return "..." .. string.sub(name, -50)
				end
				return name
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
