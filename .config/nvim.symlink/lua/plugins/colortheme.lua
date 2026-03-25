---@type LazyPluginSpec
return {
  "https://github.com/loctvl842/monokai-pro.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local is_transparent = true
    -- #A0A8B7
    -- #B0B0B0
    -- #C5C5C5
    -- local bright_gray = "#A0A8B7"

    local function apply_theme()
      local palette = require("monokai-pro").get_palette("octagon")

      require("monokai-pro").setup({
        transparent_background = is_transparent,
        terminal_colors = true,
        devicons = true,
        filter = "octagon",
        inc_search = "background",
        override = function(c)
          return {
            Comment = { fg = palette.dimmed1, italic = false },
          }
        end,
      })

      vim.cmd.colorscheme("monokai-pro")
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = palette.dimmed1, bold = true })
      vim.api.nvim_set_hl(0, "NonText", { fg = palette.dimmed2 })
      vim.api.nvim_set_hl(0, "SpecialKey", { fg = palette.dimmed2 })
    end

    apply_theme()

    local function apply_custom_transparency()
      if not is_transparent then
        return
      end

      for _, group in ipairs({ "NormalFloat", "FloatBorder" }) do
        local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
        if ok and hl then
          hl.bg = nil
          vim.api.nvim_set_hl(0, group, hl)
        end
      end
    end

    vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_custom_transparency })

    apply_custom_transparency()

    vim.keymap.set("n", "<leader>tb", function()
      is_transparent = not is_transparent
      apply_theme()
      print("Transparency: " .. tostring(is_transparent))
    end, { desc = "[T]oggle Transparent [B]ackground" })
  end,
}
