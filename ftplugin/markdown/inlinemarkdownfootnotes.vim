" Maintainer: Daniel Moerner
" Description: Insert inline markdown footnotes
" License: BSD
"
" This package was inspired by vim-markdownfootnotes. It drops support for 
" different footnote ids, but adds support for automatically counting the
" appropriate footnote number.

if exists("b:loaded_inlinemarkdownfootnotes") 
	finish
endif

let b:loaded_inlinemarkdownfootnotes = 1

let s:cpo_save = &cpo
set cpo&vim

nnoremap <buffer> <Plug>AddInlineFootnote :<c-u>call inlinemarkdownfootnotes#InsertNote()<CR>
inoremap <buffer> <Plug>AddInlineFootnote <C-O>:<c-u>call inlinemarkdownfootnotes#InsertNote()<CR>

command! -buffer -nargs=0 NextInlineFootnote call inlinemarkdownfootnotes#GetNextNote()

let &cpo = s:cpo_save
