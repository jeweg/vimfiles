if exists('g:loaded_plugin_quickdoc')
    finish
endif
let g:loaded_plugin_quickdoc = 1

if !has('python')
    echohl WarningMsg | echom "quickdoc unavaiable: requires Vim compiled with +python 2.x support" | echohl None
    finish
endif

command! QuickDocQt call quickdoc#qt()
command! QuickDocCMake call quickdoc#cmake()

if !exists('g:quickdoc_map_keys')
    let g:quickdoc_map_keys = 1
endif
if !exists('g:quickdoc_map_prefix')
    let g:quickdoc_map_prefix = '<leader>q'
endif

if g:quickdoc_map_keys
    execute "nnoremap <silent> ".g:quickdoc_map_prefix."q :QuickDocQt<cr>"
    execute "nnoremap <silent> ".g:quickdoc_map_prefix."c :QuickDocCMake<cr>"
endif

