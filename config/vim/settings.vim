""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""
set history =700

filetype plugin indent on
syntax enable

set autoread

let mapleader = ","
let g:mapleader = ","

nmap <leader>w :w!<cr>
nmap <leader>q :wq!<cr>

command W w !sudo tee % > /dev/null

""""""""""""""""""""""""""""""
" => User interface
""""""""""""""""""""""""""""""
set so=7
set wildmenu
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

set noruler
set noshowmode
set noshowcmd
set cmdheight=1
set laststatus=2
set hid
set autoindent
set smartindent
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set mat=2
set noerrorbells
set novisualbell
set noshowmatch
set t_vb=
set tm=500
set foldcolumn=1
set clipboard=unnamed
set termguicolors
set nu
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[2 q"
endif

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

if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

set encoding=utf8
set ffs=unix,dos,mac

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
set lbr
set tw=500
set ai
set si
set wrap

""""""""""""""""""""""""""""""
" => Movement
""""""""""""""""""""""""""""""
map j gj
map k gk
map <c-space> ?
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map! jk <esc>

""""""""""""""""""""""""""""""
" => Highlight
""""""""""""""""""""""""""""""
map <silent> <leader><cr> :noh<cr>

""""""""""""""""""""""""""""""
" => Buffers
""""""""""""""""""""""""""""""
map <leader>bd :Bclose<cr>
map <leader>ba :1,1000 bd!<cr>
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
set viminfo^=%
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

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
au FileType python setlocal completeopt-=preview
au FileType python syn keyword pythonDecorator True None False self
au FileType python map <buffer> F :set foldmethod=indent<cr>
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
au FileType javascript call JavaScriptFold()
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
"au FileType typescript setlocal completeopt+=menu,preview
let g:tsuquyomi_completion_detail = 0
let g:tsuquyomi_use_vimproc=1

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
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType textile      call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END

autocmd BufEnter *.md colorscheme PaperColor|let g:airline_theme="papercolor"|call airline#switch_matching_theme()|set cmdheight=1|setlocal spell

let g:vim_markdown_folding_disabled=1
let g:vim_markdown_frontmatter=1
let g:pencil#wrapModeDefault = 'soft'

""""""""""""""""""""""""""""""
" => Functions
""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction

function! PerlFold(lnum)
  if (!exists('b:in_pod'))
    let b:in_pod = 0
  endif
  if indent(a:lnum) == 0
    let l:line = getline(a:lnum)
    if b:in_pod == 0 && l:line =~ '^=\(head\d\|endpoint\)'
      let b:in_pod = 1
      return ">1"
    elseif l:line !~ '\s*#'
      if b:in_pod == 0 && l:line =~ '[{(]$'
        return ">1"
      elseif l:line =~ '\(\}\|\};\|);\|1;\)$'
        let b:in_pod = 0
        return "<1"
      endif
    endif
  endif
  return "="
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction
