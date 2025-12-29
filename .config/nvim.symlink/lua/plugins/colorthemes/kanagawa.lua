return {
  'rebelot/kanagawa.nvim',
  cofig = function ()
    -- Default options:
    require('kanagawa').setup({
      undercurl = true,            -- enable undercurls
      commentStyle = { italic = true },
      keywordStyle = { italic = true},
      statementStyle = { bold = true },
      transparent = true,
      dimInactive = true,
      terminalColors = true,
      theme = "wave",
      background = {
        dark = "wave",
        light = "lotus"
      },
    })

    -- setup must be called before loading
    vim.cmd("colorscheme kanagawa")
  end
}
