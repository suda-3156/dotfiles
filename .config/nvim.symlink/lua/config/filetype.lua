-- Treat ambiguous .tex files (no \documentclass yet) as LaTeX, not plaintex.
-- Otherwise FTtex() falls back to plaintex and tex.lua snippets won't load.
vim.g.tex_flavor = "latex"

-- From: https://zenn.dev/vim_jp/articles/fad47dfb5fcd09
vim.filetype.add({
  pattern = {
    ["compose.*%.ya?ml"] = "yaml.docker-compose",
    ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
    [".*/%.github/workflows/.*%.ya?ml"] = "yaml.github-actions",
    ["%.env.*"] = "sh.env",
    ["%.envrc"] = "sh",
  },
})
