(let [main (require :conjure.main)
      mapping (require :conjure.mapping)]
  (main.main)
  ((. mapping :on-filetype))
  nil)
