function! inlinemarkdownfootnotes#GetNextNote()
	" find the next footnote to insert, don't assume they are in order.
	let s:cur_pos = getpos(".")

	let l:pattern = '\v^\[\^[0-9]+\]:'
	let l:matchpattern = '\v^\[\^\zs[0-9]+\ze\]:'
	let l:flags = 'W'

	call cursor(1,1)

	let l:count = 0
	let l:currentnotelist = []

	let l:temp = search(l:pattern, l:flags)
	if (l:temp != 0)
		" count subsequent matches and build a list
		while 1
			" We shouldn't have more than 500 footnotes.
			if l:temp == 0 || l:count > 500 
				break
			endif
			let l:count += 1
			let l:currentnote = str2nr(matchstr(getline(l:temp), l:matchpattern))
			call add(l:currentnotelist, l:currentnote)

			let l:temp = search(l:pattern, l:flags)
		endwhile

		" Check if we have the right number of footnotes, or if we don't, insert
		" at the first possible location.
		call sort(l:currentnotelist, 'n')
		if l:count == l:currentnotelist[-1]
			let l:inlinefootnotenumber = l:count + 1
		elseif l:currentnotelist[0] != 1
			" Make sure we start as low as we can.
			let l:inlinefootnotenumber = 1
		else
			let l:c = 0
			while c < len(l:currentnotelist)
				" Somehow this slice works
				let [l:prev, l:next] = l:currentnotelist[l:c:l:c + 1]
				if l:next - l:prev > 1
					let l:inlinefootnotenumber = l:prev + 1
					break
				else
					let l:c += 1
				endif
			endwhile
		endif

	else
		let l:inlinefootnotenumber = 1
	endif

	call setpos(".", s:cur_pos)

	return l:inlinefootnotenumber
endfunction

function! inlinemarkdownfootnotes#InsertNote()
  let l:inlinefootnotenumber = inlinemarkdownfootnotes#GetNextNote()
	" We place the footnote after the nearest punctuation.
	let l:pos = search('[,:.?!]', 'Wce')

	execute "normal! a[^".l:inlinefootnotenumber."]\<esc>"
	execute "normal! }o[^".l:inlinefootnotenumber."]: "
	execute "normal! o\<esc>k$"
	startinsert!
endfunction
