(local marks (require :marks))

(marks.setup {:default_mappings true
              :cyclic true
              :force_write_shada false
              :refresh_interval 500
              :sign_priority {:lower 10 :upper 15 :builtin 8 :bookmark 20}})
