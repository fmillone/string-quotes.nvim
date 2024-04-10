# String-Quotes.nvim

This plugin provides a set of code actions (through null-ls) to quickly switch string quotes.

Install with lazy

```lua
{ 'fmillone/string-quotes.nvim' }
```

Default config

```lua
{
  'fmillone/string-quotes.nvim',
  opts = {
    disabled= false,
    filetypes = { "html", "typescript", "javascript", "typescriptreact", "javascriptreact", "lua" }
  }
}
```
