-- Override LazyVim's nvim-lint event triggers.
--
-- LazyVim default fires lints on `BufWritePost`, `BufReadPost`, AND
-- `InsertLeave`. The `InsertLeave` trigger means hitting Esc in a buffer
-- runs the linter every time, which is noisy (visible flicker, errors if
-- the linter binary is missing).
--
-- Restrict to save-and-load only.
return {
  'mfussenegger/nvim-lint',
  opts = {
    events = { 'BufWritePost', 'BufReadPost' },
  },
}
