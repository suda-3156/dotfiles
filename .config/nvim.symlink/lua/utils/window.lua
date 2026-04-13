local M = {}

---@alias ResizeDirection "left" | "right" | "up" | "down"

---Resize a normal (non-floating) window so the separator always moves
---in the direction of the arrow key, regardless of which side the window
---is on. nvim_win_set_width/height moves the edge shared with a neighbor;
---when no such neighbor exists in the forward direction, the opposite edge
---is the free one, so the delta must be flipped.
---:h window-resize
---@param window integer window id, 0 = current window
---@param direction ResizeDirection
---@param amount integer
local function resize_normal(window, direction, amount)
  local axis = (direction == "up" or direction == "down") and "height" or "width"
  local setter = vim.api["nvim_win_set_" .. axis]
  local getter = vim.api["nvim_win_get_" .. axis]

  -- Check whether the window has a neighbor in the "forward" direction
  -- (right for horizontal, bottom for vertical).
  local no_forward_neighbor
  if direction == "left" or direction == "right" then
    no_forward_neighbor = vim.fn.winnr("l") == vim.fn.winnr()
  else
    no_forward_neighbor = vim.fn.winnr("j") == vim.fn.winnr()
  end

  local shrink = (direction == "up" or direction == "left")
  if no_forward_neighbor then
    shrink = not shrink
  end

  setter(window, shrink and getter(window) - amount or getter(window) + amount)
end

---Detect whether the current window is float or not
---:h floating-windows
---@param window integer window id, 0 = current window
---@return boolean
function M.is_float(window)
  if vim.api.nvim_win_get_config(window).relative ~= "" then
    return true
  else
    return false
  end
end

---Resolve the viewport the current floating window is positioned relative to.
---@param window integer window id
-- @return integer?, integer?
local function get_float_viewport(window)
  local cfg = vim.api.nvim_win_get_config(window)
  if cfg.relative == "editor" then
    return vim.o.columns, vim.o.lines
  elseif cfg.relative == "win" then
    local anchor = (cfg.win ~= nil and cfg.win ~= 0) and cfg.win or vim.api.nvim_get_current_win()
    return vim.api.nvim_win_get_width(anchor), vim.api.nvim_win_get_height(anchor)
  end
end

---Detect whether the current floating window is centered.
---If the current window is not float, then return false.
---@param window integer window id, 0 = current window
---@return boolean
function M.is_center(window)
  if not M.is_float(window) then
    return false
  end

  local cfg = vim.api.nvim_win_get_config(window)
  local vp_w, vp_h = get_float_viewport(window)
  if not vp_w then
    return false
  end

  local width = cfg.width or vim.api.nvim_win_get_width(window)
  local height = cfg.height or vim.api.nvim_win_get_height(window)
  return math.abs(cfg.col - math.floor((vp_w - width) / 2)) <= 1
    and math.abs(cfg.row - math.floor((vp_h - height) / 2)) <= 1
end

---Resize the current floating window, keeping it centered if it was centered.
---:h api-floatwin
---@param window integer window id, 0 = current window
---@param direction ResizeDirection
---@param amount integer
local function resize_float(window, direction, amount)
  local cfg = vim.api.nvim_win_get_config(window)
  local width = cfg.width or vim.api.nvim_win_get_width(window)
  local height = cfg.height or vim.api.nvim_win_get_height(window)
  local vp_w, vp_h = get_float_viewport(window)
  local is_centered = M.is_center(window)

  -- Reconfigure the float with its full config; partial updates like only row/col
  -- can fail because floating windows require the relative positioning fields too.
  if direction == "left" then
    cfg.width = width - amount
  elseif direction == "right" then
    cfg.width = width + amount
  elseif direction == "up" then
    cfg.height = height - amount
  else
    cfg.height = height + amount
  end

  -- Recompute col/row so the window stays centered after the resize.
  if is_centered then
    cfg.col = math.floor((vp_w - cfg.width) / 2)
    cfg.row = math.floor((vp_h - cfg.height) / 2)
  end

  vim.api.nvim_win_set_config(window, cfg)
end

--- Resize the current window
---@param window integer window id, 0 = current window
---@param direction ResizeDirection
---@param amount integer
function M.resize(window, direction, amount)
  if M.is_float(window) then
    resize_float(window, direction, amount)
  else
    resize_normal(window, direction, amount)
  end
end

return M
