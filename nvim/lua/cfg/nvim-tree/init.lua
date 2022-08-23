local ok, tree = pcall(require, 'nvim-tree')
if not ok then
  return
end

tree.setup({
  git = {
    ignore = false,
  },
  renderer = {
    highlight_opened_files = 'icon',
  },
  view = {
    mappings = {
      list = {
        { -- Remove annoying default bindings.
          key = {
            '<2-LeftMouse>', '<2-RightMouse>', '<C-e>', 'O', '<C-]>', '<', '>',
            '<Tab>', 'K', 'J', 'd', 'D', '<C-r>', 'x', 'c', 'p', '<C-v>',
            '<C-x>', '<C-t>', '[e', '[c', ']e', ']c', 'y', 'Y', 'gy', 'f', 'F',
            'S', '.', 'm', 'bmv',
          },
          action = ''
        },
        { key = { '<CR>', 'o' },                  action = 'edit' },
        { key = 'v',                              action = 'vsplit' },
        { key = 's',                              action = 'split' },
        { key = 't',                              action = 'tabnew' },
        { key = 'P',                              action = 'parent_node' },
        { key = '<BS>',                           action = 'close_node' },
        { key = 'I',                              action = 'toggle_git_ignored' },
        { key = 'H',                              action = 'toggle_dotfiles' },
        { key = 'U',                              action = 'toggle_custom' },
        { key = 'R',                              action = 'refresh' },
        { key = 'n',                              action = 'create' },
        { key = 'r',                              action = 'rename' },
        -- { key = 'y',                              action = 'copy_name' },
        -- { key = 'Y',                              action = 'copy_path' },
        -- { key = 'gy',                             action = 'copy_absolute_path' },
        { key = '-',                              action = 'dir_up' },
        -- { key = 'f',                              action = 'live_filter' },
        -- { key = 'F',                              action = 'clear_live_filter' },
        { key = 'q',                              action = 'close' },
        { key = 'W',                              action = 'collapse_all' },
        { key = 'E',                              action = 'expand_all' },
        { key = '<C-k>',                          action = 'toggle_file_info' },
        { key = 'g?',                             action = 'toggle_help' },
      },
    },
  },
})

vim.keymap.set('n', '<leader>n', ':NvimTreeFindFileToggle<CR>', { noremap = true, silent = true })
