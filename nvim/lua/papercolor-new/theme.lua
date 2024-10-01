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

  theme.highlights = {
    -- why Foo?
    Foo = c.surface,

    Global  = { fg = c.global }, -- titles for output from ':set all', ':autocmd' etc.

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

    ['helpCommand'] = { bg = c.black, fg = c.blue },

    -- These groups are for the Neovim tree-sitter highlights.
    ['@annotation'] = { link = 'PreProc' },
    ['@keyword.debug'] = { link = 'Debug' },
    ['@function.builtin'] = { link = 'Special' },
    ['@function.call'] = { link = '@function' },
    ['@keyword.coroutine'] = { link = '@keyword' },
    ['@keyword.operator'] = { link = '@operator' },
    ['@keyword.return'] = { link = '@keyword' },
    ['@function.method'] = { link = 'Function' },
    ['@function.method.call'] = { link = '@function.method' },
    ['@namespace.builtin'] = { link = '@variable.builtin' },
    ['@none'] = {},
    ['@keyword.storage'] = { link = 'StorageClass' },
    ['@markup.link.label'] = { link = 'SpecialChar' },
    ['@markup.link.label.symbol'] = { link = 'Identifier' },

    ['@tag'] = { link = 'Label' },
    ['@tag.delimiter'] = { link = 'Delimiter' },
    ['@markup'] = { link = '@none' },
    ['@markup.environment'] = { link = 'Macro' },
    ['@markup.environment.name'] = { link = 'Type' },

    ['@comment.hint'] = { fg = c.hint.fg },
    ['@comment.info'] = { fg = c.info.fg },
    ['@type.qualifier'] = { link = '@keyword' },

    --- Misc
    -- TODO:
    -- ['@comment.documentation'] = { },
    --['@operator'] = { fg = c.blue5 }, -- For any operator: `+`, but also `->` and `*` in C.
    ['@operator'] = { fg = c.aqua }, -- For any operator: `+`, but also `->` and `*` in C.

    --- Punctuation
    --['@punctuation.delimiter'] = { fg = c.blue5 }, -- For delimiters ie: `.`
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
    ['@keyword'] = { fg = c.yellow, italic = true }, -- For keywords that don't fall in previous categories.
    -- ['@keyword'] = { fg = c.purple, italic = true }, -- For keywords that don't fall in previous categories.
    ['@keyword.function'] = { fg = c.fuchsia }, -- For keywords used to define a fuction.

    ['@label'] = { fg = c.blue }, -- For labels: `label:` in C and `:label:` in Lua.

    --- Types
    ['@type.builtin'] = { fg = util.darken(c.aqua, 0.8) },
    ['@variable.member'] = { fg = c.lime }, -- For fields.
    ['@property'] = { fg = c.lime },

    --- Identifiers
    ['@variable'] = { fg = c.fg }, -- Any variable name that does not have another highlight.
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

    -- NvimTree
    NvimTreeNormal = { fg = c.sidebar.fg, bg = c.sidebar.bg },
    NvimTreeWinSeparator = {
      fg = c.sidebar.bg,
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

  options.on_highlights(theme.highlights, theme.colors)

  return theme
end

return M

