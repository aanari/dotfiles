" Vim filetype plugin
" Language:    Arc <http://arclanguage.org/>
" Maintainer:  ajv
" Last Change: August 6, 2009
" URL:         http://bitbucket.org/fallintothis/arc-vim/issues/

"-------------------------------------------------------------------------------
" Setup:

if exists("b:did_ftplugin") | finish | endif

let b:did_ftplugin = 1

setlocal iskeyword=35,36,37,42,43,45,47,48,49,50,51,52,53,54,55,56,57,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,92,94,95,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122

setl lisp

"-------------------------------------------------------------------------------
" Special Forms:

setl define=^\\s*(\\%(def\\k*\\\|mac\\)

setl lispwords=accum,afn,aform,aformh,after,annotate,arform,arformh,atlet,atomic,atwith,atwiths,awhen,case,caselet,catch,ccc,cdata,center,def,defbg,defcache,defhook,defmemo,defop,defop-raw,defopl,defopr,defopr-raw,defset,deftem,down,each,fn,fontcolor,for,forlen,form,fromstring,let,linkf,loop,mac,noisy-each,on,onrlink,point,prbold,repeat,rfn,rlinkf,spanclass,spanrow,sptab,summing,taform,tag,tag-if,tarform,td,tdcolor,tdr,textarea,thread,tostring,uform,ulink,underline,unless,until,urform,w/appendfile,w/bars,w/infile,w/instring,w/link,w/link-if,w/outfile,w/outstring,w/rlink,w/socket,w/stdin,w/stdout,w/table,w/uniq,when,when-umatch,when-umatch/r,whenlet,while,whiler,whilet,whitepage,widtable,with,withs,zerotable

"-------------------------------------------------------------------------------
" Comments:

setl comments=:;;;,:;;,:;,sr:#\|,mb:\|,ex:\|#

" make comments behave as in c.vim, sans the o/O commands
setl formatoptions-=t
setl formatoptions+=crql

"-------------------------------------------------------------------------------
" Additional Features:

" If nonzero, the following options will perform these actions on buffer
" write:
"  g:arc_bodops              - macros that have body (rest) parameters will
"                              be added to &lispwords.  Requires +python.
"  g:arc_highlight_lispwords - each word in &lispwords will be highlighted.
"  g:arc_detect_atstrings    - detects expressions like
"                                (declare 'astrings t)
"                              so that at-string highlighting is turned
"                              on/off automatically based on whether you're
"                              using them in your code.


if has('python')
python << EOF
import vim
import re

additional_lispwords = []
def update_lispwords():
    global additional_lispwords
    for lw in additional_lispwords:
        vim.command('setl lw-=' + lw)
    additional_lispwords = []
    for line in vim.current.buffer:
        match = re.match('^\(mac\s+(\S+)\s+(\(.+\.\s+body\)|body)', line)
        if match:
            macro = match.groups()[0]
            vim.command('setl lw+=' + macro)
            additional_lispwords.append(macro)
EOF
endif

if exists("g:arc_bodops") && g:arc_bodops != 0

  if has('python')
    python update_lispwords()
    au BufWrite <buffer> python update_lispwords()
  else
    echo 'arc_bodops is only available with +python support.'
  endif

endif

if exists("g:arc_highlight_lispwords") && g:arc_highlight_lispwords != 0

  hi def link arcLispWord arcFn
  fu! HighlightLispwords ()
    syn clear arcLispWord
    for lispword in split(&lispwords, ',')
      exe 'syn keyword arcLispWord ' . lispword
    endfor
  endfu

  call HighlightLispwords()
  au BufWrite <buffer> call HighlightLispwords()

endif

if exists("g:arc_detect_atstrings") && g:arc_detect_atstrings != 0
  if !exists("g:arc_always_atstrings") || g:arc_always_atstrings == 0

    fu! DetectAtstrings ()
      if search("^\\s*(declare\\s\\+'atstrings\\s\\+'\\=\\%(nil\\|()\\|#f\\))\\s*$",'nw') == 0 && search("^\\s*(declare\\s\\+'atstrings .\\+)\\s*$",'nw') != 0
        syn region arcString start=/"/ skip=/\%(\\\\\|\\"\)/ end=/"/ contains=@Spell,arcStringEsc,arcStringEscError,arcAtStringAt,arcAtStringExpr
      else
        syn region arcString start=/"/ skip=/\%(\\\\\|\\"\)/ end=/"/ contains=@Spell,arcStringEsc,arcStringEscError
      endif
    endfu

    call DetectAtstrings()
    au BufWrite <buffer> call DetectAtstrings()

  endif
endif
