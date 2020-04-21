" vim: ft=vim fdm=indent:

" Context menus,
" acting back on a wheel buffer

fun! wheel#boomerang#sync ()
	" Sync buffer variables with top of stack
	" Selection
	let stack = b:wheel_stack
	if ! empty(stack.selected)
		let b:wheel_selected = stack.selected[0]
	endif
	" If selection is empty, take the old cursor line
	if empty(b:wheel_selected)
		let linum = stack.positions[0][1]
		let now = stack.current[0]
		let b:wheel_selected = [now[linum - 1]]
	endif
	" Sync settings with top of stack
	if ! empty(stack.settings)
		let b:wheel_settings = stack.settings[0]
	endif
endfun

fun! wheel#boomerang#menu (dictname)
	" Context menu
	if ! exists('b:wheel_selected') || empty(b:wheel_selected)
		if empty(wheel#line#coordin ())
			echomsg 'Wheel boomerang menu : empty selection'
			return
		endif
	endif
	let dictname = 'context/' . a:dictname
	" Close = 0 by default, to be able to catch wheel buffer variables
	let settings = {'linefun' : dictname, 'close' : 0, 'travel' : 0}
	call wheel#layer#staircase(settings)
	call wheel#boomerang#sync ()
	" Let wheel#overlay#call handle open / close
	let b:wheel_settings.close = 0
	" No more layers
	nunmap <buffer> <tab>
endfun

fun! wheel#boomerang#switch (action)
	" Switch actions
	let action = a:action
	let settings = b:wheel_settings
	if action == 'current'
		let settings.target = 'current'
		call wheel#line#switch (settings)
		return v:true
	elseif action == 'tab'
		let settings.target = 'tab'
		call wheel#line#switch (settings)
		return v:true
	elseif action == 'horizontal_split'
		let settings.target = 'horizontal_split'
		call wheel#line#switch (settings)
		return v:true
	elseif action == 'vertical_split'
		let settings.target = 'vertical_split'
		call wheel#line#switch (settings)
		return v:true
	elseif action == 'horizontal_golden'
		let settings.target = 'horizontal_golden'
		call wheel#line#switch (settings)
		return v:true
	elseif action == 'vertical_golden'
		let settings.target = 'vertical_golden'
		call wheel#line#switch (settings)
		return v:true
	endif
	return v:false
endfun

fun! wheel#boomerang#grep (action)
	" Grep actions
	let action = a:action
	if wheel#boomerang#switch (action)
		return
	endif
	if action == 'quickfix'
		call wheel#mandala#close ()
		call wheel#vector#copen ()
	endif
endfun