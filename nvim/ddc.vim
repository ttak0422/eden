" let s:sourceOptions['node-modules'] = #{
"       \ mark: '[NODE]',
"       \ isVolatile: v:true,
"       \ minAutoCompleteLength: 10000,
"       \ forceCompletionPattern:
"       \   '(?:'
"       \     . '\bimport|'
"       \     . '\bfrom|'
"       \     . '\brequire\s*\(|'
"       \     . '\bresolve\s*\(|'
"       \     . '\bimport\s*\('
"       \   . ')'
"       \   . '\s*(?:''|"|`)[^''"`]*',
"       \ }
" let s:sourceParams['node-modules'] = #{
"       \ cwdMaxItems: 0,
"       \ bufMaxItems: 0,
"       \ followSymlinks: v:true,
"       \ projMarkers: ['node_modules'],
"       \ projFromCwdMaxItems: [],
"       \ projFromBufMaxItems: [1000, 1000, 1000],
"       \ beforeResolve: 'node_modules',
"       \ displayBuf: '',
"       \ }

call ddc#custom#load_config(s:args['ts_config'])

" for Vim
call ddc#custom#patch_filetype(['vim'], #{
      \ sources: ['necovim', 'around'],
      \ })
" for node
" call ddc#custom#patch_filetype(
"       \ [
"       \   'javascript',
"       \   'typescript',
"       \   'javascriptreact',
"       \   'typescriptreact',
"       \   'tsx',
"       \ ], #{
"       \ sources: extend(s:sources, ['node-modules'])
"       \ })
" for fine-cmdline
" call ddc#custom#patch_filetype(['FineCmdlinePrompt'], #{
"       \   keywordPattern: '[0-9a-zA-Z_:#]*',
"       \   sources: ['necovim', 'cmdline', 'cmdline-history', 'file', 'around'],
"       \   specialBufferCompletion: v:true,
"       \ })

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
