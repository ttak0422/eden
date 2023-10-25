setlocal cursorline

nnoremap <buffer><silent> i <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
nnoremap <buffer><silent> q <Cmd>call ddu#ui#do_action('quit')<CR>
nnoremap <buffer><silent> <C-c> <Cmd>call ddu#ui#do_action('quit')<CR>
nnoremap <buffer><silent> <CR> <Cmd>call ddu#ui#do_action('itemAction')<CR>
