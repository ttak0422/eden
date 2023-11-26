(let [bufresize (require :bufresize)
      register {:keys [] :trigger_events [:BufWinEnter :WinEnter]}
      resize {:keys [] :trigger_events [:VimResized] :increment false}]
  (bufresize.setup {: register : resize}))
