-- Simple plugins with minimal configurations. Any complicated configs should
-- have their own config module.
--
-- NOTE: Use `opts = {}` to force a plugin to be loaded.
return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { -- Highlight todo, notes, etc in comments
    -- Below are the highlighted keywords as well as some oddly spaced
    -- instances to see how the highlighting works.
    -- TODO: todo comment
    --FIXME: no space fixme comment
    --  WARN: offset warning comment
    -- HACK no colon hacky code comment
    -- PERF: code performance comment
    -- NOTE: note comment
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      highlight = {
        -- `before` doesn't apply to multi-line comments well, their leading
        -- characters don't get changed so it looks weird.
        before = '', -- Set how to highlight the comment characters.
        keyword = 'bg', -- Set how to highlight the keyword itself.
        after = 'fg', -- Set how to highlight the rest of the comment.
        pattern = [[.*<((KEYWORDS):?)\s*]], -- Highlight colon if present.
      },
      signs = false,
    },
  },
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require('mini.statusline')
      -- set use_icons to true if you have a Nerd Font
      statusline.setup({ use_icons = vim.g.have_nerd_font })

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
