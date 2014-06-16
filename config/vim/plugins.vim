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
" => MRU
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>

""""""""""""""""""""""""""""""
" => Ctrl-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0
let g:ctrlp_map = '<c-f>'
map <leader>j :CtrlP<cr>
map <c-b> :CtrlPBuffer<cr>
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.git|local|locallib|Crowdtilt\-Internal\-API\-0\.0100|emails|ebin)$',
    \ 'file': '\v\.(exe|so|dll|tgz|gz|beam|.DS_Store)$',
    \ }

""""""""""""""""""""""""""""""
" => snipMate
""""""""""""""""""""""""""""""
ino <c-j> <c-r>=snipMate#TriggerSnippet()<cr>
snor <c-j> <esc>i<right><c-r>=snipMate#TriggerSnippet()<cr>

""""""""""""""""""""""""""""""
" => NerdTree
""""""""""""""""""""""""""""""
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>

""""""""""""""""""""""""""""""
" => Airline
""""""""""""""""""""""""""""""
let g:airline_theme="luna"
let g:airline_powerline_fonts=1
let g:airline_enable_syntastic=1

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
let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_enable_perl_checker=1
let g:syntastic_perl_checkers=['perl','podchecker']
let g:syntastic_perl_lib_path=['lib','locallib/lib/perl5']
let g:syntastic_cpp_compiler_options = '-std=c++1y'
let g:syntastic_ignore_files=['\m\c\.t$']
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

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
" => Neocomplete
""""""""""""""""""""""""""""""
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 0
let g:neocomplete#data_directory = '~/.vim/neocomplete'
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#keyword_patterns      = {}
let g:neocomplete#keyword_patterns._    = '\h\w*'

if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()"

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

let g:neocomplete#sources#omni#input_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

if !exists('g:neocomplete#sources#include#paths')
  let g:neocomplete#sources#include#paths = {}
endif
let g:neocomplete#sources#include#paths.c = '/usr/include,'.'/usr/local/include'
let g:neocomplete#sources#include#paths.cpp = '/usr/include,'.'/usr/include/c++/*,'.'/usr/local/include'

let g:neocomplete#force_overwrite_completefunc = 1
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.c =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neocomplete#force_omni_input_patterns.objc =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.objcpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::\w*'

let g:neocomplete#same_filetypes           = {}
let g:neocomplete#same_filetypes.gitconfig = '_'
let g:neocomplete#same_filetypes._         = '_'

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
nmap <leader>t :!ctp %<cr>
