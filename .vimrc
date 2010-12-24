" Generic stuff that cannot be lived without
set nocompatible
set number "Line numbering
set hidden " Keep buffers open, allows switch without save
set bufhidden=hide " This is to prevent remote edit fuckups
set history=1000 " Larger command history
set title " Set terminal title to filename.
set showmatch " Briefly display matching brackets when inserting such.
set matchtime=10 " How long to flash matching brackets, in 1/10th of a sec.

" I keep forgetting some OSes suck.
" Let's have some better backspace action.
set backspace=indent,eol,start

" current directory is always matched
" to the current buffer. <3
set autochdir

" Wild completion menu.
" Slightly better tabbing.
set wildmenu
set wildmode=list:longest,full
set wildignore=.svn,.hg,.git,CVS,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,jar,exe,bin,zip

" Highlight current line, and by the way,
" I absolutely hate when you move my cursor the
" start of a new line. So don't. Thanks.
set cursorline
set nostartofline

" Enable 256 colors terminal.
" Comment out if it bugs you.
set t_Co=256

colorscheme mustang " This color scheme supports 256 colors too,
		    " So, no need for the former hackery. (see history)

" Kill search highlight with C-n 
nmap <silent> <C-N> :silent noh<cr>

" Incremental search, ignores case
" (Except for explicitely specified uppercase characters)
set incsearch
set ignorecase " Case Insensitive
set smartcase  " Case sensitive if caps
set infercase  " Adjust case of completed text
               " to be like that of the match.

set smartindent " Proper awesome indenting

" Shorten the irritating 'Press ENTER or type command' messages.
" Also removes the plea for the poor children in uganda.
set shortmess=aI

" For the love of god STOP BLEEPING WHILE I'M AT WORK
set visualbell

" Status Line full of awesome junk
"   First block is flags:
"     Filename (full path)
"     Modified Flag
"     Read Only Flag
"     helo flag
"     preview flag
"     
"   end line format (DOS/UNIX)
"   Detected filetype
"   ASCII and Hex for current char
"   Postion (row, col)
"   Linecount
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" Always show status bar.
" Always. All the time.
set laststatus=2

" Enable code folding
"set foldenable
"set fdm=indent

" Space as 'toggle fold' key
"nnoremap <space> za

" Toggle line numbering with F3
nnoremap <F3> :set nonumber!<CR>:set foldcolumn=0<CR>

" Navigate buffers with F1 and F2
noremap <F1> :bprev!<CR>
noremap <F2> :bnext!<CR>

" MiniBufExp behaviour:
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" PURTY COLORS IN MY CODE
" THEY ARE REQUIRED
syntax on

" Enable filetype plugin so I don't clutter this.
filetype plugin indent on

" Keep 4 lines on screen while scrolling,
" because I hate going 'Uh.. did.. I miss it?'
set scrolloff=10

" gVim specific junk
if has("gui_running")
	" Remove toolbar and scrollbars from gVim, 
        " because, frankly, they are a waste of space.
	set guioptions-=Trl

        " Use text more dialogs even in gvim.
        " The ugly gtk boxes annoy me.
        " Also, do show the scrollbars in the event there's a
        " vertically split window.
        set guioptions+=cLR

	" Set font.
	set guifont=Consolas:h10

	" vim 7+: Change status line color in insert mode
        " Have I ever mentioned how much I love this?
	if version >= 700
		au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=bold,reverse
		au InsertLeave * hi StatusLine term=reverse ctermfg=0 gui=none
	endif
endif

" Still there? Have some crappy easter eggs.
map <F12> ggVGg?


