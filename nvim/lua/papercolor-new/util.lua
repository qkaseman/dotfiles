local M = {}

M.bg = '#000000'
M.fg = '#ffffff'

---@param c  string
local function hexToRgb(c)
  c = string.lower(c)
  return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

---@param foreground string foreground color
---@param background string background color
---@param alpha number|string number between 0 and 1. 0 results in bg, 1 results in fg
function M.blend(foreground, background, alpha)
  alpha = type(alpha) == 'string' and (tonumber(alpha, 16) / 0xff) or alpha
  local bg = hexToRgb(background)
  local fg = hexToRgb(foreground)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format('#%02x%02x%02x', blendChannel(1), blendChannel(2), blendChannel(3))
end

-- @param hex string colour to darken
-- @param percent number percentage to darken, 100 is black, 0 is `hex`
-- @param bg string alternate to default pure black colour to blend with
function M.darken(hex, percent, bg)
  return M.blend(bg or M.bg, hex, percent/100.0)
end

-- @param hex string colour to lighten
-- @param percent number percentage to lighten, 100 is white, 0 is `hex`
-- @param fg string alternate to pure white colour to blend with
function M.lighten(hex, percent, fg)
  return M.blend(fg or M.fg, hex, percent/100.0)
end

return M
