" vim: ft=vim fdm=indent:

" Layers stack on wheel buffers

" Script vars

if ! exists('s:selected_mark')
	let s:selected_mark = wheel#crystal#fetch('selected/mark')
	lockvar s:selected_mark
endif

if ! exists('s:selected_pattern')
	let s:selected_pattern = wheel#crystal#fetch('selected/pattern')
	lockvar s:selected_pattern
endif

" Stack

fun! wheel#layer#push ()
	" Push buffer content to the stack
	" Save modified local maps
	if ! exists('b:wheel_stack')
		let b:wheel_stack = {}
		let b:wheel_stack.full = []
		let b:wheel_stack.current = []
		let b:wheel_stack.positions = []
		let b:wheel_stack.selected = []
		let b:wheel_stack.settings = []
		let b:wheel_stack.mappings = []
	endif
	let stack = b:wheel_stack
	" Full content, without filtering
	let full = stack.full
	if ! exists('b:wheel_lines') || empty(b:wheel_lines)
		let lines = getline(2, '$')
	else
		let lines = b:wheel_lines
	endif
	call insert(full, lines)
	" Current content
	let current = stack.current
	let now = getline(1, '$')
	call insert(current, now)
	" Position
	let positions = stack.positions
	call insert(positions, getcurpos())
	" Selected lines
	let selected = stack.selected
	if ! exists('b:wheel_selected')
		let b:wheel_selected = []
	endif
	call insert(selected, b:wheel_selected)
	" Buffer settings
	let settings = stack.settings
	if exists('b:wheel_settings')
		call insert(settings, b:wheel_settings)
	else
		call insert(settings, {})
	endif
	" Map stack
	let mappings = stack.mappings
	let enter = maparg('<enter>', 'n')
	let g_enter = maparg('g<enter>', 'n')
	let space = maparg('<space>', 'n')
	let tab = maparg('<tab>', 'n')
	let mapdict = {
				\ 'enter': enter,
				\ 'g_enter': g_enter,
				\ 'space' : space,
				\ 'tab' : tab,
				\}
	call insert(mappings, mapdict)
	" Reset buffer variables
	" Fresh filter and so on
	call wheel#void#lighten('buffer')
endfun

fun! wheel#layer#pop ()
	" Pop buffer content from the stack
	" Restore modified local maps
	if ! exists('b:wheel_stack')
		return
	endif
	let stack = b:wheel_stack
	" Full content, without filtering
	let full = stack.full
	if empty(full) || empty(full[0])
		return
	endif
	let b:wheel_lines = wheel#chain#pop (full)
	" Current content
	let current = stack.current
	let now = wheel#chain#pop (current)
	call wheel#mandala#replace (now, 'delete')
	" Restore cursor position
	let positions = stack.positions
	let pos = wheel#chain#pop (positions)
	call wheel#gear#restore_cursor (pos)
	" Restore settings
	let settings = stack.settings
	let b:wheel_settings = wheel#chain#pop (settings)
	" Restore mappings
	let mappings = stack.mappings
	if ! empty(mappings)
		let mapdict = wheel#chain#pop (mappings)
		if ! empty(mapdict.enter)
			exe 'nnoremap <buffer> <cr> ' . mapdict.enter
		endif
		if ! empty(mapdict.g_enter)
			exe 'nnoremap <buffer> g<cr> ' . mapdict.g_enter
		endif
		if ! empty(mapdict.space)
			exe 'nnoremap <buffer> <space> ' . mapdict.space
		endif
		if ! empty(mapdict.tab)
			exe 'nnoremap <buffer> <tab> ' . mapdict.tab
		endif
	endif
	" Restore selection
	let selected = stack.selected
	let b:wheel_selected = wheel#chain#pop(selected)
	"call wheel#line#sync_select ()
endfun

fun! wheel#layer#call (settings)
	" Calls function whose value is given by the key on cursor line
	" settings is a dictionary, whose keys can be :
	" - dict : name of a dictionary variable in storage.vim
	" - close : whether to close wheel buffer
	" - travel : whether to apply action in previous buffer
	let settings = a:settings
	let dict = wheel#crystal#fetch (settings.linefun)
	let close = settings.close
	let travel = settings.travel
	" Cursor line
	let cursor_line = getline('.')
	let cursor_line = substitute(cursor_line, s:selected_pattern, '', '')
	if empty(cursor_line)
		echomsg 'Wheel layer call : you selected an empty line'
		return
	endif
	let key = cursor_line
	if ! has_key(dict, key)
		normal! zv
		echomsg 'Wheel layer call : key not found'
		return
	endif
	" Close & travel
	if close
		call wheel#mandala#close ()
	elseif travel
		let mandala = win_getid()
		wincmd p
	endif
	" Call
	let value = dict[key]
	if value =~ '\m)'
		exe 'call ' . value
	else
		call {value}()
	endif
	" Goto mandala if needed
	if ! close && travel
		call win_gotoid (mandala)
	endif
endfun

fun! wheel#layer#overlay (settings)
	" Define local maps for overlay
	let settings = a:settings
	let map  =  'nnoremap <buffer> '
	let pre  = ' :call wheel#layer#call('
	let post = ')<cr>'
	" Open / Close : default in settings
	exe map . '<cr>' . pre . string(settings) . post
	" Open
	let settings.close = 0
	exe map . 'g<cr>' . pre . string(settings) . post
	exe map . '<space>' . pre . string(settings) . post
	" Go back
	nnoremap <buffer> <backspace> :call wheel#layer#pop ()<cr>
endfun

fun! wheel#layer#staircase (settings)
	" Replace buffer content by a {line -> fun} layer
	" Reuse current wheel buffer
	" Define dict maps
	let settings = a:settings
	let dictname = settings.linefun
	call wheel#layer#push ()
	let dict = wheel#crystal#fetch (dictname)
	let lines = sort(keys(dict))
	call wheel#mandala#replace (lines, 'blank')
	call wheel#layer#overlay (settings)
	let b:wheel_settings = settings
	call cursor(1, 1)
endfun
