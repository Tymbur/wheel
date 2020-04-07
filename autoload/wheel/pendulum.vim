" vim: ft=vim fdm=indent:

" History

fun! wheel#pendulum#timestamp ()
	" Timestamp in seconds since epoch
	 return str2nr(strftime('%s'))
endfu

fun! wheel#pendulum#date_hour (timestamp)
	" Timestamp in date & hour format
	if g:wheel_config.debug > 0
		return strftime('%Y %B %d %A %H:%M:%S', a:timestamp)
	else
		return strftime('%Y %B %d %A %H:%M', a:timestamp)
	endif
endfu

fun! wheel#pendulum#index ()
	" History index
	" Each entry is a string : date hour | torus >> circle > location
	let history = g:wheel_history
	let strings = []
	for entry in history
		let coordin = entry.coordin
		let timestamp = entry.timestamp
		let date_hour = wheel#pendulum#date_hour (timestamp)
		let entry = date_hour . ' | '
		let entry .= coordin[0] . ' >> ' . coordin[1] . ' > ' . coordin[2]
		let strings = add(strings, entry)
	endfor
	return strings
endfu

fun! wheel#pendulum#compare (one, two)
	" Comparison of history entries : used to sort index
	return a:two.timestamp - a:one.timestamp
endfu

fun! wheel#pendulum#sorted ()
	" Sorted history index
	" Each entry is a string : date hour | torus >> circle > location
	let history = deepcopy(g:wheel_history)
	let Compare = function('wheel#pendulum#compare')
	let history = sort(history, Compare)
	let strings = []
	for entry in history
		let coordin = entry.coordin
		let timestamp = entry.timestamp
		let date_hour = wheel#pendulum#date_hour (timestamp)
		let entry = date_hour . ' | '
		let entry .= coordin[0] . ' >> ' . coordin[1] . ' > ' . coordin[2]
		let strings = add(strings, entry)
	endfor
	return strings
endfu

fun! wheel#pendulum#is_in_history (entry)
	let present = 0
	let entry = a:entry
	for elem in g:wheel_history
		if elem.coordin ==# entry.coordin
			let present = 1
		endif
	endfor
	return present
endfu

fun! wheel#pendulum#remove_if_present (entry)
	let entry = a:entry
	let history = g:wheel_history
	for elem in g:wheel_history
		if elem.coordin ==# entry.coordin
			let g:wheel_history = wheel#chain#remove_element(elem, history)
		endif
	endfor
endfu

fun! wheel#pendulum#record ()
	" Add current torus, circle, location to history
	" Put new entry at the beginning of the list
	let history = g:wheel_history
	let coordin = wheel#referen#names()
	let entry = {}
	let entry.coordin = coordin
	let entry.timestamp = wheel#pendulum#timestamp ()
	call wheel#pendulum#remove_if_present (entry)
	let g:wheel_history = insert(g:wheel_history, entry, 0)
	let max = g:wheel_config.max_history
	let g:wheel_history = g:wheel_history[:max - 1]
endfu

fun! wheel#pendulum#rename(level, old, new)
	" Rename all occurences old -> new in history
	" level = 0 or torus    : rename torus
	" level = 1 or circle   : rename circle
	" level = 2 or location : rename location
	if type(a:level) == v:t_number
		let index = a:level
	elseif type(a:level) == v:t_string
		let index = wheel#referen#coordin_index (a:level)
	else
		echomsg 'Pendulum rename : level arg must be number or string'
		return
	end
 	let old = a:old
	let new = a:new
	for elem in g:wheel_history
		let coordin = elem.coordin
		if coordin[index] ==# old
			let elem.coordin[index] = new
		endif
	endfor
endfun

fun! wheel#pendulum#delete(level, old)
	" Delete all occurences of old in history
	" level = 0 or torus    : delete torus
	" level = 1 or circle   : delete circle
	" level = 2 or location : delete location
	if type(a:level) == v:t_number
		let index = a:level
	elseif type(a:level) == v:t_string
		let index = wheel#referen#coordin_index (a:level)
	else
		echomsg 'Pendulum delete : level arg must be number or string'
		return
	end
	let old = a:old
	let history = deepcopy(g:wheel_history)
	for elem in history
		let coordin = elem.coordin
		if coordin[index] ==# old
			let g:wheel_history =
						\ wheel#chain#remove_element(elem, g:wheel_history)
		endif
	endfor
endfun

fun! wheel#pendulum#newer ()
	" Go to newer entry in history
	call wheel#vortex#update ()
	let history = g:wheel_history
	let g:wheel_history = wheel#chain#rotate_right (history)
	let g:wheel_history[0].timestamp = wheel#pendulum#timestamp ()
	let coordin = g:wheel_history[0].coordin
	call wheel#vortex#tune(coordin)
	call wheel#vortex#jump ()
endfun

fun! wheel#pendulum#older ()
	" Go to older entry in history
	call wheel#vortex#update ()
	let history = g:wheel_history
	let g:wheel_history = wheel#chain#rotate_left (history)
	let g:wheel_history[0].timestamp = wheel#pendulum#timestamp ()
	let coordin = g:wheel_history[0].coordin
	call wheel#vortex#tune(coordin)
	call wheel#vortex#jump ()
endfun

fun! wheel#pendulum#alternate ()
	" Alternate last two entries in history
	" If outside the wheel, just jump inside
	let files = wheel#helix#files ()
	let filename = expand('%:p')
	if index(files, filename) >= 0
		call wheel#vortex#update ()
		let history = g:wheel_history
		if len(history) > 1
			let coordin = history[1].coordin
			call wheel#vortex#tune(coordin)
		endif
	endif
	call wheel#vortex#jump ()
endfun

fun! wheel#pendulum#alternate_same_torus ()
	" Alternate entries in same torus
	let files = wheel#helix#files ()
	let filename = expand('%:p')
	if index(files, filename) >= 0
		call wheel#vortex#update ()
		let history = g:wheel_history
		let length = len(history)
		let current = wheel#referen#names ()
		let target = []
		for ind in range(1, length - 1)
			let coordin = history[ind].coordin
			if coordin[0] ==# current[0]
				let target = coordin
				break
			endif
		endfor
		call wheel#vortex#tune(target)
	endif
	call wheel#vortex#jump ()
endfun

fun! wheel#pendulum#alternate_same_circle ()
	" Alternate entries in same circle
	let files = wheel#helix#files ()
	let filename = expand('%:p')
	if index(files, filename) >= 0
		call wheel#vortex#update ()
		let history = g:wheel_history
		let length = len(history)
		let current = wheel#referen#names ()
		let target = []
		for ind in range(1, length - 1)
			let coordin = history[ind].coordin
			if coordin[0] ==# current[0] && coordin[1] ==# current[1]
				let target = coordin
				break
			endif
		endfor
		call wheel#vortex#tune(target)
	endif
	call wheel#vortex#jump ()
endfun

fun! wheel#pendulum#alternate_other_torus ()
	" Alternate last two toruses
	let files = wheel#helix#files ()
	let filename = expand('%:p')
	if index(files, filename) >= 0
		call wheel#vortex#update ()
		let history = g:wheel_history
		let length = len(history)
		let current = wheel#referen#names ()
		let target = []
		for ind in range(1, length - 1)
			let coordin = history[ind].coordin
			if coordin[0] !=# current[0]
				let target = coordin
				break
			endif
		endfor
		call wheel#vortex#tune(target)
	endif
	call wheel#vortex#jump ()
endfun

fun! wheel#pendulum#alternate_other_circle ()
	" Alternate last two circles
	let files = wheel#helix#files ()
	let filename = expand('%:p')
	if index(files, filename) >= 0
		call wheel#vortex#update ()
		let history = g:wheel_history
		let length = len(history)
		let current = wheel#referen#names ()
		let target = []
		for ind in range(1, length - 1)
			let coordin = history[ind].coordin
			if coordin[0] !=# current[0] || coordin[1] !=# current[1]
				let target = coordin
				break
			endif
		endfor
		call wheel#vortex#tune(target)
	endif
	call wheel#vortex#jump ()
endfun

fun! wheel#pendulum#alternate_same_torus_other_circle ()
	" Alternate in same torus but other circle
	let files = wheel#helix#files ()
	let filename = expand('%:p')
	if index(files, filename) >= 0
		call wheel#vortex#update ()
		let history = g:wheel_history
		let length = len(history)
		let current = wheel#referen#names ()
		let target = []
		for ind in range(1, length - 1)
			let coordin = history[ind].coordin
			if coordin[0] ==# current[0] && coordin[1] !=# current[1]
				let target = coordin
				break
			endif
		endfor
		call wheel#vortex#tune(target)
	endif
	call wheel#vortex#jump ()
endfun
