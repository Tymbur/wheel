" vim: set filetype=vim:

" Move to elements
" Move elements

fun! wheel#vortex#here ()
	let location = {}
	let location.file = expand('%:p')
	let location.line = line('.')
	let location.col  = col('.')
	let location.name = fnamemodify(location.file, ':t:r')
	return location
endfun

fun! wheel#vortex#update ()
	let location = wheel#referen#location()
	if ! empty(location) && location.file == expand('%:p')
		let location.line = line('.')
		let location.col  = col('.')
	endif
endfun

fun! wheel#vortex#jump ()
	let location = wheel#referen#location()
	if ! empty(location)
		let buffer = bufname(location.file)
		if empty(buffer)
			" echomsg 'Opening file ' location.file
			exe 'silent edit ' . location.file
		else
			" echomsg 'Switching to buffer ' location.file
			exe 'silent b ' . buffer
		endif
		exe location.line
		exe 'normal ' . location.col . '|'
		doau BufEnter *
minpac		"norm zv
		norm zz
		call wheel#status#dashboard()
	endif
endfun

fun! wheel#vortex#prev_torus ()
	if has_key(g:wheel, 'toruses') && ! empty(g:wheel.toruses)
		call wheel#vortex#update ()
		let current = g:wheel.current
		let length = len(g:wheel.toruses)
		let g:wheel.current = wheel#gear#circular_minus(current, length)
		call wheel#vortex#jump()
	endif
endfun

fun! wheel#vortex#next_torus ()
	if has_key(g:wheel, 'toruses') && ! empty(g:wheel.toruses)
		call wheel#vortex#update ()
		let current = g:wheel.current
		let length = len(g:wheel.toruses)
		let g:wheel.current = wheel#gear#circular_plus(current, length)
		call wheel#vortex#jump()
	endif
endfun

fun! wheel#vortex#prev_circle ()
	let cur_torus = wheel#referen#torus()
	if has_key(cur_torus, 'circles') && ! empty(cur_torus.circles)
		call wheel#vortex#update ()
		let current = cur_torus.current
		let length = len(cur_torus.circles)
		let cur_torus.current = wheel#gear#circular_minus(current, length)
		call wheel#vortex#jump()
	endif
endfun

fun! wheel#vortex#next_circle ()
	let cur_torus = wheel#referen#torus()
	if has_key(cur_torus, 'circles') && ! empty(cur_torus.circles)
		call wheel#vortex#update ()
		let current = cur_torus.current
		let length = len(cur_torus.circles)
		let cur_torus.current = wheel#gear#circular_plus(current, length)
		call wheel#vortex#jump()
	endif
endfun

fun! wheel#vortex#prev_location ()
	let cur_circle = wheel#referen#circle()
	if has_key(cur_circle, 'locations') && ! empty(cur_circle.locations) > 0
		call wheel#vortex#update ()
		let current = cur_circle.current
		let length = len(cur_circle.locations)
		let cur_circle.current = wheel#gear#circular_minus(current, length)
		call wheel#vortex#jump()
	endif
endfun

fun! wheel#vortex#next_location ()
	let cur_circle = wheel#referen#circle()
	if has_key(cur_circle, 'locations') && ! empty(cur_circle.locations) > 0
		call wheel#vortex#update ()
		let current = cur_circle.current
		let length = len(cur_circle.locations)
		let cur_circle.current = wheel#gear#circular_plus(current, length)
		call wheel#vortex#jump()
	endif
endfun

fun! wheel#vortex#switch_torus ()
	" Switch torus
	call wheel#vortex#update ()
	let torus_name = input('Switch to torus : ', '', 'custom,wheel#complete#torus')
	let glossary = g:wheel.glossary
	let index = index(glossary, torus_name)
	let g:wheel.current = index
	call wheel#vortex#jump ()
endfun

fun! wheel#vortex#switch_circle ()
	" Switch circle
	call wheel#vortex#update ()
	let circle_name = input('Switch to circle : ', '', 'custom,wheel#complete#circle')
	let cur_torus = wheel#referen#torus ()
	let glossary = cur_torus.glossary
	let index = index(glossary, circle_name)
	let cur_torus.current = index
	call wheel#vortex#jump ()
endfun

fun! wheel#vortex#switch_location ()
	" Switch location
	call wheel#vortex#update ()
	let location_name = input('Switch to location : ', '', 'custom,wheel#complete#location')
	let cur_circle = wheel#referen#circle ()
	let glossary = cur_circle.glossary
	let index = index(glossary, location_name)
	let cur_circle.current = index
	call wheel#vortex#jump ()
endfun
