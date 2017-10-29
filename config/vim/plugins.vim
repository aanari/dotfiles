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
map <leader>j :CtrlP<cr>
map <c-b> :CtrlPBuffer<cr>
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.git|local|locallib|Crowdtilt\-Internal\-API\-0\.0100|emails|ebin)$',
    \ 'file': '\v\.(exe|so|dll|tgz|gz|beam|.DS_Store)$',
    \ }

""""""""""""""""""""""""""""""
" => NerdTree
""""""""""""""""""""""""""""""
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>

""""""""""""""""""""""""""""""
" => Airline
""""""""""""""""""""""""""""""
let g:airline_theme="solarized"
let g:airline_powerline_fonts=1
let g:airline#extensions#syntastic#enabled = 1

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
" => Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_echo_current_error = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_jump = 3
let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_enable_perl_checker=1
let g:syntastic_perl_checkers=['perl']
let g:syntastic_perl_lib_path=['lib','locallib/lib/perl5']
let g:syntastic_cpp_compiler_options = '-std=c++1y'
let g:syntastic_ignore_files=['\m\c\.t$']
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol='✗'
let g:syntastic_style_warning_symbol='⚠'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = ['tslint']
function! SyntasticCheckHook(errors)
    if !empty(a:errors)
        let g:syntastic_loc_list_height = min([len(a:errors), 6])
    endif
endfunction

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
let g:rbpt_max = 15

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ScriptRunner
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:script_runner_perl = 'perl -Mfeature=:5.10 -MData::Dump'

""""""""""""""""""""""""""""""
" => MUcomplete
""""""""""""""""""""""""""""""
set rtp+=~/work/vimproc.vim/
set rtp+=~/.cache/neobundle/tsuquyomi/
set completeopt+=menuone
inoremap <expr> <c-e> mucomplete#popup_exit("\<c-e>")
inoremap <expr> <c-y> mucomplete#popup_exit("\<c-y>")
inoremap <expr>  <cr> mucomplete#popup_exit("\<cr>")
set completeopt+=noinsert
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion
let g:mucomplete#enable_auto_at_startup = 1

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
