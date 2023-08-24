set pumblend=11

call pum#set_option(#{
      \ padding: v:false,
      \ scrollbar_char: '',
      \ item_orders: ['abbr', 'space', 'kind', 'space', 'menu'],
      \ max_height: 20,
      \ use_complete: v:false,
      \ use_setline: v:true,
      \ offset_cmdcol: 0,
      \ preview: v:true,
      \ preview_border: 'single',
      \ preview_width: 120,
      \ })
inoremap <silent><expr> <C-n> pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' : ddc#map#manual_complete()
inoremap <silent><expr> <C-p> pum#visible() ? '<Cmd>call pum#map#select_relative(-1)<CR>' : ddc#map#manual_complete()
inoremap <silent><expr> <C-e> pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : '<C-e>'
inoremap <C-y> <Cmd>call pum#map#confirm()<CR>

cnoremap <expr> <C-n> pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' : '<C-n>'
cnoremap <expr> <C-p> pum#visible() ? '<Cmd>call pum#map#select_relative(-1)<CR>' : '<C-p>'
cnoremap <expr> <C-e> pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : '<C-e>'
cnoremap  <C-y> <Cmd>call pum#map#confirm()<CR>
