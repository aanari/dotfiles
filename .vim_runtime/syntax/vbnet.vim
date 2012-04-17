" Vim syntax file
" Modified from the default syntax/vb.vim
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

syn keyword vbStatement AddHandler AddressOf Alias And
syn keyword vbStatement AndAlso  Ansi As Assembly
syn keyword vbStatement Auto ByRef
syn keyword vbStatement ByVal Call Case Catch
syn keyword vbStatement Class Const Continue Custom
syn keyword vbStatement Declare Default
syn keyword vbStatement Delegate Dim DirectCast Do
syn keyword vbStatement Each Else ElseIf
syn keyword vbStatement End Enum Erase Error
syn keyword vbStatement Event Exit False Finally
syn keyword vbStatement For Friend Function Get
syn keyword vbStatement GoSub GoTo Handles
syn keyword vbStatement If Implements Imports In
syn keyword vbStatement Inherits Interface Is IsNot
syn keyword vbStatement Let Lib Like
syn keyword vbStatement Loop Me Mod Module
syn keyword vbStatement MustInherit MustOverride MyBase MyClass
syn keyword vbStatement Namespace New Next Not
syn keyword vbStatement Nothing NotInheritable NotOverridable
syn keyword vbStatement Of On Option Optional Or
syn keyword vbStatement OrElse Overloads Overridable Overrides
syn keyword vbStatement ParamArray Preserve Private Property
syn keyword vbStatement Protected Public RaiseEvent ReadOnly
syn keyword vbStatement ReDim RemoveHandler Resume
syn keyword vbStatement Return Select Set Shadows
syn keyword vbStatement Shared Static
syn keyword vbStatement Step Stop Structure
syn keyword vbStatement Sub SyncLock Then Throw
syn keyword vbStatement To True Try TypeOf
syn keyword vbStatement Unicode Until Using Variant When
syn keyword vbStatement While With WithEvents WriteOnly
syn keyword vbStatement Xor

syn keyword vbTypes Boolean Byte Char Date Decimal Double
syn keyword vbTypes Integer Long Object Short Single String
syn keyword vbTypes UInteger ULong UShort SByte

syn match vbOperator "[()+.,\-/*=&]"
syn match vbOperator "[<>]=\="
syn match vbOperator "<>"
syn match vbOperator "\s\+_$"
syn keyword vbOperator ByVal ByRef AddressOf GetType
syn keyword vbFunction CBool CByte CChar CDate CDbl CDec CInt
syn keyword vbFunction Clng CObj CSByte CShort CSng CStr
syn keyword vbFunction CUInt CULng CUShort
syn keyword vbFunction CType DirectCast GetType

syn keyword vbConst True False Nothing

syn keyword vbSpecial Me MyBase MyClass

syn keyword vbTodo contained TODO

"integer number, or floating point number without a dot.
syn match vbNumber "\<\d\+\>"
"floating point number, with dot
syn match vbNumber "\<\d\+\.\d*\>"
"floating point number, starting with a dot
syn match vbNumber "\.\d\+\>"

" String and Character contstants
syn region vbString start=+"+ end=+"+

syn region vbComment start="\<REM\>" end="$" contains=vbTodo
syn region vbComment start="'" end="$" contains=vbTodo

syn region vbPreCondit start="^#If\s" end="Then$"
syn region vbPreCondit start="^#ElseIf\s" end="Then$"
syn match vbPreCondit "^#Else$"
syn match vbPreCondit "^#End If$"

syn region vbPreCondit start="^#Region\s\+\"" end="\"$"
syn match vbPreCondit "^#End Region$"

syn region vbPreCondit start="^#ExternalSource(" end=")$"
syn match vbPreCondit "^#End ExternalSource$"

syn region vbPreCondit start="^#Const\s" end="$"

syn region vbLineNumber	start="^\d" end="\s"

syn match vbTypeSpecifier "[a-zA-Z0-9][\$%&!#]"ms=s+1

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_vb_syntax_inits")
  if version < 508
    let did_vb_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink vbLineNumber Comment
  HiLink vbNumber Number
  HiLink vbConst Constant
  HiLink vbError Error
  HiLink vbStatement Statement
  HiLink vbString String
  HiLink vbComment Comment
  HiLink vbTodo Todo
  HiLink vbFunction Identifier
  HiLink vbMethods PreProc
  HiLink vbPreCondit PreCondit
  HiLink vbSpecial Special
  HiLink vbTypeSpecifier Type
  HiLink vbTypes Type
  HiLink vbOperator Operator

  delcommand HiLink
endif

let b:match_words = '\<Namespace\>:\<End Namespace\>'
      \ . ',\<Module\>:\<End Module\>'
      \ . ',\<Class\>:\<End Class\>'
      \ . ',\<Property\>:\<End Property\>'
      \ . ',\<Enum\>:\<End Enum\>'
      \ . ',\<Function\>:\<End Function\>'
      \ . ',\<Sub\>:\<End Sub\>'
      \ . ',\<Get\>:\<End Get\>'
      \ . ',\<Set\>:\<End Set\>'
      \ . ',\<Do\>:\<Loop\>'
      \ . ',\<For\>:\<Next\>'
      \ . ',\<While\>:\<End While\>'
      \ . ',\<Select\>:\<End Select\>'
      \ . ',\<Using\>:\<End Using\>'
      \ . ',\<With\>:\<End With\>'
      \ . ',\<SyncLock\>:\<End SyncLock\>'
      \ . ',\<Try\>:\<End Try\>'
      \ . ',\<If\>:\<End If\>'
let b:current_syntax = "vbnet"
