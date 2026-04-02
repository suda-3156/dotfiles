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
