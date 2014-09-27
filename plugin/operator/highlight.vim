scriptencoding utf-8
if exists('g:loaded_operator_highlight')
  finish
endif
let g:loaded_operator_highlight = 1

let s:save_cpo = &cpo
set cpo&vim

command! OperatorHighlightClear call operator#highlight#clear()


if exists("#TextChanged")
	augroup operator-highlight
		autocmd!
		autocmd TextChanged * OperatorHighlightClear
	augroup END
endif


call operator#user#define('highlight', 'operator#highlight#do')



let &cpo = s:save_cpo
unlet s:save_cpo
