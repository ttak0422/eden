call ddc#custom#load_config(s:args['ts_config'])

" for Vim
call ddc#custom#patch_filetype(['vim'], #{ sources: ['necovim', 'around'] })

call ddc#enable(#{ context_filetype: 'treesitter' })

call signature_help#enable()
call popup_preview#enable()

inoremap <silent> <C-x>      <Cmd>call ddc#map#manual_complete()<CR>
inoremap <silent> <C-x><C-x> <Cmd>call ddc#map#manual_complete()<CR>
inoremap <silent> <C-x><C-b> <Cmd>call ddc#map#manual_complete(#{ sources: ['buffer'] })<CR>
inoremap <silent> <C-x><C-f> <Cmd>call ddc#map#manual_complete(#{ sources: ['file'] })<CR>
inoremap <silent> <C-x><C-t> <Cmd>call ddc#map#manual_complete(#{ sources: ['tmux'] })<CR>
inoremap <silent> <C-x><C-l> <Cmd>call ddc#map#manual_complete(#{ sources: ['nvim-lsp'] })<CR>

" for Obsidian
function! s:obsidian() abort
  call ddc#custom#patch_buffer('sources', ['nvim-obsidian', 'around', 'nvim-obsidian-new'])
endfunction
autocmd BufEnter,BufNewFile **/vault/**/*.md call s:obsidian()
autocmd BufEnter,BufNewFile **/vault/*.md call s:obsidian()

function! CommandlinePre() abort
  autocmd User DDCCmdlineLeave ++once call CommandlinePost()
  call ddc#enable_cmdline_completion()
endfunction
function! CommandlinePost() abort
endfunction

nnoremap <expr> : '<Cmd>call CommandlinePre()<CR>: '
nnoremap  ? <Cmd>call CommandlinePre()<CR>?
nnoremap  / <Cmd>call CommandlinePre()<CR>/
