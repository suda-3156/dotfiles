-- Ref: https://osyo-manga.hatenadiary.org/entry/20140307/1394204974
--      https://osyo-manga.hatenadiary.org/entry/20130717/1374069987
--      https://qiita.com/rbtnn/items/a47ed6684f1f0bc52906
local p = {}

p[#p + 1] = {
  "https://github.com/glts/vim-textobj-comment",
  dependencies = { "https://github.com/kana/vim-textobj-user" },
  keys = {
    { "im", "<Plug>(textobj-comment-i)", mode = { "x", "o" } },
    { "am", "<Plug>(textobj-comment-a)", mode = { "x", "o" } },
  },
  config = function()
    vim.g["textobj_comment_no_default_key_mappings"] = 1
  end,
}

p[#p + 1] = {
  "https://github.com/kana/vim-textobj-entire",
  dependencies = { "https://github.com/kana/vim-textobj-user" },
  keys = {
    { "ie", mode = { "x", "o" } },
    { "ae", mode = { "x", "o" } },
  },
}

p[#p + 1] = {
  "https://github.com/kana/vim-textobj-line",
  dependencies = { "https://github.com/kana/vim-textobj-user" },
  keys = {
    { "il", mode = { "x", "o" } },
    { "al", mode = { "x", "o" } },
  },
}

p[#p + 1] = {
  "https://github.com/kana/vim-textobj-jabraces",
  dependencies = { "https://github.com/kana/vim-textobj-user" },
  keys = {
    { "ijb", mode = { "x", "o" } },
    { "ajb", mode = { "x", "o" } },
  },
}

p[#p + 1] = {
  "https://github.com/kana/vim-textobj-indent",
  dependencies = { "https://github.com/kana/vim-textobj-user" },
  keys = {
    { "iI", mode = { "x", "o" } },
    { "aI", mode = { "x", "o" } },
  },
}

p[#p + 1] = {
  "https://github.com/thinca/vim-textobj-between",
  dependencies = { "https://github.com/kana/vim-textobj-user" },
  keys = {
    { "if", mode = { "x", "o" } },
    { "af", mode = { "x", "o" } },
  },
}

p[#p + 1] = {
  "https://github.com/sgur/vim-textobj-parameter",
  dependencies = { "https://github.com/kana/vim-textobj-user" },
  keys = {
    { "i,", mode = { "x", "o" } },
    { "a,", mode = { "x", "o" } },
  },
}

p[#p + 1] = {
  "https://github.com/mattn/vim-textobj-url",
  dependencies = { "https://github.com/kana/vim-textobj-user" },
  keys = {
    { "iu", mode = { "x", "o" } },
    { "au", mode = { "x", "o" } },
  },
}

-- p[#p + 1] = {
--   "https://github.com/kana/vim-textobj-user",
-- }

-- From: https://github.com/monaqa/dotfiles/blob/master/.config/nvim/lua/plugins/textedit.lua
p[#p + 1] = {
  "https://github.com/kana/vim-operator-replace",
  dependencies = { "https://github.com/kana/vim-operator-user" },
  keys = {
    { "R", "<Plug>(operator-replace)" },
    { "RR", "<Plug>(operator-replace)_" },
    { "<Space>R", [["+<Plug>(operator-replace)]] },
  },
}

return p
