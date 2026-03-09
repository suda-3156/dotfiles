return {
  'b0o/incline.nvim',
  event = 'BufReadPost',
  dependencies = {
    'SmiteshP/nvim-navic',
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    local navic = require 'nvim-navic'
    local devicons = require 'nvim-web-devicons'

    -- Monokai Pro Octagon palette (relevant subset)
    local palette = {
      mantle = '#1e1f2b',
      muted  = '#696d77',
      red    = '#ff657a',
      orange = '#ff9b5e',
      purple = '#a8a9e0',
    }

    local fg_active   = palette.purple
    local fg_inactive = palette.muted

    local diag_icons = { error = '󰅚 ', warn = '󰀪 ', hint = '󰌶 ', info = ' ' }

    --- @param props { buf: number, win: number, focused: boolean }
    local function get_diagnostic_label(props)
      local label = {}
      for severity, icon in pairs(diag_icons) do
        local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
        if n > 0 then
          table.insert(label, {
            icon .. n .. ' ',
            group = props.focused and ('DiagnosticSign' .. severity) or 'NonText',
          })
        end
      end
      if #label > 0 then
        table.insert(label, { '┊ ', guifg = fg_inactive })
      end
      return label
    end

    --- @param bufnr number
    local function get_dirname_and_filename(bufnr)
      local fullpath = vim.api.nvim_buf_get_name(bufnr)
      local filename = vim.fn.fnamemodify(fullpath, ':t')
      if filename == '' then
        return nil, '[No Name]'
      end
      local dirname = vim.fn.fnamemodify(fullpath, ':h:t')
      return dirname, filename
    end

    --- @param props { buf: number, win: number, focused: boolean }
    local function render(props)
      local dirname, filename = get_dirname_and_filename(props.buf)
      local ft_icon, ft_color = devicons.get_icon_color(filename)

      local hasError   = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity['ERROR'] }) > 0
      local isReadonly = vim.bo[props.buf].readonly

      local fg_filename_active = hasError and palette.red or (isReadonly and palette.muted or fg_active)
      local fg_filename = props.focused and fg_filename_active or fg_inactive

      local res = {
        { get_diagnostic_label(props) },
        {
          ft_icon and (ft_icon .. ' ') or '',
          guifg = props.focused and ft_color or fg_inactive,
        },
        {
          isReadonly and ' ' or '',
          guifg = fg_filename,
        },
        {
          dirname and (dirname .. '/') or '',
          guifg = fg_inactive,
        },
        {
          filename,
          guifg = fg_filename,
          gui = props.focused and 'bold' or '',
        },
        {
          vim.bo[props.buf].modified and ' ●' or '',
          guifg = props.focused and palette.orange or fg_inactive,
        },
      }

      -- Navic breadcrumbs appended after filename (focused only)
      if props.focused then
        for _, item in ipairs(navic.get_data(props.buf) or {}) do
          table.insert(res, {
            { ' > ', guifg = fg_inactive },
            { item.icon, group = 'NavicIcons' .. item.type },
            { item.name, group = 'NavicText' },
          })
        end
      end

      return res
    end

    require('incline').setup {
      highlight = {
        groups = {
          InclineNormal   = { guibg = palette.mantle, guifg = fg_active },
          InclineNormalNC = { guibg = 'none', guifg = fg_inactive },
        },
      },
      window = {
        options  = { winblend = 0 },
        placement = { horizontal = 'right', vertical = 'bottom' },
        margin  = { horizontal = 0, vertical = 0 },
        padding = 2,
      },
      render = render,
    }
  end,
}
