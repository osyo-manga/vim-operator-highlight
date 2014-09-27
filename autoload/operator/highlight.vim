scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


let s:V = vital#of("operator_highlight")
let s:Highlight = s:V.import("Coaster.Highlight")
let s:Search = s:V.import("Coaster.Search")
let s:Reunions = vital#of("operator_highlight").import("Reunions")


let g:operator#highlight#group = get(g:, "operator#highlight#group", "Error")
let g:operator#highlight#clear_time = get(g:, "operator#highlight#clear_time", 0)


function! s:as_wise_key(name)
	return a:name ==# "char"  ? "v"
\		 : a:name ==# "line"  ? "V"
\		 : a:name ==# "block" ? "\<C-v>"
\		 : a:name
endfunction


function! operator#highlight#clear()
	call s:Highlight.clear("YankArea")
endfunction


function! operator#highlight#do(wise)
	call operator#highlight#clear()
	let pat = s:Search.pattern_by_range(s:as_wise_key(a:wise), getpos("'[")[1:], getpos("']")[1:])
	call s:Highlight.highlight("YankArea", g:operator#highlight#group, pat, 0)
	if g:operator#highlight#clear_time == 0
		return
	endif
	let clear_task = s:Reunions.timer({}, g:operator#highlight#clear_time)
	function! clear_task.apply(parent, ...)
		call operator#highlight#clear()
		call a:parent.kill(self)
	endfunction
endfunction


augroup operator-highlight-reunions
	autocmd!
	autocmd CursorHold * call s:Reunions.update_in_cursorhold(1)
augroup END


let &cpo = s:save_cpo
unlet s:save_cpo
