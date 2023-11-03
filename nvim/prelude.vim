" `-` を単語の一部として扱う
set iskeyword+=-
autocmd WinEnter * checktime
autocmd FileType * setlocal formatoptions-=r
autocmd FileType * setlocal formatoptions-=o
