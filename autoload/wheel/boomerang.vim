" vim: ft=vim fdm=indent:

" Context menus,
" acting back on a wheel buffer

fun! wheel#boomerang#menu (dictname)
	" Context menu
	let dictname = 'context/' . a:dictname
	" Close = 0 by default, to be able to catch wheel buffer variables
	let settings = {'menu' : dictname, 'close' : 0, 'travel' : 0, 'deselect' : 0}
	call wheel#layer#staircase(settings)
endfun

fun! wheel#boomerang#common ()
	" Common things to all actions
	let stack = b:wheel_stack
	" Sync selection with top of stack
	if ! empty(stack.selected)
		let b:wheel_selected = stack.selected[0]
	endif
	" Sync settings with top of stack
	if ! empty(stack.settings)
		let b:wheel_settings = stack.settings[0]
	endif
	" Let wheel#overlay#call handle open / close
	let b:wheel_settings.close = 0
endfun

fun! wheel#boomerang#switch (action)
	" Switch actions
	call wheel#boomerang#common ()
	let action = a:action
	let settings = b:wheel_settings
	if action == 'current'
		let settings.target = 'current'
		call wheel#line#switch (settings)
	elseif action == 'horizontal_split'
		let settings.target = 'horizontal_split'
		call wheel#line#switch (settings)
	elseif action == 'vertical_split'
		let settings.target = 'vertical_split'
		call wheel#line#switch (settings)
	elseif action == 'horizontal_golden'
		let settings.target = 'horizontal_golden'
		call wheel#line#switch (settings)
	elseif action == 'vertical_golden'
		let settings.target = 'vertical_golden'
		call wheel#line#switch (settings)
	endif
endfun

fun! wheel#boomerang#grep (action)
	" Grep actions
endfun
