-- Refs: https://github.com/kana/vim-submode
--       https://thinca.hatenablog.com/entry/20130131/1359567419
--       https://github.com/monaqa/dotfiles/blob/master/.config/nvim/lua/rc/submode.lua
--       https://zenn.dev/mattn/articles/83c2d4c7645faa

local M = {}

---@class Submode
---@field submode_id string
---@field nop string
---@field set fun(enter: string, lhs: string, rhs: string|function): nil

---@param submode_id string
---@param fn_name string
---@param fn function
---@return string
local function make_cmd(submode_id, fn_name, fn)
  local cmd_name = "<Plug>(" .. submode_id .. "-" .. fn_name .. ")"
  vim.keymap.set("n", cmd_name, fn)
  return cmd_name
end

---@class SubmodeOpts
---@field before? function
---@field after? function

---@param mode_name string submode name
---@param opts? SubmodeOpts
---@return Submode
function M.create_submode(mode_name, opts)
  local m = {}
  local map = vim.keymap.set
  local counter = 0

  ---@param mname string must be normalized
  ---@param fn function
  local function register_function(mname, fn)
    counter = counter + 1
    return make_cmd(mname, tostring(counter), fn)
  end

  m.submode_id = "submode-" .. mode_name
  m.nop = "<Plug>" .. m.submode_id

  local timeoutlen

  local before_fn = (opts and opts.before)
    or function()
      timeoutlen = vim.opt.timeoutlen
      vim.opt.timeoutlen = 10000
    end

  local after_fn = (opts and opts.after) or function()
    vim.opt.timeoutlen = timeoutlen
  end

  local before_rhs = make_cmd(mode_name, "before", before_fn)
  local after_rhs = make_cmd(mode_name, "after", after_fn)

  ---@param enter string enter + lhs to enter submode
  ---@param lhs string key to repeat rhs
  ---@param rhs string|function rhs
  function m.set(enter, lhs, rhs)
    if type(rhs) == "function" then
      rhs = register_function(mode_name, rhs)
    end

    map("n", enter .. lhs, before_rhs .. rhs .. m.nop)
    map("n", m.nop .. lhs, rhs .. m.nop)
    map("n", m.nop, after_rhs)
  end

  return m
end

return M
