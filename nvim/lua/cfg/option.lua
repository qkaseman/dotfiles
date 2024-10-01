-- General --
vim.opt.mouse = 'a'
vim.opt.title = true
vim.opt.number = true
vim.opt.list = true
vim.opt.listchars = 'tab:▸-,trail:·,extends:»,precedes:«,nbsp:%'
vim.opt.signcolumn = "number" -- LSP icons in number gutter

-- Spelling --
vim.opt.spell = true

-- Tabs vs Spaces --
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.shiftround = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search --
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.wildmode = 'longest:full,full'

-- Splits --
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

-- All bells must die. --
vim.opt.belloff = 'all'
vim.opt.errorbells = false
vim.opt.visualbell = false

-- Buffers --
vim.opt.hidden = true -- Open new buffer with unsaved changes in current
vim.opt.virtualedit = 'block'

-- Tabs --
vim.opt.showtabline = 1 -- show if two tabs

-- Backup/Undo --
vim.opt.backup = true
vim.opt.backupdir = vim.fn.stdpath('data')..'/backup//'
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('data')..'/undo//'

-- Actually use cursor colours --
vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:Cursor/Cursor'

--[[
set title                   " Change window title
" Always change to dir of current file.
set autochdir

"" let mapleader=","          " leader is comma
" Set 'leader' timeout if ones isn't set.
if !has('nvim') && &ttimeoutlen == -1
    set ttimeout
    set ttimeoutlen=100
endif

if &encoding ==# 'latin1' && has('gui_running')
    set encoding=utf-8      " Modern encoding!
endif

set lazyredraw              " Don't redraw action is typed
set ttyfast                 " Fast terminal connection, better redrawing

set shortmess=aOstT         " Short messages (to avoid 'press a key' prompt)

" Enable mouse by default
set mouse=a

" Easy commands to enable/disable the mouse.
nnoremap <silent> md :set mouse=r<CR>:set number!<CR>
nnoremap <silent> me :set mouse=a<CR>:set number!<CR>

"" Spaces & Tabs {{{
"set tabstop=4 shiftwidth=4  " Tab is 4 spaces
"set shiftround              " Round '>' shifting to nearest tabstop
"set expandtab               " Expand tabs to spaces
"set smarttab                " Tabs before text insert 'shiftwidth' spaces
"set autoindent              " Auto indent always on
"set smartindent             " Intelligent code indenting
"
"" Trim trailing whitespaces (function keeps search intact)
""map <Leader>trim :%s/\s\+$//<CR>:w<CR>
"map <leader>trim :call StripTrailingWhitespaces()<CR>:w<CR>
"" }}}


augroup whitespace
    au!
    autocmd BufRead,BufWrite * silent! call StripTrailingWhitespaces()

    " Highlight trailing spaces as error when entering a window (a split is a
    " new window even if viewing same buffer).
    :au BufWinEnter,WinEnter * silent! match ErrorMsg /\s\+$/
augroup END

" Strips trailing whitespace at the end of files while keeping search and
" cursor position.
function! StripTrailingWhitespaces() " {{{
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction " }}}
command! -nargs=0 StriptrailingWhitespaces call StripTrailingWhitespaces()

" Persistant undo, see `:help persistent-undo`
" All undofiles in a single directory, create if it doesn't exist.
if !isdirectory($XDG_CACHE_HOME . "/nvim/undo")
  call mkdir($XDG_CACHE_HOME . "/nvim/undo", "p")
endif
set undodir=$XDG_CACHE_HOME/nvim/undo//,/var/tmp//,/tmp//
set undofile

" Save entire buffer for undo on reload if less than this size.
set undoreload=10000

set number                  " Line numbers
set numberwidth=6           " Good up to '99999 ' lines (inc. space after #s)
set splitright              " Vertical split to the right, not left
set splitbelow              " Horizontal split to the bottom, not top

if !&scrolloff
    set scrolloff=5         " Minimum lines above and below cursor
endif
if !&sidescrolloff
    set sidescrolloff=5     " Keep 10 columns on the side
endif

set wrap                    " Wrap long lines
set showbreak="+++"         " Show at end of wrapped lines
set linebreak               " Wrap lines based on 'breakat' (default whitespace)
set display+=lastline       " If the last line can't be fully displayed, show
                            " what fits rather than only `@`.

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

set showtabline=2           " Always show tabline at the top
if &tabpagemax < 50
  set tabpagemax=50         " All the tabs!
endif
set hidden                  " Open new buffer with unsaved changes in current

" Remove underline
hi CursorLine term=NONE cterm=NONE
set cursorline              " highlight current line

"set list                    " List certain characters
""set listchars=tab:▸\,trail:·,extends:»,precedes:«,nbsp:%,eol:↲ "utf-8
"set listchars=tab:>-,trail:.,extends:>,precedes:<,nbsp:%
""             |      |       |         |          |
""             |      |       |         |          +-- non-breakable space that
""             |      |       |         |              prevents automatic line
""             |      |       |         |              breaks at that position
""             |      |       |         + character to show line goes off
""             |      |       |           screen to the right (when 'wrap'
""             |      |       |           is off)
""             |      |       +-- character to show line goes off screen to
""             |      |           right (when 'wrap' is off)
""             |      +-- trailing spaces in line
""             +-- tab character anywhere in line
"

"" UI {{{
"" Toggle 80 column line
"nnoremap <silent> <Leader>cc :call ToggleColorColumn()<CR>
"
""set colorcolumn=+1          " Highlight column right after 'textwidth'
"set showmode                " Show the mode the editor is in
"
"" set colorcolumn=80        " Highlight specific column
"
"if has("eval")
"function! SL(function)
"  if exists('*'.a:function)
"    return call(a:function,[])
"  else
"    return ''
"  endif
"endfunction
"endif
"
""set statusline=[%n]\ %<%.99f\ %h%w%m%r%{SL('CapsLockStatusline')}%y%{SL('fugitive#statusline')}%#ErrorMsg#%{SL('SyntasticStatuslineFlag')}%*%=%-14.(%l,%c%V%)\ %P
""               +- buffer number
"
"set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
""              | | | | |  |   |      |  |     |    |
""              | | | | |  |   |      |  |     |    +-- current column
""              | | | | |  |   |      |  |     +-- current line
""              | | | | |  |   |      |  +-- current % into file
""              | | | | |  |   |      +-- current syntax in square brackets
""              | | | | |  |   +-- current fileformat
""              | | | | |  +-- number of lines
""              | | | | +-- preview flag in square brackets
""              | | | +-- help flag in square brackets
""              | | +-- readonly flag in square brackets
""              | +-- modified flag in square brackets
""              +-- full path to file in the buffer
"
"set statusline+=%{fugitive#statusline()}            " Show git statusline
"
"set statusline+=%#StatuslineErrorMsg#               " Set color for syntastic
"set statusline+=%{SyntasticStatuslineFlag()}        " Display syntastic flag
"set statusline+=%*                                  " Reset color
"
"set laststatus=2            " Always display status line
"
"if has('cmdline_info')
"    set ruler               " Show line and column number in cmdline
"    "set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
"    set showcmd             " Show partial command
"endif
"" }}}

"" Searching {{{
"set incsearch               " Find as you type search
"set hlsearch                " Highlight search matches
"
"set ignorecase              " Ignore case in search
"set smartcase               " But case sensitive if upper case present
"
"" Ignore things!
""set wildignore+=.hg,.git.svc                        " Version control
"set wildignore+=.aux,*.out,*.toc                    " LaTex intermediate files
"set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg      " Binaries
"set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest    " Compiled object files
"set wildignore+=*.spl                               " Compiled spelling lists
"set wildignore+=*.sw?                               " Vim swap files
"set wildignore+=*.DS_Store                          " OSX dir files
"set wildignore+=*.pyc                               " Python byte code
"set wildignore+=*.orig                              " Merge resolution files
"set wildignore+=*.bak                               " Backup files
"set wildignore+=*~
"set wildmode=list:longest,full " Give list for auto complete
"
"" Press F9 to turn off highlighting and clean any messages alreade displayed
""nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
""nnoremap <silent> <S-Space> :nohlsearch<Bar>:echo<CR>
"nnoremap <silent> <F9> :nohlsearch<Bar>:echo<CR>
"" }}}

set incsearch               " Find as you type search.
"set hlsearch                " Highlight search matches

set ignorecase              " Ignore case in search
set smartcase               " But case sensitive if upper case present

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

"set scroll=10               " Scroll only 10 lines with Ctrl-D and Ctrl-U
"set scrolloff=5             " Minimum lines above and below cursor
"set sidescrolloff=10        " Keep 10 columns on the side
"set virtualedit+=onemore    " Allow for cursor beyond last char of line
"set virtualedit+=block      " Allow for cursor beyond last char of line in visual block mode
"
"" highlight last inserted text
"nnoremap gV `[v`]
"
"" move to beginning/end of line
"nnoremap B ^
"nnoremap E $

" Wrapped lines goes up/down to next row rather than next line in buf
noremap j gj
noremap k gk
noremap gj j
noremap gk k
"" Convenience Mappings {{{
"" Create blank newlines and stay in Normal mode
"nnoremap <silent> zj o<Esc>
"nnoremap <silent> zk O<Esc>
"
"" No more help key, instead check if file changed outside VIM
"noremap <F1> :checktime<cr>
"inoremap <F1> <esc>:checktime<cr>
"
"" Split line (sister to [J]oin lines)
"" The normal use of S is covered by cc, so don't worry about shadowing it.
"nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w
"
"" Allow saving of files as sudo when vim wasn't started with sudo
"" (throw away the stdin part of tee)
"cmap w!! w !sudo tee > /dev/null %
"
"" Cool svn blame on highlight
"vmap bl :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
"
"" Insert new lines without being in insert mode
"" map <Enter> o<Esc>
"" map <S-Enter> O<Esc>
"
"" Save session so windows open next time
"nnoremap <leader>s :mksession<CR>
"
"" Open make output in a quick fix window
"map <Leader>m :make \| copen<CR>
"
"" Swap split positions on write and read (horizontal to vertical)
"nnoremap <silent><Leader>s <C-w>L
"
"" toggel gundo
"nnoremap <leader>u :GundoToggle<CR>
"" }}}
set tabstop=4 shiftwidth=4  " A 'tab' is 4 spaces.
set shiftround              " Round '>' shifting to nearest tabstop.
set expandtab               " Expand tabs to spaces.
set smarttab                " Tabs before text insert 'shiftwidth' spaces.
set autoindent              " Auto indent always on.
set smartindent             " Intelligent code indenting.

" Set the indent for some specific file types
autocmd FileType java setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType vim setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType unix setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType git setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType scala setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType xml setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType brazil-config setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType sh setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2 textwidth=100
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2 textwidth=100
autocmd FileType css setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType cpp setlocal shiftwidth=4 tabstop=4 softtabstop=4 textwidth=80
autocmd FileType c setlocal shiftwidth=4 tabstop=4 softtabstop=4 textwidth=80
autocmd FileType markdown setlocal shiftwidth=4 tabstop=4 softtabstop=4 textwidth=120
autocmd FileType kotlin setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType perl setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType nim setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType ion setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType kata setlocal shiftwidth=4 tabstop=4 softtabstop=4

"" Custom settings for kata files
autocmd BufNewFile,BufRead *.kata set filetype=kata
autocmd BufNewFile,BufRead *.ion set filetype=ion
"" Copy text to system clipboard on OSX
"function! g:SystemCopy() " {{{
"    let old_z = @z
"    normal! gv"zy
"    call system('pbcopy', @z)
"    let @z = old_z
"endfunction " }}}

"" Formatting {{{
"set textwidth=79            " Line break after 79 characters
"set formatoptions-=t        " No hard line wrap
"set formatoptions-=2        " No paragraph indenting
"set formatoptions+=qrn1jl
""                  ||||||
""                  |||||+-- long lines no broken in insert mode
""                  ||||+-- remove comment leader when joining lines
""                  |||+-- don't break line on one letter word if possible
""                  ||+-- recognize numbered lists, autoindent must be on
""                  |+-- automatically insert comment leader after hitting
""                  |    enter in Insert
""                  +-- alow formatting comments with "gq"
"set cinoptions=l1           " indent c switch statements in a sane way
"" }}}

"" Folding {{{
"set foldenable              " Enable folding
""set foldmethod=manual       " Manual folding
"set foldmethod=indent       " Fold based on indent level
""set foldmethod=syntax       " Fold on syntax
"set foldlevelstart=99       " Open most folds by default
"set foldnestmax=10          " Max 10 folds in folds
"
"" Create folds by pressing highlighting text and pressing F9
"" Can then open/close with F9
""inoremap <F9> <C-O>za
""nnoremap <F9> za
""onoremap <F9> <C-C>za
""vnoremap <F9> zf
"
"" Open and close folds with space
"nnoremap <space> za
"vnoremap <space> za
"
"" Fold outer level automatically
"nnoremap zr :%foldc <CR>
"vnoremap zr :%foldc <CR>
"
"" Automatically fold top level
"":autocmd BufWinEnter * silent! :%foldc
"" }}}

" Sensible Basics {{{
set laststatus=2            " Always display status line.

if has('cmdline_info')
    set ruler               " Show line and column number in cmdline.
    set showcmd             " Show partial command.
endif


if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j      " Remove comment leader when joining lines.
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if &history < 10000
  set history=10000         " Store ton of history (default 20)
endif

set sessionoptions-=options " Don't store local options in mksession
set viewoptions-=options    " Don't store local options in mkview

if version >= 700           " Use english for spell check, but off by default
    set spl=en spell
    set nospell
endif

" Copy/Cut/Paste {{{
" Make 'Y' behave like 'D' and 'C'
nnoremap Y y$

" Set F2 to toggel paste mode in normal in insert mode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Keep paste buffer around after pasting it once
xnoremap p pgvy

" Enter past mode, paste from system clipboard, and exit paste mode
" + CLIBOARD, * is PRIMARY
"   |              |
"   |              +-- things you select with mouse and paste with middle mouse
"   |                  button
"   +-- proper clipboard
noremap <leader>p :silent! set paste<CR>"+p:set nopaste<CR>
noremap <leader>P :silent! set paste<CR>"*p:set nopaste<CR>

" Paste/Copy/Cut using system clipboard
" TODO: Add if OSX, use SystemCopy()
noremap <leader>y  "+y
noremap <leader>yy "+yy
noremap <leader>Y  "+y$
noremap <leader>d  "+d
noremap <leader>dd "+dd
noremap <leader>D  "+D
" }}}


" Mostly work during the day, default to light.
set background=light

" ChangeBackground changes the background mode based on macOS's `Appearance`
" setting.
function! ChangeBackground()
  if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
    set background=dark   " for the dark version of the theme
  else
    set background=light  " for the light version of the theme
  endif
endfunction
call ChangeBackground()

" Enable syntax highlighting.
syntax enable

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif
--]]
