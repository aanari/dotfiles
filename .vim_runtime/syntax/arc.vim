" Vim syntax file
" Language:    Arc <http://arclanguage.org/>
" Maintainer:  ajv
" Last Change: August 6, 2009
" URL:         http://bitbucket.org/fallintothis/arc-vim/issues/
"
" Options:
"   g:arc_always_atstrings - if nonzero, highlight sexps after
"                            @-symbols in strings
"   g:arc_rainbow          - if nonzero, use rainbow colors to
"                            highlight nested parentheses
"                            differently from each other (up to
"                            10 levels deep)

"-------------------------------------------------------------------------------
" Setup:

" For vim-version 5.x: Clear all syntax items
" For vim-version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

setlocal iskeyword=35,36,37,42,43,45,47,48,49,50,51,52,53,54,55,56,57,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,92,94,95,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122

syn case ignore

syn cluster arcListCluster contains=TOP,arcParenError,arcParen0,arcParen1,arcParen2,arcParen3,arcParen4,arcParen5,arcParen6,arcParen7,arcParen8,arcParen9

"-------------------------------------------------------------------------------
" Identifiers:

syn match arcIdent display /[^\()[\]'`,"; \t|]\+/ contains=arcSsyntax,arcFn,arcVar,arcGlobal,arcNonfloat 
syn match arcIdent display "|..\{-}|" contains=arcSsyntax,arcFn,arcVar,arcGlobal,arcNonfloat 

syn match arcSsyntax display "[:~&.!]" 
syn match arcSsyntax display /![^\()[\]'`,"; \t|:~&.!]\+/ 
syn match arcSsyntax display "!|..\{-}|" 

"-------------------------------------------------------------------------------
" Lists:

syn match arcQQ display "`" 

syn match arcUnquote display ",@\=" 

syn match arcDotted display "\s\.\s" 

syn match arcParenError display ")" 

if exists("g:arc_rainbow") && g:arc_rainbow != 0
  syn region arcParen0 matchgroup=hlLevel0 start="`\=(" skip="|..\{-}|" matchgroup=hlLevel0 end=")" contains=@arcListCluster,arcParen1 
  syn region arcParen1 matchgroup=hlLevel1 start="`\=(" skip="|..\{-}|" matchgroup=hlLevel1 end=")" contains=@arcListCluster,arcParen2 contained 
  syn region arcParen2 matchgroup=hlLevel2 start="`\=(" skip="|..\{-}|" matchgroup=hlLevel2 end=")" contains=@arcListCluster,arcParen3 contained 
  syn region arcParen3 matchgroup=hlLevel3 start="`\=(" skip="|..\{-}|" matchgroup=hlLevel3 end=")" contains=@arcListCluster,arcParen4 contained 
  syn region arcParen4 matchgroup=hlLevel4 start="`\=(" skip="|..\{-}|" matchgroup=hlLevel4 end=")" contains=@arcListCluster,arcParen5 contained 
  syn region arcParen5 matchgroup=hlLevel5 start="`\=(" skip="|..\{-}|" matchgroup=hlLevel5 end=")" contains=@arcListCluster,arcParen6 contained 
  syn region arcParen6 matchgroup=hlLevel6 start="`\=(" skip="|..\{-}|" matchgroup=hlLevel6 end=")" contains=@arcListCluster,arcParen7 contained 
  syn region arcParen7 matchgroup=hlLevel7 start="`\=(" skip="|..\{-}|" matchgroup=hlLevel7 end=")" contains=@arcListCluster,arcParen8 contained 
  syn region arcParen8 matchgroup=hlLevel8 start="`\=(" skip="|..\{-}|" matchgroup=hlLevel8 end=")" contains=@arcListCluster,arcParen9 contained 
  syn region arcParen9 matchgroup=hlLevel9 start="`\=(" skip="|..\{-}|" matchgroup=hlLevel9 end=")" contains=@arcListCluster,arcParen0 contained 
else
  syn region arcList matchgroup=Delimiter start="(" skip="|..\{-}|" matchgroup=Delimiter end=")" contains=@arcListCluster 
  syn region arcQQList matchgroup=PreProc start="`(" skip="|..\{-}|" matchgroup=PreProc end=")" contains=@arcListCluster 
endif

"-------------------------------------------------------------------------------
" Bracket Functions:

syn region arcBracketFn matchgroup=SpecialChar start="\[" skip="|..\{-}|" matchgroup=SpecialChar end="]" contains=TOP 

syn match arcBracketError display "]" 

"-------------------------------------------------------------------------------
" Symbols:

syn match arcQuote display "'" 

syn match arcSym display /'[^\()[\]'`,"; \t|]\+/ contains=arcQuote 
syn match arcSym display "'|..\{-}|" contains=arcQuote 

syn region arcSym start=/'"/ skip=/\\"/ end=/"/ 

syn region arcSymList matchgroup=Type start="'(" skip="|..\{-}|" matchgroup=Type end=")" contains=TOP 

"-------------------------------------------------------------------------------
" Standard Functions And Macros:

syn keyword arcFn *
syn keyword arcFn +
syn keyword arcFn ++
syn keyword arcFn -
syn keyword arcFn --
syn keyword arcFn /
syn keyword arcFn <
syn keyword arcFn <=
syn keyword arcFn =
syn keyword arcFn >
syn keyword arcFn >=
syn keyword arcFn aand
syn keyword arcFn abs
syn keyword arcFn abusive-ip
syn keyword arcFn accum
syn keyword arcFn acons
syn keyword arcFn acos
syn keyword arcFn addtem
syn keyword arcFn adjoin
syn keyword arcFn admin
syn keyword arcFn admin-gate
syn keyword arcFn admin-page
syn keyword arcFn afn
syn keyword arcFn afnid
syn keyword arcFn aform
syn keyword arcFn aformh
syn keyword arcFn after
syn keyword arcFn aif
syn keyword arcFn alist
syn keyword arcFn all
syn keyword arcFn allchars
syn keyword arcFn alphadig
syn keyword arcFn alref
syn keyword arcFn and
syn keyword arcFn andf
syn keyword arcFn annotate
syn keyword arcFn app-path
syn keyword arcFn apply
syn keyword arcFn arform
syn keyword arcFn arformh
syn keyword arcFn arg
syn keyword arcFn asin
syn keyword arcFn assign
syn keyword arcFn assoc
syn keyword arcFn asv
syn keyword arcFn atan
syn keyword arcFn atend
syn keyword arcFn atlet
syn keyword arcFn atom
syn keyword arcFn atomic
syn keyword arcFn atomic-invoke
syn keyword arcFn attribute
syn keyword arcFn atwith
syn keyword arcFn atwiths
syn keyword arcFn avg
syn keyword arcFn awhen
syn keyword arcFn bad-newacct
syn keyword arcFn before
syn keyword arcFn begins
syn keyword arcFn best
syn keyword arcFn bestn
syn keyword arcFn blank
syn keyword arcFn bound
syn keyword arcFn br
syn keyword arcFn break-thread
syn keyword arcFn but
syn keyword arcFn buts
syn keyword arcFn caar
syn keyword arcFn cache
syn keyword arcFn cadr
syn keyword arcFn call-w/stdin
syn keyword arcFn call-w/stdout
syn keyword arcFn car
syn keyword arcFn carif
syn keyword arcFn caris
syn keyword arcFn case
syn keyword arcFn caselet
syn keyword arcFn catch
syn keyword arcFn ccc
syn keyword arcFn cdata
syn keyword arcFn cddr
syn keyword arcFn cdr
syn keyword arcFn cellpr
syn keyword arcFn center
syn keyword arcFn check
syn keyword arcFn clean-url
syn keyword arcFn client-ip
syn keyword arcFn close
syn keyword arcFn closedelim
syn keyword arcFn code-block
syn keyword arcFn code-density
syn keyword arcFn codeflat
syn keyword arcFn codelines
syn keyword arcFn codetree
syn keyword arcFn coerce
syn keyword arcFn color
syn keyword arcFn common-operators
syn keyword arcFn common-tokens
syn keyword arcFn commonest
syn keyword arcFn compare
syn keyword arcFn complement
syn keyword arcFn compose
syn keyword arcFn cons
syn keyword arcFn consif
syn keyword arcFn conswhen
syn keyword arcFn cook-user
syn keyword arcFn copy
syn keyword arcFn copylist
syn keyword arcFn cos
syn keyword arcFn count
syn keyword arcFn counts
syn keyword arcFn create-acct
syn keyword arcFn create-handler
syn keyword arcFn current-gc-milliseconds
syn keyword arcFn current-process-milliseconds
syn keyword arcFn current-thread
syn keyword arcFn cut
syn keyword arcFn date
syn keyword arcFn date-nums
syn keyword arcFn datestring
syn keyword arcFn days-since
syn keyword arcFn dead
syn keyword arcFn declare
syn keyword arcFn dedup
syn keyword arcFn def
syn keyword arcFn defbg
syn keyword arcFn defcache
syn keyword arcFn defhook
syn keyword arcFn defmemo
syn keyword arcFn defop
syn keyword arcFn defop-raw
syn keyword arcFn defopl
syn keyword arcFn defopr
syn keyword arcFn defopr-raw
syn keyword arcFn defs
syn keyword arcFn defset
syn keyword arcFn deftem
syn keyword arcFn dehex
syn keyword arcFn deq
syn keyword arcFn details
syn keyword arcFn digit
syn keyword arcFn dir
syn keyword arcFn dir-exists
syn keyword arcFn disable-acct
syn keyword arcFn disktable
syn keyword arcFn diskvar
syn keyword arcFn disp
syn keyword arcFn do
syn keyword arcFn do1
syn keyword arcFn dotted
syn keyword arcFn down
syn keyword arcFn downcase
syn keyword arcFn drain
syn keyword arcFn each
syn keyword arcFn edit-app
syn keyword arcFn ellipsize
syn keyword arcFn empty
syn keyword arcFn end-tag
syn keyword arcFn endmatch
syn keyword arcFn english-date
syn keyword arcFn english-time
syn keyword arcFn enq
syn keyword arcFn enq-limit
syn keyword arcFn ensure-dir
syn keyword arcFn ero
syn keyword arcFn err
syn keyword arcFn errpage
syn keyword arcFn errsafe
syn keyword arcFn esc-tags
syn keyword arcFn eschtml
syn keyword arcFn eval
syn keyword arcFn even
syn keyword arcFn evtil
syn keyword arcFn exact
syn keyword arcFn expand-metafn-call
syn keyword arcFn expand=
syn keyword arcFn expand=list
syn keyword arcFn expt
syn keyword arcFn failed-login
syn keyword arcFn file-exists
syn keyword arcFn filechars
syn keyword arcFn fill-table
syn keyword arcFn find
syn keyword arcFn findsubseq
syn keyword arcFn firstn
syn keyword arcFn flat
syn keyword arcFn flatlen
syn keyword arcFn flink
syn keyword arcFn flushout
syn keyword arcFn fn
syn keyword arcFn fnform
syn keyword arcFn fnid
syn keyword arcFn fnid-field
syn keyword arcFn fontcolor
syn keyword arcFn for
syn keyword arcFn force-close
syn keyword arcFn forlen
syn keyword arcFn form
syn keyword arcFn fromdisk
syn keyword arcFn fromstring
syn keyword arcFn gen-type-header
syn keyword arcFn gentag
syn keyword arcFn get
syn keyword arcFn get-user
syn keyword arcFn good-login
syn keyword arcFn goodname
syn keyword arcFn gray
syn keyword arcFn halve
syn keyword arcFn handle-post
syn keyword arcFn handle-request
syn keyword arcFn handle-request-1
syn keyword arcFn handle-request-thread
syn keyword arcFn harvest-fnids
syn keyword arcFn headmatch
syn keyword arcFn hello-page
syn keyword arcFn hex>color
syn keyword arcFn hexrep
syn keyword arcFn hook
syn keyword arcFn hours-since
syn keyword arcFn hspace
syn keyword arcFn idfn
syn keyword arcFn if
syn keyword arcFn iflet
syn keyword arcFn in
syn keyword arcFn inc
syn keyword arcFn indented-code
syn keyword arcFn infile
syn keyword arcFn input
syn keyword arcFn inputs
syn keyword arcFn insert-sorted
syn keyword arcFn inside
syn keyword arcFn insort
syn keyword arcFn insortnew
syn keyword arcFn inst
syn keyword arcFn instring
syn keyword arcFn int
syn keyword arcFn intersperse
syn keyword arcFn is
syn keyword arcFn isa
syn keyword arcFn isnt
syn keyword arcFn iso
syn keyword arcFn join
syn keyword arcFn jtime
syn keyword arcFn keep
syn keyword arcFn keys
syn keyword arcFn kill-thread
syn keyword arcFn last
syn keyword arcFn len
syn keyword arcFn len<
syn keyword arcFn len>
syn keyword arcFn let
syn keyword arcFn letter
syn keyword arcFn lines
syn keyword arcFn link
syn keyword arcFn linkf
syn keyword arcFn list
syn keyword arcFn listtab
syn keyword arcFn literal
syn keyword arcFn litmatch
syn keyword arcFn load
syn keyword arcFn load-table
syn keyword arcFn load-tables
syn keyword arcFn log
syn keyword arcFn log-request
syn keyword arcFn logfile-name
syn keyword arcFn login
syn keyword arcFn login-form
syn keyword arcFn login-handler
syn keyword arcFn login-page
syn keyword arcFn logout-user
syn keyword arcFn loop
syn keyword arcFn mac
syn keyword arcFn macex
syn keyword arcFn macex1
syn keyword arcFn map
syn keyword arcFn map1
syn keyword arcFn mappend
syn keyword arcFn maptable
syn keyword arcFn markdown
syn keyword arcFn max
syn keyword arcFn md-from-form
syn keyword arcFn med
syn keyword arcFn median
syn keyword arcFn mem
syn keyword arcFn memo
syn keyword arcFn memory
syn keyword arcFn memtable
syn keyword arcFn menu
syn keyword arcFn merge
syn keyword arcFn mergesort
syn keyword arcFn metafn
syn keyword arcFn min
syn keyword arcFn minutes-since
syn keyword arcFn mismatch
syn keyword arcFn mod
syn keyword arcFn monthnum
syn keyword arcFn most
syn keyword arcFn msec
syn keyword arcFn multiple
syn keyword arcFn multisubst
syn keyword arcFn mvfile
syn keyword arcFn n-of
syn keyword arcFn nearest
syn keyword arcFn needrows
syn keyword arcFn new-bgthread
syn keyword arcFn new-hspace
syn keyword arcFn new-thread
syn keyword arcFn newstring
syn keyword arcFn next-parabreak
syn keyword arcFn nil
syn keyword arcFn no
syn keyword arcFn noisy-each
syn keyword arcFn nonblank
syn keyword arcFn nonop
syn keyword arcFn nonwhite
syn keyword arcFn nor
syn keyword arcFn nthcdr
syn keyword arcFn num
syn keyword arcFn number
syn keyword arcFn obj
syn keyword arcFn odd
syn keyword arcFn on
syn keyword arcFn on-err
syn keyword arcFn onlink
syn keyword arcFn only
syn keyword arcFn onrlink
syn keyword arcFn ontree
syn keyword arcFn opcheck
syn keyword arcFn opcolor
syn keyword arcFn open-socket
syn keyword arcFn opendelim
syn keyword arcFn opesc
syn keyword arcFn opmeth
syn keyword arcFn opnum
syn keyword arcFn opsel
syn keyword arcFn opstring
syn keyword arcFn opsym
syn keyword arcFn or
syn keyword arcFn or=
syn keyword arcFn orf
syn keyword arcFn out
syn keyword arcFn outfile
syn keyword arcFn outstring
syn keyword arcFn pagemessage
syn keyword arcFn pair
syn keyword arcFn para
syn keyword arcFn parabreak
syn keyword arcFn parafy
syn keyword arcFn paras
syn keyword arcFn parse-date
syn keyword arcFn parse-format
syn keyword arcFn parse-time
syn keyword arcFn parseargs
syn keyword arcFn parsecookies
syn keyword arcFn parseheader
syn keyword arcFn parseurl
syn keyword arcFn peekc
syn keyword arcFn pipe-from
syn keyword arcFn plural
syn keyword arcFn pluralize
syn keyword arcFn point
syn keyword arcFn pop
syn keyword arcFn pos
syn keyword arcFn positions
syn keyword arcFn positive
syn keyword arcFn posmatch
syn keyword arcFn ppr
syn keyword arcFn ppr-call
syn keyword arcFn ppr-progn
syn keyword arcFn pprcode
syn keyword arcFn pprest
syn keyword arcFn pr
syn keyword arcFn pr-escaped
syn keyword arcFn prall
syn keyword arcFn prbold
syn keyword arcFn prcookie
syn keyword arcFn precomputable-tagopt
syn keyword arcFn prf
syn keyword arcFn prn
syn keyword arcFn prompt-page
syn keyword arcFn protect
syn keyword arcFn prrow
syn keyword arcFn prs
syn keyword arcFn prt
syn keyword arcFn pull
syn keyword arcFn punc
syn keyword arcFn push
syn keyword arcFn pushnew
syn keyword arcFn pwfields
syn keyword arcFn qlen
syn keyword arcFn qlist
syn keyword arcFn quasiquote
syn keyword arcFn quit
syn keyword arcFn quote
syn keyword arcFn rand
syn keyword arcFn rand-choice
syn keyword arcFn rand-elt
syn keyword arcFn rand-key
syn keyword arcFn rand-string
syn keyword arcFn range
syn keyword arcFn ratio
syn keyword arcFn read
syn keyword arcFn read-app
syn keyword arcFn read-table
syn keyword arcFn readall
syn keyword arcFn readb
syn keyword arcFn readc
syn keyword arcFn readfile
syn keyword arcFn readfile1
syn keyword arcFn readline
syn keyword arcFn readstring1
syn keyword arcFn readvar
syn keyword arcFn reassemble-args
syn keyword arcFn reclist
syn keyword arcFn recstring
syn keyword arcFn reduce
syn keyword arcFn reinsert-sorted
syn keyword arcFn rem
syn keyword arcFn rem-app
syn keyword arcFn rep
syn keyword arcFn repeat
syn keyword arcFn repl
syn keyword arcFn replpage
syn keyword arcFn respond
syn keyword arcFn respond-err
syn keyword arcFn retrieve
syn keyword arcFn rev
syn keyword arcFn rflink
syn keyword arcFn rfn
syn keyword arcFn rlinkf
syn keyword arcFn rmfile
syn keyword arcFn rotate
syn keyword arcFn round
syn keyword arcFn roundup
syn keyword arcFn row
syn keyword arcFn rreduce
syn keyword arcFn run-app
syn keyword arcFn safe-load-table
syn keyword arcFn saferead
syn keyword arcFn safeset
syn keyword arcFn save-optime
syn keyword arcFn save-table
syn keyword arcFn scar
syn keyword arcFn scdr
syn keyword arcFn seconds
syn keyword arcFn serve
syn keyword arcFn serve1
syn keyword arcFn set
syn keyword arcFn set-pw
syn keyword arcFn setforms
syn keyword arcFn setuid
syn keyword arcFn shash
syn keyword arcFn shortlink
syn keyword arcFn showvars
syn keyword arcFn sig
syn keyword arcFn sin
syn keyword arcFn since
syn keyword arcFn single
syn keyword arcFn single-input
syn keyword arcFn sleep
syn keyword arcFn slices
syn keyword arcFn socket-accept
syn keyword arcFn some
syn keyword arcFn sort
syn keyword arcFn sortable
syn keyword arcFn sp
syn keyword arcFn space-eaters
syn keyword arcFn spacerow
syn keyword arcFn spanclass
syn keyword arcFn spanrow
syn keyword arcFn split
syn keyword arcFn sptab
syn keyword arcFn sqrt
syn keyword arcFn sread
syn keyword arcFn sref
syn keyword arcFn srvlog
syn keyword arcFn ssexpand
syn keyword arcFn ssyntax
syn keyword arcFn start-tag
syn keyword arcFn static-filetype
syn keyword arcFn stderr
syn keyword arcFn stdin
syn keyword arcFn stdout
syn keyword arcFn string
syn keyword arcFn striptags
syn keyword arcFn submit
syn keyword arcFn subst
syn keyword arcFn sum
syn keyword arcFn summing
syn keyword arcFn swap
syn keyword arcFn sym
syn keyword arcFn system
syn keyword arcFn t
syn keyword arcFn tab
syn keyword arcFn table
syn keyword arcFn tablist
syn keyword arcFn taform
syn keyword arcFn tag
syn keyword arcFn tag-if
syn keyword arcFn tag-options
syn keyword arcFn tan
syn keyword arcFn tarform
syn keyword arcFn td
syn keyword arcFn tdcolor
syn keyword arcFn tdr
syn keyword arcFn temload
syn keyword arcFn temloadall
syn keyword arcFn templatize
syn keyword arcFn temread
syn keyword arcFn testify
syn keyword arcFn text-rows
syn keyword arcFn text-type
syn keyword arcFn textarea
syn keyword arcFn thread
syn keyword arcFn throw
syn keyword arcFn time
syn keyword arcFn time10
syn keyword arcFn timed-fnid
syn keyword arcFn timedate
syn keyword arcFn todisk
syn keyword arcFn togglemem
syn keyword arcFn tokcount
syn keyword arcFn tokens
syn keyword arcFn top40
syn keyword arcFn tostring
syn keyword arcFn tr
syn keyword arcFn trav
syn keyword arcFn tree-subst
syn keyword arcFn treewise
syn keyword arcFn trim
syn keyword arcFn trtd
syn keyword arcFn trues
syn keyword arcFn trunc
syn keyword arcFn tuples
syn keyword arcFn type
syn keyword arcFn uform
syn keyword arcFn ulink
syn keyword arcFn underline
syn keyword arcFn underlink
syn keyword arcFn union
syn keyword arcFn uniq
syn keyword arcFn unique-id
syn keyword arcFn unless
syn keyword arcFn unmarkdown
syn keyword arcFn unquote
syn keyword arcFn unquote-splicing
syn keyword arcFn until
syn keyword arcFn upcase
syn keyword arcFn urform
syn keyword arcFn url-for
syn keyword arcFn urldecode
syn keyword arcFn urlencode
syn keyword arcFn urlend
syn keyword arcFn user-exists
syn keyword arcFn username-taken
syn keyword arcFn valid-date
syn keyword arcFn valid-url
syn keyword arcFn vals
syn keyword arcFn varcompare
syn keyword arcFn varfield
syn keyword arcFn varline
syn keyword arcFn vars-form
syn keyword arcFn vhspace
syn keyword arcFn view-app
syn keyword arcFn vspace
syn keyword arcFn w/appendfile
syn keyword arcFn w/bars
syn keyword arcFn w/infile
syn keyword arcFn w/instring
syn keyword arcFn w/link
syn keyword arcFn w/link-if
syn keyword arcFn w/outfile
syn keyword arcFn w/outstring
syn keyword arcFn w/rlink
syn keyword arcFn w/socket
syn keyword arcFn w/stdin
syn keyword arcFn w/stdout
syn keyword arcFn w/table
syn keyword arcFn w/uniq
syn keyword arcFn warn
syn keyword arcFn when
syn keyword arcFn when-umatch
syn keyword arcFn when-umatch/r
syn keyword arcFn whenlet
syn keyword arcFn while
syn keyword arcFn whiler
syn keyword arcFn whilet
syn keyword arcFn whitec
syn keyword arcFn whitepage
syn keyword arcFn widtable
syn keyword arcFn wipe
syn keyword arcFn with
syn keyword arcFn withs
syn keyword arcFn write
syn keyword arcFn write-app
syn keyword arcFn write-spaced
syn keyword arcFn write-table
syn keyword arcFn writeb
syn keyword arcFn writec
syn keyword arcFn writefile
syn keyword arcFn zap
syn keyword arcFn zerotable

"-------------------------------------------------------------------------------
" Variables:

syn match arcGlobal display /[^\()[\]'`,"; \t|:~&.!]\+\*/ 

syn keyword arcVar adminfile*
syn keyword arcVar appdir*
syn keyword arcVar arcdir*
syn keyword arcVar bad-logins*
syn keyword arcVar bar*
syn keyword arcVar bgthreads*
syn keyword arcVar bigformwid*
syn keyword arcVar black
syn keyword arcVar bodops*
syn keyword arcVar breaksrv*
syn keyword arcVar cookfile*
syn keyword arcVar cookie->user*
syn keyword arcVar darkblue
syn keyword arcVar darkred
syn keyword arcVar dc-usernames*
syn keyword arcVar dead-msg*
syn keyword arcVar dos-window*
syn keyword arcVar fnids*
syn keyword arcVar fns*
syn keyword arcVar fnurl*
syn keyword arcVar formatdoc-url*
syn keyword arcVar formwid*
syn keyword arcVar good-logins*
syn keyword arcVar header*
syn keyword arcVar hexreps
syn keyword arcVar hooks*
syn keyword arcVar hpwfile*
syn keyword arcVar ignore-ips*
syn keyword arcVar jfnurl*
syn keyword arcVar linkblue
syn keyword arcVar logdir*
syn keyword arcVar logins*
syn keyword arcVar max-age*
syn keyword arcVar month-names*
syn keyword arcVar months*
syn keyword arcVar numwid*
syn keyword arcVar oidfile*
syn keyword arcVar oneline*
syn keyword arcVar opcounts*
syn keyword arcVar opmeths*
syn keyword arcVar optimes*
syn keyword arcVar orange
syn keyword arcVar pending-bgthreads*
syn keyword arcVar quitsrv*
syn keyword arcVar rdheader*
syn keyword arcVar redirector*
syn keyword arcVar req-limit*
syn keyword arcVar req-times*
syn keyword arcVar req-window*
syn keyword arcVar requests*
syn keyword arcVar requests/ip*
syn keyword arcVar rfnurl*
syn keyword arcVar rfnurl2*
syn keyword arcVar savers*
syn keyword arcVar setter
syn keyword arcVar spurned*
syn keyword arcVar srv-noisy*
syn keyword arcVar srvops*
syn keyword arcVar static-max-age*
syn keyword arcVar staticdir*
syn keyword arcVar templates*
syn keyword arcVar threadlife*
syn keyword arcVar throttle-ips*
syn keyword arcVar timed-fnids*
syn keyword arcVar type-header*
syn keyword arcVar unique-ids*
syn keyword arcVar unknown-msg*
syn keyword arcVar user->cookie*
syn keyword arcVar white

"-------------------------------------------------------------------------------
" Optional Parameters:

syn region arcOpt matchgroup=Identifier start="(o\>" skip="|..\{-}|" matchgroup=Identifier end=")" contains=TOP 

"-------------------------------------------------------------------------------
" Strings:

syn match arcStringEscError contained display "\\." 

syn match arcStringEsc contained display /\\[\abtnvfre'"]/ 
syn match arcStringEsc contained display "\\\o\{1,3}" 
syn match arcStringEsc contained display "\\\Cx\x\{1,2}" 
syn match arcStringEsc contained display "\\\Cu\x\{1,4}" 
syn match arcStringEsc contained display "\\\CU\x\{1,8}" 

syn match arcAtStringAt contained display "@@" 

syn match arcAtStringExpr contained skipwhite skipempty "@@\@!" nextgroup=@arcListCluster,arcParen.* 

if exists("g:arc_always_atstrings") && g:arc_always_atstrings != 0
  syn region arcString start=/"/ skip=/\%(\\\\\|\\"\)/ end=/"/ contains=@Spell,arcStringEsc,arcStringEscError,arcAtStringAt,arcAtStringExpr 
else
  syn region arcString start=/"/ skip=/\%(\\\\\|\\"\)/ end=/"/ contains=@Spell,arcStringEsc,arcStringEscError 
endif

"-------------------------------------------------------------------------------
" Numbers:

syn match arcNonfloat contained display ?\%(^\|[\()[\]'`,"; \t|:~&.!]\)\@<=\%(#b\%(#[ie]\)\=\|\%(#[ie]\)\=#b\)\%([+-]\=\%([01]\+#*/[01]\+#*\%([esfdl][+-]\=[01]\+\)\=\|[01]\+#*\%([esfdl][+-]\=[01]\+\)\=\)\|[+-]\=\%([01]\+#*/[01]\+#*\%([esfdl][+-]\=[01]\+\)\=\|[01]\+#*\%([esfdl][+-]\=[01]\+\)\=\)@[+-]\=\%([01]\+#*/[01]\+#*\%([esfdl][+-]\=[01]\+\)\=\|[01]\+#*\%([esfdl][+-]\=[01]\+\)\=\)\|[+-]\=\%([01]\+#*/[01]\+#*\%([esfdl][+-]\=[01]\+\)\=\|[01]\+#*\%([esfdl][+-]\=[01]\+\)\=\)\=[+-]\%(\%([01]\+#*/[01]\+#*\%([esfdl][+-]\=[01]\+\)\=\|[01]\+#*\%([esfdl][+-]\=[01]\+\)\=\)\)\=i\)\ze\%($\|[\()[\]'`,"; \t|:~&.!]\)? 
syn match arcNonfloat contained display ?\%(^\|[\()[\]'`,"; \t|:~&.!]\)\@<=\%(#o\%(#[ie]\)\=\|\%(#[ie]\)\=#o\)\%([+-]\=\%(\o\+#*/\o\+#*\%([esfdl][+-]\=\o\+\)\=\|\o\+#*\%([esfdl][+-]\=\o\+\)\=\)\|[+-]\=\%(\o\+#*/\o\+#*\%([esfdl][+-]\=\o\+\)\=\|\o\+#*\%([esfdl][+-]\=\o\+\)\=\)@[+-]\=\%(\o\+#*/\o\+#*\%([esfdl][+-]\=\o\+\)\=\|\o\+#*\%([esfdl][+-]\=\o\+\)\=\)\|[+-]\=\%(\o\+#*/\o\+#*\%([esfdl][+-]\=\o\+\)\=\|\o\+#*\%([esfdl][+-]\=\o\+\)\=\)\=[+-]\%(\%(\o\+#*/\o\+#*\%([esfdl][+-]\=\o\+\)\=\|\o\+#*\%([esfdl][+-]\=\o\+\)\=\)\)\=i\)\ze\%($\|[\()[\]'`,"; \t|:~&.!]\)? 
syn match arcNonfloat contained display ?\%(^\|[\()[\]'`,"; \t|:~&.!]\)\@<=\%(\%(#d\)\=\%(#[ie]\)\=\|\%(#[ie]\)\=\%(#d\)\=\)\%([+-]\=\%(\d\+#*/\d\+#*\%([esfdl][+-]\=\d\+\)\=\|\d\+#*\%([esfdl][+-]\=\d\+\)\=\)\|[+-]\=\%(\d\+#*/\d\+#*\%([esfdl][+-]\=\d\+\)\=\|\d\+#*\%([esfdl][+-]\=\d\+\)\=\)@[+-]\=\%(\d\+#*/\d\+#*\%([esfdl][+-]\=\d\+\)\=\|\d\+#*\%([esfdl][+-]\=\d\+\)\=\)\|[+-]\=\%(\d\+#*/\d\+#*\%([esfdl][+-]\=\d\+\)\=\|\d\+#*\%([esfdl][+-]\=\d\+\)\=\)\=[+-]\%(\%(\d\+#*/\d\+#*\%([esfdl][+-]\=\d\+\)\=\|\d\+#*\%([esfdl][+-]\=\d\+\)\=\)\)\=i\)\ze\%($\|[\()[\]'`,"; \t|:~&.!]\)? 
syn match arcNonfloat contained display ?\%(^\|[\()[\]'`,"; \t|:~&.!]\)\@<=\%(#x\%(#[ie]\)\=\|\%(#[ie]\)\=#x\)\%([+-]\=\%(\x\+#*/\x\+#*\%([sl][+-]\=\x\+\)\=\|\x\+#*\%([sl][+-]\=\x\+\)\=\)\|[+-]\=\%(\x\+#*/\x\+#*\%([sl][+-]\=\x\+\)\=\|\x\+#*\%([sl][+-]\=\x\+\)\=\)@[+-]\=\%(\x\+#*/\x\+#*\%([sl][+-]\=\x\+\)\=\|\x\+#*\%([sl][+-]\=\x\+\)\=\)\|[+-]\=\%(\x\+#*/\x\+#*\%([sl][+-]\=\x\+\)\=\|\x\+#*\%([sl][+-]\=\x\+\)\=\)\=[+-]\%(\%(\x\+#*/\x\+#*\%([sl][+-]\=\x\+\)\=\|\x\+#*\%([sl][+-]\=\x\+\)\=\)\)\=i\)\ze\%($\|[\()[\]'`,"; \t|:~&.!]\)? 

syn match arcNumber display !\%(^\|[\()[\]'`,"; \t|]\)\@<=\%(#b\%(#[ie]\)\=\|\%(#[ie]\)\=#b\)\%(\%([+-]\=\%([01]\+#*/[01]\+#*\%([esfdl][+-]\=[01]\+\)\=\|\%([01]\+#*\|\.[01]\+#*\|[01]\+\.[01]*#*\|[01]\+#\+\.#*\)\%([esfdl][+-]\=[01]\+\)\=\)\|[+-]\%(inf\.0\|nan\.0\)\)\|\%([+-]\=\%([01]\+#*/[01]\+#*\%([esfdl][+-]\=[01]\+\)\=\|\%([01]\+#*\|\.[01]\+#*\|[01]\+\.[01]*#*\|[01]\+#\+\.#*\)\%([esfdl][+-]\=[01]\+\)\=\)\|[+-]\%(inf\.0\|nan\.0\)\)@\%([+-]\=\%([01]\+#*/[01]\+#*\%([esfdl][+-]\=[01]\+\)\=\|\%([01]\+#*\|\.[01]\+#*\|[01]\+\.[01]*#*\|[01]\+#\+\.#*\)\%([esfdl][+-]\=[01]\+\)\=\)\|[+-]\%(inf\.0\|nan\.0\)\)\|\%([+-]\=\%([01]\+#*/[01]\+#*\%([esfdl][+-]\=[01]\+\)\=\|\%([01]\+#*\|\.[01]\+#*\|[01]\+\.[01]*#*\|[01]\+#\+\.#*\)\%([esfdl][+-]\=[01]\+\)\=\)\|[+-]\%(inf\.0\|nan\.0\)\)\=[+-]\%(\%([01]\+#*/[01]\+#*\%([esfdl][+-]\=[01]\+\)\=\|\%([01]\+#*\|\.[01]\+#*\|[01]\+\.[01]*#*\|[01]\+#\+\.#*\)\%([esfdl][+-]\=[01]\+\)\=\)\|inf\.0\|nan\.0\)\=i\)\ze\%($\|[\()[\]'`,"; \t|]\)! 
syn match arcNumber display !\%(^\|[\()[\]'`,"; \t|]\)\@<=\%(#o\%(#[ie]\)\=\|\%(#[ie]\)\=#o\)\%(\%([+-]\=\%(\o\+#*/\o\+#*\%([esfdl][+-]\=\o\+\)\=\|\%(\o\+#*\|\.\o\+#*\|\o\+\.\o*#*\|\o\+#\+\.#*\)\%([esfdl][+-]\=\o\+\)\=\)\|[+-]\%(inf\.0\|nan\.0\)\)\|\%([+-]\=\%(\o\+#*/\o\+#*\%([esfdl][+-]\=\o\+\)\=\|\%(\o\+#*\|\.\o\+#*\|\o\+\.\o*#*\|\o\+#\+\.#*\)\%([esfdl][+-]\=\o\+\)\=\)\|[+-]\%(inf\.0\|nan\.0\)\)@\%([+-]\=\%(\o\+#*/\o\+#*\%([esfdl][+-]\=\o\+\)\=\|\%(\o\+#*\|\.\o\+#*\|\o\+\.\o*#*\|\o\+#\+\.#*\)\%([esfdl][+-]\=\o\+\)\=\)\|[+-]\%(inf\.0\|nan\.0\)\)\|\%([+-]\=\%(\o\+#*/\o\+#*\%([esfdl][+-]\=\o\+\)\=\|\%(\o\+#*\|\.\o\+#*\|\o\+\.\o*#*\|\o\+#\+\.#*\)\%([esfdl][+-]\=\o\+\)\=\)\|[+-]\%(inf\.0\|nan\.0\)\)\=[+-]\%(\%(\o\+#*/\o\+#*\%([esfdl][+-]\=\o\+\)\=\|\%(\o\+#*\|\.\o\+#*\|\o\+\.\o*#*\|\o\+#\+\.#*\)\%([esfdl][+-]\=\o\+\)\=\)\|inf\.0\|nan\.0\)\=i\)\ze\%($\|[\()[\]'`,"; \t|]\)! 
syn match arcNumber display !\%(^\|[\()[\]'`,"; \t|]\)\@<=\%(\%(#d\)\=\%(#[ie]\)\=\|\%(#[ie]\)\=\%(#d\)\=\)\%(\%([+-]\=\%(\d\+#*/\d\+#*\%([esfdl][+-]\=\d\+\)\=\|\%(\d\+#*\|\.\d\+#*\|\d\+\.\d*#*\|\d\+#\+\.#*\)\%([esfdl][+-]\=\d\+\)\=\)\|[+-]\%(inf\.0\|nan\.0\)\)\|\%([+-]\=\%(\d\+#*/\d\+#*\%([esfdl][+-]\=\d\+\)\=\|\%(\d\+#*\|\.\d\+#*\|\d\+\.\d*#*\|\d\+#\+\.#*\)\%([esfdl][+-]\=\d\+\)\=\)\|[+-]\%(inf\.0\|nan\.0\)\)@\%([+-]\=\%(\d\+#*/\d\+#*\%([esfdl][+-]\=\d\+\)\=\|\%(\d\+#*\|\.\d\+#*\|\d\+\.\d*#*\|\d\+#\+\.#*\)\%([esfdl][+-]\=\d\+\)\=\)\|[+-]\%(inf\.0\|nan\.0\)\)\|\%([+-]\=\%(\d\+#*/\d\+#*\%([esfdl][+-]\=\d\+\)\=\|\%(\d\+#*\|\.\d\+#*\|\d\+\.\d*#*\|\d\+#\+\.#*\)\%([esfdl][+-]\=\d\+\)\=\)\|[+-]\%(inf\.0\|nan\.0\)\)\=[+-]\%(\%(\d\+#*/\d\+#*\%([esfdl][+-]\=\d\+\)\=\|\%(\d\+#*\|\.\d\+#*\|\d\+\.\d*#*\|\d\+#\+\.#*\)\%([esfdl][+-]\=\d\+\)\=\)\|inf\.0\|nan\.0\)\=i\)\ze\%($\|[\()[\]'`,"; \t|]\)! 
syn match arcNumber display !\%(^\|[\()[\]'`,"; \t|]\)\@<=\%(#x\%(#[ie]\)\=\|\%(#[ie]\)\=#x\)\%(\%([+-]\=\%(\x\+#*/\x\+#*\%([sl][+-]\=\x\+\)\=\|\%(\x\+#*\|\.\x\+#*\|\x\+\.\x*#*\|\x\+#\+\.#*\)\%([sl][+-]\=\x\+\)\=\)\|[+-]\%(inf\.0\|nan\.0\)\)\|\%([+-]\=\%(\x\+#*/\x\+#*\%([sl][+-]\=\x\+\)\=\|\%(\x\+#*\|\.\x\+#*\|\x\+\.\x*#*\|\x\+#\+\.#*\)\%([sl][+-]\=\x\+\)\=\)\|[+-]\%(inf\.0\|nan\.0\)\)@\%([+-]\=\%(\x\+#*/\x\+#*\%([sl][+-]\=\x\+\)\=\|\%(\x\+#*\|\.\x\+#*\|\x\+\.\x*#*\|\x\+#\+\.#*\)\%([sl][+-]\=\x\+\)\=\)\|[+-]\%(inf\.0\|nan\.0\)\)\|\%([+-]\=\%(\x\+#*/\x\+#*\%([sl][+-]\=\x\+\)\=\|\%(\x\+#*\|\.\x\+#*\|\x\+\.\x*#*\|\x\+#\+\.#*\)\%([sl][+-]\=\x\+\)\=\)\|[+-]\%(inf\.0\|nan\.0\)\)\=[+-]\%(\%(\x\+#*/\x\+#*\%([sl][+-]\=\x\+\)\=\|\%(\x\+#*\|\.\x\+#*\|\x\+\.\x*#*\|\x\+#\+\.#*\)\%([sl][+-]\=\x\+\)\=\)\|inf\.0\|nan\.0\)\=i\)\ze\%($\|[\()[\]'`,"; \t|]\)! 

"-------------------------------------------------------------------------------
" Character Literals:

syn match arcChar "#\\[ -~]" 
syn match arcChar "#\\\%(null\|nul\|backspace\|tab\|newline\|linefeed\|vtab\|page\|return\|space\|rubout\)" 
syn match arcChar "#\\[0-3][0-7][0-7]" 
syn match arcChar "#\\\Cu\x\{1,4}" 
syn match arcChar "#\\\CU\x\{1,6}" 

"-------------------------------------------------------------------------------
" Comments:

" arcCommentGroup allows adding matches for special things in comments

syn cluster arcCommentGroup contains=arcTodo,@Spell

syn match arcComment ";.*$" contains=@arcCommentGroup 

syn match arcTodo contained "\%(todo\|xxx\|fixme\):\=" 

syn region arcCommentRegion start="#|" end="|#" contains=arcCommentRegion,@arcCommentGroup 

"-------------------------------------------------------------------------------
" Define Highlighting:

hi def link arcAtStringAt SpecialChar
hi def link arcAtStringExpr SpecialChar
hi def link arcBracketError Error
hi def link arcChar Type
hi def link arcComment Comment
hi def link arcCommentRegion Comment
hi def link arcDotted Statement
hi def link arcFn Statement
hi def link arcGlobal Identifier
hi def link arcNonfloat Number
hi def link arcNumber Number
hi def link arcOpt Type
hi def link arcParenError Error
hi def link arcQQ PreProc
hi def link arcQuote Type
hi def link arcSsyntax Type
hi def link arcString String
hi def link arcStringEsc SpecialChar
hi def link arcStringEscError Error
hi def link arcSym Type
hi def link arcTodo Todo
hi def link arcUnquote PreProc
hi def link arcVar Statement

if exists("g:arc_rainbow") && g:arc_rainbow != 0
  if &bg == "dark"
    hi def hlLevel0 ctermfg=red guifg=red1
    hi def hlLevel1 ctermfg=yellow guifg=orange1
    hi def hlLevel2 ctermfg=green guifg=yellow1
    hi def hlLevel3 ctermfg=cyan guifg=greenyellow
    hi def hlLevel4 ctermfg=magenta guifg=green1
    hi def hlLevel5 ctermfg=red guifg=springgreen1
    hi def hlLevel6 ctermfg=yellow guifg=cyan1
    hi def hlLevel7 ctermfg=green guifg=slateblue1
    hi def hlLevel8 ctermfg=cyan guifg=magenta1
    hi def hlLevel9 ctermfg=magenta guifg=purple1
  else
    hi def hlLevel0 ctermfg=red guifg=red3
    hi def hlLevel1 ctermfg=darkyellow guifg=orangered3
    hi def hlLevel2 ctermfg=darkgreen guifg=orange2
    hi def hlLevel3 ctermfg=blue guifg=yellow3
    hi def hlLevel4 ctermfg=darkmagenta guifg=olivedrab4
    hi def hlLevel5 ctermfg=red guifg=green4
    hi def hlLevel6 ctermfg=darkyellow guifg=paleturquoise3
    hi def hlLevel7 ctermfg=darkgreen guifg=deepskyblue4
    hi def hlLevel8 ctermfg=blue guifg=darkslateblue
    hi def hlLevel9 ctermfg=darkmagenta guifg=darkviolet
  endif
endif

syn sync lines=100

let b:current_syntax="arc"
