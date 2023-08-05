let s:sources = ['nvim-lsp', 'tsnip', 'vsnip', 'around']

let s:sourceOptions = {}
let s:sourceOptions._ = #{
      \ ignoreCase: v:true,
      \ matchers: [
      \   'matcher_fuzzy',
      \ ],
      \ sorters: ['sorter_fuzzy'],
      \ converters: [
      \   'converter_remove_overlap',
      \   'converter_truncate',
      \   'converter_fuzzy',
      \ ],
      \ dup: 'ignore',
      \ minKeywordLength: 2,
      \ }
let s:sourceOptions.around = #{
      \ mark: '[AROUND]',
      \ }
let s:sourceOptions.tsnip = #{
      \ mark: '[TSNIP]',
      \ sorters: ['sorter_rank'],
      \ }
let s:sourceOptions.vsnip = #{
      \ mark: '[VSNIP]',
      \ }
let s:sourceOptions.line= #{
      \ mark: '[LINE]',
      \ maxItems: 50,
      \ }
let s:sourceOptions.file = #{
      \ mark: '[FILE]',
      \ forceCompletionPattern: '\S/\S*',
      \ isVolatile: v:true,
      \ dup: 'ignore',
      \ }
let s:sourceOptions['node-modules'] = #{
      \ mark: '[NODE]',
      \ isVolatile: v:true,
      \ minAutoCompleteLength: 10000,
      \ forceCompletionPattern:
      \   '(?:'
      \     . '\bimport|'
      \     . '\bfrom|'
      \     . '\brequire\s*\(|'
      \     . '\bresolve\s*\(|'
      \     . '\bimport\s*\('
      \   . ')'
      \   . '\s*(?:''|"|`)[^''"`]*',
      \ }
let s:sourceOptions.buffer = #{
      \   mark: '[BUFF]',
      \ }
let s:sourceOptions.skkeleton = #{
      \ mark: '[SKK]',
      \ matchers: ['skkeleton'],
      \ isVolatile: v:true,
      \ sorters: [],
      \ }
let s:sourceOptions['nvim-lsp'] = #{
      \   mark: '[LSP]',
      \   keywordPattern: '\k+',
      \   dup: 'keep',
      \   forceCompletionPattern: '\.\w*|:\w*|->\w*',
      \   maxItems: 800,
      \   minKeywordLength: 0,
      \   sorters: ['sorter_lsp-kind', 'sorter_fuzzy'],
      \ }
let s:sourceOptions.tmux = #{
      \ mark: '[TMUX]',
      \ }
let s:sourceOptions.necovim = #{
      \ mark: '[VIM]',
      \ }
let s:sourceOptions.cmdline = #{
      \ mark: '[CMD]',
      \ }
let s:sourceOptions['cmdline-history'] = #{
      \ mark: '[HIST]',
      \ }
let s:sourceOptions['nvim-obsidian'] = #{
      \   mark: ' ',
      \ }
let s:sourceOptions['nvim-obsidian-new'] = #{
      \   mark: ' +',
      \ }

let s:sourceParams = {}
let s:sourceParams['nvim-lsp'] = #{
      \   snippetEngine: denops#callback#register({ body -> vsnip#anonymous(body) }),
      \   enableResolveItem: v:true,
      \   enableAdditionalTextEdit: v:true,
      \ }
" vsnip
" luasnip
" \   snippetEngine: denops#callback#register({ body -> luaeval('require("luasnip").lsp_expand(_A)', body)}),
" luasnip
let s:sourceParams.buffer = #{
      \   requireSameFiletype: v:true,
      \   limitBytes: 500000,
      \   fromAltBuf: v:true,
			\   forceCollect: v:true,
      \ }
let s:sourceParams.tmux = #{
      \ currentWinOnly: v:true,
      \ excludeCurrentPane: v:true,
      \ kindFormat: '#{pane_current_command}',
      \ }
let s:sourceParams.file = #{
      \   projAsRoot: v:false,
			\   cwdMaxItems: 0,
			\   projFromCwdMaxItems: [0],
			\   projFromBufMaxItems: [0],
      \   displayFile: '',
      \   displayDir: '',
      \   displaySym: '',
      \   displaySymFile: '',
      \   displaySymDir: '',
      \ }
let s:sourceParams['node-modules'] = #{
      \ cwdMaxItems: 0,
      \ bufMaxItems: 0,
      \ followSymlinks: v:true,
      \ projMarkers: ['node_modules'],
      \ projFromCwdMaxItems: [],
      \ projFromBufMaxItems: [1000, 1000, 1000],
      \ beforeResolve: 'node_modules',
      \ displayBuf: '',
      \ }
let s:sourceParams['nvim-obsidian'] = #{
      \   dir: '~/vault',
      \ }
let s:sourceParams['nvim-obsidian-new'] = #{
      \   dir: '~/vault',
      \ }

let s:filterParams = {}
" let s:filterParams.sorter_reverse = {}
let s:filterParams.converter_truncate = { 'maxAbbrWidth': 60, 'maxKindWidth': 10, 'maxMenuWidth': 40 }
let s:filterParams['sorter_lsp-kind'] = #{
      \ priority: [
      \   'Variable',
      \   ['Method', 'Function'],
      \   'Constructor',
      \   'Field',
      \   'Interface',
      \   ['Class', 'Module'],
      \   'Property',
      \   'Unit',
      \   'Value',
      \   'Enum',
      \   'Keyword',
      \   'Color',
      \   'File',
      \   'Reference',
      \   'Folder',
      \   'EnumMember',
      \   'Constant',
      \   'Struct',
      \   'Event',
      \   'Operator',
      \   'TypeParameter',
      \   'Text',
      \   'Snippet',
      \ ]}

let s:cmdlineSources = {
      \ ':': [ 'file', 'necovim', 'cmdline', 'cmdline-history', 'around' ],
      \ '@': [],
      \ '>': [],
      \ '/': [ 'around', 'line' ],
      \ '?': [ 'around', 'line' ],
      \ '-': [],
      \ '=': [ 'input' ],
      \ }

let s:patch_global = {}
let s:patch_global.ui = 'pum'
let s:patch_global.keywordPattern = '[0-9a-zA-Z]\k*'
" let s:patch_global.ui = 'native'
" let s:patch_global.autoCompleteDelay = 150
let s:patch_global.autoCompleteEvents = [ 'InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineChanged' ]

" let s:patch_global.autoCompleteDelay = 100
let s:patch_global.backspaceCompletion = v:true
let s:patch_global.sources = s:sources
let s:patch_global.sourceOptions = s:sourceOptions
let s:patch_global.sourceParams = s:sourceParams
let s:patch_global.filterParams = s:filterParams
let s:patch_global.cmdlineSources = s:cmdlineSources

call ddc#custom#alias('source', 'node-modules', 'file')
call ddc#custom#patch_global(s:patch_global)

" for Java
" call ddc#custom#patch_filetype(['java'], 'sourceOptions', #{
"       \ _: #{
"       \   sorters: ['sorter_lsp-kind', 'sorter_fuzzy'],
"       \ }})
call ddc#custom#patch_filetype(['java'], 'filterParams', #{
      \ sorter_itemsize: #{ sameWordOnly: v:true },
      \ })
      " \ converter_truncate: #{ maxAbbrWidth: 60, maxKindWidth: 10, maxMenuWidth: 0 },
" for Vim
call ddc#custom#patch_filetype(['vim'], #{
      \ sources: extend(['necovim'], s:sources),
      \ })
" for node
call ddc#custom#patch_filetype(
      \ [
      \   'javascript',
      \   'typescript',
      \   'javascriptreact',
      \   'typescriptreact',
      \   'tsx',
      \ ], #{
      \ sources: extend(s:sources, ['node-modules'])
      \ })
" for fine-cmdline
call ddc#custom#patch_filetype(['FineCmdlinePrompt'], #{
      \   keywordPattern: '[0-9a-zA-Z_:#]*',
      \   sources: ['necovim', 'cmdline', 'cmdline-history', 'file', 'around'],
      \   specialBufferCompletion: v:true,
      \ })

call ddc#enable(#{ context_filetype: 'treesitter' })
call signature_help#enable()
let g:popup_preview_config = #{
      \ maxWidth: 100,
      \ }
call popup_preview#enable()

inoremap <silent> <C-x>      <Cmd>call ddc#map#manual_complete()<CR>
inoremap <silent> <C-x><C-x> <Cmd>call ddc#map#manual_complete()<CR>
inoremap <silent> <C-x><C-b> <Cmd>call ddc#map#manual_complete(#{ sources: ['buffer'] })<CR>
inoremap <silent> <C-x><C-f> <Cmd>call ddc#map#manual_complete(#{ sources: ['file'] })<CR>
inoremap <silent> <C-x><C-t> <Cmd>call ddc#map#manual_complete(#{ sources: ['tmux'] })<CR>
inoremap <silent> <C-x><C-l> <Cmd>call ddc#map#manual_complete(#{ sources: ['nvim-lsp'] })<CR>

" for debug
" call ddc#custom#patch_global('sources', ['file'])

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

" lua << EOF
" vim.fn["denops#callback#register"](function(body)
" 	require('luasnip').lsp_expand(body)
" end)
" EOF
