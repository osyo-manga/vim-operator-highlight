scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


let s:V = vital#of("vital")
let s:Highlight = s:V.import("Coaster.Highlight")
let s:Search = s:V.import("Coaster.Search")


let g:operator#highlight#group = get(g:, "operator#highlight#group", "Error")


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
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
