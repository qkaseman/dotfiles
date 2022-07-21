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
    ["<C-k>"] = cmp.mapping.select_prev_item(),
	["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ["<Tab>"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end,
      { "i", "s", }
    ),
    ["<S-Tab>"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end,
      { "i", "s", }
    ),
  }),
  sources = cmp.config.sources({
    { name = 'npm', keyword_length = 4 }, -- only active in 'package.json'
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' }, -- emphasize current arg
    { name = 'nvim_lua' }, --nvim lua api
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  }),
})
