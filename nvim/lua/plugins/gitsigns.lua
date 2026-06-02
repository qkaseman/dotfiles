-- Wrap LazyVim's gitsigns `on_attach` to relocate hunk keys from
-- `<leader>gh*` to `<leader>h*` (kickstart-style) while keeping LazyVim's
-- bracket nav (`]h`/`[h`/`]H`/`[H`/`ih`) intact.
--
-- The wrap pattern is canonical for extending plugin opts that include
-- functions: `opts = function(_, opts)` receives the merged opts so we
-- can capture the original `on_attach`, then replace it with a closure
-- that calls the original first and adjusts after.

return {
  'lewis6991/gitsigns.nvim',
  opts = function(_, opts)
    opts.update_debounce = 500
    local lazyvim_on_attach = opts.on_attach

    opts.on_attach = function(buffer)
      lazyvim_on_attach(buffer) -- LazyVim's `[h`/`]h`/etc + `<leader>gh*`

      -- Remove LazyVim's `<leader>gh*` hunk keymaps from this buffer.
      for _, k in ipairs({ 's', 'r', 'S', 'u', 'R', 'p', 'b', 'B', 'd', 'D' }) do
        pcall(vim.keymap.del, 'n', '<leader>gh' .. k, { buffer = buffer })
      end
      pcall(vim.keymap.del, 'x', '<leader>ghs', { buffer = buffer })
      pcall(vim.keymap.del, 'x', '<leader>ghr', { buffer = buffer })

      -- Add `<leader>h*` equivalents.
      local gs = package.loaded.gitsigns
      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
      end

      map({ 'n', 'x' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', 'Stage Hunk')
      map({ 'n', 'x' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', 'Reset Hunk')
      map('n', '<leader>hS', gs.stage_buffer, 'Stage Buffer')
      map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo Stage Hunk')
      map('n', '<leader>hR', gs.reset_buffer, 'Reset Buffer')
      map('n', '<leader>hp', gs.preview_hunk_inline, 'Preview Hunk Inline')
      map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, 'Blame Line')
      map('n', '<leader>hB', function() gs.blame() end, 'Blame Buffer')
      map('n', '<leader>hd', gs.diffthis, 'Diff This')
      map('n', '<leader>hD', function() gs.diffthis('~') end, 'Diff This ~')
    end
  end,
}
