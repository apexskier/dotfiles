" Vim syntax file
" Language:	    KPL
" Maintainer:	Adam Blinkinsop <blinks@acm.org>
" Last Change:	2007 Apr 17
" Remark:	    A Kernel Programming Language used by the BLITZ tools.

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" Comments
syntax region kplSingleLineComment start=/--/ end=/$/ contained
syntax region kplMultiLineComment start=/\/\*/ end=/\*\// contained
syntax cluster kplComment contains=kplSingleLineComment,kplMultiLineComment

" Types
syntax keyword kplType char int double bool void typeOfNull anyType ptr to array of function returns
syntax region kplRecord matchgroup=kplType start=/record/ end=/endRecord/ contains=ALL

" Expressions
syntax keyword kplOperator asPtrTo asInteger arraySize isInstanceOf isKindOf new alloc sizeOf
syntax match kplOp /[][.()<=>|&^!+*/%]/ contained
syntax keyword kplConstant null self super
syntax keyword kplBoolean true false
syntax match kplCharacter /'\\?.'/
syntax match kplInteger /[0-9]+/
syntax match kplHex /0x[0-9a-fA-F]+/
syntax match kplFloat /[0-9]+\.[0-9]+(e[0-9]+)?/
syntax region kplString start=/"/ end=/"/ skip=/\\"/

" Statements
syntax keyword kplConditional if elseIf else endIf switch endSwitch
syntax keyword kplRepeat while endWhile do until for endFor
syntax keyword kplStatement break continue free debug
syntax keyword kplLabel case default
syntax keyword kplException try catch throw endTry

" Block Definitions
syntax keyword kplKeyword extends messages implements superclass fields uses renaming to const var errors type enum returns function[s] external endFunction infix prefix method[s] endMethod
syntax region kplInterface matchgroup=kplDefBlock start=/interface/ end=/endInterface/ contains=ALL
syntax region kplClass matchgroup=kplDefBlock start=/class/ end=/endClass/ contains=ALL
syntax region kplBehavior matchgroup=kplDefBlock start=/behavior/ end=/endBehavior/ contains=ALL

" File Blocks
syntax region kplHeader matchgroup=kplFile start=/header/ end=/endHeader/ contains=ALLBUT,kplHeader,kplCode
syntax region kplCode matchgroup=kplFile start=/code/ end=/endCode/ contains=ALLBUT,kplHeader,kplCode

syntax sync match kplCode grouphere kplCode 'code'
syntax sync match kplCode groupthere kplCode 'endCode'
syntax sync match kplHeader grouphere kplHeader 'region'
syntax sync match kplHeader groupthere kplHeader 'endRegion'

hi def link kplSingleLineComment    Comment
hi def link kplMultiLineComment     Comment
hi def link kplType                 Type
hi def link kplOperator             Operator
hi def link kplOp                   Operator
hi def link kplConstant             Constant
hi def link kplBoolean              Boolean
hi def link kplString               String
hi def link kplCharacter            Character
hi def link kplInteger              Number
hi def link kplHex                  Number
hi def link kplFloat                Float
hi def link kplConditional          Conditional
hi def link kplRepeat               Repeat
hi def link kplStatement            Statement
hi def link kplLabel                Label
hi def link kplException            Exception
hi def link kplKeyword              Keyword
hi def link kplFile                 Special
hi def link kplDefBlock             Structure
