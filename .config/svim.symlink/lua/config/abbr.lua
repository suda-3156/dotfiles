-- From: https://zenn.dev/kawarimidoll/books/6064bf6f193b51/viewer/e5428b
-- abbreviation only for ex-command
local function abbrev_excmd(lhs, rhs, opts)
  vim.keymap.set("ca", lhs, function()
    return vim.fn.getcmdtype() == ":" and rhs or lhs
  end, vim.tbl_extend("force", { expr = true }, opts))
end

abbrev_excmd("qw", "wq", { desc = "fix typo" })
abbrev_excmd("lup", "lua =", { desc = "lua print" })
