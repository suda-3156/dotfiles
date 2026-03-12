-- From: https://zenn.dev/uga_rosa/articles/afe384341fc2e1
-- Ref:
--  https://zenn.dev/ras96/articles/4d9d9493d29c06
--  https://minerva.mamansoft.net/Notes/%F0%9F%93%9C2025-04-27+nvim-lspconfig+v2%E3%81%A7Neovim+0.11%E3%81%AELSP%E3%81%AB%E6%9C%80%E9%81%A9%E3%81%AA%E8%A8%AD%E5%AE%9A%E3%82%92%E6%A7%8B%E6%88%90%E3%81%99%E3%82%8B

---@param names string[]
---@return string[]
local function get_plugin_paths(names)
  local plugins = require("lazy.core.config").plugins
  local paths = {}
  for _, name in ipairs(names) do
    if plugins[name] then
      table.insert(paths, plugins[name].dir .. "/lua")
    else
      vim.notify("Invalid plugin name: " .. name)
    end
  end
  return paths
end

---@param plugins string[]
---@return string[]
local function library(plugins)
  local paths = get_plugin_paths(plugins)
  table.insert(paths, vim.fn.stdpath("config") .. "/lua")
  table.insert(paths, vim.env.VIMRUNTIME .. "/lua")
  table.insert(paths, "${3rd}/luv/library")
  table.insert(paths, "${3rd}/busted/library")
  table.insert(paths, "${3rd}/luassert/library")
  return paths
end

---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        pathStrict = true,
        path = { "?.lua", "?/init.lua" },
      },
      workspace = {
        library = library({ "lazy.nvim" }),
        checkThirdParty = "Disable",
      },
    },
  },
}
