local M = {}

M.script = vim.env.HOME .. "/dotfiles/bin/oda"

---@param app_name string
local function activate_app(app_name)
  if app_name == "" then
    return
  end

  local escaped = app_name:gsub("\\", "\\\\"):gsub('"', '\\"')
  vim.system({
    "osascript",
    "-e",
    string.format('tell application "%s" to activate', escaped),
  })
end

---@return string
local function get_frontmost_app()
  local result = vim
    .system({
      "osascript",
      "-e",
      'tell application "System Events" to get name of first application process whose frontmost is true',
    }, { text = true })
    :wait()

  if result.code ~= 0 then
    return ""
  end
  return vim.trim(result.stdout or "")
end

---Open daily note generating it if not exists
---@param day? string The day to open the daily note
function M.open_daily(day)
  local frontmost_app = get_frontmost_app()
  local command = { M.script, "--print-path" }
  if day and day ~= "" then
    table.insert(command, day)
  end

  vim.system(command, { text = true }, function(result)
    vim.schedule(function()
      if result.code ~= 0 then
        vim.notify(vim.trim(result.stderr or "Failed to open daily note."), vim.log.levels.ERROR)
        activate_app(frontmost_app)
        return
      end

      local path = vim.trim(result.stdout or "")
      if path == "" then
        vim.notify(
          "The script to open daily notes (" .. M.script .. ") returned an empty note path.",
          vim.log.levels.ERROR
        )
        activate_app(frontmost_app)
        return
      end

      vim.cmd.edit(vim.fn.fnameescape(path))
      activate_app(frontmost_app)
    end)
  end)
end

return M
