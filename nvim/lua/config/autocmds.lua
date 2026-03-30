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

-- Resize splits if the window size changed.
--
-- WARN: This will evenly distribute space between splits!
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup('resize_splits'),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- Enable text wrapping and spell check for specific filetypes.
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('wrap_spell'),
  pattern = { 'text', 'plaintex', 'typst', 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Automatically create missing directories when saving a file.
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup('auto_create_dir'),
  callback = function(event)
    if event.match:match('^%w%w+:[\\/][\\/]') then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- Open buffers with cursor in the position it was when the buffer closed.
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('last_loc'),
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc_checked then
      return
    end
    vim.b[buf].last_loc_checked = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close helper windows with `q`.
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'help', 'man', 'qf', 'notify', 'checkhealth',
    'lspinfo', 'startuptime', 'gitsigns-blame', 'grug-far', 'trouble',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- LazyVim's pre-defined autocmds are:
-- 1. Automatically reload the file when it changes (triggered on certain events like focus gain).
-- 2. Highlights text when yanked (copied).
-- 3. Resizes all window splits if the Vim window is resized.
-- 4. Automatically returns to the last cursor location when reopening a buffer, except for certain file types (e.g., gitcommit).
-- 5. Binds <q> to close certain filetypes (like help, LSP info, and test panels) for easier quitting.
-- 6. Man files opened inline are set as unlisted to prevent clutter in buffer lists.
-- 7. Enables word wrap and spell checking for text-related filetypes (markdown, gitcommit, etc.).
-- 8. Disables JSON file concealment for better readability.
-- 9. Automatically creates missing directories when saving a file, ensuring that any intermediate directories are created if needed.
-- 10. Adds custom filetype detection logic to handle large files ("bigfile"), disables certain animations, and adjusts syntax highlighting to improve performance.

-- Disable line numbers and enter insert mode when opening a terminal
-- vim.api.nvim_create_autocmd("TermOpen", {
--   group = augroup("term_open"),
--   callback = function()
--     vim.opt_local.number = false
--     vim.opt_local.relativenumber = false
--     vim.cmd("startinsert")
--   end,
-- })

-- Set filetype to "helm" for specific YAML template and helm-related files
-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
--   pattern = { "*.*/templates/*.yaml", "*/templates/*.tpl", "*.gotmpl", "helmfile*.yaml" },
--   callback = function()
--     vim.opt_local.filetype = "helm"
--   end,
-- })
