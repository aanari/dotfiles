""""""""""""""""""""""""""""""
" => Ag
""""""""""""""""""""""""""""""
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>
map <leader>g :Ag
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

""""""""""""""""""""""""""""""
" => Buffergator
""""""""""""""""""""""""""""""
map <leader>o :BuffergatorOpen<cr>
let g:buffergator_viewport_split_policy = "N"
let g:buffergator_sort_regime = "basename"
let g:buffergator_show_full_directory_path = 0
let g:buffergator_suppress_keymaps = 1

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
let g:comfortable_motion_air_drag = 16.0
nnoremap <silent> <C-d> :call comfortable_motion#flick(50)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(-50)<CR>

""""""""""""""""""""""""""""""
" => Prettier
""""""""""""""""""""""""""""""
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

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
let NERDTreeShowHidden = 1
let NERDTreeRespectWildIgnore = 1
let NERDTreeHighlightCursorline = 0
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeMinimalMenu = 1
let NERDTreeHighlightCursorline = 1
let g:NERDTreeWinSize = 40
let NERDTreeDirArrows = 1
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd VimEnter * if argc() == 1 && !isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' | wincmd p | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

""""""""""""""""""""""""""""""
" => Airline
""""""""""""""""""""""""""""""
let g:airline_theme="solarized"
let g:solarized_termcolors=256
let g:airline_powerline_fonts=1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_a=''
let g:airline_section_y=''
let g:airline_inactive_collapse=1
let g:airline#extensions#obsession#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#ale#enabled = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Table Mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:table_mode_corner='|'

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
" => markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_markdown_folding_style_pythonic = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_virtualtext_cursor         = 1
let g:ale_virtualtext_prefix         = '❯ '
let g:ale_open_list                  = 0
let g:ale_sign_column_always         = 1
let g:ale_echo_msg_error_str = '✘'
let g:ale_echo_msg_warning_str = '➤'
let g:ale_echo_msg_info_str = '➤'
let g:ale_echo_msg_format = '[%severity% %linter%] %s'
let g:ale_sign_column_always = 1
let g:ale_sign_error='✘'
let g:ale_sign_style_error='✘'
let g:ale_sign_warning='➤'
let g:ale_sign_style_warning='➤'
let g:ale_sign_info = '➤'
augroup ALE_Settings
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
  autocmd ColorScheme *
        \ :hi link ALEError           SpellBad    |
        \ :hi link ALEWarning         SpellRare
  autocmd ColorScheme * :hi ALEWarningSign gui=bold guifg=#d33682 guibg=#073642
  autocmd ColorScheme * :hi ALEErrorSign gui=bold guifg=#dc322f guibg=#073642
augroup END
nmap <leader>k <Plug>(ale_previous_wrap)
nmap <leader>j <Plug>(ale_next_wrap)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => React
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:jsx_ext_required = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NeatFold
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NeatFoldTextFancy = 1

""""""""""""""""""""""""""""""
" => MUcomplete
""""""""""""""""""""""""""""""
set rtp+=~/work/vimproc.vim/
set rtp+=~/.cache/neobundle/tsuquyomi/
set noshowmode shortmess+=c
set noinfercase
set completeopt+=menuone,noselect,noinsert
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
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

""""""""""""""""""""""""""""""
" => yankstack
""""""""""""""""""""""""""""""
nmap Y y$
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

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
let g:signify_sign_delete            = '✕'
let g:signify_sign_delete_first_line = '▤'
let g:signify_sign_change            = '✹'
let g:signify_sign_changedelete      = '≃'
augroup Signify_Settings
  autocmd!
  autocmd ColorScheme * :hi SignColumn guibg=#073642
  autocmd ColorScheme * :hi SignifySignAdd cterm=bold guibg=#073642 guifg=#859900
  autocmd ColorScheme * :hi SignifySignDelete cterm=bold guibg=#073642 guifg=#cb4b16
  autocmd ColorScheme * :hi SignifySignChange cterm=bold guibg=#073642 guifg=#b58900
augroup END

""""""""""""""""""""""""""""""
" => Incsearch
""""""""""""""""""""""""""""""
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

""""""""""""""""""""""""""""""
" => vim-textmanip
"""""""""""""""""""""""""""""
xmap <Space>d <Plug>(textmanip-duplicate-down)
nmap <Space>d <Plug>(textmanip-duplicate-down)
xmap <Space>D <Plug>(textmanip-duplicate-up)
nmap <Space>D <Plug>(textmanip-duplicate-up)

xmap <C-j> <Plug>(textmanip-move-down)
xmap <C-k> <Plug>(textmanip-move-up)
xmap <C-h> <Plug>(textmanip-move-left)
xmap <C-l> <Plug>(textmanip-move-right)

xmap  <Up>    <Plug>(textmanip-move-up-r)
xmap  <Down>  <Plug>(textmanip-move-down-r)
xmap  <Left>  <Plug>(textmanip-move-left-r)
xmap  <Right> <Plug>(textmanip-move-right-r)

""""""""""""""""""""""""""""""
" => tex-conceal
""""""""""""""""""""""""""""""
let g:tex_conceal="abdgm"

""""""""""""""""""""""""""""""
" => pydocstring
""""""""""""""""""""""""""""""
nmap <silent> <C-_> <Plug>(pydocstring)

""""""""""""""""""""""""""""""
" => Python Mode
""""""""""""""""""""""""""""""
let g:pymode_options = 0
let g:pymode_python = 'python3'
let g:pymode_run = 0
let g:pymode_breakpoint = 0
let g:pymode_syntax = 1
let g:pymode_syntax_slow_sync = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_highlight_equal_operator = 1
let g:pymode_syntax_highlight_stars_operator = 1
let g:pymode_lint = 0
let g:pymode_options_colorcolumn = 0
augroup Python_Settings
  autocmd!
  autocmd ColorScheme * :hi link pythonDocstring Comment
  autocmd ColorScheme * :hi pythonInclude cterm=italic guifg=#cb4b16
  autocmd ColorScheme * :hi pythonSelf guifg=#cb4b16
augroup END

""""""""""""""""""""""""""""""
" => vim-terraform
""""""""""""""""""""""""""""""
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=1

""""""""""""""""""""""""""""""
" => Vim Go
""""""""""""""""""""""""""""""
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

augroup go
  autocmd!
  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
  " :GoTest
  autocmd FileType go nmap <leader>t  <Plug>(go-test)
  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)
  " :GoDoc
  autocmd FileType go nmap <Leader>d <Plug>(go-doc)
  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
  " :GoInfo
  autocmd FileType go nmap <Leader>i <Plug>(go-info)
  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)
  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  " :GoDef but opens in a horizontal split
  autocmd FileType go nmap <Leader>s <Plug>(go-def-split)
  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

""""""""""""""""""""""""""""""
" => WinResizer
""""""""""""""""""""""""""""""
let g:winresizer_vert_resize = 1
let g:winresizer_horiz_resize = 1

""""""""""""""""""""""""""""""
" => HighlightedYank
""""""""""""""""""""""""""""""
let g:highlightedyank_highlight_duration = 250

""""""""""""""""""""""""""""""
" => EasyMotion
"""""""""""""""""""""""""""""
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0
nmap t <Plug>(easymotion-overwin-f2)
map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>l <Plug>(easymotion-lineforward)
augroup EasyMotion_Settings
    autocmd!
    autocmd ColorScheme * :hi EasyMotionTarget guifg=#eee8d5
augroup END

""""""""""""""""""""""""""""""
" => Rainbow Improved
""""""""""""""""""""""""""""""
let g:rainbow_active = 1

""""""""""""""""""""""""""""""
" => Custom Filetypes
""""""""""""""""""""""""""""""
augroup Custom_Filetypes
    au!
    autocmd BufNewFile,BufRead *.prisma set syntax=graphql ts=2 sw=2 expandtab
augroup END

""""""""""""""""""""""""""""""
" => Re-apply the color-scheme again for custom colors
""""""""""""""""""""""""""""""
try
    colorscheme solarized8_flat
catch
endtry
