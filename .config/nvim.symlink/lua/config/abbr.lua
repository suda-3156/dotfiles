-- From: https://zenn.dev/kawarimidoll/books/6064bf6f193b51/viewer/e5428b
-- abbreviation only for ex-command
local function abbr(lhs, rhs, opts)
  vim.keymap.set("ca", lhs, function()
    if vim.fn.getcmdtype() ~= ":" or not rhs or rhs == "" then
      return lhs
    end

    if type(rhs) == "function" then
      return rhs()
    else
      return rhs
    end
  end, vim.tbl_extend("force", { expr = true }, opts))
end

abbr("qw", "wq", { desc = "Fix typo" })
abbr("lup", "lua =", { desc = "Lua print" })

vim.api.nvim_create_user_command("Restart", function()
  vim.cmd("AutoSession save")
  vim.cmd.restart()
end, { desc = "Restart current Neovim session" })
abbr("rst", "Restart", { desc = "Save session and restart" })

-- From: https://zenn.dev/vim_jp/articles/2023-06-30-vim-substitute-tips
abbr("s", function()
  vim.fn.getchar()
  return "%s///g<Left><Left>"
end, { desc = "Replace all matched in current buffer" })
