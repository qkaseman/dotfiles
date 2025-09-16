-- [[ Setting options ]]
-- See `:help vim.o`
-- For all options, see `:help option-list`
--
-- `vim.o` is used over `vim.opt` b/c eventually it will be required and it
-- has better overall devex. The one exception is tables, so those still use
-- `vim.opt`.
local o = vim.o

-- UI --
o.number = true -- Numbers are good.
o.relativenumber = false -- But relative numbers are evil.
o.showmode = false -- Don't show mode since there is a statusline.
o.signcolumn = 'yes' -- Show signcolumn to avoid shifting text each time.
o.list = true -- Show whitespace characters.
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
o.inccommand = 'nosplit' -- Preview substitutions in buffer.
o.scrolloff = 10 -- Min rows between cursor and edge of buffer.
o.sidescrolloff = 5 -- Min columns between cursor and edge of buffer.
o.cursorline = true -- Highlight row with the cursor.
o.colorcolumn = '+1,80' -- Highlight 80th column and one past `textwidth`.
o.conceallevel = 0 -- Don't conceal things.
o.breakindent = true -- Wrapped lines have pseudo-indentation.
o.linebreak = true -- Wrap lines at convenient points.
vim.opt.shortmess:append({
  I = true, -- Suppress intro message.
  W = true, -- Suppress file write messages.
  c = true, -- Suppress completion messages.
  C = true, -- Suppress completion scanning messages.
})
o.splitright = true -- New vertical splits to the right of the current buffer.
o.splitbelow = true -- New splits below the current buffer.
o.splitkeep = 'screen' -- Keep view stable rather than cursor position.

--- Features ---
o.mouse = 'a' -- Enable the mouse.
o.clipboard = '' -- Don't use the system clipboard unless specified.
o.updatetime = 1000 -- Time between swapfile writes, in ms.
o.timeoutlen = vim.g.vscode and 1000 or 500 -- General timeout, in ms.
o.modeline = false -- Only use my configurations.
o.confirm = true -- If operation would fail, ask for confirm first.
o.virtualedit = 'block' -- Allow Visual Block cursor where there is no text.
o.spell = true -- Enable spellchecking, in code this only applies to comments.
o.undofile = true -- Save undo history.
o.undolevels = 10000 -- And lots of it.
o.ignorecase = true -- Case-insensitive search.
o.smartcase = true -- Unless `\C` or capital letters are present.
o.wildmode = 'longest:full,full' -- Command-line completion mode
o.expandtab = true -- Use spaces, not tabs.
o.shiftwidth = 2 -- Size of an indent.
o.tabstop = 2 -- Size of a tab, in spaces.
o.shiftround = true -- Round to multiples of `shiftwidth`.
o.autoindent = true -- Copy indent from current line to new line.
o.smartindent = true -- Attempt to intelligently indent from context.
vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings
