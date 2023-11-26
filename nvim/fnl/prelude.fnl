(local cache-path (vim.fn.stdpath :cache))

(each [k v (pairs {:helplang :ja
                   :mouse :a
                   :ignorecase true
                   :smartcase true
                   :hlsearch true
                   :incsearch true
                   :hidden true
                   :termguicolors true
                   :showmode false
                   :autoread true
                   :showmatch true
                   :startofline false
                   :completeopt "menu,menuone,noinsert"
                   :number true
                   :signcolumn :yes
                   :virtualedit :block
                   :cmdheight 0
                   :laststatus 3
                   :undofile true
                   :undodir (.. cache-path :/undo)
                   :swapfile true
                   :directory (.. cache-path :/swap)
                   :winwidth 20
                   :winminwidth 20
                   :expandtab true
                   :tabstop 2
                   :shiftwidth 2
                   :foldlevel 99
                   :foldlevelstart 99
                   :equalalways false
                   ;; update inode for emanote
                   :backup true
                   :backupcopy :yes
                   :backupdir (.. cache-path :/backup)
                   :diffopt "internal,filler,closeoff,vertical"})]
  (tset vim.o k v))
