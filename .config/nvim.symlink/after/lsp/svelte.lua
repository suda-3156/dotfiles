-- We have to install prettier and prettier-plugin-svelte in each project
-- And write below to the .prettierrc
-- {
--   "plugins": ["prettier-plugin-svelte"],
--   "overrides": [{ "files": "*.svelte", "options": { "parser": "svelte" } }]
-- }

---@type vim.lsp.Config
return {
  single_file_support = true,
  settings = {
    format = {
      enable = false,
    },
  },
}
