-- :h group-name
-- :h highlight-groups
-- :h diagnostic-highlights'
-- :highlight

local p = {}

local is_transparent = true
local themes = {}

local function apply_custom_transparency()
  for _, group in ipairs({ "NormalFloat", "FloatBorder" }) do
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
    if ok and hl then
      hl.bg = nil
      ---@diagnostic disable-next-line: param-type-mismatch
      vim.api.nvim_set_hl(0, group, hl)
    end
  end
end

local function apply_current_theme()
  local name = vim.g.colors_name
  if themes[name] then
    themes[name](is_transparent)
  end
end

-- Default
-- https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/palette.lua
p[#p + 1] = {
  "https://github.com/navarasu/onedark.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- Register shared keymap and autocmd here (priority=1000 ensures this runs first)
    vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_custom_transparency })
    vim.keymap.set("n", "<leader>tt", function()
      is_transparent = not is_transparent
      apply_current_theme()
      print("Transparency: " .. tostring(is_transparent))
    end, { desc = "Toggle Background Transparency" })

    local function apply(transparent)
      require("onedark").setup({
        style = "darker",
        transparent = transparent,
        cmp_itemkind_reverse = false,
        colors = {
          grey = "#717782", -- Default: "#5c6370"
        },
        highlights = {},
      })
      require("onedark").load()
    end

    themes["onedark"] = apply
    apply(is_transparent)
  end,
}

p[#p + 1] = {
  "https://github.com/loctvl842/monokai-pro.nvim",
  lazy = false,
  config = function()
    for _, variant in ipairs({
      "monokai-pro",
      "monokai-pro-octagon",
      "monokai-pro-classic",
      "monokai-pro-machine",
      "monokai-pro-ristretto",
      "monokai-pro-spectrum",
    }) do
      local v = variant
      themes[v] = function(transparent)
        require("monokai-pro").setup({
          transparent_background = transparent,
          terminal_colors = true,
          devicons = true,
          filter = "octagon",
          inc_search = "background",
          override = function()
            local palette = require("monokai-pro").get_palette("octagon")
            return {
              Comment = { fg = palette.dimmed1, italic = false },
            }
          end,
        })
        vim.cmd.colorscheme(v)
      end
    end
  end,
}

p[#p + 1] = {
  "https://github.com/catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  config = function()
    for _, variant in ipairs({
      "catppuccin",
      "catppuccin-latte",
      "catppuccin-frappe",
      "catppuccin-macchiato",
      "catppuccin-mocha",
    }) do
      local v = variant
      themes[v] = function(transparent)
        require("catppuccin").setup({ transparent_background = transparent })
        vim.cmd.colorscheme(v)
      end
    end
  end,
}

p[#p + 1] = {
  "https://github.com/rebelot/kanagawa.nvim",
  lazy = false,
  config = function()
    for _, variant in ipairs({ "kanagawa", "kanagawa-wave", "kanagawa-dragon", "kanagawa-lotus" }) do
      local v = variant
      themes[v] = function(transparent)
        require("kanagawa").setup({ transparent = transparent })
        vim.cmd.colorscheme(v)
      end
    end
  end,
}

p[#p + 1] = {
  "https://github.com/rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  config = function()
    for _, variant in ipairs({ "rose-pine", "rose-pine-main", "rose-pine-moon", "rose-pine-dawn" }) do
      local v = variant
      themes[v] = function(transparent)
        require("rose-pine").setup({ disable_background = transparent })
        vim.cmd.colorscheme(v)
      end
    end
  end,
}

return p
