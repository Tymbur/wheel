" vim: ft=vim fdm=indent:

" Command, Mappings

fun! wheel#centre#commands ()
	" Define commands
	" Status
	command! WheelDashboard call wheel#status#dashboard()
	command! -nargs=+ WheelBatch call wheel#vector#argdo(<q-args>)
endfun

fun! wheel#centre#plugs ()
	" Define <plug> mappings
	let prefix = g:wheel_config.prefix
	" Menus
	nnoremap <plug>(wheel-menu-main) :call wheel#hub#main()<cr>
	nnoremap <plug>(wheel-menu-meta) :call wheel#hub#meta()<cr>
	" Add
	nnoremap <plug>(wheel-add-here) :call wheel#tree#add_here()<cr>
	nnoremap <plug>(wheel-add-circle) :call wheel#tree#add_circle()<cr>
	nnoremap <plug>(wheel-add-torus) :call wheel#tree#add_torus()<cr>
	nnoremap <plug>(wheel-add-file) :call wheel#tree#add_file()<cr>
	nnoremap <plug>(wheel-add-buffer) :call wheel#tree#add_buffer()<cr>
	" Rename
	nnoremap <plug>(wheel-rename-location) :call wheel#tree#rename('location')<cr>
	nnoremap <plug>(wheel-rename-circle) :call wheel#tree#rename('circle')<cr>
	nnoremap <plug>(wheel-rename-torus) :call wheel#tree#rename('torus')<cr>
	nnoremap <plug>(wheel-rename-file) :call wheel#tree#rename_file()<cr>
	" Delete
	nnoremap <plug>(wheel-delete-location) :call wheel#tree#delete('location')<cr>
	nnoremap <plug>(wheel-delete-circle) :call wheel#tree#delete('circle')<cr>
	nnoremap <plug>(wheel-delete-torus) :call wheel#tree#delete('torus')<cr>
	" Load / Save wheel
	nnoremap <plug>(wheel-read-all) :call wheel#disc#read_all()<cr>
	nnoremap <plug>(wheel-write-all) :call wheel#disc#write_all()<cr>
	" Next / Previous
	nnoremap <plug>(wheel-previous-location) :call wheel#vortex#previous('location')<cr>
	nnoremap <plug>(wheel-next-location) :call wheel#vortex#next('location')<cr>
	nnoremap <plug>(wheel-previous-circle) :call wheel#vortex#previous('circle')<cr>
	nnoremap <plug>(wheel-next-circle) :call wheel#vortex#next('circle')<cr>
	nnoremap <plug>(wheel-previous-torus) :call wheel#vortex#previous('torus')<cr>
	nnoremap <plug>(wheel-next-torus) :call wheel#vortex#next('torus')<cr>
	" Switch
	nnoremap <plug>(wheel-switch-location) :call wheel#vortex#switch('location')<cr>
	nnoremap <plug>(wheel-switch-circle) :call wheel#vortex#switch('circle')<cr>
	nnoremap <plug>(wheel-switch-torus) :call wheel#vortex#switch('torus')<cr>
	" History
	nnoremap <plug>(wheel-history-newer) :call wheel#pendulum#newer()<cr>
	nnoremap <plug>(wheel-history-older) :call wheel#pendulum#older()<cr>
	" Alternate
	nnoremap <plug>(wheel-alternate) :call wheel#pendulum#alternate()<cr>
	nnoremap <plug>(wheel-alternate-same-torus-other-circle) :call wheel#pendulum#alternate_same_torus_other_circle()<cr>
	nnoremap <plug>(wheel-alternate-same-torus) :call wheel#pendulum#alternate_same_torus()<cr>
	nnoremap <plug>(wheel-alternate-same-circle) :call wheel#pendulum#alternate_same_circle()<cr>
	nnoremap <plug>(wheel-alternate-other-torus) :call wheel#pendulum#alternate_other_torus()<cr>
	nnoremap <plug>(wheel-alternate-other-circle) :call wheel#pendulum#alternate_other_circle()<cr>
	" Navigation
	nnoremap <plug>(wheel-navigation-location) :call wheel#sailing#switch('location')<cr>
	nnoremap <plug>(wheel-navigation-circle) :call wheel#sailing#switch('circle')<cr>
	nnoremap <plug>(wheel-navigation-torus) :call wheel#sailing#switch('torus')<cr>
	" Indexes
	nnoremap <plug>(wheel-index-locations) :call wheel#sailing#helix()<cr>
	nnoremap <plug>(wheel-index-circles) :call wheel#sailing#grid()<cr>
	nnoremap <plug>(wheel-tree) :call wheel#sailing#tree()<cr>
	"History
	nnoremap <plug>(wheel-history) :call wheel#sailing#history()<cr>
	" Search inside files
	nnoremap <plug>(wheel-occur) :call wheel#sailing#occur()<cr>
	nnoremap <plug>(wheel-grep) :call wheel#sailing#grep()<cr>
	nnoremap <plug>(wheel-outline) :call wheel#sailing#outline()<cr>
	nnoremap <plug>(wheel-tags) :call wheel#sailing#tags()<cr>
	" Jumps & Changes lists
	nnoremap <plug>(wheel-jumps) :call wheel#sailing#jumps()<cr>
	nnoremap <plug>(wheel-changes) :call wheel#sailing#changes()<cr>
	" Search for files
	nnoremap <plug>(wheel-mru) :call wheel#sailing#mru()<cr>
	nnoremap <plug>(wheel-locate) :call wheel#sailing#locate()<cr>
	nnoremap <plug>(wheel-find) :call wheel#sailing#find()<cr>
	" Batch
	nnoremap <plug>(wheel-batch) :call wheel#vector#batch()<cr>
	" Reorder
	nnoremap <plug>(wheel-reorder-location) :call wheel#shape#reorder('location')<cr>
	nnoremap <plug>(wheel-reorder-circle) :call wheel#shape#reorder('circle')<cr>
	nnoremap <plug>(wheel-reorder-torus) :call wheel#shape#reorder('torus')<cr>
	" Reorganize
	nnoremap <plug>(wheel-reorganize) :call wheel#shape#reorganize()<cr>
	" Yank wheel
	nnoremap <plug>(wheel-yank-list) :call wheel#clipper#yank('list')<cr>
	nnoremap <plug>(wheel-yank-plain) :call wheel#clipper#yank('plain')<cr>
	" Save (push) wheel buffer
	nnoremap <plug>(wheel-buffer-push) :call wheel#cylinder#push()<cr>
	" Remove (pop) wheel buffer
	nnoremap <plug>(wheel-buffer-pop) :call wheel#cylinder#pop()<cr>
	" Cycle wheel buffers
	nnoremap <plug>(wheel-buffer-cycle) :call wheel#cylinder#cycle()<cr>
	" Tabs
	nnoremap <plug>(wheel-tabs-locations) :call wheel#mosaic#tabs('location')<cr>
	nnoremap <plug>(wheel-tabs-circles) :call wheel#mosaic#tabs('circle')<cr>
	nnoremap <plug>(wheel-tabs-toruses) :call wheel#mosaic#tabs('torus')<cr>
	" Windows
	nnoremap <plug>(wheel-split-locations) :call wheel#mosaic#split('location')<cr>
	nnoremap <plug>(wheel-split-circles) :call wheel#mosaic#split('circle')<cr>
	nnoremap <plug>(wheel-split-toruses) :call wheel#mosaic#split('torus')<cr>
	nnoremap <plug>(wheel-vsplit-locations) :call wheel#mosaic#split('location', 'vertical')<cr>
	nnoremap <plug>(wheel-vsplit-circles) :call wheel#mosaic#split('circle', 'vertical')<cr>
	nnoremap <plug>(wheel-vsplit-toruses) :call wheel#mosaic#split('torus', 'vertical')<cr>
	nnoremap <plug>(wheel-mainleft-locations) :call wheel#mosaic#split('location', 'main_left')<cr>
	nnoremap <plug>(wheel-mainleft-circles) :call wheel#mosaic#split('circle', 'main_left')<cr>
	nnoremap <plug>(wheel-mainleft-toruses) :call wheel#mosaic#split('torus', 'main_left')<cr>
	nnoremap <plug>(wheel-grid-locations) :call wheel#mosaic#split_grid('location')<cr>
	nnoremap <plug>(wheel-grid-circles) :call wheel#mosaic#split_grid('circle')<cr>
	nnoremap <plug>(wheel-grid-toruses) :call wheel#mosaic#split_grid('torus')<cr>
	" Rotating windows
	nnoremap <plug>(wheel-rotate-counter-clockwise) :call wheel#mosaic#rotate_counter_clockwise()<cr>
	nnoremap <plug>(wheel-rotate-clockwise) :call wheel#mosaic#rotate_clockwise()<cr>
	" Tabs & Windows
	nnoremap <plug>(wheel-zoom) :call wheel#mosaic#zoom()<cr>
	nnoremap <plug>(wheel-tabnwin-torus) :call wheel#pyramid#steps('torus')<cr>
	nnoremap <plug>(wheel-tabnwin-circle) :call wheel#pyramid#steps('circle')<cr>
	" Debug
	nnoremap <plug>(wheel-debug-fresh-wheel) :call wheel#void#fresh_wheel()<cr>
	" Misc
	" To use in custom maps, e.g. :
	" nmap <silent> <c-l> :nohl<cr><plug>(wheel-spiral-cursor)
	" imap <silent> <c-l> <esc>:nohl<cr><plug>(wheel-spiral-cursor)a
	nnoremap <plug>(wheel-spiral-cursor) :call wheel#spiral#cursor()<cr>
endfun

fun! wheel#centre#cables ()
	" Link <plug> mappings to keys
	let prefix = g:wheel_config.prefix
	" Basic
	if g:wheel_config.mappings >= 0
		" Menus
		exe 'nmap ' . prefix . 'm <plug>(wheel-menu-main)'
		exe 'nmap ' . prefix . '= <plug>(wheel-menu-meta)'
		" Add
		exe 'nmap ' . prefix . 'a <plug>(wheel-add-here)'
		exe 'nmap ' . prefix . '<c-a> <plug>(wheel-add-circle)'
		exe 'nmap ' . prefix . 'A <plug>(wheel-add-torus)'
		exe 'nmap ' . prefix . 'f <plug>(wheel-add-file)'
		exe 'nmap ' . prefix . 'b <plug>(wheel-add-buffer)'
		" Next / Previous
		exe 'nmap ' . prefix . '<left> <plug>(wheel-previous-location)'
		exe 'nmap ' . prefix . '<right> <plug>(wheel-next-location)'
		exe 'nmap ' . prefix . '<c-left> <plug>(wheel-previous-circle)'
		exe 'nmap ' . prefix . '<c-right> <plug>(wheel-next-circle)'
		exe 'nmap ' . prefix . '<s-left> <plug>(wheel-previous-torus)'
		exe 'nmap ' . prefix . '<s-right> <plug>(wheel-next-torus)'
		" Load / Save wheel
		exe 'nmap ' . prefix . 'r <plug>(wheel-read-all)'
		exe 'nmap ' . prefix . 'w <plug>(wheel-write-all)'
	endif
	" Common
	if g:wheel_config.mappings >= 1
		" Navigation
		exe 'nmap ' . prefix . '<space> <plug>(wheel-navigation-location)'
		exe 'nmap ' . prefix . '<c-space> <plug>(wheel-navigation-circle)'
		exe 'nmap ' . prefix . '<s-space> <plug>(wheel-navigation-torus)'
		" Indexes
		exe 'nmap ' . prefix . 'x <plug>(wheel-index-locations)'
		exe 'nmap ' . prefix . '<c-x> <plug>(wheel-index-circles)'
		exe 'nmap ' . prefix . '<m-x> <plug>(wheel-tree)'
		"History
		exe 'nmap ' . prefix . 'h <plug>(wheel-history)'
		" Reorder
		exe 'nmap ' . prefix . 'o <plug>(wheel-reorder-location)'
		exe 'nmap ' . prefix . '<C-o> <plug>(wheel-reorder-circle)'
		exe 'nmap ' . prefix . 'O <plug>(wheel-reorder-torus)'
		" Rename
		exe 'nmap ' . prefix . 'n <plug>(wheel-rename-location)'
		exe 'nmap ' . prefix . '<c-n> <plug>(wheel-rename-circle)'
		exe 'nmap ' . prefix . 'N <plug>(wheel-rename-torus)'
		exe 'nmap ' . prefix . '<m-n> <plug>(wheel-rename-file)'
		" Delete
		exe 'nmap ' . prefix . 'd <plug>(wheel-delete-location)'
		exe 'nmap ' . prefix . '<c-d> <plug>(wheel-delete-circle)'
		exe 'nmap ' . prefix . 'D <plug>(wheel-delete-torus)'
		" Switch
		exe 'nmap ' . prefix . '<cr> <plug>(wheel-switch-location)'
		exe 'nmap ' . prefix . '<c-cr> <plug>(wheel-switch-circle)'
		exe 'nmap ' . prefix . '<s-cr> <plug>(wheel-switch-torus)'
		" History
		exe 'nmap ' . prefix . '<pageup> <plug>(wheel-history-newer)'
		exe 'nmap ' . prefix . '<pagedown> <plug>(wheel-history-older)'
		exe 'nmap ' . prefix . '^ <plug>(wheel-history-alternate)'
	endif
	" Advanced
	if g:wheel_config.mappings >= 2
		" Search inside files
		exe 'nmap ' . prefix . ': <plug>(wheel-occur)'
		exe 'nmap ' . prefix . '* <plug>(wheel-grep)'
		exe 'nmap ' . prefix . '# <plug>(wheel-outline)'
		exe 'nmap ' . prefix . '% <plug>(wheel-tags)'
		exe 'nmap ' . prefix . 'j <plug>(wheel-jumps)'
		exe 'nmap ' . prefix . 'c <plug>(wheel-changes)'
		" Search for files
		exe 'nmap ' . prefix . '? <plug>(wheel-mru)'
		exe 'nmap ' . prefix . '/ <plug>(wheel-locate)'
		exe 'nmap ' . prefix . '& <plug>(wheel-find)'
		" Batch
		exe 'nmap ' . prefix . '<m-b> <plug>(wheel-batch)'
		" Yank wheel
		exe 'nmap ' . prefix . 'y <plug>(wheel-yank-list)'
		exe 'nmap ' . prefix . '<m-y> <plug>(wheel-yank-plain)'
		" Reorganize
		exe 'nmap ' . prefix . '<m-o> <plug>(wheel-reorganize)'
		" Save (push) wheel buffer
		exe 'nmap ' . prefix . '<tab> <plug>(wheel-buffer-push)'
		" Remove (pop) wheel buffer
		exe 'nmap ' . prefix . '<backspace> <plug>(wheel-buffer-pop)'
		" Cycle wheel buffers
		exe 'nmap ' . prefix . '@ <plug>(wheel-buffer-cycle)'
		" Tabs
		exe 'nmap ' . prefix . 't <plug>(wheel-tabs-locations)'
		exe 'nmap ' . prefix . '<c-t> <plug>(wheel-tabs-circles)'
		exe 'nmap ' . prefix . 'T <plug>(wheel-tabs-toruses)'
		" Windows
		exe 'nmap ' . prefix . 's <plug>(wheel-split-locations)'
		exe 'nmap ' . prefix . '<c-s> <plug>(wheel-split-circles)'
		exe 'nmap ' . prefix . 'S <plug>(wheel-split-toruses)'
		exe 'nmap ' . prefix . 'v <plug>(wheel-vsplit-locations)'
		exe 'nmap ' . prefix . '<c-v> <plug>(wheel-vsplit-circles)'
		exe 'nmap ' . prefix . 'V <plug>(wheel-vsplit-toruses)'
		exe 'nmap ' . prefix . 'l <plug>(wheel-mainleft-locations)'
		exe 'nmap ' . prefix . '<c-l> <plug>(wheel-mainleft-circles)'
		exe 'nmap ' . prefix . 'L <plug>(wheel-mainleft-toruses)'
		exe 'nmap ' . prefix . 'g <plug>(wheel-grid-locations)'
		exe 'nmap ' . prefix . '<c-g> <plug>(wheel-grid-circles)'
		exe 'nmap ' . prefix . 'G <plug>(wheel-grid-toruses)'
		" Rotating windows
		exe 'nmap ' . prefix . '<up> <plug>(wheel-rotate-counter-clockwise)'
		exe 'nmap ' . prefix . '<down> <plug>(wheel-rotate-clockwise)'
		" Tabs & Windows
		exe 'nmap ' . prefix . 'z <plug>(wheel-zoom)'
		exe 'nmap ' . prefix . 'P <plug>(wheel-tabnwin-torus)'
		exe 'nmap ' . prefix . '<c-p> <plug>(wheel-tabnwin-circle)'
	endif
	" Without prefix
	if g:wheel_config.mappings >= 10
		" Menus
		nmap <M-m>        <plug>(wheel-menu-main)
		nmap <M-=>        <plug>(wheel-menu-meta)
		" Add, Delete
		nmap <M-Insert>   <plug>(wheel-add-here)
		nmap <M-Del>      <plug>(wheel-delete-location)
		" Next / Previous
		nmap <C-PageUp>   <plug>(wheel-previous-location)
		nmap <C-PageDown> <plug>(wheel-next-location)
		nmap <C-Home>     <plug>(wheel-previous-circle)
		nmap <C-End>      <plug>(wheel-next-circle)
		nmap <S-Home>     <plug>(wheel-previous-torus)
		nmap <S-End>      <plug>(wheel-next-torus)
		" History
		nmap <S-PageUp>     <plug>(wheel-history-newer)
		nmap <S-PageDown>   <plug>(wheel-history-older)
		" Alternate
		nmap <C-^>          <plug>(wheel-alternate)
		nmap <D-^>          <plug>(wheel-alternate-same-torus-other-circle)
		nmap <C-S-PageUp>   <plug>(wheel-alternate-same-torus)
		nmap <C-S-PageDown> <plug>(wheel-alternate-same-circle)
		nmap <C-S-Home>     <plug>(wheel-alternate-other-torus)
		nmap <C-S-End>      <plug>(wheel-alternate-other-circle)
		" Navigation buffers
		nmap <Space>      <plug>(wheel-navigation-location)
		nmap <C-Space>    <plug>(wheel-navigation-circle)
		nmap <S-Space>    <plug>(wheel-navigation-torus)
		nmap <M-x>        <plug>(wheel-tree)
		nmap <D-x>        <plug>(wheel-index-locations)
		nmap <M-h>        <plug>(wheel-history)
		" Search inside files
		nmap <M-s>          <plug>(wheel-occur)
		nmap <M-g>          <plug>(wheel-grep)
		nmap <M-o>          <plug>(wheel-outline)
		nmap <M-t>          <plug>(wheel-tags)
		nmap <M-j>          <plug>(wheel-jumps)
		nmap <M-c>          <plug>(wheel-changes)
		" Search for files
		nmap <M-u>          <plug>(wheel-mru)
		nmap <M-l>          <plug>(wheel-locate)
		nmap <M-f>          <plug>(wheel-find)
		" Reshaping buffers
		nmap <M-r>          <plug>(wheel-reorganize)
		" Yank
		nmap <M-y>          <plug>(wheel-yank-list)
		nmap <M-p>          <plug>(wheel-yank-plain)
		" Batch
		nmap <M-b>          <plug>(wheel-batch)
		" Windows
		nmap <M-z>          <plug>(wheel-zoom)
		nmap <M-Home>       <plug>(wheel-tabs-locations)
		nmap <M-End>        <plug>(wheel-mainleft-locations)
		nmap <M-&>          <plug>(wheel-tabnwin-circle)
		" Rotate windows
		nmap <M-PageUp>     <plug>(wheel-rotate-counter-clockwise)
		nmap <M-PageDown>   <plug>(wheel-rotate-clockwise)
		" Save (push) wheel buffer
		nmap <M-Tab>        <plug>(wheel-buffer-push)
		" Remove (pop) wheel buffer
		nmap <M-Backspace>  <plug>(wheel-buffer-pop)
		" Cycle wheel buffers
		nmap <M-Space>      <plug>(wheel-buffer-cycle)
	endif
	" Debug
	if g:wheel_config.mappings >= 20
		exe 'nmap ' . prefix . 'Z <plug>(wheel-debug-fresh-wheel)'
	endif
endfun
