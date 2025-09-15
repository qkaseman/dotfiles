-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

local function augroup(name)
  return vim.api.nvim_create_augroup('user_' .. name, { clear = true })
end

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup('highlight-yank'),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Remove all trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  command = [[:%s/\s\+$//e]],
  group = augroup('trim-whitespace'),
})

-- Automatically reload buffers when contents are changed externally.
--
-- TODO: why does this need an autocommand vs setting `autoread` option?
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd('checktime')
    end
  end,
})
