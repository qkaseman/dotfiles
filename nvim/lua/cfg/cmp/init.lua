-- Setup nvim-cmp.
--
-- Taken mostly from:
-- https://github.com/hrsh7th/nvim-cmp/#recommended-configuration

local ok, cmp = pcall(require, 'cmp')
if not ok then
  return
end

local ok, luasnip = pcall(require, 'luasnip')
if not ok then
  return
end

local has_words_before = function()
  local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,longest,preview'

require('cmp-npm').setup({})

cmp.setup({
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
  formatting = {
    format = require('lspkind').cmp_format({
      with_text = true,
      menu = {
        nvim_lsp = '[LSP]',
        nvim_lua = '[Lua]',
        buffer = '[BUF]',
      },
    }),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ['<Tab>'] = cmp.mapping(
      function(fallback)
        -- if luasnip.expand_or_jumpable() then
        --   luasnip.expand_or_jump()
        if luasnip.jumpable(1) then
          luasnip.jump(1)
        elseif cmp.visible() then
          cmp.select_next_item()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end,
      { 'i', 's' }
    ),
    ['<S-Tab>'] = cmp.mapping(
      function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        elseif cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end,
      { 'i', 's' }
    ),
  }),
  sources = cmp.config.sources({
    { name = 'npm', keyword_length = 4 }, -- only active in 'package.json'
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' }, -- emphasize current arg
    { name = 'nvim_lua' }, --nvim lua api
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
})

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
