local M = {}

---@class Palette
M.light = {
  none              = 'NONE',

  -- These colour names are based on xterm's colour names which can
  -- be found
  -- The actual terminal colours can (and in this case are) different
  -- than the name suggests.

  -- Colour names from various sources. `xterm` ones come from
  -- [here](https://www.ditig.com/publications/256-colors-cheat-sheet).
  -- cterm comes from `:help cterm-colors`, while `real` comes from an
  -- online search for the closest named colour.
  --
  --                                xterm     | real        | cterm                 |
  --                                ----------+-------------+-----------------------+
  color00           = '#eeeeee', -- black     | white       | Black                 |
  color01           = '#af0000', -- maroon    | maroon      | DarkRed               |
  color02           = '#008700', -- green     | green       | DarkGreen             |
  color03           = '#5f8700', -- olive     | olive       | Brown, DarkYellow     |
  color04           = '#0087af', -- navy      | cerulean    | DarkBlue              |
  color05           = '#878787', -- purple    | grey        | DarkMagenta           |
  color06           = '#005f87', -- teal      | navy        | DarkCyan              |
  color07           = '#444444', -- silver    | charcoal    | LightGray, Gray       |
  color08           = '#bcbcbc', -- grey      | silver      | DarkGray              |
  color09           = '#d70000', -- red       | red         | Red, LightRed         |
  color10           = '#d70087', -- lime      | pink        | Green, LightGreen     |
  color11           = '#8700af', -- yellow    | purple      | Yellow, LightYellow   |
  color12           = '#d75f00', -- blue      | orange      | Blue, LightBlue       |
  color13           = '#d75f00', -- fuchsia   |             | Magenta, LightMagenta |
  color14           = '#005faf', -- aqua      | denim       | Cyan, LightCyan       |
  color15           = '#005f87', -- white     | blue_lagoon | White                 |
  color16           = '#0087af', -- grey0     | blue        |                       |
  color17           = '#008700', -- navy_blue |             |                       |
  color18           = '#8700af', -- dark_blue | wine        |                       |
}

--- Set up the default VIM highlight groups for the UI.
---
--- All names obtained from `:help highlight-groups`
local function vim_ui(theme)
  return {
    -- Used for the columns set with 'colorcolumn'.
    ColorColumn = {},
    -- Placeholder characters substituted for concealed text (see 'conceallevel').
    Conceal = {},
    CurSearch = { link = 'Search' }, -- Current match for the last search pattern (see 'hlsearch'). Note: This is correct after a search, but may get outdated if changes are made or the screen is redrawn.
    Cursor = { fg = c.cursor.fg, bg = c.cursor.bg }, -- Character under the cursor.
    -- Character under the cursor when language-mapping is used (see 'guicursor').
    lCursor = { link = 'Cursor' },
    -- Like Cursor, but used when in IME mode. CursorIM
    CursorIM = {},
    -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorColumn = {},
    -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    CursorLine = {},
    -- Directory names (and other special names in listings).
    Directory = {},
    DiffAdd = { link = '@diff.plus' }, -- Diff mode: Added line. diff.txt
    DiffChange = { link = '@diff.delta' }, -- Diff mode: Changed line. diff.txt
    DiffDelete = { link = '@diff.minus' }, -- Diff mode: Deleted line. diff.txt
    DiffText = { link = '@diff.delta' }, -- Diff mode: Changed text within a changed line. diff.txt | TODO: ??
    -- Filler lines (~) after the end of the buffer. By default, this is highlighted like hl-NonText.
    EndOfBuffer = { link = 'NonText' },
    TermCursor = { reverse = true }, -- Cursor in a focused terminal.
    -- Cursor in an unfocused terminal.
    TermCursorNC = {},
    ErrorMsg = { fg = c.error.fg, bg = c.error.bg }, -- Error messages on the command line.
    WinSeparator = { link = 'VertSplit' }, -- Separators between window splits.
    -- Line used for closed folds.
    Folded = {},
    -- 'foldcolumn'
    FoldColumn = {},
    -- Column where signs are displayed.
    SignColumn = {},
    IncSearch = { reverse = true }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c".
    Substitute = { link = 'Search' }, -- :substitute replacement text highlighting.
    -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    LineNr = {},
    -- Line number for when the 'relativenumber' option is set, above the cursor line.
    LineNrAbove = { link = 'LineNr' },
    -- Line number for when the 'relativenumber' option is set, below the cursor line.
    LineNrBelow = { link = 'LineNr' },
    -- Like LineNr when 'cursorline' is set and 'cursorlineopt' contains "number" or is "both", for the cursor line.
    CursorLineNr = {},
    -- Like FoldColumn when 'cursorline' is set for the cursor line.
    CursorLineFold = { link = 'FoldColumn' },
    -- Like SignColumn when 'cursorline' is set for the cursor line.
    CursorLineSign = { link = 'SignColumn' },
    -- Character under the cursor or just before it, if it is a paired bracket, and its match. pi_paren.txt
    MatchParen = {},
    -- 'showmode' message (e.g., "-- INSERT --").
    ModeMsg = { bold = true },
    -- Area for messages and command-line, see also 'cmdheight'.
    MsgArea = {},
    -- Separator for scrolled messages msgsep.
    MsgSeparator = { link = 'StatusLine' },
    -- more-prompt
    MoreMsg = {},
    NonText = { fg = c.non_text, bold = true }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also hl-EndOfBuffer.
    -- Normal text.
    Normal = {},
    NormalFloat = { link = 'Pmenu' }, -- Normal text in floating windows.
    FloatBorder = { link = 'WinSeparator' }, -- Border of floating windows.
    FloatTitle = { link = 'Title' }, -- Title of floating windows.
    FloatFooter = { link = 'Title' }, -- Footer of floating windows.
    -- Normal text in non-current windows.
    NormalNC = {},
    -- Popup menu: Normal item.
    Pmenu = {},
    -- Popup menu: Selected item.
    PmenuSel = {},
    PmenuKind = { link = 'Pmenu' }, -- Popup menu: Normal item "kind".
    PmenuKindSel = { link = 'PmenuSel' }, -- Popup menu: Selected item "kind".
    PmenuExtra = { link = 'Pmenu' }, -- Popup menu: Normal item "extra text".
    PmenuExtraSel = { link = 'PmenuSel' }, -- Popup menu: Selected item "extra text".
    -- Popup menu: Scrollbar.
    PmenuSbar = {},
    -- Popup menu: Thumb of the scrollbar.
    PmenuThumb = {},
    PmenuMatch = { link = 'Pmenu' }, -- Popup menu: Matched text in normal item.
    PmenuMatchSel = { link = 'PmenuSel' }, -- Popup menu: Matched text in selected item.
    -- hit-enter prompt and yes/no questions.
    Question = {},
    QuickFixLine = { link = 'Search' }, -- Current quickfix item in the quickfix window. Combined with hl-CursorLine when the cursor is there.
    -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    Search = {},
    -- Tabstops in snippets. vim.snippet
    SnippetTabstop = {},
    -- Unprintable characters: Text displayed differently from what it really is. But not 'listchars' whitespace. hl-Whitespace
    SpecialKey = {},
    -- Word that is not recognized by the spellchecker. spell Combined with the highlighting used otherwise.
    SpellBad = {},
    -- Word that should start with a capital. spell Combined with the highlighting used otherwise.
    SpellCap = {},
    -- Word that is recognized by the spellchecker as one that is used in another region. spell Combined with the highlighting used otherwise.
    SpellLocal = {},
    -- Word that is recognized by the spellchecker as one that is hardly ever used. spell Combined with the highlighting used otherwise.
    SpellRare = {},
    StatusLine = { reverse = true, bold = true }, -- Status line of current window.
    StatusLineNC = { reverse = true }, -- Status lines of not-current windows.
    -- Status line of terminal window.
    StatusLineTerm = {},
    -- Status line of non-current terminal windows.
    StatusLineTermNC  = {},
    -- Tab pages line, not active tab page label.
    TabLine = {},
    TabLineFill = { reverse = true }, -- Tab pages line, where there are no labels.
    TabLineSel = { bold = true }, -- Tab pages line, active tab page label.
    Title = { link = '@markup.heading' }, -- Titles for output from ":set all", ":autocmd" etc.
    -- Visual mode selection.
    Visual = {},
    -- Visual mode selection when vim is "Not Owning the Selection".
    VisualNOS = {},
    -- Warning messages.
    WarningMsg = {},
    Whitespace = { link = 'NonText' }, -- "nbsp", "space", "tab", "multispace", "lead" and "trail" in 'listchars'.
    -- Current match in 'wildmenu' completion.
    WildMenu = {},
    WinBar = { link = 'StatusLine' }, -- Window bar of current window.
    WinBarNC = { link = 'StatusLineNC' }, -- Window bar of not-current windows.

    -- Additional not from manpages, but were in previous colourschemes and seem
    -- like a good idea to set up.
    Bold        = { link = '@markup.strong' },
    Italic      = { link = '@markup.emphasis' },
  }
end

local function lsp(theme)
  return {
    -- remapping of treesitter things that were mapped to vim defualts to their passthrough equivalent. they would have linked to `Constant` for example, but that links to `@constant` so now this links directly to `@constant`.
    ['@lsp.type.enumMember']        = { link = '@constant' },
    ['@lsp.type.comment']           = { link = '@comment' },
    ['@lsp.type.decorator']         = { link = '@function' },
    ['@lsp.type.function']          = { link = '@function' },
    ['@lsp.type.method']            = { link = '@function' },
    ['@lsp.type.parameter']         = { link = '@variable' },
    ['@lsp.type.property']          = { link = '@variable' },
    ['@lsp.type.variable']          = { link = '@variable' },
    ['@lsp.type.macro']             = { link = '@function.macro' },
    ['@lsp.type.interface']         = { link = '@keyword.type' },
    ['@lsp.type.namespace']         = { link = '@keyword.type' },
    ['@lsp.type.struct']            = { link = '@keyword.type' },
    ['@lsp.type.class']             = { link = '@keyword.type' },
    ['@lsp.type.enum']              = { link = '@keyword.type' },
    ['@lsp.type.type']              = { link = '@type' },
    ['@lsp.type.typeParameter']     = { link = '@type.definition' },
  }
end

--- Link the "standard" syntax highlight groups for VIM to TreeSitter's.
---
--- There aren't any truly standard ones, but these are the commonly
--- used defaults, pulled from `:help group-name`.
--
-- They are linked to the TreeSitter highlight group to make TreeSitter
-- the authoritative source.
local function vim_syntax_link()
  return {
    -- Comments
    Comment     = { link = '@comment' }, -- any comment

    -- Constants
    Constant    = { link = '@constant' }, -- any constant
    String      = { link = '@string' }, -- a string constant: "this is a string"
    Character   = { link = '@character' }, -- a character constant: 'c', '\n'
    Number      = { link = '@number' }, -- a number constant: 234, 0xff
    Boolean     = { link = '@boolean' }, -- a boolean constant: TRUE, false
    Float       = { link = '@number.float' }, -- a floating point constant: 2.3e10

    -- Identifiers
    Identifier  = { link = '@variable' }, -- any variable name
    Function    = { link = '@function' }, -- function name (also: methods for classes)

    -- Control Flow
    Statement          = { link = '@keyword' }, -- any statement
    Conditional = { link = '@keyword.conditional' }, -- if, then, else, endif, switch, etc.
    Repeat      = { link = '@keyword.repeat' }, -- for, do, while, etc.
    Label       = { link = '@label' }, -- case, default, etc.
    Operator    = { link = '@operator' }, -- "sizeof", "+", "*", etc.
    Keyword     = { link = '@keyword' }, -- any other keyword
    Exception   = { link = '@keyword.exception' }, -- try, catch, throw

    -- Preprocessor
    PreProc     = { link = '@keyword.directive' }, -- generic Preprocessor
    Include     = { link = '@keyword.import' }, -- preprocessor #include
    Define      = { link = '@keyword.directive.define' }, -- preprocessor #define
    Macro       = { link = '@function.macro' }, -- same as Define
    PreCondit   = { link = '@keyword.directive' }, -- preprocessor #if, #else, #endif, etc. | TODO: '@keyword.directive.define'?

    -- Types
    Type        = { link = '@type' }, -- int, long, char, etc. | TODO: '@type.builtin' or '@keyword.type' ?
    StorageClass= { link = '@keyword.modifier' }, -- static, register, volatile, etc.
    Structure   = { link = '@keyword.type' }, -- struct, union, enum, etc.
    TypeDef     = { link = '@type.definition' }, -- a typedef

    -- Special Symbols
    Special         = { link = '@constant.builtin' }, -- any special symbol | TODO: '@punctuation.special' ?
    SpecialChar     = { link = '@character.special' }, -- special character in a constant
    Tag             = { link = '@tag' }, -- you can use CTRL-] on this | TODO: Probably the wrong mapping.
    Delimiter       = { link = '@punctuation.delimiter' }, -- character that needs attention
    SpecialComment  = { link = '@string.special' }, -- special things inside a comment | TODO: '@punctuation.special'?

    Debug       = { link = '@keyword.debug' }, -- debugging statements

    Underlined  = { link = '@string.special' }, -- text that stands out, HTML links, TODO: just specify as `{ underline = true }`?

    -- Ignore	 = {}, -- left blank, hidden  hl-Ignore

    Error       = { link = '@comment.error' }, -- any erroneous construct

    Todo        = { link = '@comment.todo' }, -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- Diffs
    Added       = { link = '@diff.plus' }, -- added line in a diff
    Changed     = { link = '@diff.delta' }, -- changed line in a diff
    Removed     = { link = '@diff.minus' }, -- removed line in a diff
  }
end

--- Configure the base TreeSitter highlight capture groups.
---
--- Pulled from
--- [here](https://github.com/nvim-treesitter/nvim-treesitter/blob/c1ad655b6a0c83ab48e55240f367e2bc0c15af31/CONTRIBUTING.md)
local function treesitter(theme)
  return {
    -- Identifiers
    ['@variable'] = { fg = theme.identifier }, -- various variable names
    ['@variable.builtin'] = { link = '@constant.builtin' }, -- built-in variable names (e.g. this, self)
    ['@variable.parameter'] = { link = '@variable' }, -- parameters of a function
    ['@variable.parameter.builtin'] = { link = '@variable.builtin' }, -- special parameters (e.g. _, it)
    ['@variable.member'] = { link = '@variable' }, -- object and struct fields

    ['@constant'] = { fg = theme.constant }, -- constant identifiers
    ['@constant.builtin'] = { fg = theme.special }, -- built-in constant values
    ['@constant.macro'] = { link = '@keyword.directive.define' }, -- constants defined by the preprocessor

    ['@module'] = { link = '@variable' }, -- modules or namespaces
    ['@module.builtin'] = { link = '@constant.builtin' }, -- built-in modules or namespaces
    ['@label'] = { fg = theme.label }, -- GOTO and other labels (e.g. label: in C), including heredoc labels

    -- Literals
    ['@string'] = { fg = theme.string }, -- string literals
    -- string documenting code (e.g. Python docstrings)
    ['@string.documentation'] = {},
    -- regular expressions
    ['@string.regexp'] = {},
    -- escape sequences
    ['@string.escape'] = { link = '@character.special' },
    ['@string.special'] = { fg = theme.special_comment, bold = true }, -- other special strings (e.g. dates)
    -- symbols or atoms
    ['@string.special.symbol'] = {},
    -- URIs (e.g. hyperlinks)
    ['@string.special.url'] = {},
    -- filenames
    ['@string.special.path'] = {},

    ['@character'] = { fg = theme.character }, -- character literals
    ['@character.special'] = { fg = theme.special_char }, -- special characters (e.g. wildcards)

    ['@boolean'] = { fg = theme.boolean, bold = true }, -- boolean literals
    ['@number'] = { fg = theme.number }, -- numeric literals
    ['@number.float'] = { fg = theme.float }, -- floating-point number literals

    -- Types
    ['@type'] = { fg = theme.type, bold = true }, -- type or class definitions and annotations
    -- built-in types
    ['@type.builtin'] = {},
    ['@type.definition'] = { fg = theme.typedef, bold = true }, -- identifiers in type definitions (e.g. typedef <type> <identifier> in C)

    ['@attribute'] = { link = '@keyword.directive' }, -- attribute annotations (e.g. Python decorators, Rust lifetimes)
    ['@attribute.builtin'] = { link = '@attribute' }, -- builtin annotations (e.g. @property in Python)
    -- the key in key/value pairs
    ['@property'] = { link = '@variable' },

    -- Functions
    ['@function'] = { fg = theme.func }, -- function definitions
    -- built-in functions
    ['@function.builtin'] = { link = '@constant.builtin' },
    -- function calls
    ['@function.call'] = {},
    ['@function.macro'] = { fg = theme.macro }, -- preprocessor macros

    ['@function.method'] = { link = '@function' }, -- method definitions
    -- method calls
    ['@function.method.call'] = {},

    -- constructor calls and definitions
    ['@constructor'] = { link = '@constant.builtin' },
    ['@operator'] = { fg = theme.operator }, -- symbolic operators (e.g. +, *)

    -- Keywords
    ['@keyword'] = { fg = theme.keyword, italic = true }, -- keywords not fitting into specific categories
    -- keywords related to coroutines (e.g. go in Go, async/await in Python)
    ['@keyword.coroutine'] = {},
    -- keywords that define a function (e.g. func in Go, def in Python)
    ['@keyword.function'] = {},
    -- operators that are English words (e.g. and, or)
    ['@keyword.operator'] = {},
    -- keywords for including modules (e.g. import, from in Python)
    ['@keyword.import'] = {},
    ['@keyword.type'] = { fg = theme.structure, bold = true }, -- keywords defining composite types (e.g. struct, enum)
    ['@keyword.modifier'] = { fg = theme.storage_class, bold = true }, -- keywords defining type modifiers (e.g. const, static, public)
    ['@keyword.repeat'] = { fg = theme._repeat, bold = true }, -- keywords related to loops (e.g. for, while)
    -- keywords like return and yield
    ['@keyword.return'] = {},
    ['@keyword.debug'] = { fg = theme.debug.fg, bg = theme.debug.bg }, -- keywords related to debugging
    ['@keyword.exception'] = { fg = theme.exception }, -- keywords related to exceptions (e.g. throw, catch)

    ['@keyword.conditional'] = { fg = theme.conditional, bold = true }, -- keywords related to conditionals (e.g. if, else)
    -- ternary operator (e.g. ?, :)
    ['@keyword.conditional.ternary'] = {},

    ['@keyword.directive'] = { fg = theme.pre_proc }, -- various preprocessor directives and shebangs
    ['@keyword.directive.define'] = { fg = theme.define }, -- preprocessor definition directives

    -- Punctuation
    ['@punctuation.delimiter'] = { fg = theme.delimiter }, -- delimiters (e.g. ;, ., ,)
    -- brackets (e.g. (), {}, [])
    ['@punctuation.bracket'] = {},
    -- special symbols (e.g. {} in string interpolation)
    ['@punctuation.special'] = {},

    -- Comments
    ['@comment'] = { fg = theme.comment, italic = true }, -- line and block comments
    -- comments documenting code
    ['@comment.documentation'] = {},

    ['@comment.error'] = { fg = theme.error.fg, bg = theme.error.bg }, -- error-type comments (e.g. ERROR, FIXME, DEPRECATED)
    ['@comment.warning'] = { fg = theme.warn.fg }, -- warning-type comments (e.g. WARNING, FIX, HACK)
    ['@comment.todo'] = { fg = theme.todo.fg, bg = theme.todo.bg }, -- todo-type comments (e.g. TODO, WIP)
    ['@comment.note'] = { fg = theme.hint.fg }, -- note-type comments (e.g. NOTE, INFO, XXX)

    -- Markup (mostly for markup languages, though others can use them).
    ['@markup.strong'] = { fg = theme.bold, bold = true }, -- bold text
    ['@markup.italic'] = { fg = theme.italic, italic = true }, -- italic text
    ['@markup.strikethrough'] = { strikethrough = true }, -- struck-through text
    ['@markup.underline'] = { underline = true }, -- underlined text (only for literal underline markup!)

    ['@markup.heading']   = { fg = theme.title }, -- headings, titles (including markers)
    ['@markup.heading.1'] = { fg = theme.blue, bold = true }, -- top-level heading
    ['@markup.heading.2'] = { fg = theme.yellow, bold = true }, -- section heading
    ['@markup.heading.3'] = { fg = theme.green, bold = true }, -- subsection heading
    ['@markup.heading.4'] = { fg = theme.aqua, bold = true }, -- and so on
    ['@markup.heading.5'] = { fg = theme.fuchsia, bold = true }, -- and so forth
    ['@markup.heading.6'] = { fg = theme.purple, bold = true }, -- six levels ought to be enough for anybody

    ['@markup.quote']     = { link = '@comment' }, --* block quotes
    ['@markup.math']      = { link = '@string.special' }, -- math environments (e.g. $ ... $ in LaTeX) | TODO: '@constant.builtin' would be default

    ['@markup.link']        = { link = '@variable' }, -- text references, footnotes, citations, etc.
    -- link, reference descriptions
    ['@markup.link.label']  = {},
    ['@markup.link.url']    = { link = '@markup.underline' }, -- URL-style links

    ['@markup.raw']       = { link = '@string' }, -- literal or verbatim text (e.g. inline code) | TODO: @comment instead?
    -- literal or verbatim text as a stand-alone block
    ['@markup.raw.block'] = {},

    -- list markers
    ['@markup.list']            = {},
    -- checked todo-style list markers
    ['@markup.list.checked']    = {},
    -- unchecked todo-style list markers
    ['@markup.list.unchecked']  = {},

    -- added text (for diff files)
    ['@diff.plus']  = {},
    -- deleted text (for diff files)
    ['@diff.minus'] = {},
    -- changed text (for diff files)
    ['@diff.delta'] = {},

    ['@tag']            = { fg = theme.tag }, -- XML-style tag names (e.g. in XML, HTML, etc.)
    ['@tag.builtin']    = { link = '@constant.builtin' }, -- XML-style tag names (e.g. HTML5 tags)
    ['@tag.attribute']  = { link = '@property' }, -- XML-style tag attributes
    -- XML-style tag delimiters
    ['@tag.delimiter']  = {},
  }
end

function M.setup(palette)
  -- TODO: Maybe nicer way to extend this?
  -- TODO: darkmode

  local styles = vim.deepcopy(palette)

  -- add xterm colour names
  styles.black = styles.color00
  styles.maroon = styles.color01
  styles.green = styles.color02
  styles.olive = styles.color03
  styles.navy = styles.color04
  styles.purple = styles.color05
  styles.teal = styles.color06
  styles.silver = styles.color07
  styles.grey = styles.color08
  styles.red = styles.color09
  styles.lime = styles.color10
  styles.yellow = styles.color11
  styles.blue = styles.color12
  styles.fuchsia = styles.color13
  styles.aqua = styles.color14
  styles.white = styles.color15
  styles.grey0 = styles.color16
  styles.navy_blue = styles.color17
  styles.dark_blue = styles.color18

  -- Default editing surface
  styles.surface = {
    fg = styles.silver,
    bg = styles.black,
  }


  -- If later highlight definitions define the same thing, the later will win.
  M.highlights = vim.tbl_deep_extend('force', {},
    vim_ui(styles),
    vim_syntax_link(),
    treesitter(styles),
    lsp(styles)
  )
end

function M.syntax(syntax)
  for group, colors in pairs(syntax) do
    if colors.style then
      colors = vim.tbl_extend('force', colors, colors.style)
      colors.style = nil
    end
    vim.api.nvim_set_hl(0, group, colors)
  end
end

---@param opts Config|nil
function M.load(opts)
  -- only needed to clear when not the default colorscheme
  if vim.g.colors_name then
    vim.cmd('hi clear')
  end

  vim.o.termguicolors = true
  vim.g.colors_name = 'papercolor-lua'

  M.setup(M.light)
  M.syntax(M.highlights)
end

return M

