" Vim color file
" Maintainer:	
" Last Change:	

" First remove all existing highlighting.
set background=light
hi clear
"if exists("syntax_on")
  "syntax reset
"endif

let colors_name = "emacs"

hi Normal	guifg=Black 	guibg=White
hi Normal	ctermfg=Black 	ctermbg=White
hi Cursor	guifg=Black	guibg=Green
hi Cursor	ctermfg=Black	ctermbg=Green
hi Directory	guifg=DarkCyan
hi Directory	ctermfg=DarkCyan
hi DiffAdd	guifg=White	guibg=DarkGreen
hi DiffAdd	ctermfg=White	guibg=DarkGreen
hi DiffChange	guifg=White	guibg=DarkBlue
hi DiffChange	ctermfg=White	guibg=DarkBlue
hi DiffDelete	guifg=White	guibg=DarkRed
hi DiffDelete	ctermfg=White	guibg=DarkRed
hi ErrorMsg	guifg=White	guibg=Red
hi ErrorMsg	ctermfg=White	guibg=Red
hi IncSearch	gui=reverse
hi IncSearch	cterm=reverse
hi Question	guifg=Black	guibg=Green
hi Question	ctermfg=Black	ctermbg=Green
hi Search	guifg=Black	guibg=LightBlue	gui=underline
hi Search	ctermfg=Black	ctermbg=LightBlue	cterm=underline
hi SpecialKey	guifg=DarkBlue
hi SpecialKey	ctermfg=DarkBlue
hi StatusLine	guifg=White	guibg=Black	gui=NONE
hi StatusLine	ctermfg=White	ctermbg=Black	cterm=NONE
hi StatusLineNC guifg=LightGrey	guibg=Black	gui=None
hi StatusLineNC ctermfg=LightGrey	ctermbg=Black	cterm=None
hi Visual	guifg=Grey	guibg=fg
hi Visual	ctermfg=Grey	ctermbg=fg
hi VisualNOS	gui=bold,underline
hi VisualNOS	cterm=bold,underline
hi WarningMsg	guifg=Red
hi WarningMsg	ctermfg=Red

hi Error	guibg=Red guifg=White
hi Error	ctermbg=Red ctermfg=White
hi Comment	guifg=Red
hi Comment	ctermfg=Red
hi Include	guifg=DarkCyan
hi Include	ctermfg=DarkCyan
hi Constant	guifg=DarkBlue
hi Constant	ctermfg=DarkBlue
hi Keyword	guifg=Blue
hi Keyword	ctermfg=Blue
hi String	guifg=DarkGreen
hi String	ctermfg=DarkGreen
hi Type		guifg=Black 	guibg=White	gui=NONE 
hi Type		ctermfg=Black 	ctermbg=White	cterm=NONE 
    "Multi-word types get really ugly with bright colors...
hi Todo		guifg=Black 	guibg=Yellow
hi Todo		ctermfg=Black 	ctermbg=Yellow
hi Statement 	guifg=Blue	guibg=White
hi Statement 	ctermfg=Blue	ctermbg=White
