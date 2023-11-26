(let [bufresize (require :bufresize)
      register {:keys [] :trigger_events [:BufWinEnter :WinEnter :WinNew]}
      resize {:keys []
              :trigger_events [:VimResized :WinClosed]
              :increment false}]
  (bufresize.setup {: register : resize}))
