-- :h vim.diagnostic.Opts
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = {
    -- source = true,
    suffix = function(diagnostic)
      if diagnostic.code == nil then
        return string.format(" [%s]", diagnostic.source)
      end
      return string.format(" [%s: %s]", diagnostic.source, diagnostic.code)
    end,
    hl_mode = "replace",
  },
  float = {
    border = "single",
  },
})
