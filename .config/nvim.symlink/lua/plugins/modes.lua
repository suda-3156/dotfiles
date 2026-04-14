return {
  "https://github.com/mvllow/modes.nvim",
  event = { "BufReadPre", "BufNewFile" },
  version = "*",
  config = function()
    require("modes").setup({
      colors = {
        copy = "#E5C07B",
        delete = "#E06C75",
        insert = "#98C379",
        visual = "#C678DD",
        change = "#D19A66",
        format = "#56B6C2",
        replace = "#BE5046",
        select = "#61AFEF",
      },
      line_opacity = {
        copy = 0.3,
        delete = 0.3,
        insert = 0.3,
        visual = 0.4,
        change = 0.3,
        format = 0.3,
        replace = 0.3,
        select = 0.3,
      },
    })
  end,
}
