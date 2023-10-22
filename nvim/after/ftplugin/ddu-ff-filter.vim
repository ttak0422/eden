inoremap <buffer><silent> <CR>  <ESC><Cmd>call ddu#ui#do_action('itemAction')<CR>
inoremap <buffer><silent> <ESC> <ESC><Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
inoremap <buffer><silent> <C-c> <Cmd>call ddu#ui#do_action('quit')<CR>
inoremap <buffer><silent> <C-n> <Cmd>call ddu#ui#do_action('cursorNext', #{ loop: v:true })<CR>
inoremap <buffer><silent> <C-p> <Cmd>call ddu#ui#do_action('cursorPrevious', #{ loop: v:true })<CR>

nnoremap <buffer><silent> <ESC> <Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
nnoremap <buffer><silent> <C-n> <Cmd>call ddu#ui#do_action('cursorNext', #{ loop: v:true })<CR>
nnoremap <buffer><silent> <C-p> <Cmd>call ddu#ui#do_action('cursorPrevious', #{ loop: v:true })<CR>
