local U = {}

U.quote = {
	SINGLE = [[']],
	DOUBLE = [["]],
	BACKTICK = [[`]],
}

function U.get_cusor_node()
	if vim.treesitter.get_node then
		return vim.treesitter.get_node({ ignore_injections = false })
	else
		return require("nvim-treesitter.ts_utils").get_node_at_cursor()
	end
end

function U.get_char_under(row, col)
	return vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]:sub(col, col)
end

function U.replace_string_with(start_row, start_col, end_col, quote)
	local line = vim.api.nvim_buf_get_lines(0, start_row, start_row + 1, false)[1]
	local new_line = line:sub(1, start_col)
		.. quote
		.. line:sub(start_col + 2, end_col - 1)
		.. quote
		.. line:sub(end_col + 1)

	vim.api.nvim_buf_set_lines(0, start_row, start_row + 1, false, { new_line })
	vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col + 1 })
end

return U
