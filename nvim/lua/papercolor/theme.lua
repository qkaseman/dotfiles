local util = require('papercolor.util')
local colors = require('papercolor.colors')

local M = {}
--
---@class Highlight
---@field fg string|nil
---@field bg string|nil
---@field sp string|nil
---@field style string|nil|Highlight
---@field link string|nil

---@alias Highlights table<string,Highlight>

---@return Theme
function M.setup()
  local config = require('papercolor.config')
  local options = config.options
  ---@class Theme
  ---@field highlights Highlights
  local theme = {
    config = options,
    colors = colors.setup(),
  }

  local c = theme.colors

  -- By default, util.bg is black, util.fg is white
  -- util.bg = c.bg
  -- util.fg = c.fg
  util.brightness = config.options.brightness

  theme.highlights = {
    -- why Foo?
    Foo = c.surface,

    -- These groups are not listed as default vim groups,
    -- but they are defacto standard group names for syntax highlighting.
    -- commented out groups should chain up to their 'preferred' group by
    -- default,
    -- Uncomment and edit if you want more specific syntax highlighting.
    --
    -- Comment = { fg = c.comment, style = options.styles.comments },
    -- Constant = { fg = c.orange },
    -- String = { fg = c.green },
    -- Character = { fg = c.green },
    -- Number        = { },
    -- Boolean       = { },
    -- Float         = { },
    --
    -- Identifier = { fg = c.light_magenta, style = options.styles.variables },
    -- Function = { fg = c.blue, style = options.styles.functions },
    --
    -- Statement = { fg = c.light_magenta },
    -- Conditional   = { },
    -- Repeat        = { },
    -- Label         = { },
    -- Operator = { fg = c.blue5 },
    -- Keyword = { fg = c.light_cyan, style = options.styles.keywords },
    -- Exception     = { },
    --
    -- PreProc = { fg = c.light_cyan },
    -- Include       = { },
    -- Define        = { },
    -- Macro         = { },
    -- PreCondit     = { },
    --
    -- Type = { fg = c.blue },
    -- StorageClass  = { },
    -- Structure     = { },
    -- Typedef       = { },
    --
    -- Special = { fg = c.blue },
    -- SpecialChar   = { },
    -- Tag           = { },
    -- Delimiter = { link = 'Special' },
    -- SpecialComment= { },
    -- Debug = { fg = c.orange },
    --
    -- Error = { fg = c.error },
    -- Todo = { bg = c.light_yellow, fg = c.bg },
    --
    -- Title = { },
    -- Global = { },
    --
    -- Underlined = { underline = true },
    -- Bold = { bold = true, fg = c.fg },
    -- Italic = { italic = true, fg = c.fg },
    --
    -- ('Ignore', below, may be invisible...)
    -- Ignore = { }, -- (preferred) left blank, hidden  |hl-Ignore|

    Comment   = { fg = c.comment, style = options.styles.comments   }, -- any comment
    Constant  = { fg = c.constant                                   }, -- (preferred) any constant
    String    = { fg = c.string                                     }, --   a string constant: 'this is a string'
    Character = { fg = c.character                                  }, --  a character constant: 'c', '\n'
    Number    = { fg = c.number                                     }, --   a number constant: 234, 0xff
    Boolean   = { fg = c.boolean, bold = true                       }, --  a boolean constant: TRUE, false
    Float     = { fg = c.float                                      }, --    a floating point constant: 2.3e10

    Identifier  = { fg = c.identifier, style = options.styles.variables }, -- (preferred) any variable name
    Function    = { fg = c.func,       style = options.styles.functions }, -- function name (also: methods for classes)

    Statement   = { fg = c.statement                                }, -- (preferred) any statement
    Conditional = { fg = c.conditional, bold = true                 }, --  if, then, else, endif, switch, etc.
    Repeat      = { fg = c._repeat,     bold = true                 }, --   for, do, while, etc.
    Label       = { fg = c.label                                    }, --    case, default, etc.
    Operator    = { fg = c.operator                                 }, -- 'sizeof', '+', '*', etc.
    Keyword     = { fg = c.keyword, style = options.styles.keywords }, --  any other keyword
    Exception   = { fg = c.exception                                }, --  try, catch, throw

    PreProc   = { fg = c.pre_proc   }, -- (preferred) generic Preprocessor
    Include   = { fg = c.include    }, --  preprocessor #include
    Define    = { fg = c.define     }, --   preprocessor #define
    Macro     = { fg = c.macro      }, --    same as Define
    PreCondit = { fg = c.pre_condit }, --  preprocessor #if, #else, #endif, etc.

    Type          = { fg = c.type,          bold = true }, -- (preferred) int, long, char, etc.
    StorageClass  = { fg = c.storage_class, bold = true }, -- static, register, volatile, etc.
    Structure     = { fg = c.structure,     bold = true }, --  struct, union, enum, etc.
    Typedef       = { fg = c.typedef,       bold = true }, --  A typedef

    Special         = { fg = c.special                                        }, -- (preferred) any special symbol
    SpecialChar     = { fg = c.special_char                                   }, --  special character in a constant
    Tag             = { fg = c.tag                                            }, --    you can use CTRL-] on this
    Delimiter       = { fg = c.delimiter                                      }, -- character that needs attention
    SpecialComment  = { fg = c.special_comment,                  bold = true  }, -- special things inside a comment

    Debug = { fg = c.debug.fg,  bg = c.debug.bg             }, --    debugging statements
    Error = { fg = c.error.fg,  bg = c.error.bg             }, -- (preferred) any erroneous construct
    Todo  = { fg = c.todo.fg,   bg = c.todo.bg, bold = true }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    Title   = { fg = c.title  }, -- titles for output from ':set all', ':autocmd' etc.
    Global  = { fg = c.global }, -- titles for output from ':set all', ':autocmd' etc.

    Underlined  = {                 underline = true  }, -- (preferred) text that stands out, HTML links
    Bold        = { fg = c.bold,    bold = true       }, -- (preferred) any bold text
    Italic      = { fg = c.italic,  italic = true     }, -- (preferred) any italic text

    -- NonText = { fg = c.dark3 },
    NonText = { fg = c.nontext, bg = c.bg }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., '>' displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.

    -- ('Ignore', below, may be invisible...)
    -- Ignore = { }, -- (preferred) left blank, hidden  |hl-Ignore|

    -- Objects

    -- Cursor = { fg = c.bg, bg = c.fg },
    -- CursorColumn = { bg = c.bg_accent },
    -- CursorLine = { bg = c.bg_accent },
    -- CursorLineNr = { fg = c.dark5 },
    --Cursor        = { fg = c.cursor.fg,         bg = c.cursor.bg }, -- character under the cursor
    Cursor        = c.cursor, -- character under the cursor
    CursorColumn  = {                           bg = c.cursorcolumn }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine    = {                           bg = c.cursorline }, -- Screen-line at the cursor, when 'cursorline' is set.
    CursorLineNr  = c.cursorlinenr, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.

    -- TODO: which order? TermStatusLine or StatusLineTerm?
    -- StatusLine = { fg = c.sidebar.fg, bg = c.statusline.bg },
    -- StatusLineNC = { fg = c.gutter.fg, bg = c.statusline.bg },
    StatusLine        = { fg = c.statusline.active.fg,    bg = c.statusline.active.bg   }, -- status line of current window
    StatusLineNC      = { fg = c.statusline.inactive.fg,  bg = c.statusline.inactive.bg }, -- status lines of not-current windows
    StatusLineTerm    = { fg = c.statusline.active.fg,    bg = c.statusline.active.bg   },
    StatusLineTermNC  = { fg = c.statusline.inactive.fg,  bg = c.statusline.inactive.bg },

    -- LineNr = { bg = util.darken(c.bg, 0.95), fg = c.fg },
    -- SignColumn = { bg = options.transparent and c.none or c.bg, fg = c.gutter.fg },
    -- ColorColumn = { bg = c.black },
    LineNr      = { fg = c.gutter.fg, bg = c.gutter.bg  }, -- Line number for ':number' and ':#' commands, and when 'number' or 'relativenumber' option is set.
    SignColumn  = { fg = c.green,     bg = c.bg         }, -- column where |signs| are displayed
    ColorColumn = { bg = c.color00                      }, -- used for the columns set with 'colorcolumn'

    Directory = { fg = c.blue }, -- directory names (and other special names in listings)

    -- VertSplit = { fg = c.border },
    VertSplit = { fg = c.vertsplit.fg, bg = c.vertsplit.bg }, -- the column separating vertically split windows
    --WinSeparator = { fg = c.border, bold = true }, -- the column separating vertically split windows
    WinSeparator = { fg = c.vertsplit.fg, bg = c.vertsplit.bg, bold = true }, -- the column separating vertically split windows

    -- TODO: Should these be capitals?
    -- TODO: what is difference between `style = {}` and just using directly?
    -- Pmenu = { bg = c.bg_popup, fg = c.fg },
    -- PmenuSel = { bg = util.darken(c.gutter.fg, 0.8) },
    -- PmenuSbar = { bg = util.lighten(c.bg_popup, 0.95) },
    -- PmenuThumb = { bg = c.gutter.fg },
    -- PMenu       = { fg = c.popupmenu.fg,  bg = c.popupmenu.bg                   }, -- Popup menu: normal item.
    -- PMenuSel    = { fg = c.popupmenu.fg,  bg = c.popupmenu.bg,  reverse = true  }, -- Popup menu: selected item.
    PMenu       = { fg = c.surface_container.fg,  bg = c.surface_container.bg                   }, -- Popup menu: normal item.
    PMenuSel    = { fg = c.surface_container.fg,  bg = c.surface_container.bg,  reverse = true  }, -- Popup menu: selected item.
    PMenuSbar   = {                   bg = c.bg                         }, -- Popup menu: scrollbar.
    PMenuThumb  = {                   bg = c.fg                         }, -- Popup menu: Thumb of the scrollbar.

    -- WildMenu = { bg = c.visual.bg },
    WildMenu = { fg = c.wildmenu.fg, bg = c.wildmenu.bg, bold = true }, -- current match in 'wildmenu' completion

    TabLine     = { fg = c.tabline.inactive.fg, bg = c.tabline.inactive.bg  }, -- tab pages line, not active tab page label
    TabLineFill = { fg = c.bg,          bg = c.tabline.bg           }, -- tab pages line, where there are no labels
    TabLineSel  = { fg = c.tabline.active.fg,   bg = c.tabline.active.bg    }, -- tab pages line, active tab page label

    -- TODO: BufTabLine

    -- Concepts

    -- Search = { bg = c.bg_search, fg = c.fg },
    -- IncSearch = { bg = c.orange, fg = c.black },
    Search    = { fg = c.secondary.fg,     bg = c.secondary.bg    }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    IncSearch = { fg = c.secondary.fg,  bg = util.lighten(c.secondary.bg, 50) }, -- 'incsearch' highlighting; also used for the text replaced with ':s///c'
    --Search    = { fg = c.search.fg,     bg = c.search.bg    }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    --IncSearch = { fg = c.incsearch.fg,  bg = c.incsearch.bg }, -- 'incsearch' highlighting; also used for the text replaced with ':s///c'

    -- Plugin: Vimdiff
    DiffAdd     = { fg = c.diff.add.fg, bg = c.diff.add.bg    }, -- diff mode: Added line |diff.txt|
    DiffChange  = { fg = c.diff.change.fg, bg = c.diff.change.bg }, -- diff mode: Changed line |diff.txt|
    DiffDelete  = { fg = c.diff.delete.fg, bg = c.diff.delete.bg }, -- diff mode: Deleted line |diff.txt|
    DiffText    = { fg = c.diff.text.fg, bg = c.diff.text.bg   }, -- diff mode: Changed text within a changed line |diff.txt|

    -- MatchParen = { fg = c.orange, bold = true },
    MatchParen = { fg = c.matchparen.fg, bg = c.matchparen.bg }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|

    -- Folded = { fg = c.blue, bg = c.gutter.fg },
    -- FoldColumn = { bg = options.transparent and c.none or c.bg, fg = c.comment },
    Folded = { fg = c.folded.fg, bg = c.folded.bg }, -- line used for closed folds
    FoldColumn = { bg = c.bg, fg = c.color00 }, -- 'foldcolumn'

    -- TODO: sp or fg?
    -- SpellBad = { sp = c.error, undercurl = true },
    -- SpellCap = { sp = c.warn, undercurl = true },
    -- SpellLocal = { sp = c.info, undercurl = true },
    -- SpellRare = { sp = c.hint, undercurl = true },
    SpellBad    = { sp = c.spell.bad,     undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap    = { sp = c.spell.cap,     undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal  = { sp = c.spell._local,  undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare   = { sp = c.spell.rare,    undercurl = true }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.

    -- ModeMsg = { fg = c.fg_dark, bold = true },
    -- MoreMsg = { fg = c.blue },
    -- Question = { fg = c.blue },
    -- WarningMsg = { fg = c.warn },
    ModeMsg     = { fg = c.olive }, -- 'showmode' message (e.g., '-- INSERT -- ')
    MoreMsg     = { fg = c.olive }, -- |more-prompt|
    Question    = { fg = c.olive }, -- |hit-enter| prompt and yes/no questions
    WarningMsg  = { fg = c.pc.pink  }, -- warning messages

    -- Modes

    -- Normal = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    -- Visual = { bg = c.visual.bg },
    Normal = { fg = c.fg, bg = c.bg }, -- normal text
    Visual = { fg = c.visual.fg, bg = c.visual.bg }, -- Visual mode selection

    -- No idea

    -- Conceal = { fg = c.dark5 },
    -- EndOfBuffer = { fg = c.bg },
    -- SpecialKey = { fg = c.dark3 },
    Conceal     = { fg = c.gutter.fg, bg = c.gutter.bg  }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    EndOfBuffer = { fg = c.cursor.fg                    }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    SpecialKey  = { fg = c.nontext                      }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|

    -- Neovim LSP Diagnostics
    -- TODO: sp or fg/bg?
    -- These groups are for the native LSP client. Some other LSP clients may
    -- use these groups, or use their own. Consult your LSP client's
    -- documentation.
    LspDiagnosticsDefaultError          = { fg = c.error.fg,                                    }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    LspDiagnosticsDefaultWarning        = { fg = c.warn.fg,                   bold = true       }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    LspDiagnosticsDefaultInformation    = { fg = c.info.fg,                   bold = true       }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    LspDiagnosticsDefaultHint           = { fg = c.hint.fg,                   bold = true       }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    LspDiagnosticsUnderlineError        = { sp = c.error.fg,                  undercurl = true  }, -- Used to underline 'Error' diagnostics
    LspDiagnosticsUnderlineWarning      = { sp = c.warn.fg,                   undercurl = true  }, -- Used to underline 'Warning' diagnostics
    LspDiagnosticsUnderlineInformation  = { sp = c.info.fg,                   undercurl = true  }, -- Used to underline 'Information' diagnostics
    LspDiagnosticsUnderlineHint         = { sp = c.hint.fg,                   undercurl = true  }, -- Used to underline 'Hint' diagnostics

    LspReferenceText  = { bg = c.gutter.fg }, -- used for highlighting 'text' references
    LspReferenceRead  = { bg = c.gutter.fg }, -- used for highlighting 'read' references
    LspReferenceWrite = { bg = c.gutter.fg }, -- used for highlighting 'write' references

    -- LspSignatureActiveParameter = { bg = util.darken(c.visual.bg, 0.4), bold = true },
    -- LspCodeLens = { fg = c.comment },
    -- LspInlayHint = { bg = util.darken(c.blue7, 0.1), fg = c.dark3 },
    -- LspInfoBorder = { fg = c.border_accent, bg = c.bg_float },
    LspSignatureActiveParameter = {                       bg = c.visual.bg, bold = true },
    LspCodeLens                 = { fg = c.comment                                      },
    --LspInlayHint                = { fg = c.black,         bg = c.blue                   },
    LspInlayHint                = { fg = c.navy,         bg = c.blue                   },
    LspInfoBorder               = { fg = c.border_accent, bg = c.surface_container.bg               },

    DiagnosticError           = { link = 'LspDiagnosticsDefaultError'         },
    DiagnosticWarn            = { link = 'LspDiagnosticsDefaultWarning'       },
    DiagnosticInfo            = { link = 'LspDiagnosticsDefaultInformation'   },
    DiagnosticHint            = { link = 'LspDiagnosticsDefaultHint'          },
    DiagnosticUnderlineError  = { link = 'LspDiagnosticsUnderlineError'       },
    DiagnosticUnderlineWarn   = { link = 'LspDiagnosticsUnderlineWarning'     },
    DiagnosticUnderlineInfo   = { link = 'LspDiagnosticsUnderlineInformation' },
    DiagnosticUnderlineHint   = { link = 'LspDiagnosticsUnderlineHint'        },
    DiagnosticUnnecessary     = { fg = c.pc.orange                                }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default. This is what general errors get coloured as I guess.
    -- DiagnosticVirtualTextError = { bg = util.darken(c.error, 0.1), fg = c.error },
    -- DiagnosticVirtualTextWarn = { bg = util.darken(c.warn, 0.1), fg = c.warn },
    -- DiagnosticVirtualTextInfo = { bg = util.darken(c.info, 0.1), fg = c.info },
    -- DiagnosticVirtualTextHint = { bg = util.darken(c.hint, 0.1), fg = c.hint },
    DiagnosticVirtualTextError  = { link = 'LspDiagnosticsDefaultError'       }, -- Used for 'Error' diagnostic virtual text
    DiagnosticVirtualTextWarn   = { link = 'LspDiagnosticsDefaultWarning'     }, -- Used for 'Warning' diagnostic virtual text
    DiagnosticVirtualTextInfo   = { link = 'LspDiagnosticsDefaultInformation' }, -- Used for 'Information' diagnostic virtual text
    DiagnosticVirtualTextHint   = { link = 'LspDiagnosticsDefaultHint'        }, -- Used for 'Hint' diagnostic virtual text

    -- Highlighting For BuiltIn Things (mostly)
    -- Pulled from the PaperColor theme itself

    -- TODO:
    --
    -- Langs:
    -- CMake
    -- C
    -- CPP
    -- Rust
    -- Yacc
    -- NASM
    -- GAS
    -- MIPS
    -- PowerShell
    -- Golang
    -- Systemtap
    -- DTrace
    -- Haskel
    -- SQL
    -- Octave/MATLAB
    -- Fortran
    -- ALGOL
    -- R
    -- XXD
    -- PHP
    -- Pascal
    -- Clojure
    -- Dockerfile
    -- NGINX
    -- Qt
    -- Dosini
    -- Mail
    -- Elixir
    -- Erlang
    -- Ada
    -- COBOL
    -- Elm
    -- Purescript
    -- F#
    -- ASN.1
    --
    -- Plugins:
    -- Netrw
    -- vimdiff
    -- vim-gitgutter
    -- AGit
    -- Spell Checking
    -- Startify
    -- Signify
    -- CoC ?
    -- Debug Adapter Protocol (DAP)


    --- VimScript
    vimCommand = { fg = c.pc.pink },
    vimVar = { fg = c.navy },
    vimFuncKey = { fg = c.pc.pink },
    vimFunction = { fg = c.blue, bold = true },
    vimNotFunc = { fg = c.pc.pink },
    vimMap = { fg = c.red },
    vimAutoEvent = { fg = c.aqua, bold = true },
    vimMapModKey = { fg = c.aqua },
    vimFuncName = { fg = c.purple },
    vimIsCommand = { fg = c.fg },
    vimFuncVar = { fg = c.aqua },
    vimLet = { fg = c.red },
    vimContinue = { fg = c.aqua },
    vimMapRhsExtend = { fg = c.fg },
    vimCommentTitle = { fg = c.comment, italic = true, bold = true },
    vimBracket = { fg = c.aqua },
    vimParenSep = { fg = c.aqua },
    vimNotation = { fg = c.aqua },
    vimOper = { fg = c.fg },
    vimOperParen = { fg = c.fg },
    vimSynType = { fg = c.purple },
    vimSynReg = { fg = c.pc.pink },
    vimSynRegion = { fg = c.fg },
    vimSynMtchGrp = { fg = c.pc.pink },
    vimSynNextgroup = { fg = c.pc.pink },
    vimSynKeyRegion = { fg = c.green },
    vimSynRegOpt = { fg = c.blue },
    vimSynMtchOpt = { fg = c.blue },
    vimSynContains = { fg = c.pc.pink },
    vimGroupName = { fg = c.fg },
    vimGroupList = { fg = c.fg },
    vimHiGroup = { fg = c.fg },
    vimGroup = { fg = c.navy, bold = true },
    vimOnlyOption = { fg = c.blue },

    -- Makefile
    makeIdent = { fg = c.blue },
    makeSpecTarget = { fg = c.olive },
    makeTarget = { fg = c.red },
    makeStatement = { fg = c.aqua, bold = true },
    makeCommands = { fg = c.fg },
    makeSpecial = { fg = c.pc.orange, bold = true },

    -- Shell/Bash highlighting
    bashStatement = { fg = c.fg, bold = true },
    shDerefVar = { fg = c.aqua, bold = true },
    shDerefSimple = { fg = c.aqua },
    shFunction = { fg = c.pc.orange, bold = true },
    shStatement = { fg = c.fg },
    shLoop = { fg = c.purple, bold = true },
    shQuote = { fg = c.olive },
    shCaseEsac = { fg = c.aqua, bold = true },
    shSnglCase = { fg = c.purple },
    shFunctionOne = { fg = c.navy },
    shCase = { fg = c.navy },
    shSetList = { fg = c.navy },
    -- @see Dockerfile Highlighting section for more sh*

    -- HTML Highlighting
    htmlTitle = { fg = c.green, bold = true },
    --htmlH1 = { fg = c.light_magenta, bold = true },
    --htmlH1 = { fg = c.light_magenta, bold = true },
    htmlH1 = { fg = c.green, bold = true },
    --htmlH2 = { fg = c.blue, bold = true },
    htmlH2 = { fg = c.aqua, bold = true },
    htmlH3 = { fg = c.purple, bold = true },
    htmlH4 = { fg = c.pc.orange, bold = true },
    htmlTag = { fg = c.comment },
    htmlTagName = { fg = c.pc.wine },
    htmlArg = { fg = c.pc.pink },
    htmlEndTag = { fg = c.comment },
    htmlString = { fg = c.blue },
    htmlScriptTag = { fg = c.comment },
    htmlBold = { fg = c.fg, bold = true },
    htmlItalic = { fg = c.comment, italic = true },
    htmlBoldItalic = { fg = c.navy, italic = true, bold = true },
    htmlLink = { fg = c.blue, bold = true },
    htmlTagN = { fg = c.pc.wine, bold = true },
    htmlSpecialTagName = { fg = c.pc.wine },
    htmlComment = { fg = c.comment, italic = true },
    htmlCommentPart = { fg = c.comment, italic = true },

    -- CSS Highlighting
    cssIdentifier = { fg = c.pc.pink },
    cssPositioningProp = { fg = c.fg },
    cssNoise = { fg = c.fg },
    cssBoxProp = { fg = c.fg },
    cssTableAttr = { fg = c.purple },
    cssPositioningAttr = { fg = c.navy },
    cssValueLength = { fg = c.pc.orange },
    cssFunctionName = { fg = c.blue },
    cssUnitDecorators = { fg = c.aqua },
    cssColor = { fg = c.blue, bold = true },
    cssBraces = { fg = c.pc.pink },
    cssBackgroundProp = { fg = c.fg },
    cssTextProp = { fg = c.fg },
    cssDimensionProp = { fg = c.fg },
    cssClassName = { fg = c.pc.pink },

    -- Markdown Highlighting
    markdownHeadingRule = { fg = c.pc.pink, bold = true },
    markdownHeadingDelimiter = { fg = c.pc.orange, bold = true },
    --markdownH1 = { fg = c.light_magenta, bold = true },
    markdownH1 = { fg = c.pc.pink, bold = true },
    --markdownH2 = { fg = c.blue, bold = true },
    markdownH2 = { fg = c.pc.orange, bold = true },
    markdownBlockquote = { fg = c.pc.pink },
    --markdownCodeBlock = { fg = c.light_cyan },
    markdownCodeBlock = { fg = c.olive },
    --markdownCode = { fg = c.aqua },
    markdownCode = { fg = c.olive },
    markdownLink = { fg = c.blue, bold = true },
    markdownUrl = { fg = c.blue },
    --markdownLinkText = { fg = c.blue, underline = true },
    markdownLinkText = { fg = c.pc.pink },
    markdownLinkTextDelimiter = { fg = c.purple },
    markdownLinkDelimiter = { fg = c.purple },
    markdownCodeDelimiter = { fg = c.blue },

    -- mkdHeading = { fg = c.orange, bold = true },
    -- mkdCode = { bg = c.terminal_black, fg = c.fg },
    mkdCodeDelimiter = { bg = c.black, fg = c.fg },
    mkdCodeStart = { fg = c.aqua, bold = true },
    mkdCodeEnd = { fg = c.aqua, bold = true },
    mkdCode = { fg = c.olive },
    mkdLink = { fg = c.blue, bold = true },
    mkdURL = { fg = c.comment },
    mkdString = { fg = c.fg },
    mkdBlockQuote = { fg = c.pc.pink },
    mkdLinkTitle = { fg = c.pc.pink },
    mkdDelimiter = { fg = c.aqua },
    mkdRule = { fg = c.pc.pink },
    -- mkdLink = { fg = c.blue, underline = true },

    -- reStructuredText Highlighting
    rstSections = { fg = c.pc.pink, bold = true },
    rstDelimiter = { fg = c.pc.pink, bold = true },
    rstExplicitMarkup = { fg = c.pc.pink, bold = true },
    rstDirective = { fg = c.blue },
    rstHyperlinkTarget = { fg = c.green },
    rstExDirective = { fg = c.fg },
    rstInlineLiteral = { fg = c.olive },
    rstInterpretedTextOrHyperlinkReference = { fg = c.blue },

    -- Python Highlighting
    pythonImport = { fg = c.pc.pink, bold = true },
    pythonExceptions = { fg = c.red },
    pythonException = { fg = c.purple, bold = true },
    pythonInclude = { fg = c.red },
    pythonStatement = { fg = c.pc.pink },
    pythonConditional = { fg = c.purple, bold = true },
    pythonRepeat = { fg = c.purple, bold = true },
    pythonFunction = { fg = c.aqua, bold = true },
    pythonPreCondit = { fg = c.purple },
    pythonExClass = { fg = c.pc.orange },
    pythonOperator = { fg = c.purple, bold = true },
    pythonBuiltin = { fg = c.fg },
    pythonDecorator = { fg = c.pc.orange },

    pythonString = { fg = c.olive },
    pythonEscape = { fg = c.olive, bold = true },
    pythonStrFormatting = { fg = c.olive, bold = true },

    pythonBoolean = { fg = c.green, bold = true },
    pythonBytesEscape = { fg = c.olive, bold = true },
    pythonDottedName = { fg = c.purple },
    pythonStrFormat = { fg = c.fg },

    pythonBuiltinFunc = { fg = c.blue },
    pythonBuiltinObj = { fg = c.red },

    -- Java Highlighting
    javaExternal = { fg = c.pc.pink },
    javaAnnotation = { fg = c.pc.orange },
    javaTypedef = { fg = c.aqua },
    javaClassDecl = { fg = c.aqua, bold = true },
    javaScopeDecl = { fg = c.blue, bold = true },
    javaStorageClass = { fg = c.navy, bold = true },
    javaBoolean = { fg = c.green, bold = true },
    javaConstant = { fg = c.blue },
    javaCommentTitle = { fg = c.pc.wine },
    javaDocTags = { fg = c.aqua },
    javaDocComment = { fg = c.comment },
    javaDocParam = { fg = c.fg },
    javaStatement = { fg = c.pc.pink },

    -- JavaScript Highlighting
    javaScriptBraces = { fg = c.blue },
    javaScriptParens = { fg = c.blue },
    javaScriptIdentifier = { fg = c.pc.pink },
    javaScriptFunction = { fg = c.blue, bold = true },
    javaScriptConditional = { fg = c.purple, bold = true },
    javaScriptRepeat = { fg = c.purple, bold = true },
    javaScriptBoolean = { fg = c.green, bold = true },
    javaScriptNumber = { fg = c.pc.orange },
    javaScriptMember = { fg = c.navy },
    javaScriptReserved = { fg = c.navy },
    javascriptNull = { fg = c.comment, bold = true },
    javascriptGlobal = { fg = c.fg },
    javascriptStatement = { fg = c.pc.pink },
    javaScriptMessage = { fg = c.fg },

    -- TypeScript Highlighting
    typescriptDecorators = { fg = c.pc.orange },
    typescriptLabel = { fg = c.purple, bold = true },

    -- @target https://github.com/pangloss/vim-javascript
    jsImport = { fg = c.pc.pink, bold = true },
    jsExport = { fg = c.pc.pink, bold = true },
    jsModuleAs = { fg = c.pc.pink, bold = true },
    jsFrom = { fg = c.pc.pink, bold = true },
    jsExportDefault = { fg = c.pc.pink, bold = true },
    jsFuncParens = { fg = c.blue },
    jsFuncBraces = { fg = c.blue },
    jsParens = { fg = c.blue },
    jsBraces = { fg = c.blue },
    jsNoise = { fg = c.blue },

    -- Jsx Highlighting
    -- @target https://github.com/MaxMEllon/vim-jsx-pretty
    jsxTagName = { fg = c.pc.wine },
    jsxComponentName = { fg = c.pc.wine },
    jsxAttrib = { fg = c.pc.pink },
    jsxEqual = { fg = c.comment },
    jsxString = { fg = c.blue },
    jsxCloseTag = { fg = c.comment },
    jsxCloseString = { fg = c.comment },
    jsxDot = { fg = c.pc.wine },
    jsxNamespace = { fg = c.pc.wine },
    jsxPunct = { fg = c.comment },

    -- Json Highlighting
    -- @target https://github.com/elzr/vim-json
    jsonKeyword = { fg = c.blue },
    jsonString = { fg = c.olive },
    jsonQuote = { fg = c.comment },
    jsonNoise = { fg = c.fg },
    jsonKeywordMatch = { fg = c.fg },
    jsonBraces = { fg = c.fg },
    jsonNumber = { fg = c.pc.orange },
    jsonNull = { fg = c.purple, bold = true },
    jsonBoolean = { fg = c.green, bold = true },
    jsonCommentError = { fg = c.pc.pink, bg = c.bg },

    -- PlantUML Highlighting
    plantumlPreProc = { fg = c.pc.orange, bold = true },
    plantumlDirectedOrVerticalArrowRL = { fg = c.pc.pink },
    plantumlDirectedOrVerticalArrowLR = { fg = c.pc.pink },
    plantumlString = { fg = c.olive },
    plantumlActivityThing = { fg = c.purple },
    plantumlText = { fg = c.navy },
    plantumlClassPublic = { fg = c.olive, bold = true },
    plantumlClassPrivate = { fg = c.red },
    plantumlColonLine = { fg = c.pc.orange },
    plantumlClass = { fg = c.navy },
    plantumlHorizontalArrow = { fg = c.pc.pink },
    plantumlTypeKeyword = { fg = c.blue, bold = true },
    plantumlKeyword = { fg = c.pc.pink, bold = true },

    plantumlType = { fg = c.blue, bold = true },
    plantumlBlock = { fg = c.pc.pink, bold = true },
    plantumlPreposition = { fg = c.pc.orange },
    plantumlLayout = { fg = c.blue, bold = true },
    plantumlNote = { fg = c.pc.orange },
    plantumlLifecycle = { fg = c.aqua },
    plantumlParticipant = { fg = c.fg, bold = true },

    -- Ruby Highlighting
    rubyModule = { fg = c.navy, bold = true },
    rubyClass = { fg = c.pc.pink, bold = true },
    rubyPseudoVariable = { fg = c.comment, bold = true },
    rubyKeyword = { fg = c.pc.pink },
    rubyInstanceVariable = { fg = c.purple },
    rubyFunction = { fg = c.fg, bold = true },
    rubyDefine = { fg = c.pc.pink },
    rubySymbol = { fg = c.aqua },
    rubyConstant = { fg = c.blue },
    rubyAccess = { fg = c.navy },
    rubyAttribute = { fg = c.green },
    rubyInclude = { fg = c.red },
    rubyLocalVariableOrMethod = { fg = c.pc.orange },
    rubyCurlyBlock = { fg = c.fg },
    rubyCurlyBlockDelimiter = { fg = c.aqua },
    rubyArrayDelimiter = { fg = c.aqua },
    rubyStringDelimiter = { fg = c.olive },
    rubyInterpolationDelimiter = { fg = c.pc.orange },
    rubyConditional = { fg = c.purple, bold = true },
    rubyRepeat = { fg = c.purple, bold = true },
    rubyControl = { fg = c.purple, bold = true },
    rubyException = { fg = c.purple, bold = true },
    rubyExceptional = { fg = c.purple, bold = true },
    rubyBoolean = { fg = c.green, bold = true },

    -- Perl Highlighting
    perlFiledescRead = { fg = c.green },
    perlMatchStartEnd = { fg = c.pc.pink },
    perlStatementFlow = { fg = c.pc.pink },
    perlStatementStorage = { fg = c.pc.pink },
    perlFunction = { fg = c.pc.pink, bold = true },
    perlMethod = { fg = c.fg },
    perlStatementFiledesc = { fg = c.pc.orange },
    perlVarPlain = { fg = c.navy },
    perlSharpBang = { fg = c.comment },
    perlStatementInclude = { fg = c.aqua, bold = true },
    perlStatementScalar = { fg = c.purple },
    perlSubName = { fg = c.aqua, bold = true },
    perlSpecialString = { fg = c.olive, bold = true },

    -- Lua Highlighting
    luaFunc = { fg = c.fg },
    luaIn = { fg = c.blue, bold = true },
    luaFunction = { fg = c.pc.pink },
    luaStatement = { fg = c.blue },
    luaRepeat = { fg = c.blue, bold = true },
    luaCondStart = { fg = c.purple, bold = true },
    luaTable = { fg = c.aqua, bold = true },
    luaConstant = { fg = c.green, bold = true },
    luaElse = { fg = c.purple, bold = true },
    luaCondElseif = { fg = c.purple, bold = true },
    luaCond = { fg = c.purple, bold = true },
    luaCondEnd = { fg = c.purple },

    -- Yaml Highlighting
    yamlBlockMappingKey = { fg = c.blue },
    yamlKeyValueDelimiter = { fg = c.pc.pink },
    yamlBlockCollectionItemStart = { fg = c.pc.pink },

    -- XML Highlighting
    xmlProcessingDelim = { fg = c.pc.pink },
    xmlString = { fg = c.olive },
    xmlEqual = { fg = c.pc.orange },
    xmlAttrib = { fg = c.navy },
    xmlAttribPunct = { fg = c.pc.pink },
    xmlTag = { fg = c.blue },
    xmlTagName = { fg = c.blue },
    xmlEndTag = { fg = c.blue },
    xmlNamespace = { fg = c.pc.orange },

    -- Cucumber Highlighting
    cucumberFeature = { fg = c.blue, bold = true },
    cucumberBackground = { fg = c.pc.pink, bold = true },
    cucumberScenario = { fg = c.pc.pink, bold = true },
    cucumberGiven = { fg = c.pc.orange },
    cucumberGivenAnd = { fg = c.blue },
    cucumberThen = { fg = c.pc.orange },
    cucumberThenAnd = { fg = c.blue },
    cucumberWhen = { fg = c.purple, bold = true },
    cucumberScenarioOutline = { fg = c.pc.pink, bold = true },
    cucumberExamples = { fg = c.aqua },
    cucumberTags = { fg = c.aqua },
    cucumberPlaceholder = { fg = c.aqua },

    -- GNU sed highlighting
    sedST = { fg = c.purple, bold = true },
    sedFlag = { fg = c.purple, bold = true },
    sedRegexp47 = { fg = c.pc.pink },
    sedRegexpMeta = { fg = c.blue, bold = true },
    sedReplacement47 = { fg = c.olive },
    sedReplaceMeta = { fg = c.pc.orange, bold = true },
    sedAddress = { fg = c.pc.pink },
    sedFunction = { fg = c.aqua, bold = true },
    sedBranch = { fg = c.green, bold = true },
    sedLabel = { fg = c.green, bold = true },

    -- GNU awk highlighting
    awkPatterns = { fg = c.pc.pink, bold = true },
    awkSearch = { fg = c.pc.pink },
    awkRegExp = { fg = c.blue, bold = true },
    awkCharClass = { fg = c.blue, bold = true },
    awkFieldVars = { fg = c.green, bold = true },
    awkStatement = { fg = c.blue, bold = true },
    awkFunction = { fg = c.blue },
    awkVariables = { fg = c.green, bold = true },
    awkArrayElement = { fg = c.pc.orange },
    awkOperator = { fg = c.fg },
    awkBoolLogic = { fg = c.fg },
    awkExpression = { fg = c.fg },
    awkSpecialPrintf = { fg = c.olive, bold = true },

    -- }}}

    -- Plugin: NERDTree
    NERDTreeUp = { fg = c.comment },
    NERDTreeHelpCommand = { fg = c.pc.pink },
    NERDTreeHelpTitle = { fg = c.blue, bold = true },
    NERDTreeHelpKey = { fg = c.pc.pink },
    NERDTreeHelp = { fg = c.fg },
    NERDTreeToggleOff = { fg = c.red },
    NERDTreeToggleOn = { fg = c.green },
    NERDTreeDir = { fg = c.blue, bold = true },
    NERDTreeDirSlash = { fg = c.pc.pink },
    NERDTreeFile = { fg = c.fg },
    NERDTreeExecFile = { fg = c.green },
    NERDTreeOpenable = { fg = c.aqua, bold = true },
    NERDTreeClosable = { fg = c.pc.pink },

    -- Plugin: Tagbar
    TagbarHelpTitle = { fg = c.blue, bold = true },
    TagbarHelp = { fg = c.fg },
    TagbarKind = { fg = c.pc.pink },
    TagbarSignature = { fg = c.aqua },

    -- Plugin: Indent Guides
    IndentGuidesOdd = { bg = c.bg },
    IndentGuidesEven = { bg = c.cursorline },

    -- Git commit message
    gitcommitSummary = { fg = c.blue },
    gitcommitHeader = { fg = c.green, bold = true },
    gitcommitSelectedType = { fg = c.blue },
    gitcommitSelectedFile = { fg = c.pc.pink },
    gitcommitUntrackedFile = { fg = c.diff.delete.fg },
    gitcommitBranch = { fg = c.aqua, bold = true },
    gitcommitDiscardedType = { fg = c.diff.delete.fg },
    gitcommitDiff = { fg = c.comment },

    -- nvim-cmp
    CmpItemKindValue = { link = 'Number' },
    CmpItemKindVariable = { link = 'Identifier' },
    CmpItemKindKeyword = { link = 'Keyword' },
    CmpItemKindField = { link = 'CmpItemKindVariable' },
    temKindFunction = { fg = c.blue },
    CmpItemKindMethod = { link = 'CmpItemKindFunction' },
    CmpItemKindConstructor = { link = 'CmpItemKindFunction' },
    CmpItemKindClass = { link = 'Structure' },
    CmpItemKindInterface = { link = 'Structure' },
    CmpItemKindSnippet = { fg = c.pc.orange },
    CmpItemKindFile = { fg = c.pc.orange },
    CmpItemKindFolder = { link = 'CmpItemKindFile' },
    CmpItemAbbr = { fg = c.fg, bg = c.none },
    --CmpItemAbbrMatch = { fg = c.blue, bg = c.none },
    CmpItemAbbrMatch = { fg = c.blue, bold = true },
    --CmpItemAbbrMatchFuzzy = { fg = c.blue, bg = c.none },
    CmpItemAbbrMatchFuzzy = { fg = c.blue, bold = true },
    --CmpItemAbbrDeprecated = { fg = c.gutter.fg, bg = c.none, strikethrough = true },
    CmpItemAbbrDeprecated = { fg = c.fg, strikethrough = true },
    CmpDocumentation = { fg = c.fg, bg = c.surface_container.bg },
    CmpDocumentationBorder = { fg = c.border_accent, bg = c.surface_container.bg },
    CmpGhostText = { fg = c.black },
    CmpItemMenu = { fg = c.comment, bg = c.none },
    --CmpItemKindDefault = { fg = c.fg_dark, bg = c.none },
    CmpItemKindDefault = { fg = c.olive, bg = c.none },
    --CmpItemKindCodeium = { fg = c.teal, bg = c.none },
    --CmpItemKindCopilot = { fg = c.teal, bg = c.none },
    --CmpItemKindTabNine = { fg = c.teal, bg = c.none },
    CmpItemKindCodeium = { fg = c.aqua, bg = c.none },
    CmpItemKindCopilot = { fg = c.aqua, bg = c.none },
    CmpItemKindTabNine = { fg = c.aqua, bg = c.none },

    --[

    ---------------------

    -------------
    -- unorganized below here

    -- I don't know what these all are, just going to throw things in to see what happens.

    lCursor = { fg = c.bg, bg = c.fg }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    CursorIM = { fg = c.bg, bg = c.fg }, -- like Cursor, but used when in IME mode |CursorIM|
    --TermCursor  = { }, -- cursor in a focused terminal
    --TermCursorNC= { }, -- cursor in an unfocused terminal
    ErrorMsg = { fg = c.error.fg, bg = c.error.bg }, -- error messages on the command line
    SignColumnSB = { bg = c.sidebar.bg, fg = c.gutter.fg }, -- column where |signs| are displayed
    Substitute = { bg = c.red, fg = c.black }, -- |:substitute| replacement text highlighting
    --MsgArea = { fg = c.fg_dark }, -- Area for messages and cmdline
    MsgArea = { fg = c.dark_blue }, -- Area for messages and cmdline
    --MsgSeparator= { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    --NormalNC = { fg = c.fg, bg = options.transparent and c.none or options.dim_inactive and c.bg_dark or c.bg }, -- normal text in non-current windows
    NormalNC = { fg = c.fg, bg = c.bg }, -- normal text in non-current windows
    NormalSB = { fg = c.sidebar.fg, bg = c.sidebar.bg }, -- normal text in sidebar
    NormalFloat = { fg = c.surface_container.fg, bg = c.surface_container.bg }, -- Normal text in floating windows.
    FloatBorder = { fg = c.border_accent, bg = c.surface_container.bg },
    FloatTitle = { fg = c.border_accent, bg = c.surface_container.bg },

    QuickFixLine = { bg = c.visual.bg, bold = true }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    CurSearch = { link = 'IncSearch' },
    VisualNOS = { bg = c.visual.bg }, -- Visual mode selection when vim is 'Not Owning the Selection'.
    Whitespace = { fg = c.gutter.fg }, -- 'nbsp', 'space', 'tab' and 'trail' in 'listchars'
    WinBar = { link = 'StatusLine' }, -- window bar
    WinBarNC = { link = 'StatusLineNC' }, -- window bar in inactive windows

    -- These groups are not listed as default vim groups,
    -- but they are defacto standard group names for syntax highlighting.
    -- commented out groups should chain up to their 'preferred' group by
    -- default,
    -- Uncomment and edit if you want more specific syntax highlighting.

    --qfLineNr = { fg = c.dark5 },
    qfLineNr = { fg = c.dark_blue },
    qfFileName = { fg = c.blue },


    ['helpCommand'] = { bg = c.black, fg = c.blue },

    debugPC = { bg = c.sidebar.bg }, -- used for highlighting the current line in terminal-debug
    --debugBreakpoint = { bg = util.darken(c.info, 0.1), fg = c.info }, -- used for breakpoint colors in terminal-debug
    debugBreakpoint = { bg = c.info.bg, fg = c.info.fg }, -- used for breakpoint colors in terminal-debug

    dosIniLabel = { link = '@property' },

    DapStoppedLine = { bg = c.warn.bg }, -- Used for 'Warning' diagnostic virtual text

    -- These groups are for the Neovim tree-sitter highlights.
    ['@annotation'] = { link = 'PreProc' },
    ['@attribute'] = { link = 'PreProc' },
    ['@boolean'] = { link = 'Boolean' },
    ['@character'] = { link = 'Character' },
    ['@character.special'] = { link = 'SpecialChar' },
    ['@comment'] = { link = 'Comment' },
    ['@keyword.conditional'] = { link = 'Conditional' },
    ['@constant'] = { link = 'Constant' },
    ['@constant.builtin'] = { link = 'Special' },
    ['@constant.macro'] = { link = 'Define' },
    ['@keyword.debug'] = { link = 'Debug' },
    ['@keyword.directive.define'] = { link = 'Define' },
    ['@keyword.exception'] = { link = 'Exception' },
    ['@number.float'] = { link = 'Float' },
    ['@function'] = { link = 'Function' },
    ['@function.builtin'] = { link = 'Special' },
    ['@function.call'] = { link = '@function' },
    ['@function.macro'] = { link = 'Macro' },
    ['@keyword.import'] = { link = 'Include' },
    ['@keyword.coroutine'] = { link = '@keyword' },
    ['@keyword.operator'] = { link = '@operator' },
    ['@keyword.return'] = { link = '@keyword' },
    ['@function.method'] = { link = 'Function' },
    ['@function.method.call'] = { link = '@function.method' },
    ['@namespace.builtin'] = { link = '@variable.builtin' },
    ['@none'] = {},
    ['@number'] = { link = 'Number' },
    ['@keyword.directive'] = { link = 'PreProc' },
    ['@keyword.repeat'] = { link = 'Repeat' },
    ['@keyword.storage'] = { link = 'StorageClass' },
    ['@string'] = { link = 'String' },
    ['@markup.link.label'] = { link = 'SpecialChar' },
    ['@markup.link.label.symbol'] = { link = 'Identifier' },
    ['@tag'] = { link = 'Label' },
    ['@tag.attribute'] = { link = '@property' },
    ['@tag.delimiter'] = { link = 'Delimiter' },
    ['@markup'] = { link = '@none' },
    ['@markup.environment'] = { link = 'Macro' },
    ['@markup.environment.name'] = { link = 'Type' },
    ['@markup.raw'] = { link = 'String' },
    ['@markup.math'] = { link = 'Special' },
    ['@markup.strong'] = { bold = true },
    ['@markup.emphasis'] = { italic = true },
    ['@markup.strikethrough'] = { strikethrough = true },
    ['@markup.underline'] = { underline = true },
    ['@markup.heading'] = { link = 'Title' },
    ['@comment.note'] = { fg = c.hint.fg },
    ['@comment.error'] = { fg = c.error.fg },
    ['@comment.hint'] = { fg = c.hint.fg },
    ['@comment.info'] = { fg = c.info.fg },
    ['@comment.warning'] = { fg = c.warn.fg },
    ['@comment.todo'] = { fg = c.todo.fg },
    ['@markup.link.url'] = { link = 'Underlined' },
    ['@type'] = { link = 'Type' },
    ['@type.definition'] = { link = 'Typedef' },
    ['@type.qualifier'] = { link = '@keyword' },

    --- Misc
    -- TODO:
    -- ['@comment.documentation'] = { },
    --['@operator'] = { fg = c.blue5 }, -- For any operator: `+`, but also `->` and `*` in C.
    ['@operator'] = { fg = c.aqua }, -- For any operator: `+`, but also `->` and `*` in C.

    --- Punctuation
    --['@punctuation.delimiter'] = { fg = c.blue5 }, -- For delimiters ie: `.`
    ['@punctuation.delimiter'] = { link = 'Delimiter' }, -- For delimiters ie: `.`
    --['@punctuation.bracket'] = { fg = c.fg_dark }, -- For brackets and parens.
    ['@punctuation.bracket'] = { fg = c.aqua }, -- For brackets and parens.
    ['@punctuation.special'] = { fg = c.aqua }, -- For special symbols (e.g. `{}` in string interpolation)
    ['@markup.list'] = { fg = c.navy }, -- For special punctutation that does not fall in the catagories before.
    ['@markup.list.markdown'] = { fg = c.pc.orange, bold = true },

    --- Literals
    --['@string.documentation'] = { fg = c.yellow },
    --['@string.regexp'] = { fg = c.blue6 }, -- For regexes.
    --['@string.escape'] = { fg = c.light_magenta }, -- For escape characters within a string.
    ['@string.documentation'] = { fg = c.yellow },
    ['@string.regexp'] = { fg = c.aqua }, -- For regexes.
    ['@string.escape'] = { fg = c.fuchsia }, -- For escape characters within a string.

    --- Functions
    ['@constructor'] = { fg = c.fuchsia }, -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
    ['@variable.parameter'] = { fg = c.yellow }, -- For parameters of a function.
    ['@variable.parameter.builtin'] = { fg = util.lighten(c.yellow, 0.8) }, -- For builtin parameters of a function, e.g. '...' or Smali's p[1-99]

    --- Keywords
    ['@keyword'] = { fg = c.yellow, style = options.styles.keywords }, -- For keywords that don't fall in previous categories.
    -- ['@keyword'] = { fg = c.purple, style = options.styles.keywords }, -- For keywords that don't fall in previous categories.
    ['@keyword.function'] = { fg = c.fuchsia, style = options.styles.functions }, -- For keywords used to define a fuction.

    ['@label'] = { fg = c.blue }, -- For labels: `label:` in C and `:label:` in Lua.

    --- Types
    ['@type.builtin'] = { fg = util.darken(c.aqua, 0.8) },
    ['@variable.member'] = { fg = c.lime }, -- For fields.
    ['@property'] = { fg = c.lime },

    --- Identifiers
    ['@variable'] = { fg = c.fg, style = options.styles.variables }, -- Any variable name that does not have another highlight.
    ['@variable.builtin'] = { fg = c.red }, -- Variable names that are defined by the languages, like `this` or `self`.
    ['@module.builtin'] = { fg = c.red }, -- Variable names that are defined by the languages, like `this` or `self`.

    --- Text
    -- ['@markup.raw.markdown'] = { fg = c.blue },
    --['@markup.raw.markdown_inline'] = { bg = c.terminal_black, fg = c.blue },
    ['@markup.raw.markdown_inline'] = { bg = c.black, fg = c.blue },
    --['@markup.link'] = { fg = c.teal },
    ['@markup.link'] = { fg = c.aqua },

    ['@markup.list.unchecked'] = { fg = c.blue }, -- For brackets and parens.
    --['@markup.list.checked'] = { fg = c.green }, -- For brackets and parens.
    ['@markup.list.checked'] = { fg = c.lime }, -- For brackets and parens.

    ['@diff.plus'] = { link = 'DiffAdd' },
    ['@diff.minus'] = { link = 'DiffDelete' },
    ['@diff.delta'] = { link = 'DiffChange' },

    ['@module'] = { link = 'Include' },

    -- tsx
    ['@tag.tsx'] = { fg = c.red },
    --['@constructor.tsx'] = { fg = c.blue },
    ['@constructor.tsx'] = { fg = c.aqua },
    ['@tag.delimiter.tsx'] = { fg = util.darken(c.blue, 0.7) },

    -- LSP Semantic Token Groups
    ['@lsp.type.boolean'] = { link = '@boolean' },
    ['@lsp.type.builtinType'] = { link = '@type.builtin' },
    ['@lsp.type.comment'] = { link = '@comment' },
    ['@lsp.type.decorator'] = { link = '@attribute' },
    ['@lsp.type.deriveHelper'] = { link = '@attribute' },
    ['@lsp.type.enum'] = { link = '@type' },
    ['@lsp.type.enumMember'] = { link = '@constant' },
    ['@lsp.type.escapeSequence'] = { link = '@string.escape' },
    ['@lsp.type.formatSpecifier'] = { link = '@markup.list' },
    ['@lsp.type.generic'] = { link = '@variable' },
    --['@lsp.type.interface'] = { fg = util.lighten(c.blue, 0.7) },
    ['@lsp.type.interface'] = { fg = util.lighten(c.aqua, 0.7) },
    ['@lsp.type.keyword'] = { link = '@keyword' },
    ['@lsp.type.lifetime'] = { link = '@keyword.storage' },
    ['@lsp.type.namespace'] = { link = '@module' },
    ['@lsp.type.number'] = { link = '@number' },
    ['@lsp.type.operator'] = { link = '@operator' },
    ['@lsp.type.parameter'] = { link = '@variable.parameter' },
    ['@lsp.type.property'] = { link = '@property' },
    ['@lsp.type.selfKeyword'] = { link = '@variable.builtin' },
    ['@lsp.type.selfTypeKeyword'] = { link = '@variable.builtin' },
    ['@lsp.type.string'] = { link = '@string' },
    ['@lsp.type.typeAlias'] = { link = '@type.definition' },
    ['@lsp.type.unresolvedReference'] = { undercurl = true, sp = c.error.fg },
    ['@lsp.type.variable'] = {}, -- use treesitter styles for regular variables
    ['@lsp.typemod.class.defaultLibrary'] = { link = '@type.builtin' },
    ['@lsp.typemod.enum.defaultLibrary'] = { link = '@type.builtin' },
    ['@lsp.typemod.enumMember.defaultLibrary'] = { link = '@constant.builtin' },
    ['@lsp.typemod.function.defaultLibrary'] = { link = '@function.builtin' },
    ['@lsp.typemod.keyword.async'] = { link = '@keyword.coroutine' },
    ['@lsp.typemod.keyword.injected'] = { link = '@keyword' },
    ['@lsp.typemod.macro.defaultLibrary'] = { link = '@function.builtin' },
    ['@lsp.typemod.method.defaultLibrary'] = { link = '@function.builtin' },
    ['@lsp.typemod.operator.injected'] = { link = '@operator' },
    ['@lsp.typemod.string.injected'] = { link = '@string' },
    ['@lsp.typemod.struct.defaultLibrary'] = { link = '@type.builtin' },
    --['@lsp.typemod.type.defaultLibrary'] = { fg = util.darken(c.blue, 0.8) },
    --['@lsp.typemod.typeAlias.defaultLibrary'] = { fg = util.darken(c.blue, 0.8) },
    ['@lsp.typemod.type.defaultLibrary'] = { fg = util.darken(c.aqua, 0.8) },
    ['@lsp.typemod.typeAlias.defaultLibrary'] = { fg = util.darken(c.aqua, 0.8) },
    ['@lsp.typemod.variable.callable'] = { link = '@function' },
    ['@lsp.typemod.variable.defaultLibrary'] = { link = '@variable.builtin' },
    ['@lsp.typemod.variable.injected'] = { link = '@variable' },
    ['@lsp.typemod.variable.static'] = { link = '@constant' },
    -- NOTE: maybe add these with distinct highlights?
    -- ['@lsp.typemod.variable.globalScope'] (global variables)

    -- ts-rainbow
    rainbowcol1 = { fg = c.red },
    --rainbowcol2 = { fg = c.light_yellow },
    rainbowcol2 = { fg = c.yellow },
    rainbowcol3 = { fg = c.green },
    --rainbowcol4 = { fg = c.teal },
    rainbowcol4 = { fg = c.aqua },
    rainbowcol5 = { fg = c.blue },
    --rainbowcol6 = { fg = c.light_magenta },
    rainbowcol6 = { fg = c.fuchsia },
    rainbowcol7 = { fg = c.purple },

    -- ts-rainbow2 (maintained fork)
    TSRainbowRed = { fg = c.red },
    TSRainbowOrange = { fg = c.pc.orange },
    --TSRainbowYellow = { fg = c.light_yellow },
    TSRainbowYellow = { fg = c.yellow },
    TSRainbowGreen = { fg = c.green },
    TSRainbowBlue = { fg = c.blue },
    TSRainbowViolet = { fg = c.purple },
    --TSRainbowCyan = { fg = c.light_cyan },
    TSRainbowCyan = { fg = c.aqua },

    -- rainbow-delimiters
    RainbowDelimiterRed = { fg = c.red },
    RainbowDelimiterOrange = { fg = c.pc.orange },
    --RainbowDelimiterYellow = { fg = c.light_yellow },
    RainbowDelimiterYellow = { fg = c.yellow },
    RainbowDelimiterGreen = { fg = c.green },
    RainbowDelimiterBlue = { fg = c.blue },
    RainbowDelimiterViolet = { fg = c.purple },
    --RainbowDelimiterCyan = { fg = c.light_cyan },
    RainbowDelimiterCyan = { fg = c.aqua },

    -- LspTrouble
    --TroubleText = { fg = c.fg_dark },
    --TroubleCount = { fg = c.light_magenta, bg = c.gutter.fg },
    TroubleText = { fg = c.olive },
    TroubleCount = { fg = c.fuchsia, bg = c.gutter.fg },
    TroubleNormal = { fg = c.fg, bg = c.sidebar.bg },

    -- Illuminate
    illuminatedWord = { bg = c.gutter.fg },
    illuminatedCurWord = { bg = c.gutter.fg },
    IlluminatedWordText = { bg = c.gutter.fg },
    IlluminatedWordRead = { bg = c.gutter.fg },
    IlluminatedWordWrite = { bg = c.gutter.fg },

    -- diff
    diffAdded = { fg = c.diff.add.fg },
    diffRemoved = { fg = c.diff.delete.fg },
    diffChanged = { fg = c.diff.change.fg },
    diffOldFile = { fg = c.yellow },
    --diffNewFile = { fg = c.comment },
    diffNewFile = { fg = c.pc.orange },
    diffSubname = { fg = c.comment },
    diffFile = { fg = c.blue },
    --diffLine = { fg = c.orange },
    diffLine = { fg = c.comment },
    --diffIndexLine = { fg = c.comment },
    diffIndexLine = { fg = c.fuchsia },
    diffBDiffer = { fg = c.pc.orange },

    -- Neogit
    --NeogitBranch = { fg = c.light_magenta },
    NeogitBranch = { fg = c.fuchsia },
    NeogitRemote = { fg = c.purple },
    NeogitHunkHeader = { bg = c.bg_accent, fg = c.fg },
    NeogitHunkHeaderHighlight = { bg = c.gutter.fg, fg = c.blue },
    --NeogitDiffContextHighlight = { bg = util.darken(c.gutter.fg, 0.5), fg = c.fg_dark },
    NeogitDiffContextHighlight = { bg = util.darken(c.gutter.fg, 0.5), fg = c.olive },
    NeogitDiffDeleteHighlight = { fg = c.diff.delete.fg, bg = c.diff.delete.bg },
    NeogitDiffAddHighlight = { fg = c.diff.add.fg, bg = c.diff.add.bg },

    -- Neotest
    NeotestPassed = { fg = c.green },
    --NeotestRunning = { fg = c.light_yellow },
    NeotestRunning = { fg = c.yellow },
    NeotestFailed = { fg = c.red },
    NeotestSkipped = { fg = c.blue },
    --NeotestNamespace = { fg = c.dark_green },
    --NeotestFocused = { fg = c.light_yellow },
    --NeotestFile = { fg = c.teal },
    NeotestTest = { fg = c.sidebar.fg },
    NeotestNamespace = { fg = c.green },
    NeotestFocused = { fg = c.yellow },
    NeotestFile = { fg = c.aqua },
    NeotestDir = { fg = c.blue },
    NeotestBorder = { fg = c.blue },
    NeotestIndent = { fg = c.sidebar.fg },
    NeotestExpandMarker = { fg = c.sidebar.fg },
    NeotestAdapterName = { fg = c.purple, bold = true },
    NeotestWinSelect = { fg = c.blue },
    NeotestMarked = { fg = c.blue },
    NeotestTarget = { fg = c.blue },
    --[ NeotestUnknown = {}, ]

    -- GitGutter
    GitGutterAdd = { fg = c.diff.add.fg }, -- diff mode: Added line |diff.txt|
    GitGutterChange = { fg = c.diff.change.fg }, -- diff mode: Changed line |diff.txt|
    GitGutterDelete = { fg = c.diff.delete.fg }, -- diff mode: Deleted line |diff.txt|
    GitGutterAddLineNr = { fg = c.diff.add.fg },
    GitGutterChangeLineNr = { fg = c.diff.change.fg },
    GitGutterDeleteLineNr = { fg = c.diff.delete.fg },
    GitGutterAddLine = { fg = c.diff.add.bg },
    GitGutterChangeLine = { fg = c.diff.change.fg },
    GitGutterDeleteLine = { fg = c.diff.delete.fg },

    -- GitSigns
    GitSignsAdd = { fg = c.diff.add.fg }, -- diff mode: Added line |diff.txt|
    GitSignsChange = { fg = c.diff.change.fg }, -- diff mode: Changed line |diff.txt|
    GitSignsDelete = { fg = c.diff.delete.fg }, -- diff mode: Deleted line |diff.txt|

    -- Telescope
    TelescopeBorder = { fg = c.border_accent, bg = c.surface_container.bg },
    TelescopeNormal = { fg = c.fg, bg = c.surface_container.bg },

    -- NvimTree
    NvimTreeNormal = { fg = c.sidebar.fg, bg = c.sidebar.bg },
    NvimTreeWinSeparator = {
      fg = options.styles.sidebars == 'transparent' and c.border or c.sidebar.bg,
      bg = c.sidebar.bg,
    },
    NvimTreeNormalNC = { fg = c.sidebar.fg, bg = c.sidebar.bg },
    NvimTreeRootFolder = { fg = c.blue, bold = true },
    NvimTreeGitDirty = { fg = c.diff.change.fg },
    NvimTreeGitNew = { fg = c.diff.add.fg },
    NvimTreeGitDeleted = { fg = c.diff.delete.fg },
    NvimTreeOpenedFile = { bg = c.bg_accent },
    NvimTreeSpecialFile = { fg = c.purple, underline = true },
    NvimTreeIndentMarker = { fg = c.gutter.fg },
    NvimTreeImageFile = { fg = c.sidebar.fg },
    NvimTreeSymlink = { fg = c.blue },
    NvimTreeFolderIcon = { bg = c.none, fg = c.blue },
    -- NvimTreeFolderName= { fg = c.fg_float },

    NeoTreeNormal = { fg = c.sidebar.fg, bg = c.sidebar.bg },
    NeoTreeNormalNC = { fg = c.sidebar.fg, bg = c.sidebar.bg },
    NeoTreeDimText = { fg = c.gutter.fg },

    -- Fern
    FernBranchText = { fg = c.blue },

    -- glyph palette
    --GlyphPalette1 = { fg = c.red1 },
    --GlyphPalette3 = { fg = c.light_yellow },
    --GlyphPalette6 = { fg = c.green },
    GlyphPalette1 = { fg = c.red },
    GlyphPalette2 = { fg = c.green },
    GlyphPalette3 = { fg = c.yellow },
    GlyphPalette4 = { fg = c.blue },
    GlyphPalette6 = { fg = c.lime },
    GlyphPalette7 = { fg = c.fg },
    GlyphPalette9 = { fg = c.red },

    -- Dashboard
    --DashboardShortCut = { fg = c.light_cyan },
    DashboardShortCut = { fg = c.aqua },
    DashboardHeader = { fg = c.blue },
    --DashboardCenter = { fg = c.light_magenta },
    --DashboardFooter = { fg = c.blue },
    DashboardCenter = { fg = c.fuchsia },
    DashboardFooter = { fg = c.aqua },
    DashboardKey = { fg = c.pc.orange },
    --DashboardDesc = { fg = c.light_cyan },
    --DashboardIcon = { fg = c.light_cyan, bold = true },
    DashboardDesc = { fg = c.aqua },
    DashboardIcon = { fg = c.aqua, bold = true },

    -- Alpha
    AlphaShortcut = { fg = c.pc.orange },
    AlphaHeader = { fg = c.blue },
    AlphaHeaderLabel = { fg = c.pc.orange },
    --AlphaFooter = { fg = c.blue },
    --AlphaButtons = { fg = c.light_cyan },
    AlphaFooter = { fg = c.aqua },
    AlphaButtons = { fg = c.aqua },

    -- WhichKey
    --WhichKey = { fg = c.light_cyan },
    WhichKey = { fg = c.aqua },
    WhichKeyGroup = { fg = c.blue },
    --WhichKeyDesc = { fg = c.light_magenta },
    WhichKeyDesc = { fg = c.fuchsia },
    WhichKeySeperator = { fg = c.comment },
    WhichKeySeparator = { fg = c.comment },
    WhichKeyFloat = { bg = c.sidebar.bg },
    --WhichKeyValue = { fg = c.dark5 },
    WhichKeyValue = { fg = c.black },

    -- LspSaga
    DiagnosticWarning = { link = 'DiagnosticWarn' },
    DiagnosticInformation = { link = 'DiagnosticInfo' },

    LspFloatWinNormal = { bg = c.surface_container.bg },
    LspFloatWinBorder = { fg = c.border_accent },
    LspSagaBorderTitle = { fg = c.aqua },
    LspSagaHoverBorder = { fg = c.blue },
    LspSagaRenameBorder = { fg = c.green },
    LspSagaDefPreviewBorder = { fg = c.green },
    LspSagaCodeActionBorder = { fg = c.blue },
    LspSagaFinderSelection = { fg = c.visual.bg },
    --LspSagaCodeActionTitle = { fg = c.blue },
    LspSagaCodeActionTitle = { fg = c.aqua },
    LspSagaCodeActionContent = { fg = c.purple },
    LspSagaSignatureHelpBorder = { fg = c.red },
    ReferencesCount = { fg = c.purple },
    DefinitionCount = { fg = c.purple },
    DefinitionIcon = { fg = c.blue },
    ReferencesIcon = { fg = c.blue },
    TargetWord = { fg = c.aqua },

    -- NeoVim
    healthError = { fg = c.error.fg },
    healthSuccess = { fg = c.green },
    healthWarning = { fg = c.warn.fg },

    -- BufferLine
    BufferLineIndicatorSelected = { fg = c.diff.change.fg },

    -- Barbar
    BufferCurrent = { bg = c.bg, fg = c.fg },
    BufferCurrentERROR = { bg = c.bg, fg = c.error.fg },
    BufferCurrentHINT = { bg = c.bg, fg = c.hint.fg },
    -- BufferCurrentIcon = { bg = c.bg, fg = c.},
    BufferCurrentINFO = { bg = c.bg, fg = c.info.fg },
    BufferCurrentWARN = { bg = c.bg, fg = c.warn.fg },
    BufferCurrentIndex = { bg = c.bg, fg = c.info.fg },
    BufferCurrentMod = { bg = c.bg, fg = c.warn.fg },
    BufferCurrentSign = { bg = c.bg, fg = c.bg },
    BufferCurrentTarget = { bg = c.bg, fg = c.red },
    BufferAlternate = { bg = c.gutter.fg, fg = c.fg },
    BufferAlternateERROR = { bg = c.gutter.fg, fg = c.error.fg },
    BufferAlternateHINT = { bg = c.gutter.fg, fg = c.hint.fg },
    -- BufferAlternateIcon = { bg = c.gutter.fg, fg = c. },
    BufferAlternateIndex = { bg = c.gutter.fg, fg = c.info.fg },
    BufferAlternateINFO = { bg = c.gutter.fg, fg = c.info.fg },
    BufferAlternateMod = { bg = c.gutter.fg, fg = c.warn.fg },
    BufferAlternateSign = { bg = c.gutter.fg, fg = c.info.fg },
    BufferAlternateTarget = { bg = c.gutter.fg, fg = c.red },
    BufferAlternateWARN = { bg = c.gutter.fg, fg = c.warn.fg },
    BufferVisible = { bg = c.statusline.bg, fg = c.fg },
    BufferVisibleERROR = { bg = c.statusline.bg, fg = c.error.fg },
    BufferVisibleHINT = { bg = c.statusline.bg, fg = c.hint.fg },
    -- BufferVisibleIcon = { bg = c.statusline.bg, fg = c. },
    BufferVisibleINFO = { bg = c.statusline.bg, fg = c.info.fg },
    BufferVisibleWARN = { bg = c.statusline.bg, fg = c.warn.fg },
    BufferVisibleIndex = { bg = c.statusline.bg, fg = c.info.fg },
    BufferVisibleMod = { bg = c.statusline.bg, fg = c.warn.fg },
    BufferVisibleSign = { bg = c.statusline.bg, fg = c.info.fg },
    BufferVisibleTarget = { bg = c.statusline.bg, fg = c.red },
    --BufferInactive = { bg = util.darken(c.bg_accent, 0.4), fg = util.darken(c.dark5, 0.8) },
    BufferInactive = { bg = util.darken(c.bg_accent, 0.4), fg = util.darken(c.black, 0.8) },
    BufferInactiveERROR = { bg = util.darken(c.bg_accent, 0.4), fg = util.darken(c.error.fg, 0.8) },
    BufferInactiveHINT = { bg = util.darken(c.bg_accent, 0.4), fg = util.darken(c.hint.fg, 0.8) },
    -- BufferInactiveIcon = { bg = c.statusline.bg, fg = util.darken(c., 0.1) },
    BufferInactiveINFO = { bg = util.darken(c.bg_accent, 0.4), fg = util.darken(c.info.fg, 0.8) },
    BufferInactiveWARN = { bg = util.darken(c.bg_accent, 0.4), fg = util.darken(c.warn.fg, 0.8) },
    --BufferInactiveIndex = { bg = util.darken(c.bg_accent, 0.4), fg = c.dark5 },
    BufferInactiveIndex = { bg = util.darken(c.bg_accent, 0.4), fg = c.black },
    BufferInactiveMod = { bg = util.darken(c.bg_accent, 0.4), fg = util.darken(c.warn.fg, 0.8) },
    BufferInactiveSign = { bg = util.darken(c.bg_accent, 0.4), fg = c.bg },
    BufferInactiveTarget = { bg = util.darken(c.bg_accent, 0.4), fg = c.red },
    --BufferOffset = { bg = c.statusline.bg, fg = c.dark5 },
    --BufferTabpageFill = { bg = util.darken(c.bg_accent, 0.8), fg = c.dark5 },
    BufferOffset = { bg = c.statusline.bg, fg = c.black },
    BufferTabpageFill = { bg = util.darken(c.bg_accent, 0.8), fg = c.black },
    BufferTabpages = { bg = c.statusline.bg, fg = c.none },

    -- Sneak
    Sneak = { fg = c.bg_accent, bg = c.fuchsia },
    SneakScope = { bg = c.visual.bg },

    -- Hop
    HopNextKey = { fg = c.purple, bold = true },
    HopNextKey1 = { fg = c.dark_blue, bold = true },
    HopNextKey2 = { fg = util.darken(c.dark_blue, 0.6) },
    --HopUnmatched = { fg = c.dark3 },
    HopUnmatched = { fg = c.black },

    TSNodeKey = { fg = c.purple, bold = true },
    --TSNodeUnmatched = { fg = c.dark3 },
    TSNodeUnmatched = { fg = c.black },

    LeapMatch = { bg = c.purple, fg = c.fg, bold = true },
    LeapLabelPrimary = { fg = c.purple, bold = true },
    LeapLabelSecondary = { fg = c.green, bold = true },
    --LeapBackdrop = { fg = c.dark3 },
    LeapBackdrop = { fg = c.black },

    --FlashBackdrop = { fg = c.dark3 },
    FlashBackdrop = { fg = c.black },
    FlashLabel = { bg = c.purple, bold = true, fg = c.fg },

    --LightspeedGreyWash = { fg = c.dark3 },
    LightspeedGreyWash = { fg = c.black },
    -- LightspeedCursor = { link = 'Cursor' },
    LightspeedLabel = { fg = c.purple, bold = true, underline = true },
    LightspeedLabelDistant = { fg = c.green, bold = true, underline = true },
    LightspeedLabelDistantOverlapped = { fg = c.green, underline = true },
    LightspeedLabelOverlapped = { fg = c.purple, underline = true },
    LightspeedMaskedChar = { fg = c.pc.orange },
    LightspeedOneCharMatch = { bg = c.purple, fg = c.fg, bold = true },
    LightspeedPendingOpArea = { bg = c.purple, fg = c.fg },
    LightspeedShortcut = { bg = c.purple, fg = c.fg, bold = true, underline = true },
    -- LightspeedShortcutOverlapped = { link = 'LightspeedShortcut' },
    -- LightspeedUniqueChar = { link = 'LightspeedUnlabeledMatch' },
    LightspeedUnlabeledMatch = { fg = c.dark_blue, bold = true },


    -- headlines.nvim
    --CodeBlock = { bg = c.bg_dark },
    CodeBlock = { bg = c.black },

    -- navic
    NavicSeparator = { fg = c.fg, bg = c.none },
    NavicText = { fg = c.fg, bg = c.none },

    AerialNormal = { fg = c.fg, bg = c.none },
    AerialGuide = { fg = c.gutter.fg },
    AerialLine = { link = 'LspInlayHint' },

    IndentBlanklineChar = { fg = c.gutter.fg, nocombine = true },
    IndentBlanklineContextChar = { fg = c.purple, nocombine = true },
    IblIndent = { fg = c.gutter.fg, nocombine = true },
    IblScope = { fg = c.purple, nocombine = true },

    -- Scrollbar
    ScrollbarHandle = { fg = c.none, bg = c.bg_accent },

    ScrollbarSearchHandle = { fg = c.pc.orange, bg = c.bg_accent },
    ScrollbarSearch = { fg = c.pc.orange, bg = c.none },

    ScrollbarErrorHandle = { fg = c.error.fg, bg = c.bg_accent },
    ScrollbarError = { fg = c.error.fg, bg = c.none },

    ScrollbarWarnHandle = { fg = c.warn.fg, bg = c.bg_accent },
    ScrollbarWarn = { fg = c.warn.fg, bg = c.none },

    ScrollbarInfoHandle = { fg = c.info.fg, bg = c.bg_accent },
    ScrollbarInfo = { fg = c.info.fg, bg = c.none },

    ScrollbarHintHandle = { fg = c.hint.fg, bg = c.bg_accent },
    ScrollbarHint = { fg = c.hint.fg, bg = c.none },

    ScrollbarMiscHandle = { fg = c.purple, bg = c.bg_accent },
    ScrollbarMisc = { fg = c.purple, bg = c.none },

    -- Yanky
    YankyPut = { link = 'IncSearch' },
    YankyYanked = { link = 'IncSearch' },

    -- Lazy
    LazyProgressDone = { bold = true, fg = c.purple },
    LazyProgressTodo = { bold = true, fg = c.gutter.fg },

    -- Notify
    NotifyBackground = { fg = c.fg, bg = c.bg },
    --- Border
    NotifyERRORBorder = { fg = util.darken(c.error.fg, 0.3), bg = options.transparent and c.none or c.bg },
    NotifyWARNBorder = { fg = util.darken(c.warn.fg, 0.3), bg = options.transparent and c.none or c.bg },
    NotifyINFOBorder = { fg = util.darken(c.info.fg, 0.3), bg = options.transparent and c.none or c.bg },
    NotifyDEBUGBorder = { fg = util.darken(c.comment, 0.3), bg = options.transparent and c.none or c.bg },
    NotifyTRACEBorder = { fg = util.darken(c.purple, 0.3), bg = options.transparent and c.none or c.bg },
    --- Icons
    NotifyERRORIcon = { fg = c.error.fg },
    NotifyWARNIcon = { fg = c.warn.fg },
    NotifyINFOIcon = { fg = c.info.fg },
    NotifyDEBUGIcon = { fg = c.comment },
    NotifyTRACEIcon = { fg = c.purple },
    --- Title
    NotifyERRORTitle = { fg = c.error.fg },
    NotifyWARNTitle = { fg = c.warn.fg },
    NotifyINFOTitle = { fg = c.info.fg },
    NotifyDEBUGTitle = { fg = c.comment },
    NotifyTRACETitle = { fg = c.purple },
    --- Body
    NotifyERRORBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    NotifyWARNBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    NotifyINFOBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    NotifyDEBUGBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    NotifyTRACEBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },

    -- Mini
    MiniCompletionActiveParameter = { underline = true },

    MiniCursorword = { bg = c.gutter.fg },
    MiniCursorwordCurrent = { bg = c.gutter.fg },

    MiniIndentscopeSymbol = { fg = c.blue, nocombine = true },
    MiniIndentscopePrefix = { nocombine = true }, -- Make it invisible

    MiniJump = { bg = c.purple, fg = '#ffffff' },

    MiniJump2dSpot = { fg = c.purple, bold = true, nocombine = true },

    MiniStarterCurrent = { nocombine = true },
    MiniStarterFooter = { fg = c.yellow, italic = true },
    MiniStarterHeader = { fg = c.blue },
    MiniStarterInactive = { fg = c.comment, style = options.styles.comments },
    MiniStarterItem = { fg = c.fg, bg = options.transparent and c.none or c.bg },
    MiniStarterItemBullet = { fg = c.border_accent },
    MiniStarterItemPrefix = { fg = c.warn.fg },
    MiniStarterSection = { fg = c.blue },
    MiniStarterQuery = { fg = c.info.fg },

    --MiniStatuslineDevinfo = { fg = c.fg_dark, bg = c.bg_accent },
    --MiniStatuslineFileinfo = { fg = c.fg_dark, bg = c.bg_accent },
    --MiniStatuslineFilename = { fg = c.fg_dark, bg = c.gutter.fg },
    MiniStatuslineDevinfo = { fg = c.fg, bg = c.bg_accent },
    MiniStatuslineFileinfo = { fg = c.fg, bg = c.bg_accent },
    MiniStatuslineFilename = { fg = c.fg, bg = c.gutter.fg },
    MiniStatuslineInactive = { fg = c.blue, bg = c.statusline.bg },
    MiniStatuslineModeCommand = { fg = c.black, bg = c.yellow, bold = true },
    MiniStatuslineModeInsert = { fg = c.black, bg = c.green, bold = true },
    MiniStatuslineModeNormal = { fg = c.black, bg = c.blue, bold = true },
    --MiniStatuslineModeOther = { fg = c.black, bg = c.teal, bold = true },
    MiniStatuslineModeOther = { fg = c.black, bg = c.aqua, bold = true },
    MiniStatuslineModeReplace = { fg = c.black, bg = c.red, bold = true },
    MiniStatuslineModeVisual = { fg = c.black, bg = c.fuchsia, bold = true },

    MiniSurround = { bg = c.pc.orange, fg = c.black },

    MiniTablineCurrent = { fg = c.fg, bg = c.gutter.fg },
    MiniTablineFill = { bg = c.black },
    --MiniTablineHidden = { fg = c.dark5, bg = c.statusline.bg },
    MiniTablineHidden = { fg = c.black, bg = c.statusline.bg },
    MiniTablineModifiedCurrent = { fg = c.warn.fg, bg = c.gutter.fg },
    MiniTablineModifiedHidden = { bg = c.statusline.bg, fg = util.darken(c.warn.fg, 0.7) },
    MiniTablineModifiedVisible = { fg = c.warn.fg, bg = c.statusline.bg },
    MiniTablineTabpagesection = { bg = c.statusline.bg, fg = c.none },
    MiniTablineVisible = { fg = c.fg, bg = c.statusline.bg },

    MiniTestEmphasis = { bold = true },
    MiniTestFail = { fg = c.red, bold = true },
    MiniTestPass = { fg = c.green, bold = true },

    MiniTrailspace = { bg = c.red },

    -- Noice

    --NoiceCompletionItemKindDefault = { fg = c.fg_dark, bg = c.none },
    NoiceCompletionItemKindDefault = { fg = c.black, bg = c.none },

    TreesitterContext = { bg = util.darken(c.gutter.fg, 0.8) },
    Hlargs = { fg = c.yellow },
    -- TreesitterContext = { bg = util.darken(c.visual.bg, 0.4) },
    --]]
  }

  -- lsp symbol kind and completion kind highlights
  local kinds = {
    Array = '@punctuation.bracket',
    Boolean = '@boolean',
    Class = '@type',
    Color = 'Special',
    Constant = '@constant',
    Constructor = '@constructor',
    Enum = '@lsp.type.enum',
    EnumMember = '@lsp.type.enumMember',
    Event = 'Special',
    Field = '@variable.member',
    File = 'Normal',
    Folder = 'Directory',
    Function = '@function',
    Interface = '@lsp.type.interface',
    Key = '@variable.member',
    Keyword = '@lsp.type.keyword',
    Method = '@function.method',
    Module = '@module',
    Namespace = '@module',
    Null = '@constant.builtin',
    Number = '@number',
    Object = '@constant',
    Operator = '@operator',
    Package = '@module',
    Property = '@property',
    Reference = '@markup.link',
    Snippet = 'Conceal',
    String = '@string',
    Struct = '@lsp.type.struct',
    Unit = '@lsp.type.struct',
    Text = '@markup',
    TypeParameter = '@lsp.type.typeParameter',
    Variable = '@variable',
    Value = '@string',
  }

  local kind_groups = { 'NavicIcons%s', 'Aerial%sIcon', 'CmpItemKind%s', 'NoiceCompletionItemKind%s' }
  for kind, link in pairs(kinds) do
    local base = 'LspKind' .. kind
    theme.highlights[base] = { link = link }
    for _, plugin in pairs(kind_groups) do
      theme.highlights[plugin:format(kind)] = { link = base }
    end
  end

  local markdown_rainbow = { c.blue, c.yellow, c.green, c.aqua, c.fuchsia, c.purple }
  --local markdown_rainbow = { c.blue, c.light_yellow, c.green, c.teal, c.light_magenta, c.purple }

  for i, color in ipairs(markdown_rainbow) do
    theme.highlights['@markup.heading.' .. i .. '.markdown'] = { fg = color, bold = true }
    theme.highlights['Headline' .. i] = { bg = util.darken(color, 0.05) }
  end
  theme.highlights['Headline'] = { link = 'Headline1' }

  if not vim.diagnostic then
    local severity_map = {
      Error = 'Error',
      Warn = 'Warning',
      Info = 'Information',
      Hint = 'Hint',
    }
    local types = { 'Default', 'VirtualText', 'Underline' }
    for _, type in ipairs(types) do
      for snew, sold in pairs(severity_map) do
        theme.highlights['LspDiagnostics' .. type .. sold] = {
          link = 'Diagnostic' .. (type == 'Default' and '' or type) .. snew,
        }
      end
    end
  end

  ---@type table<string, table>
  theme.defer = {}

  if options.hide_inactive_statusline then
    local inactive = { underline = true, bg = c.none, fg = c.bg, sp = c.border }

    -- StatusLineNC
    theme.highlights.StatusLineNC = inactive

    -- LuaLine
    for _, section in ipairs({ 'a', 'b', 'c' }) do
      theme.defer['lualine_' .. section .. '_inactive'] = inactive
    end

    -- mini.statusline
    theme.highlights.MiniStatuslineInactive = inactive
  end

  options.on_highlights(theme.highlights, theme.colors)

  --[[
  if config.lightmode() then
    util.invert_colors(theme.colors)
    util.invert_highlights(theme.highlights)
  end
  --]]

  return theme
end

return M

