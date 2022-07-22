local ws_regex = "\\s\\+"

function RSTRIP()
  -- Only do if the buffer is modifiable
  if not vim.bo.modifiable or vim.o.binary and vim.o.filetype == 'diff' then
    return
  end

  local view = vim.fn.winsaveview()
  vim.cmd("silent! keeppatterns %s/"..ws_regex.."$//e")
  vim.fn.winrestview(view)
end

function HL_WHITESPACE()
    vim.cmd("silent! keeppatterns match ErrorMsg /"..ws_regex.."$/")
end

local au = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup('whitespace', { clear = true })
au({ 'BufRead', 'BufWrite' }, { group = group, callback = RSTRIP } )
-- Doesn't work nicely with floating windows and there is automatic stripping
-- so lets try not worrying about the highlight.
--au({ 'BufWinEnter', 'WinEnter' }, { group = group, callback = HL_WHITESPACE } )
