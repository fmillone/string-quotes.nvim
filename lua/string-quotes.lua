local M = {}

function M.setup(opts)
  local config = require("string-quotes.config")
  local options = vim.tbl_extend("force", config.options, opts or {})
  if options.disabled then
    return
  end

  local actions = require("string-quotes.actions")
  local null_ls = require("null-ls")

  null_ls.register({
    name = "string-quotes",
    method = null_ls.methods.CODE_ACTION,
    filetypes = options.filetypes,
    generator = {
      fn = actions.switch_string,
    },
  })
end

return M
