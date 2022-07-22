local ok, tree = pcall(require, 'nvim-tree')
if not ok then
  return
end

vim.g.nvim_tree_highlight_opened_files = 1

tree.setup({
  git = {
    ignore = false,
  },
})

vim.keymap.set('n', '<leader>n', ':NvimTreeFindFileToggle<CR>', { noremap = true, silent = true })
