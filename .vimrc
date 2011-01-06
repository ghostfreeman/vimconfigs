"         ,-.-. .=-.-.       ___                _,.----.
"  ,--.-./=/ ,//==/_ /.-._ .'=.'\  .-.,.---.  .' .' -   \
" /==/, ||=| -|==|, |/==/ \|==|  |/==/  `   \/==/  ,  ,-'
" \==\,  \ / ,|==|  ||==|,|  / - |==|-, .=., |==|-   |  .
"  \==\ - ' - /==|- ||==|  \/  , |==|   '='  /==|_   `-' \
"   \==\ ,   ||==| ,||==|- ,   _ |==|- ,   .'|==|   _  , |
"   |==| -  ,/|==|- ||==| _ /\   |==|_  . ,'.\==\.       /
"   \==\  _ / /==/. //==/  / / , /==/  /\ ,  )`-.`.___.-'
"    `--`--'  `--`-` `--`./  `--``--`-`--`--'
"
" Main vim editor confirguation file
" Alexandre Gauthier <alex@underwares.org>
"
" Up to date version always on github:
"   https://github.com/mrdaemon/vimconfigs
"
"-----------------------------------------------------------------------------

" Using pathogen to split plugins into 'bundles'.
" Feels a lot neater. Must be called first with filetype disabled.
"   @ See vim.org script 2332
"   @ https://github.com/tpope/vim-pathogen
" -- Pathogen --
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
" --

" -- Base, Important editor behavior --
set nocompatible            " This is not 1979 anymore. Sorry, grandpa vi.
filetype plugin indent on   " Turns on filetype detection and loading of
                            " plugin and syntax files.
" --

" -- Editor messages, info and verbosity --
set showcmd        " Show current command, text area etc as last line
set shortmess=aI   " Use abbreviated messages and selfishly ignore uganda
set visualbell     " For the love of god STOP BLEEPING WHILE I'M AT WORK
" --

" -- Editor Movement, searching and patterns --
set startofline  " Move to first non-blank character of a line
set incsearch    " Incremental search
set ignorecase   " Case Insensitive
set smartcase    " Case sensitive if caps
" --

" -- Text Display Options --
set scrolloff=4 " Keep 4 lines on screen while scrolling,
                "  because I hate going 'Uh.. did.. I miss it?'
set number      " Line numbering
" --

" -- Highlighting, spelling and Text Appearance --
syntax on          " Auto select syntax highlighting from filetype
set cursorline     " Highlight current line.
set hlsearch       " Highlight search results

" Column highlight is only supported on vim 7.3+
if version >= 703
    set colorcolumn=80 " Highlight column 80, as a guide.
    
    " Override color for highlighted column
    " Often it is this eye melting red.
    hi ColorColumn term=reverse ctermbg=4 guibg=#1f1f1f
endif

" Color Scheme for terminal
" (GUI colorscheme is defined in gvim)
colorscheme xoria256
" --

" -- Windows, Tabs and buffers behavior --

"  -Windows:
set laststatus=2   " Always show status bar

" Status Line full of awesome junk
"   First block is flags:
"     Filename (full path)
"     Modified Flag
"     Read Only Flag
"     helo flag
"     preview flag
"     Fugitive (git) status
"
"   end line format (DOS/UNIX)
"   Detected filetype
"   ASCII and Hex for current char
"   Postion (row, col)
"   Linecount
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [%{&ff}]\ [%Y]\[ascii\:\%03.3b]\ [hex\:\%02.2B]\ [%04l,%04v][%p%%]\ [F\:%L]


"  -Buffers:
set hidden         " Don't unload buffers when the windows is no longer shown.
                   "  Allows you to navigate buffers without saving them.

set bufhidden=hide " Set default action of buffers that are no longer
                   "  in a window to be hidden. This is the default, and is
                   "  per-buffer, but I set it there anyways -- I once had
                   "  a remote edit go terribly wrong when switching buffers
                   "  and forcing this on loading the first buffer prevented
                   "  it. It probably is not necessary, feel free to ignore.

"  -Tabs:
set showtabline=1  " Only show tabline if there are more than one tab open.

" -- Terminal Settings --
set ttyfast  " Better, faster redrawing on modern ttys.
             "  Yeah... remember to turn this off if redrawing
             "  goes awry wherever you use this.

set title    " Set terminal title to filename and status

set t_Co=256 " Force terminal into 256 colors mode.
             "  ** this WILL be nasty on crappy terms like Terminal.app **
" --

" -- Mouse settings
set mouse=a  " Enable mouse in all supported modes.
" --

" -- Text editing settings --
set infercase    " Adjust case of completed text
                 "  to be like that of the match.

set showmatch    " Briefly display matching brackets when inserting such.
set matchtime=10 " How long to flash matching brackets, in 1/10th of a sec.
set backspace=indent,eol,start  " Make backspace useful in insert mode.
" --

" -- Indent and tabbing --
"  NOTE: The proper tabbing settings, i.e. shiftwdith, tabstop, etc
"        are all defined in their specific filetype plugins.
set smartindent   " Proper awesome indenting
" --

" -- Command line Editing
set history=1000                " Larger command history
set wildmenu                    " Enable completion menu
set wildmode=list:longest,full  " Command line completion

" Ignore these partterns while tabbing out to complete
set wildignore=.svn,.hg,.git,CVS,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,jar,exe,bin,zip
" --

" -- Misc and AutoCommands --
set encoding=utf-8  " Default encoding used through vim

" vim 7+: Change status line color in insert mode
" Have I ever mentioned how much I love this?
if version >= 700
    " Function to save current status line highlight
    " settings for StatusLine and StatusLineNC
    "
    " Not sure where I originally got the reference code I based
    " this function upon. Credit goes to whoever wrote the code fragment
    " which has been sitting in my ~/tmp for ages until I shaped it into this.
    let s:sline_hi = {}
    function! s:save_statuslinehl()
        for g in ['StatusLine', 'StatusLineNC']
            let l:current = ''
            redir => l:current
            silent exec 'hi '.g
            redir END

           " Dict to hold the values we will be
           " modifying -- set to NONE for now.
           let l:vals = {}
           for a in ['term', 'cterm', 'gui']
               let l:vals[a] = 'NONE'
           endfor

           " Parse current values, map out to attributes
           " defined above, and save as s:savedstatus_hi[group]
           for token in split(l:current)[2:-1]
               let [attribute, value] = split(token, '=')
               let l:vals[attribute] = value
           endfor
           let s:sline_hi[g] = join(map(items(l:vals),'v:val[0]."=".v:val[1]'))
        endfor
    endfunction

    call s:save_statuslinehl() " Call our save function once at load

    au ColorScheme * call s:save_statuslinehl() " Save on scheme change
    au InsertEnter * hi StatusLine term=reverse cterm=reverse gui=reverse,bold
    au InsertLeave * exec 'hi StatusLine '.s:sline_hi['StatusLine']
endif
" --

" -- Keybinds, macros and aliases --

" Kill search highlight with C-n
nmap <silent> <C-N> :silent noh<cr>

" Toggle line numbering with <F3>
nnoremap <F3> :set nonumber!<CR>:set foldcolumn=0<CR>
" Togger relative line numbering with <S-F3>
nnoremap <S-F3> :set relativenumber!<CR>

" Navigate buffers with F1 and F2
noremap <F1> :bprev!<CR>
noremap <F2> :bnext!<CR>

" MiniBufExpl behaviour (enable/disable)
let g:miniBufExplMapWindowNavVim = 1    " Maps ctrl+ vim movement keys to
                                        " window navigation
let g:miniBufExplMapWindowNavArrows = 1 " Maps ctrl + arrows to window
                                        "  navigation
let g:miniBufExplMapCTabSwitchBufs = 0  " Switch buffer tabs
                                        "  with <C-TAB> and <C-S-TAB>
let g:miniBufExplModSelTarget = 1       " Coerces buffers into not appearing
                                        "  in non-editable windows.
let g:miniBufExplUseSingleClick = 0     " Activate buffer tabs with a
                                        "  single click

" Bind <F4> to MiniBufExpl toggle (hide/show)
noremap <F4> :TMiniBufExplorer<CR>

" Still there? Have some crappy easter eggs.
map <F12> ggVGg?

