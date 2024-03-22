local util = require('papercolor.util')
local theme = require('papercolor.theme')
local config = require('papercolor.config')

local M = {}

---@param opts Config|nil
function M.load(opts)
  if opts then
    require('papercolor.config').extend(opts)
  end
  util.load(theme.setup())
end

M.setup = config.setup

-- keep for backward compatibility
-- M.colorscheme = M.load

return M

