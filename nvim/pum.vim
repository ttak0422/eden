set pumblend=12

call pum#set_option(#{
      \ padding: v:true,
      \ item_orders: ["abbr", "kind", "menu"],
      \ scrollbar_char: '',
      \ max_height: 20,
      \ use_complete: v:true,
      \ use_setline: v:false,
      \ })

inoremap <silent><expr> <C-n> pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' : '<Tab>'
inoremap <silent><expr> <C-p> pum#visible() ? '<Cmd>call pum#map#select_relative(-1)<CR>' : '<C-p>'
inoremap <silent><expr> <C-e> pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : '<C-e>'
inoremap <C-y> <Cmd>call pum#map#confirm()<CR>

cnoremap <expr> <C-n> pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' : '<C-n>'
cnoremap <expr> <C-p> pum#visible() ? '<Cmd>call pum#map#select_relative(-1)<CR>' : '<C-p>'
cnoremap <expr> <C-e> pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : '<C-e>'
cnoremap <silent><expr> <C-y> pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<C-y>'
