local QUOTES = {
  SINGLE = [[']],
  DOUBLE = [["]],
  BACKTICK = [[`]],
}

local ts_types = { "string_fragment", "template_string" }

local utils = require("string-quotes.utils")

local get_action = function(node, action, quote)
  return {
    title = "Replace with " .. action,
    action = function()
      local start_row, start_col, end_row, end_col = node:range()
      if node:type() == "template_string" then
        utils.replace_string_with(start_row, start_col, end_col, quote)
      else
        utils.replace_string_with(start_row, start_col - 1, end_col + 1, quote)
      end
    end,
  }
end

local M = {}

function M.switch_string()
  local node = utils.get_cusor_node()
  if not node then
    return
  end
  -- vim.print("switch_string:type", node:type())
  if vim.tbl_contains(ts_types, node:type()) then
    if node:type() == "template_string" then
      return {
        get_action(node, "single quotes", QUOTES.SINGLE),
        get_action(node, "double quotes", QUOTES.DOUBLE),
      }
    else
      local start_row, start_col = node:range()
      local char = utils.get_char_under(start_row, start_col)
      if char == utils.quote.SINGLE then
        return {
          get_action(node, "double quotes", QUOTES.DOUBLE),
          get_action(node, "template string", QUOTES.BACKTICK),
        }
      else
        return {
          get_action(node, "single quotes", QUOTES.SINGLE),
          get_action(node, "template string", QUOTES.BACKTICK),
        }
      end
    end
  end
end

return M
