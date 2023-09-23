local M = {}

function M.setup(opts)
	local config = require("config")
	local options = vim.tbl_extend("force", config.options, opts or {})
	if not options.disabled then
		return
	end

	local actions = require("actions")
	local null_ls = require("null-ls")

	null_ls.register({
		method = null_ls.methods.CODE_ACTION,
		filetypes = config.options.filetypes,
		generator = {
			fn = actions.switch_string,
		},
	})
end

return M
