function! GinaOpenRev() abort
  let can = gina#action#candidates()
  let url = system(printf('%s %s', 'getpr', can[0].rev))->trim()
  let cmd = printf('Gina browse --exact %s:%%', can[0].rev)
  execute cmd
endfunction

call gina#custom#mapping#nmap(
      \ 'blame', '<C-o>',
      \ ':<C-u>call GinaOpenRev()<CR>',
      \ {'silent': 1},
      \)
