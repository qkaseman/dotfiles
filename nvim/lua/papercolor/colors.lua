local util = require('papercolor.util')

local M = {}

--[[
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
--]]

-- Liked old colours for search and errors before swapping to PC.
-- I might overall just like using the core colours with some
-- slight modifications rather than all of the subcolours.

M.light = {
  none              = 'NONE',
  color00           = '#eeeeee', -- black     | white       |
  color01           = '#af0000', -- maroon    | maroon      |
  color02           = '#008700', -- green     | green       |
  color03           = '#5f8700', -- olive     | olive       |
  color04           = '#0087af', -- navy      | cerulean    |
  color05           = '#878787', -- purple    | grey        |
  color06           = '#005f87', -- teal      | navy        |
  color07           = '#444444', -- silver    | charcoal    |
  color08           = '#bcbcbc', -- grey      | silver      |
  color09           = '#d70000', -- red       | red         |
  color10           = '#d70087', -- lime      | pink        |
  color11           = '#8700af', -- yellow    | purple      |
  color12           = '#d75f00', -- blue      | orange      |
  color13           = '#d75f00', -- fuchsia   |             |
  color14           = '#005faf', -- aqua      | denim       |
  color15           = '#005f87', -- white     | blue_lagoon |
  color16           = '#0087af', -- grey0     | blue        |
  color17           = '#008700', -- navy_blue |             |
  color18           = '#8700af', -- dark_blue | wine        |

  vertsplit = {
    -- bg  = colors.color00,
    -- bg = '#eeeeee',
    -- fg  = colors.color15,
    -- fg = '#005f87',
    fg              = '#005f87',
    bg              = '#eeeeee',
  },
  statusline = {
    active = {
      -- bg = colors.color06,
      -- fg = colors.color08,
      fg            = '#e4e4e4',
      bg            = '#005f87',
    },
    inactive = {
      -- bg = colors.color08,
      -- fg = colors.color06,
      fg            = '#444444',
      bg            = '#d0d0d0',
    },
  },
  todo = {
    -- old light was
    --fg = colors.color04, -- colors.blue
    --bg = colors.bg,
    fg              = '#00af5f',
    bg              = '#eeeeee',
  },
  error = {
    -- old light was
    --fg = colors.color01, -- colors.red1
    --bg = colors.bg
    fg              = '#af0000',
    bg              = '#ffd7ff',
  },
  matchparen = {
    -- bg = colors.color05,
    -- fg = colors.color00,
    fg              = '#005f87',
    bg              = '#c6c6c6',
  },
  visual = { -- could this be use for `inverse`?
    fg              = '#eeeeee',
    bg              = '#0087af',
  },
  folded = {
    -- bg  = colors.color05,
    -- fg  = colors.color00,
    fg              = '#0087af',
    bg              = '#afd7ff',
  },
  wildmenu = {
    -- bg = colors.color06,
    -- fg = colors.color00,
    fg              = '#444444',
    bg              = '#ffff00',
  },
  spell = {
    -- bad = colors.color04,
    -- bad = '#0087af',
    -- cap = colors.color05,
    -- cap = '#878787',
    -- rare = colors.color06,
    -- rare = '#005f87',
    -- _local = colors.color01,
    -- _local = '#af0000',
    bad             = '#ffafd7',
    cap             = '#ffffaf',
    rare            = '#afff87',
    _local          = '#d7d7ff', -- `local` is reserved keyword
  },
  diff = {
    -- gitSigns = { add = '#266d6a', change = '#536c9e', delete = '#b2555b', },
    -- ignore = colors.color08,
    add = {
      -- add = colors.color02, -- util.darken(colors.green2, 0.15),
      -- add = colors.color10,
      fg            = '#008700',
      bg            = '#afffaf',
    },
    delete = {
      -- delete = colors.color04, -- util.darken(colors.red1, 0.15),
      -- delete = colors.color01,
      fg            = '#af0000',
      bg            = '#ffd7ff',
    },
    text = {
      -- text = colors.color06, -- colors.blue7,
      fg            = '#0087af',
      bg            = '#ffffd7',
    },
    change = {
      -- change = colors.color14, -- util.darken(colors.blue7, 0.15),
      -- change = colors.color07,
      fg            = '#444444',
      bg            = '#ffd787',
    },
  },
  tabline = {
    -- bg = colors.color00,
    -- fg = colors.color00,
    fg              = '#eeeeee',-- had no equivalent
    bg              = '#005f87',
    active = {
      -- bg = colors.color00,
      -- fg = colors.color07,
      fg            = '#444444',
      bg            = '#e4e4e4',
    },
    inactive = {
      -- bg = colors.color08,
      -- fg = colors.color07,
      fg            = '#eeeeee',
      bg            = '#0087af',
    },
  },
  buftabline = {
    -- bg = colors.color00,
    -- fg = colors.color00,
    fg              = '#eeeeee',-- had no equivalent
    bg              = '#005f87',
    current = {
      -- bg = colors.color05,
      -- fg = colors.color07,
      fg            = '#444444',
      bg            = '#e4e4e4',
    },
    active = {
      -- bg = colors.color00,
      -- fg = colors.color07,
      fg            = '#eeeeee',
      bg            = '#005faf',
    },
    inactive = {
      -- bg = colors.color08,
      -- fg = colors.color07,
      fg            = '#eeeeee',
      bg            = '#0087af',
    },
  },
}

---@class Palette
M.dark = {
  none              = 'NONE',
  color00           = '#1c1c1c',
  color01           = '#af005f',
  color02           = '#5faf00',
  color03           = '#d7af5f',
  color04           = '#5fafd7',
  color05           = '#808080',
  color06           = '#d7875f',
  color07           = '#d0d0d0',
  color08           = '#585858',
  color09           = '#5faf5f',
  color10           = '#afd700',
  color11           = '#af87d7',
  color12           = '#ffaf00',
  color13           = '#ff5faf',
  color14           = '#00afaf',
  color15           = '#5f8787',
  color16           = '#5fafd7',
  color17           = '#d7af00',
  color18           = '#af87d7',
  cursor = {
    fg              = '#1c1c1c',
    bg              = '#c6c6c6',
  },
  cursorline        = '#303030',
  cursorcolumn      = '#303030',
  cursorlinenr = {
    fg              = '#ffff00',
    bg              = '#1c1c1c',
  },
  popupmenu = {
    fg              = '#c6c6c6',
    bg              = '#303030',
  },
  search = {
    fg              = '#000000',
    bg              = '#00875f',
  },
  incsearch = {
    fg              = '#00875f',
    bg              = '#000000',
  },
  linenumber = {
    fg              = '#585858',
    bg              = '#1c1c1c',
  },
  vertsplit = {
    fg              = '#5f8787',
    bg              = '#1c1c1c',
  },
  statusline = {
    active = {
      fg            = '#1c1c1c',
      bg            = '#5f8787',
    },
    inactive = {
      fg            = '#bcbcbc',
      bg            = '#3a3a3a',
    },
  },
  todo = {
    fg              = '#ff8700',
    bg              = '#1c1c1c',
  },
  error = {
    fg              = '#af005f',
    bg              = '#5f0000',
  },
  matchparen = {
    fg              = '#c6c6c6',
    bg              = '#4e4e4e',
  },
  visual = {
    fg              = '#000000',
    bg              = '#8787af',
  },
  folded = {
    fg              = '#d787ff',
    bg              = '#5f005f',
  },
  wildmenu = {
    fg              = '#1c1c1c',
    bg              = '#afd700',
  },
  spell = {
    bad             = '#5f0000',
    cap             = '#5f005f',
    rare            = '#005f00',
    _local          = '#00005f',
  },
  diff = {
    add = {
      fg            = '#87d700',
      bg            = '#005f00',
    },
    delete = {
      fg            = '#af005f',
      bg            = '#5f0000',
    },
    text = {
      fg            = '#5fffff',
      bg            = '#008787',
    },
    change = {
      fg            = '#d0d0d0',
      bg            = '#005f5f',
    },
  },
  tabline = {
    bg              = '#262626',
    active = {
      fg            = '#121212',
      bg            = '#00afaf',
    },
    inactive = {
      fg            = '#bcbcbc',
      bg            = '#585858',
    },
  },
  buftabline = {
    bg              = '#262626',
    current = {
      fg            = '#121212',
      bg            = '#00afaf',
    },
    active = {
      fg            = '#00afaf',
      bg            = '#585858',
    },
    inactive = {
      fg            = '#bcbcbc',
      bg            = '#585858',
    },
  },
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

  -- These colour names are based on xterm's colour names which can
  -- be found
  -- [here](https://www.ditig.com/publications/256-colors-cheat-sheet).
  -- The actual terminal colours can (and in this case are) different
  -- than the name suggests.
  colors.black = colors.color00
  colors.maroon = colors.color01
  colors.green = colors.color02
  colors.olive = colors.color03
  colors.navy = colors.color04
  colors.purple = colors.color05
  colors.teal = colors.color06
  colors.silver = colors.color07

  colors.grey = colors.color08
  colors.red = colors.color09 -- import / try/catch
  colors.lime = colors.color10
  colors.yellow = colors.color11
  colors.blue = colors.color12
  colors.fuchsia = colors.color13
  -- this was `blue`, old value for `aqua` was `color16`
  colors.aqua = colors.color14
  colors.white = colors.color15

  colors.grey0 = colors.color16
  colors.navy_blue = colors.color17 -- was colors.color06 -- storageclass
  colors.dark_blue = colors.color18

  colors.pc = {
    white = colors.black,
    maroon = colors.maroon,
    green = colors.green,
    olive = colors.olive,
    cerulean = colors.navy,
    grey = colors.purple,
    navy = colors.teal,
    charcoal = colors.silver,

    silver = colors.grey,
    red = colors.red,
    pink = colors.lime, -- statement, type
    purple = colors.yellow, -- if / conditional
    orange = colors.blue, -- number
    --orange = colors.fuchsia,

    denim = colors.aqua, -- other keyword
    blue_lagoon = colors.white,

    blue = colors.grey0,
    wine = colors.dark_blue,
  }

  --[[
  for "default" and for "container"
      Primary   | Default   | Normal
      Secondary | Contrast  | Emphasis
      Tertiary  | Subtle    | Diminish


Surface – A role used for backgrounds and large, low-emphasis areas of the screen.

Primary, Secondary, Tertiary – Accent color roles used to emphasize or de-emphasize foreground elements.

Container – Roles used as a fill color for foreground elements like buttons. They should not be used for text or icons.

On – Roles starting with this term indicate a color for text or icons on top of its paired parent color. For example, on primary is used for text and icons against the primary fill color.

Variant – Roles ending with this term offer a lower emphasis alternative to its non-variant pair. For example, outline variant is a less emphasized version of the outline color.

color.primary
color.on-primary

Look at this for how to structure the colours to use

https://github.com/material-foundation/material-tokens/blob/main/dsp/dist/styledictionary/properties/colors.json

primary
on-primary
primary-container
on-primary-container
secondary
on-secondary
secondary-container
on-secondary-container
tertiary
on-tertiary
tertiary-container
on-tertiary-container
error
on-error
error-container
on-error-container
surface-dim (darker)
surface
surface-bright (lighter)
inverse-surface
inverse-on-surface
inverse-primary
scrim
shadow
on-surface
on-surface-variant
outline
outline-variant

  --]]

  -- Semantic Layer
  -- need `container` ones? (things like popup-menus) ?
  -- need `surface` ones (wide general BG) ?
  -- need `inverse` ones (contrasting things) ?
  -- need `error` ones (prob no)?
  -- need `on-X` ones?
  colors.surface = {
    fg = colors.silver,
    bg = colors.black,
  }

  colors.surface_container = { -- popups
    -- Popups and statusline always get a dark background?

    -- colors.bg_float = config.options.styles.floats == 'transparent' and colors.none
      -- or config.options.styles.floats == 'dark' and colors.bg_dark
      -- or colors.bg
    -- colors.fg_float = config.options.styles.floats == 'dark' and colors.fg_dark or colors.fg
    fg = colors.silver,
    bg = colors.grey, -- #d0d0d0
  }

  colors.surface_container_low = { -- sidebar, linenumber, 'low' towards white
    fg              = util.darken(colors.grey, 5), -- '#b2b2b2', 5 gets #b3b3b3, 6 gets #b1b1b1,
    bg              = util.lighten(colors.surface.bg, 25),
  }

  colors.primary = { -- ??
    bg = colors.grey, -- highlight
    fg = colors.blue, -- accent
  }

  colors.secondary = { -- search?
    -- colors.bg_search = colors.blue0
    -- bg = colors.color15,
    bg = colors.teal,
    -- fg = colors.color00,
    fg = '#eeeeee',
    -- fg              = '#444444',
    -- bg              = '#ffff5f',

    -- incsearch
    -- colors.bg_search = colors.blue0
    -- fg              = '#ffff5f',
    -- fg = colors.color00,
    -- fg = '#eeeeee',
    -- bg              = '#444444',
    -- alternatively, `bg = color.navy`, but that seems too light
    -- bg = colors.color15,
    -- bg = '#005f87',
  }

  colors.tertiary = { -- statusline inactive
    fg = colors.grey, -- nontext
  }

  colors.cursor = {
    fg = colors.black,
    bg = colors.teal,
  }

  -- I think having cursorline on and the cursorline colour
  -- being the same as the default bg colour and then have
  -- the cursorlinenr being set.
  -- cursorline = colors.color00,
  -- colors.cursorline        = '#e4e4e4',
  colors.cursorline = util.darken(colors.surface.bg, 90)
  colors.cursorcolumn = colors.cursorline
  colors.cursorlinenr = { -- this could also be used for `inverse` on the secondary
                          -- or de-emphasized surface colour.
    -- bg = colors.color00;
    -- fg = colors.color13;
    -- fg = '#d75f00',
    fg              = '#af5f00',
    bg              = colors.cursorline,
  }

  colors.bg = colors.black
  colors.bg_accent = colors.silver
  colors.fg = colors.silver

  colors.sentiment = {
    negative = colors.maroon,
    positive = colors.green,
    neutral = colors.navy,
  }

  -- TODO: object with { primary: black, secondary: fg } ?
  -- possible 'normal' 'emphasis' 'diminish'
  -- and do this for 'bg' and 'fg' as well
  --
  -- colors.border_highlight = util.darken(colors.blue1, 0.8)
  -- colors.border = colors.black
  colors.border = colors.black
  colors.border_accent = colors.fg
  colors.borders = {
    primary = colors.black,
    accent = colors.fg,
  }

  colors.syntax = {
    comment = colors.pc.grey,
    special_comment = colors.pc.grey, -- comment,

    constant = colors.pc.orange,

    string = colors.pc.olive,
    character = colors.pc.olive,

    number = colors.pc.orange,
    float = colors.pc.orange,
    boolean = colors.pc.green,

    identifier = colors.pc.green, -- navy
    func = colors.pc.charcoal, -- fg
    statement = colors.pc.pink,
    conditional = colors.pc.purple,
    _repeat = colors.pc.purple,
    label = colors.pc.orange, -- blue
    operator = colors.pc.denim, -- aqua,
    keyword = colors.pc.orange, -- blue
    exception = colors.pc.red,

    pre_proc = colors.pc.orange, -- blue
    include = colors.pc.red,
    define = colors.pc.orange, -- blue,
    macro = colors.pc.orange, -- blue,
    pre_condit = colors.pc.denim, -- aqua,

    type = colors.pc.pink,
    storage_class = colors.pc.green, -- navy,
    structure = colors.pc.orange, -- blue,
    typedef = colors.pc.pink,

    special = colors.pc.charcoal, -- fg,
    special_char = colors.pc.charcoal, -- fg,

    tag = colors.green,
    delimiter = colors.pc.denim, -- aqua,
    title = colors.pc.grey, -- comment,
    global = colors.pc.orange, -- blue,
  }
  colors.comment = colors.pc.grey
  colors.special_comment = colors.pc.grey -- comment,

  colors.constant = colors.pc.orange

  colors.string = colors.pc.olive
  colors.character = colors.pc.olive

  colors.number = colors.pc.orange
  colors.float = colors.pc.orange
  colors.boolean = colors.pc.green

  colors.identifier = colors.pc.green -- navy
  colors.func = colors.pc.charcoal -- fg
  colors.statement = colors.pc.pink
  colors.conditional = colors.pc.purple
  colors._repeat = colors.pc.purple
  colors.label = colors.pc.orange -- blue
  colors.operator = colors.pc.denim -- aqua,
  colors.keyword = colors.pc.orange -- blue
  colors.exception = colors.pc.red

  colors.pre_proc = colors.pc.orange -- blue
  colors.include = colors.pc.red
  colors.define = colors.pc.orange -- blue,
  colors.macro = colors.pc.orange -- blue,
  colors.pre_condit = colors.pc.denim -- aqua,

  colors.type = colors.pc.pink
  colors.storage_class = colors.pc.green -- navy,
  colors.structure = colors.pc.orange -- blue,
  colors.typedef = colors.pc.pink

  colors.special = colors.pc.charcoal -- fg,
  colors.special_char = colors.pc.charcoal -- fg,

  colors.tag = colors.green
  colors.delimiter = colors.pc.denim -- aqua,
  colors.title = colors.pc.grey -- comment,
  colors.global = colors.pc.orange -- blue,
  colors.nontext = colors.pc.grey -- blue,

  colors.hint = {
    fg = colors.color06, -- colors.teal (trace)
    bg = colors.bg,
  }
  colors.trace = {
    fg = colors.color06, -- colors.teal (trace)
    bg = colors.bg,
  }
  colors.debug = {
    fg = colors.pc.orange,
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
  colors.fatal = {
    fg = colors.color01,
    bg = colors.bg,
  }

  colors.bold = colors.fg
  colors.italic = colors.fg

  -- Component Layer --

  -- TODO: are 'gutter' and 'sidebar' actually the same?
  -- is 'gutter' the sign section and 'sidebar' the number line?
  -- or are both 'gutter' and 'sidebar' for things like nvimtree
  -- that pops up on the side. I'll probably do that, that makes
  -- sense to me.
  colors.gutter = {
    -- linenumber_bg  = '#eeeeee',
    -- linenumber_fg  = '#b2b2b2',
    -- bg = colors.bg,
    -- fg = colors.color08,
    fg = colors.surface_container_low.fg,
    bg = colors.surface_container_low.bg,
  }

  colors.sidebar = {
    -- colors.bg_sidebar = config.options.styles.sidebars == 'transparent' and colors.none
      -- or config.options.styles.sidebars == 'dark' and colors.bg_dark
      -- or colors.bg
    -- colors.fg_sidebar = colors.fg_dark
    -- bg = colors.bg,
    -- fg = colors.fg,
    fg = colors.surface_container_low.fg,
    bg = colors.surface_container_low.bg,
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
