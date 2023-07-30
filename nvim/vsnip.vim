imap <expr> <C-k> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-k>'
smap <expr> <C-k> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-k>'
imap <expr> <C-l> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-l>'
smap <expr> <C-l> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-l>'
