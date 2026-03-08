local header = {
  [[                                   ]],
  [[                                   ]],
  [[ .    ∧__∧                         ]],
  [[     (  ･ω･)          それは私の   ]],
  [[    ＿|  ⊃／(＿＿_    特上カルビ！ ]],
  [[ ／  └-(＿＿＿_／                  ]],
  [[ ￣￣￣￣￣￣￣                    ]],
  [[   ＜⌒／ヽ-､_＿_    夢か…         ]],
  [[ ／＜_/＿＿＿＿／                  ]],
  [[ ￣￣￣￣￣￣￣                    ]],
  [[                                   ]],
  [[                                   ]],
}

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      theme = 'hyper', --  theme is doom and hyper default is hyper
      config = {
        header = header,
        disable_move = true,
        shortcut = {
          { icon = '󰊳 ', desc = 'Update', action = 'Lazy update', key = 'u' },
          { icon = '󰒲 ', desc = 'Lazy', action = 'Lazy', key = 'l' },
          {
            icon = ' ',
            desc = 'Files',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            icon = ' ',
            desc = 'dotfiles',
            action = 'Telescope find_files cwd=$HOME/dotfiles',
            key = 'd',
          },
          {
            icon = ' ',
            desc = 'Quit',
            action = function()
              vim.api.nvim_input '<Cmd>qa<CR>'
            end,
            key = 'q',
          },
        },
        packages = { enable = true },
        -- project = { enable = false },
        -- mru = { enable = false },
        footer = {},
      },
    }
  end,
}
