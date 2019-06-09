""""""""""""""""""""""""""""""
" => Ag
""""""""""""""""""""""""""""""
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>
map <leader>g :Ag
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

""""""""""""""""""""""""""""""
" => bufexplorer
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>

""""""""""""""""""""""""""""""
" => Colorizer
""""""""""""""""""""""""""""""
let g:colorizer_auto_filetype='css,html,javascript,typescript'

""""""""""""""""""""""""""""""
" => Prettier
""""""""""""""""""""""""""""""
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

""""""""""""""""""""""""""""""
" => Black
""""""""""""""""""""""""""""""
let g:black_linelength = 79
let g:black_fast=1
autocmd BufWritePre *.py execute ':Black'

""""""""""""""""""""""""""""""
" => MRU
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>

""""""""""""""""""""""""""""""
" => FZF
""""""""""""""""""""""""""""""
set rtp+=/usr/local/opt/fzf

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
"command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

nnoremap <Leader>f :Find<Space>
nnoremap <c-f> :Files<cr>

""""""""""""""""""""""""""""""
" => Ctrl-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0
map <c-b> :CtrlPBuffer<cr>
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.git|local|locallib|Crowdtilt\-Internal\-API\-0\.0100|emails|ebin)$',
    \ 'file': '\v\.(exe|so|dll|tgz|gz|beam|.DS_Store)$',
    \ }

""""""""""""""""""""""""""""""
" => NerdCommenter
""""""""""""""""""""""""""""""
autocmd! VimEnter * call s:fcy_nerdcommenter_map()
function! s:fcy_nerdcommenter_map()
	nmap <leader>cc <plug>NERDCommenterToggle
	vmap <leader>cc <plug>NERDCommenterToggle gv
endfunction

""""""""""""""""""""""""""""""
" => NerdTree
""""""""""""""""""""""""""""""
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>
let NERDTreeIgnore = ['\.pyc$', '__MACOSX', '__pycache__']
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

""""""""""""""""""""""""""""""
" => Airline
""""""""""""""""""""""""""""""
let g:airline_theme="solarized"
let g:airline_powerline_fonts=1
let g:airline#extensions#ale#enabled = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Goyo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>
function! Goyo_before()
  let g:neocomplete#disable_auto_complete = 1
  if exists('$TMUX')
    silent !tmux set status off
  endif
endfunction
function! Goyo_after()
  let g:neocomplete#disable_auto_complete = 0
  if exists('$TMUX')
    silent !tmux set status on
  endif
endfunction
let g:goyo_callbacks = [function('Goyo_before'), function('Goyo_after')]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_sign_column_always = 1
let g:ale_sign_error='✗'
let g:ale_sign_style_error='✗'
let g:ale_sign_warning='⚠'
let g:ale_sign_style_warning='⚠'
hi ALEErrorSign ctermfg=1 ctermbg=0
hi ALEStyleErrorSign ctermfg=1 ctermbg=0
hi ALEWarningSign ctermfg=3 ctermbg=0
hi ALEStyleWarningSign ctermfg=3 ctermbg=0
hi ALEErrorLine ctermbg=0
hi ALEStyleErrorLine ctermbg=0
hi ALEWarningLine ctermbg=0
hi ALEStyleWarningLine ctermbg=0
nmap <leader>k <Plug>(ale_previous_wrap)
nmap <leader>j <Plug>(ale_next_wrap)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => React
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:jsx_ext_required = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Sprunge
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:sprunge_cmd='nopaste'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Indent guides
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NeatFold
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NeatFoldTextFancy = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Rainbow Parenthesis
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 13
let g:bold_parentheses = 1
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ScriptRunner
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:script_runner_perl = 'perl -Mfeature=:5.10 -MData::Dump'

""""""""""""""""""""""""""""""
" => MUcomplete
""""""""""""""""""""""""""""""
set rtp+=~/work/vimproc.vim/
set rtp+=~/.cache/neobundle/tsuquyomi/
set noshowmode shortmess+=c
set noinfercase
set completeopt-=preview
set completeopt+=menuone,noinsert,noselect
set belloff+=ctrlg
let g:jedi#popup_on_dot = 0
let g:mucomplete#enable_auto_at_startup = 1
set complete-=i

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => clang_complete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:clang_library_path = "/Library/Developer/CommandLineTools/usr/lib"
let g:clang_use_library = 1
let g:clang_complete_auto = 0
let g:clang_auto_select = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UltiSnip
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

""""""""""""""""""""""""""""""
" => YankRing
""""""""""""""""""""""""""""""
if has("win16") || has("win32")
    " Don't do anything
else
    silent !mkdir ~/.vim/yankdir > /dev/null 2>&1
    let g:yankring_history_dir = '~/.vim/yankdir'
endif

""""""""""""""""""""""""""""""
" => Custom
""""""""""""""""""""""""""""""
vmap <leader>pt :!perltidy<cr>
nmap <leader>pt :%! perltidy<cr>
