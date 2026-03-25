---@type LazyPluginSpec
return {
  "https://github.com/rmagatti/auto-session",
  lazy = false,
  config = function()
    local app_name = vim.env.NVIM_APPNAME or "nvim"

    require("auto-session").setup({
      suppressed_dirs = { "~/", "~/Downloads", "/", "~/Documents/*" },
      bypass_save_filetypes = { "alpha", "dashboard", "snacks_dashboard" },
      log_level = "info",

      -- Sessions older than purge_after_minutes will be deleted asynchronously on startup
      purge_after_minutes = 14400,

      root_dir = "/tmp/" .. app_name .. "/sessions/",

      session_lens = {
        picker = nil, -- Disable session lens
        mappings = {
          delete_session = nil,
          alternate_session = nil,
          copy_session = nil,
        },
      },

      session_control = {
        -- Auto session control dir, for control files, like alternating between two sessions with session-lens
        control_dir = "/tmp/" .. app_name .. "/auto_session/",
      },

      post_restore_cmds = {
        -- Re-fire BufReadPost for all loaded buffers so treesitter (and other
        -- plugins that attach on that event) can re-attach after session restore.
        function()
          vim.schedule(function()
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) ~= "" then
                vim.api.nvim_exec_autocmds("BufReadPost", { buffer = buf })
              end
            end
          end)
        end,
      },
    })
  end,
}
