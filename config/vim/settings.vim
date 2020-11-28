""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""
set listchars=tab:\┆\ ,trail:-,extends:>,conceal:*,precedes:<,nbsp:·
set showbreak=↳
let g:indentguides_tabchar = '┆'
autocmd BufNewFile,BufRead * call matchadd('SpecialKey', '\s\+')
autocmd BufNewFile,BufRead * call matchadd('NonText', '\n\+')

if &history < 2000
  set history=2000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif

filetype plugin indent on
syntax enable

set autoread
augroup checktime
  au!
  if !has("gui_running")
    "silent! necessary otherwise throws errors when using command
    "line window.
    autocmd BufEnter        * silent! checktime
    autocmd CursorHold      * silent! checktime
    autocmd CursorHoldI     * silent! checktime
  endif
augroup END

let mapleader = ","
let g:mapleader = ","

nmap <leader>w :w!<cr>
nmap <leader>q :wq!<cr>

command W w !sudo tee % > /dev/null

""""""""""""""""""""""""""""""
" => User interface
""""""""""""""""""""""""""""""
set wildmode=longest:full,full
set wildmenu
set wildignore+=.DS_Store,*.o,*.so,*~,*.pyc,*.class,*.swp,*.zip,*.pdf,.git\*,.hg\*,.svn\*,node_modules\*,*bower_components\*,*dist\*,*env\*,*venv\*,*.idea\*,*.pytest_cache\*,*__MACOSX\*,*__pycache__\*

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

set mouse=nv
set report=0
set hidden
set noruler
set noshowmode
set noshowcmd
set cmdheight=1
set laststatus=2
set hid
set autoindent
set smartindent
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set matchpairs+=<:>
set matchtime=1
set mat=2
set noerrorbells
set novisualbell
set nocursorcolumn
set nocursorline
set splitbelow
set splitright
set t_vb=
set ttyfast
set foldcolumn=0
set termguicolors
set nu
set foldlevelstart=2
set cursorline
set so=999
set belloff=all
set virtualedit=block
set synmaxcol=2500
set diffopt=filler,iwhite
set switchbuf=useopen,vsplit
set completeopt=menu,menuone
set completeopt+=noselect,noinsert

if has('vim_starting')
    set encoding=utf-8
    scriptencoding utf-8
endif

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[2 q"
endif

if exists('+completepopup')
	set completeopt+=popup
	set completepopup=height:4,width:60,highlight:InfoPopup
endif

if has('clipboard')
    set clipboard& clipboard+=unnamedplus
endif

if has('conceal') && v:version >= 703
	" For snippet_complete marker
	set conceallevel=2 concealcursor=niv
endif

if exists('+previewpopup')
	set previewpopup=height:10,width:60
endif

if executable('rg')
	set grepformat=%f:%l:%m
	let &grepprg = 'rg --vimgrep' . (&smartcase ? ' --smart-case' : '')
elseif executable('ag')
	set grepformat=%f:%l:%m
	let &grepprg = 'ag --vimgrep' . (&smartcase ? ' --smart-case' : '')
endif

set fillchars+=vert:\  " Whitespace

""""""""""""""""""""""""""""""
" => Timing
""""""""""""""""""""""""""""""
set timeout ttimeout
set timeoutlen=500   " Time out on mappings
set ttimeoutlen=10   " Time out on key codes
set updatetime=500   " Idle time to write swap and trigger CursorHold
set redrawtime=1000  " Time in milliseconds for stopping display redraw

""""""""""""""""""""""""""""""
" => Colors and fonts
""""""""""""""""""""""""""""""
syntax enable

try
    colorscheme solarized8_flat
catch
endtry

set background=dark
let g:solarized_italics = 1
let g:solarized_statusline = 'flat'
let g:solarized_extra_hi_groups = 1

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set t_Co=256
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set guitablabel=%M\ %t
endif

set ffs=unix,dos,mac

augroup Color_Settings
  autocmd!
  autocmd ColorScheme * :hi! link Folded SignColumn
  autocmd ColorScheme * :hi Normal guibg=NONE
  autocmd ColorScheme * :hi EndOfBuffer guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=black ctermbg=black cterm=NONE
  autocmd ColorScheme * :hi CursorLine guibg=#073642
  autocmd ColorScheme * :hi CursorLineNr guibg=#073642
  autocmd ColorScheme * :hi LineNr guibg=#073642
  autocmd ColorScheme * :hi! HighlightedyankRegion guifg=#eee8d5 guibg=NONE
  autocmd ColorScheme * :hi ExtraWhitespace guibg=#dc322f
augroup END

set title
" Title length.
set titlelen=95
" " Title string.
let &g:titlestring="
      \ %{expand('%:p:~:.')}%(%m%r%w%)
      \ %<\[%{fnamemodify(getcwd(), ':~')}\] - Neovim"

""""""""""""""""""""""""""""""
" => Backups
""""""""""""""""""""""""""""""
set nobackup
set nowb
set noswapfile

""""""""""""""""""""""""""""""
" => Tabs
""""""""""""""""""""""""""""""
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set softtabstop=-1
set shiftround
set lbr
set tw=500
set ai
set si
set wrap

if exists('+previewpopup')
    set previewpopup=height:10,width:60
endif

""""""""""""""""""""""""""""""
" => Movement
""""""""""""""""""""""""""""""
" nnoremap <silent> <C-d> 10jzz<CR>
" nnoremap <silent> <C-u> 10kzz<CR>
" nnoremap <silent> <S-g> Gzz<CR>

nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

nnoremap <expr> ' "'" . nr2char(getchar()) . "zz"
nnoremap <expr> ` "`" . nr2char(getchar()) . "zz"

""""""""""""""""""""""""""""""
" => Highlight
""""""""""""""""""""""""""""""
map <silent> <leader><cr> :noh<cr>
noremap <silent> <Space> :silent noh<Bar>echo<CR>

""""""""""""""""""""""""""""""
" => Buffers
""""""""""""""""""""""""""""""
map <leader>bd :Bclose<cr>
map <leader>ba :1,1000 bd!<cr>
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

""""""""""""""""""""""""""""""
" => Tabs
""""""""""""""""""""""""""""""
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<cr>
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
map <leader>cd :cd %:p:h<cr>:pwd<cr>

""""""""""""""""""""""""""""""
" => Spell checking
""""""""""""""""""""""""""""""
map <leader>ss :setlocal spell!<cr>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

""""""""""""""""""""""""""""""
" => Misc
""""""""""""""""""""""""""""""
map 0 ^
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
map <leader>x :e ~/buffer.md<cr>
map <leader>pp :setlocal paste!<cr>

""""""""""""""""""""""""""""""
" => Persistent undo
""""""""""""""""""""""""""""""
try
    silent !mkdir ~/.vim/undodir > /dev/null 2>&1
    set undodir=~/.vim/undodir
    set undofile
catch
endtry

""""""""""""""""""""""""""""""
" => Command mode
""""""""""""""""""""""""""""""
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

""""""""""""""""""""""""""""""
" => Date
""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

""""""""""""""""""""""""""""""
" => Python
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def

""""""""""""""""""""""""""""""
" => Javascript
""""""""""""""""""""""""""""""
au FileType javascript set nofoldenable
au FileType javascript setl nocindent
au FileType javascript imap <c-t> AJS.log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi
au FileType javascript inoremap <buffer> $r return
au FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi
au FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
let g:vim_jsx_pretty_colorful_config = 1

""""""""""""""""""""""""""""""
" => JSON
""""""""""""""""""""""""""""""
au FileType json setlocal tabstop=2 softtabstop=2 shiftwidth=2

""""""""""""""""""""""""""""""
" => Swift
""""""""""""""""""""""""""""""
au FileType swift setlocal tabstop=2 softtabstop=2 shiftwidth=2

""""""""""""""""""""""""""""""
" => Typescript
""""""""""""""""""""""""""""""
au FileType typescript setlocal tabstop=2 softtabstop=2 shiftwidth=2

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

augroup Typescript_Settings
  autocmd!
  autocmd ColorScheme * :hi typescriptDecorator cterm=italic gui=italic guifg=#cb4b16
  autocmd ColorScheme * :hi typescriptImport cterm=italic gui=italic guifg=#cb4b16
augroup END

""""""""""""""""""""""""""""""
" => HTML
""""""""""""""""""""""""""""""
au FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2

""""""""""""""""""""""""""""""
" => CSS
""""""""""""""""""""""""""""""
au FileType css setlocal tabstop=2 softtabstop=2 shiftwidth=2

""""""""""""""""""""""""""""""
" => SQL
""""""""""""""""""""""""""""""
au FileType sql setlocal tabstop=2 softtabstop=2 shiftwidth=2
let g:sql_type_default = 'pgsql'
let g:dbext_default_profile_myDB='type=pgsql:host=localhost:user=geneangel:dsnname=geneangel:dbname=geneangel:passwd='
let g:dbext_default_profile='geneangel'

""""""""""""""""""""""""""""""
" => Perl
""""""""""""""""""""""""""""""
inoremap => =><Esc>:call tabularity#Align('=>')<cr>a
au BufNewFile,BufRead *.t set filetype=perl
au BufNewFile,BufRead *.tt set filetype=xml
au FileType perl setl foldexpr=PerlFold(v:lnum)
au FileType perl setl foldmethod=expr

""""""""""""""""""""""""""""""
" => Ruby
""""""""""""""""""""""""""""""
au FileType ruby setl sw=2 sts=2 et

""""""""""""""""""""""""""""""
" => C++
""""""""""""""""""""""""""""""
au FileType cpp setl sw=2 sts=2 et

""""""""""""""""""""""""""""""
" => Scala
""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.scala setlocal filetype=scala
au FileType scala setlocal cindent
au FileType scala setlocal tabstop=2 softtabstop=2 shiftwidth=2
let g:scala_first_party_namespaces='\(controllers\|views\|models\|util\|de.\|relayr\)'
let g:scala_sort_across_groups=1

""""""""""""""""""""""""""""""
" => Markdown
""""""""""""""""""""""""""""""
augroup litecorrect
  autocmd!
  autocmd FileType markdown,mkd call litecorrect#init()
  autocmd FileType textile      call litecorrect#init()
  autocmd FileType text         call litecorrect#init()
augroup END
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_frontmatter=1

""""""""""""""""""""""""""""""
" => Terminal
""""""""""""""""""""""""""""""
tnoremap <C-n> <C-\><C-n>
nnoremap <Leader>e :ter<Cr>

""""""""""""""""""""""""""""""
" => Tex
""""""""""""""""""""""""""""""
let g:tex_flavor = 'latex'
