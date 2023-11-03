(local cache-path (vim.fn.stdpath :cache))

(let [o vim.o]
  (tset o :helplang :ja)
  (tset o :mouse :a)
  (tset o :ignorecase true)
  (tset o :smartcase true)
  (tset o :hlsearch true)
  (tset o :incsearch true)
  (tset o :hidden true)
  (tset o :termguicolors true)
  (tset o :showmode false)
  (tset o :autoread true)
  (tset o :showmatch true)
  (tset o :startofline false)
  (tset o :completeopt "menu,menuone,noinsert")
  (tset o :number true)
  (tset o :signcolumn :yes)
  (tset o :virtualedit :block)
  (tset o :cmdheight 0)
  (tset o :laststatus 3)
  (tset o :undofile true)
  (tset o :undodir (.. cache-path :/undo))
  (tset o :swapfile true)
  (tset o :directory (.. cache-path :/swap))
  (tset o :winwidth 20)
  (tset o :winminwidth 20)
  (tset o :expandtab true)
  (tset o :tabstop 2)
  (tset o :shiftwidth 2)
  (tset o :foldlevel 99)
  (tset o :foldlevelstart 99)
  ;; update inode for emanote})
  (tset o :backup true)
  (tset o :backupcopy :yes)
  (tset o :backupdir (.. cache-path :/backup))
  (tset o :diffopt "internal,filler,closeoff,vertical"))
