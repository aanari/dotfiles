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
let g:colorizer_auto_filetype='css,html,javascript,typescript,vim'

""""""""""""""""""""""""""""""
" => Comfortable Motion
""""""""""""""""""""""""""""""
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"
let g:comfortable_motion_friction = 0.0
let g:comfortable_motion_air_drag = 10.0
nnoremap <silent> <C-d> :call comfortable_motion#flick(50)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(-50)<CR>

""""""""""""""""""""""""""""""
" => Prettier
""""""""""""""""""""""""""""""
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

""""""""""""""""""""""""""""""
" => Black
""""""""""""""""""""""""""""""
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

" Add extra space around delimiters when commenting, remove them when
" uncommenting
let g:NERDSpaceDelims = 1
let g:NERDCreateDefaultMappings = 0

" Always remove the extra spaces when uncommenting regardless of whether
" NERDSpaceDelims is set
let g:NERDRemoveExtraSpaces = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code
" indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a
" region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Always use alternative delimiter
let g:NERD_c_alt_style = 1
let g:NERDCustomDelimiters = {'c': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' }}

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
" => Limelight
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:limelight_conceal_ctermfg = 240

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Goyo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:save_option = {}
nnoremap <silent> <leader>z :Goyo<cr>
function! s:goyo_enter()
  let s:save_option['showmode'] = &showmode
  let s:save_option['showcmd'] = &showcmd
  let s:save_option['scrolloff'] = &scrolloff
  set noshowmode
  set noshowcmd
  set scrolloff=999
  if exists(':Limelight') == 2
    Limelight
    let s:save_option['limelight'] = 1
  endif
endfunction

function! s:goyo_leave()
  let &showmode = s:save_option['showmode']
  let &showcmd = s:save_option['showcmd']
  let &scrolloff = s:save_option['scrolloff']
  if get(s:save_option,'limelight', 0)
    execute 'Limelight!'
  endif
endfunction
augroup goyo_map
  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_virtualtext_cursor         = 1
let g:ale_virtualtext_prefix         = '❯ '
let g:ale_open_list                  = 0
let g:ale_sign_column_always         = 1
let g:ale_echo_msg_error_str = '✖'
let g:ale_echo_msg_warning_str = '⚠'
let g:ale_echo_msg_info_str = '➤'
let g:ale_echo_msg_format = '[%severity% %linter%] %s'
let g:ale_sign_column_always = 1
let g:ale_sign_error='✖'
let g:ale_sign_style_error='✖'
let g:ale_sign_warning='⚠'
let g:ale_sign_style_warning='⚠'
let g:ale_sign_info = '➤'
augroup ALE_Settings
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
  autocmd ColorScheme *
        \ :hi link ALEVirtualTextError    SpellBad    |
        \ :hi link ALEVirtualTextWarning  SpellCap    |
        \ :hi link ALEVirtualTextInfo     SpellRare
augroup END
nmap <leader>k <Plug>(ale_previous_wrap)
nmap <leader>j <Plug>(ale_next_wrap)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => React
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:jsx_ext_required = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Indent guides
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
augroup Indent_Settings
    autocmd!
    autocmd ColorScheme * :hi IndentGuidesOdd ctermbg=0
    autocmd Colorscheme * :hi IndentGuidesEven ctermbg=0
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NeatFold
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NeatFoldTextFancy = 1

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
" => Startify
""""""""""""""""""""""""""""""
let g:startify_files_number = 6
let g:startify_list_order   = [
      \ ['    My most recently used files in the current directory:'],
      \ 'dir',
      \ ['    My most recently used files:'],
      \ 'files',
      \ ['    These are my sessions:'],
      \ 'sessions',
      \ ]
let g:startify_update_oldfiles        = 1
let g:startify_disable_at_vimenter    = 0
let g:startify_session_autoload       = 1
let g:startify_session_persistence    = 1
let g:startify_session_delete_buffers = 0
let g:startify_change_to_dir          = 0
let g:startify_change_to_vcs_root     = 0  " vim-rooter has same feature

""""""""""""""""""""""""""""""
" => Signify
""""""""""""""""""""""""""""""
let g:signify_update_on_focusgained  = 1
let g:signify_fold_context           = [0, 3]
let g:signify_sign_add               = '✚'
let g:signify_sign_delete            = '✖'
let g:signify_sign_delete_first_line = '▤'
let g:signify_sign_change            = '✹'
let g:signify_sign_changedelete      = '≃'
augroup Signify_Settings
    autocmd!
    autocmd ColorScheme * :hi SignColumn guibg=#002b36
    autocmd ColorScheme * :hi SignifySignAdd cterm=bold guibg=#002b36 guifg=#859900
    autocmd ColorScheme * :hi SignifySignDelete cterm=bold guibg=#002b36 guifg=#cb4b16
    autocmd ColorScheme * :hi SignifySignChange cterm=bold guibg=#002b36 guifg=#b58900
augroup END

""""""""""""""""""""""""""""""
" => Incsearch
""""""""""""""""""""""""""""""
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

""""""""""""""""""""""""""""""
" => Python Mode
""""""""""""""""""""""""""""""
let g:pymode_python = 'python3'
let g:pymode_syntax = 1
let g:pymode_syntax_slow_sync = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_highlight_equal_operator = 1
let g:pymode_lint = 0
let g:pymode_options_colorcolumn = 0
augroup Python_Settings
    autocmd!
    autocmd ColorScheme * :hi link pythonDocstring Comment
    autocmd ColorScheme * :hi pythonInclude cterm=italic guifg=#cb4b16
    " autocmd ColorScheme * :hi pythonClassParameters guifg=#6c71c4
    autocmd ColorScheme * :highlight pythonSelf guifg=#cb4b16
augroup END

""""""""""""""""""""""""""""""
" => WinResizer
""""""""""""""""""""""""""""""
let g:winresizer_vert_resize = 1
let g:winresizer_horiz_resize = 1

""""""""""""""""""""""""""""""
" => HighlightedYank
""""""""""""""""""""""""""""""
let g:highlightedyank_highlight_duration = 400
augroup YankRing_Settings
    autocmd!
    autocmd ColorScheme * :hi HighlightedyankRegion guifg=#eee8d5
augroup END

""""""""""""""""""""""""""""""
" => EasyMotion
""""""""""""""""""""""""""""""
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-overwin-f2)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
augroup EasyMotion_Settings
    autocmd!
    autocmd ColorScheme * :hi EasyMotionTarget guifg=#eee8d5
augroup END

""""""""""""""""""""""""""""""
" => Custom
""""""""""""""""""""""""""""""
vmap <leader>pt :!perltidy<cr>
nmap <leader>pt :%! perltidy<cr>

""""""""""""""""""""""""""""""
" => Re-apply the color-scheme again for custom colors
""""""""""""""""""""""""""""""
try
    colorscheme solarized8_flat
catch
endtry
