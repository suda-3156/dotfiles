return {
  'rmagatti/auto-session',
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/', '~/Documents/*' },
    bypass_save_filetypes = { 'alpha', 'dashboard', 'snacks_dashboard' },
    -- log_level = 'debug',
    root_dir = '/tmp' .. '/sessions/',
    session_lens = {
      mappings = {
        delete_session = nil,
        alternate_session = nil,
        copy_session = nil,
      },
    },
    session_control = {
      control_dir = '/tmp' .. '/auto_session/', -- Auto session control dir, for control files, like alternating between two sessions with session-lens
      control_filename = 'session_control.json', -- File name of the session control file
    },
    post_restore_cmds = {
      function()
        -- Re-fire BufReadPost for all loaded buffers so treesitter (and other
        -- plugins that attach on that event) can re-attach after session restore.
        vim.schedule(function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) ~= '' then
              vim.api.nvim_exec_autocmds('BufReadPost', { buffer = buf })
            end
          end
        end)
      end,
    },
  },
}
