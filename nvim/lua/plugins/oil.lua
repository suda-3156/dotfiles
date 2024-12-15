return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  config = function ()
    require("oil").setup()
    vim.api.nvim_create_augroup("OilRelPathFix", {})
    vim.api.nvim_create_autocmd("BufLeave", {
      group = "OilRelPathFix",
      pattern = "oil:///*",
      callback = function()
        vim.cmd("cd .")
      end,
    })
  end
}


