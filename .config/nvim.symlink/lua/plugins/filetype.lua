--- Ref: https://github.com/monaqa/dotfiles/blob/master/.config/nvim/lua/plugins/filetype.lua

local brew = { "https://github.com/bfontaine/Brewfile.vim", ft = { "brewfile" } }

local toml = { "https://github.com/cespare/vim-toml", ft = { "toml" } }

local vim = { "https://github.com/justinmk/vim-syntax-extra", ft = { "vim" } }

local html = { "https://github.com/othree/html5.vim", ft = { "html" } }

local javascript = { "https://github.com/pangloss/vim-javascript", ft = { "javascript" } }

local applescript = { "https://github.com/mityu/vim-applescript", ft = { "applescript" } }

return {
  brew,
  toml,
  vim,
  html,
  javascript,
  applescript,
}
