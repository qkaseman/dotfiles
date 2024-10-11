local ok, cfg = pcall(require, 'nvim-treesitter.configs')
if not ok then
  return
end

cfg.setup {
  -- Just install everything. Is a bit of bloat but space is cheap.
  ensure_installed = 'all',

  highlight = {
    enable = true,
    -- Disable slow highlighting for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
}

vim.cmd('set foldmethod=expr')
vim.cmd('set foldexpr=nvim_tresitter#foldexpr()')
vim.cmd('set foldnestmax=5')
