local ws_regex = "\\s\\+"

function rstrip()
  -- Only do if the buffer is modifiable
  if not vim.bo.modifiable or vim.o.binary and vim.o.filetype == 'diff' then
    return
  end

  local view = vim.fn.winsaveview()
  vim.cmd("silent! keeppatterns %s/"..ws_regex.."$//e")
  vim.fn.winrestview(view)
end

function hl_whitespace()
    vim.cmd("silent! keeppatterns match ErrorMsg /"..ws_regex.."$/")
end

local au = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup('whitespace', { clear = true })
au({ 'BufRead', 'BufWrite' }, { group = group, callback = rstrip } )
au({ 'BufWinEnter', 'WinEnter' }, { group = group, callback = hl_whitespace } )
