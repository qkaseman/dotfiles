local util = require('papercolor.util')

local M = {}

---@class Palette
M.light = {
  none = 'NONE',
  color00 = '#eeeeee', -- black
  color01 = '#af0000', -- dark red
  color02 = '#008700', -- dark green
  color03 = '#5f8700', -- dark yellow
  color04 = '#0087af', -- dark blue
  color05 = '#878787', -- dark magenta
  color06 = '#005f87', -- dark cyan
  color07 = '#444444', -- light gray
  color08 = '#bcbcbc', -- dark gray
  color09 = '#d70000', -- light red (red2)
  color10 = '#d70087', -- light green (green2)
  color11 = '#8700af', -- light yellow (yellow2)
  color12 = '#d75f00', -- light blue (blue2)
  color13 = '#d75f00', -- light magenta (magenta2)
  color14 = '#005faf', -- light cyan (cyan2)
  color15 = '#005f87', -- white
  color16 = '#0087af', -- ?? (color11)
  color17 = '#008700', -- ?? (color13)
  color18 = '#8700af', -- ?? (color11)

  -- bg_dark = '#1f2335',
  -- bg = '#24283b',
  -- bg_highlight = '#292e42',
  -- terminal_black = '#414868',
  -- fg = '#c0caf5',
  -- fg_dark = '#a9b1d6',
  -- fg_gutter = '#3b4261',
  -- dark3 = '#545c7e',
  -- comment = '#565f89',
  -- dark5 = '#737aa2',
  -- blue0 = '#3d59a1',
  -- blue = '#7aa2f7',
  -- cyan = '#7dcfff',
  -- blue1 = '#2ac3de',
  -- blue2 = '#0db9d7',
  -- blue5 = '#89ddff',
  -- blue6 = '#b4f9f8',
  -- blue7 = '#394b70',
  -- magenta = '#bb9af7',
  -- magenta2 = '#ff007c',
  -- purple = '#9d7cd8',
  -- orange = '#ff9e64',
  -- yellow = '#e0af68',
  -- green = '#9ece6a',
  -- green1 = '#73daca',
  -- green2 = '#41a6b5',
  -- teal = '#1abc9c',
  -- red = '#f7768e',
  -- red1 = '#db4b4b',
}

M.default = M.light


---@return ColorScheme
function M.setup(opts)
  opts = opts or {}
  local config = require('papercolor.config')

  local style = (config.lightmode() and 'light' or 'dark')
  local palette = M[style] or {}

  -- Color Palette
  ---@class ColorScheme: Palette
  local colors = vim.tbl_deep_extend('force', vim.deepcopy(M.default), palette)

  -- The 16-color names are according to `:h cterm-colors`, the actual
  -- terminal colors can (and in this case are) different than the name
  -- suggests.
  -- colors.black = util.darken(colors.bg, 0.8, '#000000')
  colors.black = colors.color00
  colors.dark_red = colors.color01
  colors.dark_green = colors.color02
  colors.dark_yellow = colors.color03
  colors.dark_blue = colors.color04
  colors.dark_magenta = colors.color05
  colors.dark_cyan = colors.color06
  colors.light_gray = colors.color07

  colors.dark_gray = colors.color08
  colors.light_red = colors.color09
  colors.light_green = colors.color10
  colors.light_yellow = colors.color11
  colors.light_blue = colors.color12
  colors.light_magenta = colors.color13
  colors.light_cyan = colors.color14
  colors.white = colors.color15

  -- Semantic Layer
  colors.bg = colors.color00
  colors.bg_accent = colors.color00 -- bg_highlight
  colors.negative = colors.color01
  colors.positive = colors.color02
  colors.olive = colors.color03
  colors.neutral = colors.color04
  -- colors.comment = colors.color05
  colors.navy = colors.color06 -- storageclass
  colors.fg = colors.color07

  colors.nontext = colors.color08
  colors.red = colors.color09 -- import / try/catch
  colors.pink = colors.color10 -- statement, type
  colors.purple = colors.color11 -- if / conditional
  colors.accent = colors.color12
  colors.orange = colors.color13 -- number
  colors.blue = colors.color14 -- other keyword
  colors.hi = colors.color15

  colors.aqua = colors.color16
  colors.green = colors.color17
  colors.wine = colors.color18

  -- TODO: object with { primary: black, secondary: fg } ?
  -- possible 'normal' 'emphasis' 'diminish'
  -- and do this for 'bg' and 'fg' as well
  --
  -- colors.border_highlight = util.darken(colors.blue1, 0.8)
  -- colors.border = colors.black
  colors.border = colors.black
  colors.border_accent = colors.fg

  colors.comment = colors.color05
  colors.constant = colors.orange
  colors.string = colors.olive
  colors.character = colors.olive
  colors.number = colors.orange
  colors.boolean = colors.green
  colors.float = colors.orange
  colors.identifier = colors.navy
  colors.func = colors.fg -- 'function' is a reserved keyword
  colors.statement = colors.pink
  colors.conditional = colors.purple
  colors._repeat = colors.purple -- 'repeat' is a reserved keyword
  colors.label = colors.blue
  colors.operator = colors.aqua
  colors.keyword = colors.blue
  colors.exception = colors.red
  colors.pre_proc = colors.blue
  colors.include = colors.red
  colors.define = colors.blue
  colors.macro = colors.blue
  colors.pre_condit = colors.aqua
  colors.type = colors.pink
  colors.storage_class = colors.navy
  colors.structure = colors.blue
  colors.typedef = colors.pink
  colors.special = colors.fg
  colors.special_char = colors.fg
  colors.tag = colors.green
  colors.delimiter = colors.aqua
  colors.special_comment = colors.comment
  colors.title = colors.comment
  colors.global = colors.blue

  colors.todo = {
    -- todo_fg  = '#00af5f',
    -- todo_bg  = '#eeeeee',
    fg = colors.color04, -- colors.blue
    bg = colors.bg,
  }
  colors.hint = {
    fg = colors.color06, -- colors.teal (trace)
    bg = colors.bg,
  }
  colors.trace = {
    fg = colors.color06, -- colors.teal (trace)
    bg = colors.bg,
  }
  colors.debug = {
    fg = colors.orange,
    bg = colors.bg,
  }
  colors.info = {
    fg = colors.color12, -- colors.blue2
    bg = colors.bg,
  }
  colors.warn = {
    fg = colors.color03, -- colors.yellow
    bg = colors.bg,
  }
  colors.error = {
    -- error_fg  = '#af0000',
    -- error_bg  = '#ffd7ff',
    fg = colors.color01, -- colors.red1
    bg = colors.bg
  }
  colors.fatal = {
    fg = colors.color01,
    bg = colors.bg,
  }

  colors.bold = colors.fg
  colors.italic = colors.fg

  colors.spell = {
    -- bad =   '#ffafd7',
    -- cap =   '#ffffaf',
    -- rare =  '#afff87',
    -- _local = '#d7d7ff',
    bad = colors.color04,
    cap = colors.color05,
    rare = colors.color06,
    _local = colors.color01, -- 'local' is a keyword
  }

  -- Component Layer --
  -- TODO: Can any of these be simplified to semantic?
  colors.cursor = {
    -- fg = '#eeeeee',
    -- bg  = '#005f87',
    -- line  = '#e4e4e4',
    -- column  = '#e4e4e4',
    bg = colors.fg,
    fg = colors.bg,
    line = colors.color00,
    column = colors.color00,
    linenr = {
      --bg = '#af5f00',
      --fg = '#eeeeee',
      bg = colors.color00;
      fg = colors.color13;
    }
  }

  -- TODO: are 'gutter' and 'sidebar' actually the same?
  -- is 'gutter' the sign section and 'sidebar' the number line?
  -- or are both 'gutter' and 'sidebar' for things like nvimtree
  -- that pops up on the side. I'll probably do that, that makes
  -- sense to me.
  colors.gutter = {
    -- linenumber_bg  = '#eeeeee',
    -- linenumber_fg  = '#b2b2b2',
    bg = colors.bg,
    fg = colors.color08,
  }

  colors.sidebar = {
    -- colors.bg_sidebar = config.options.styles.sidebars == 'transparent' and colors.none
      -- or config.options.styles.sidebars == 'dark' and colors.bg_dark
      -- or colors.bg
    -- colors.fg_sidebar = colors.fg_dark
    bg = colors.bg,
    fg = colors.fg,
  }

  colors.diff = {
    -- TODO: need to care about fg & bg?
    -- diffadd_fg =    '#008700',
    -- diffadd_bg =    '#afffaf',
    -- diffdelete_fg = '#af0000',
    -- diffdelete_bg = '#ffd7ff',
    -- difftext_fg =   '#0087af',
    -- difftext_bg =   '#ffffd7',
    -- diffchange_fg = '#444444',
    -- diffchange_bg = '#ffd787',
    -- add = colors.color10, -- util.darken(colors.green2, 0.15),
    -- delete = colors.color01, -- util.darken(colors.red1, 0.15),
    -- change = colors.color07, -- util.darken(colors.blue7, 0.15),
    -- text = colors.color04, -- colors.blue7,
    add = colors.color02, -- util.darken(colors.green2, 0.15),
    delete = colors.color04, -- util.darken(colors.red1, 0.15),
    change = colors.color14, -- util.darken(colors.blue7, 0.15),
    text = colors.color06, -- colors.blue7,
  }

  colors.git = {
    -- gitSigns = { add = '#266d6a', change = '#536c9e', delete = '#b2555b', },
    ignore = colors.color08,
    -- TODO: Do I need this vs using the diff colours above?
    change = colors.color07,
    add = colors.color10,
    delete = colors.color01,
  }

  colors.popup = {
    -- Popups and statusline always get a dark background
    -- TODO: Should this be `d0d0d0` like in the vim PC theme?
    -- popupmenu_bg  = '#d0d0d0',
    -- popupmenu_fg  = '#444444',
    --
    -- colors.bg_float = config.options.styles.floats == 'transparent' and colors.none
      -- or config.options.styles.floats == 'dark' and colors.bg_dark
      -- or colors.bg
    -- colors.fg_float = config.options.styles.floats == 'dark' and colors.fg_dark or colors.fg
    bg = colors.color00,
    fg = colors.color07
  }

  colors.statusline = {
    active = {
      -- statusline_active_bg  = '#005f87',
      -- statusline_active_fg  = '#e4e4e4',
      bg = colors.color06,
      fg = colors.color08,
    },
    inactive = {
      -- statusline_inactive_bg  = '#d0d0d0',
      -- statusline_inactive_fg  = '#444444',
      bg = colors.color08,
      fg = colors.color06,
    }
  }

  -- VISUAL mode
  colors.visual = {
    -- colors.bg_visual = util.darken(colors.blue0, 0.4)
    -- visual_bg  = '#0087af',
    -- visual_fg  = '#eeeeee',
    bg = colors.color04,
    fg = colors.color00,
  }

  colors.search = {
    -- colors.bg_search = colors.blue0
    -- search_bg  = '#ffff5f',
    -- search_fg  = '#444444',
    bg = colors.color15,
    fg = colors.color00,
  }

  colors.incsearch = {
    -- colors.bg_search = colors.blue0
    -- incsearch_bg  = '#444444',
    -- incsearch_fg  = '#ffff5f',
    bg = colors.color15,
    fg = colors.color00,
  }

  colors.vertsplit = {
    -- vertsplit_bg  = '#eeeeee',
    -- vertsplit_fg  = '#005f87',
    bg  = colors.color00,
    fg  = colors.color15,
  }

  colors.matchparen = {
    -- matchparen_bg  = '#c6c6c6',
    -- matchparen_fg  = '#005f87',
    bg = colors.color05,
    fg = colors.color00,
  }

  colors.fold = {
    -- folded_bg  = '#afd7ff',
    -- folded_fg  = '#0087af',
    bg  = colors.color05,
    fg  = colors.color00,
  }

  colors.wildmenu = {
    -- wildmenu_bg = '#ffff00',
    -- wildmenu_fg = '#444444',
    bg = colors.color06,
    fg = colors.color00,
  }

  colors.tabline = {
    -- tabline_bg =          '#005f87',
    bg = colors.color00,
    fg = colors.color00,
    active = {
      -- tabline_active_bg =   '#e4e4e4',
      -- tabline_active_fg =   '#444444',
      bg = colors.color00,
      fg = colors.color07,
    },
    inactive = {
      -- tabline_inactive_bg = '#0087af',
      -- tabline_inactive_fg = '#eeeeee',
      bg = colors.color08,
      fg = colors.color07,
    },
    current = { -- only for buftabline
      -- buftabline_current_bg =  '#e4e4e4',
      -- buftabline_current_fg =  '#444444',
      bg = colors.color05,
      fg = colors.color07,
    }
  }

  -- colors.delta = {
    -- add = util.darken(colors.green2, 0.45),
    -- delete = util.darken(colors.red1, 0.45),
  -- }

  -- config.options.on_colors(colors)
  -- if opts.transform and config.is_day() then
    -- util.invert_colors(colors)
  -- end
  --

  return colors
end

return M
