return {
  'mcauley-penney/visual-whitespace.nvim',
  event = 'BufReadPost',
  config = function()
    local palette = require('monokai-pro').get_palette 'octagon'

    -- Apply the same opacity as the modes.nvim
    local function blend(fg_hex, bg_hex, alpha)
      local function parse(hex)
        hex = hex:gsub('#', '')
        return { tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16) }
      end
      local fg = parse(fg_hex)
      local bg = parse(bg_hex)
      local ch = function(i)
        return math.floor(math.min(math.max(0, alpha * fg[i] + (1 - alpha) * bg[i]), 255) + 0.5)
      end
      return string.format('#%02X%02X%02X', ch(1), ch(2), ch(3))
    end

    local normal_bg = string.format('#%06X', vim.api.nvim_get_hl(0, { name = 'Normal' }).bg or 0)
    local blended = blend(palette.accent6, normal_bg, 0.4)

    vim.api.nvim_set_hl(0, 'VisualNonText', { fg = '#5D5F71', bg = blended })

    -- Highlight special/invisible Unicode whitespace characters:
    -- From: https://zenn.dev/kawarimidoll/articles/450a1c7754bde6
    -- u00A0 ' ' no-break space -- FIXME: In my nvim, this is not Highlighted.
    -- u2000 ' ' en quad
    -- u2001 ' ' em quad
    -- u2002 ' ' en space
    -- u2003 ' ' em space
    -- u2004 ' ' three-per em space
    -- u2005 ' ' four-per em space
    -- u2006 ' ' six-per em space
    -- u2007 ' ' figure space
    -- u2008 ' ' punctuation space
    -- u2009 ' ' thin space
    -- u200A ' ' hair space
    -- u200B '​' zero-width space
    -- u3000 '　' ideographic (zenkaku) space
    vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = blend(palette.accent1, normal_bg, 0.4) })
    vim.api.nvim_set_hl(0, 'TrailingWhitespace', { bg = blend(palette.accent1, normal_bg, 0.4) })

    local matches = {
      -- u00A0 no-break space, u2000-u200B various Unicode spaces, u3000 ideographic space
      { group = 'ExtraWhitespace', pattern = '[\\u00A0\\u2000-\\u200B\\u3000]' },
      -- Trailing spaces/tabs at end of line (all modes)
      { group = 'TrailingWhitespace', pattern = '\\s\\+$' },
    }

    local function add_matches()
      if vim.bo.buftype == 'terminal' then
        return
      end
      local existing = {}
      for _, m in ipairs(vim.fn.getmatches()) do
        existing[m.group] = true
      end
      for _, m in ipairs(matches) do
        if not existing[m.group] then
          vim.fn.matchadd(m.group, m.pattern)
        end
      end
    end

    add_matches()
    vim.api.nvim_create_autocmd('WinNew', { callback = add_matches })
    vim.api.nvim_create_autocmd('TermOpen', {
      callback = function()
        for _, m in ipairs(vim.fn.getmatches()) do
          if m.group == 'ExtraWhitespace' or m.group == 'TrailingWhitespace' then
            vim.fn.matchdelete(m.id)
          end
        end
      end,
    })
  end,
}
