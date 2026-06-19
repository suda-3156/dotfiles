---@diagnostic disable: undefined-global
local M = {}

local function play_sound()
  local sysname = vim.uv.os_uname().sysname
  if sysname == "Darwin" then
    vim.fn.jobstart({ "afplay", "/System/Library/Sounds/Basso.aiff" }, { detach = true })
    -- elseif sysname == "Linux" then
    --   local ok = vim.fn.jobstart(
    --     { "paplay", "/usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga" },
    --     { detach = true }
    --   )
    --   if ok <= 0 then
    --     vim.fn.jobstart({ "aplay", "-q", "/usr/share/sounds/alsa/Front_Center.wav" }, { detach = true })
    --   end
    -- else
    --   vim.notify("alarm!", vim.log.levels.WARN, { title = "alarm" })
  end
end

--- Alert with a sound when the same key is typed consecutively.
---@param opts {keys: string|string[], count?: integer, modes?: string[]}
---@return integer ns  namespace id — pass to M.remove() to tear down
M.setup = function(opts)
  opts = opts or {}
  local threshold = opts.count or 5
  local raw_keys = opts.keys or {}
  local key_list ---@type string[]
  if type(raw_keys) == "string" then
    key_list = vim.split(raw_keys, "")
  else
    key_list = raw_keys
  end
  local letter_set = {}
  for _, l in ipairs(key_list) do
    letter_set[l] = true
  end
  local mode_set = {}
  for _, m in ipairs(opts.modes or { "n", "i" }) do
    mode_set[m] = true
  end

  local ns = vim.api.nvim_create_namespace("alarm_" .. tostring(vim.uv.hrtime()))
  local last_key, count = nil, 0

  vim.on_key(function(key)
    if not mode_set[vim.fn.mode()] or not letter_set[key] then
      last_key, count = nil, 0
      return
    end
    if key == last_key then
      count = count + 1
    else
      last_key, count = key, 1
    end
    if count >= threshold then
      count = 0
      vim.schedule(play_sound)
    end
  end, ns)

  return ns
end

---@param ns integer
M.remove = function(ns)
  vim.on_key(nil, ns)
end

return M
