(let [neogit (require :neogit)
      git_services {:github.com "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1"
                    :bitbucket.org "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1"
                    :gitlab.com "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}"}
      signs {:hunk ["" ""] :item ["" ""] :section ["" ""]}
      sections {:sequencer {:folded false :hidden false}
                :untracked {:folded false :hidden false}
                :unstaged {:folded false :hidden false}
                :staged {:folded false :hidden false}
                :stashes {:folded true :hidden false}
                :unpulled_upstream {:folded true :hidden false}
                :unmerged_upstream {:folded false :hidden false}
                :unpulled_pushRemote {:folded true :hidden false}
                :unmerged_pushRemote {:folded false :hidden false}
                :recent {:folded true :hidden false}
                :rebase {:folded true :hidden false}}
      ignored_settings [:NeogitPushPopup--force-with-lease
                        :NeogitPushPopup--force
                        :NeogitPullPopup--rebase
                        :NeogitLogPopup--
                        :NeogitCommitPopup--allow-empty
                        :NeogitRevertPopup--no-edit]
      integrations {:telescope nil :diffview true :fzf_lua nil} ;;
      ;; mappings
      commit_editor {:q :Close :<c-c><c-c> :Submit :<c-c><c-k> :Abort}
      rebase_editor {:p :Pick
                     :r :Reword
                     :e :Edit
                     :s :Squash
                     :f :Fixup
                     :x :Execute
                     :d :Drop
                     :b :Break
                     :q :Close
                     :<cr> :OpenCommit
                     :gk :MoveUp
                     :gj :MoveDown
                     :<c-c><c-c> :Submit
                     :<c-c><c-k> :Abort}
      finder {:<cr> :Select
              :<c-c> :Close
              :<esc> :Close
              :<c-n> :Next
              :<c-p> :Previous
              :<down> :Next
              :<up> :Previous
              :<tab> :MultiselectToggleNext
              :<s-tab> :MultiselectTogglePrevious
              :<c-j> :NOP}
      popup {:? :HelpPopup
             :A :CherryPickPopup
             :D :DiffPopup
             :M :RemotePopup
             :P :PushPopup
             :X :ResetPopup
             :Z :StashPopup
             :i :IgnorePopup
             :t :TagPopup
             :b :BranchPopup
             :c :CommitPopup
             :f :FetchPopup
             :l :LogPopup
             :m :MergePopup
             :p :PullPopup
             :r :RebasePopup
             :v :RevertPopup}
      status {:q :Close
              :I :InitRepo
              :1 :Depth1
              :2 :Depth2
              :3 :Depth3
              :4 :Depth4
              :<tab> :Toggle
              :x :Discard
              :s :Stage
              :S :StageUnstaged
              :<c-s> :StageAll
              :u :Unstage
              :U :UnstageStaged
              :d :DiffAtFile
              :$ :CommandHistory
              "#" :Console
              :<c-r> :RefreshBuffer
              :<enter> :GoToFile
              :<c-v> :VSplitOpen
              :<c-x> :SplitOpen
              :<c-t> :TabOpen
              "{" :GoToPreviousHunkHeader
              "}" :GoToNextHunkHeader}
      mappings {: commit_editor : rebase_editor : finder : popup : status}]
  (neogit.setup {:use_default_keymaps false
                 :disable_hint false
                 :disable_context_highlighting false
                 :disable_commit_confirmation true
                 :filewatcher {:interval 1000 :enabled false}
                 :telescope_sorter (fn [])
                 :disable_insert_on_commit true
                 :use_per_project_settings true
                 :remember_settings true
                 :auto_refresh true
                 :sort_branches :-committerdate
                 :kind :tab
                 :disable_line_numbers true
                 :console_timeout 2000
                 :auto_show_console true
                 :notification_icon "󰊢"
                 :status {:recent_commit_count 10}
                 :commit_editor {:kind :auto}
                 :commit_select_view {:kind :tab}
                 :commit_view {:kind :tab
                               :verify_commit (fn []
                                                (= (vim.fn.executable :gpg) 1))}
                 :log_view {:kind :tab}
                 :rebase_editor {:kind :auto}
                 :reflog_view {:kind :tab}
                 :merge_editor {:kind :auto}
                 :description_editor {:kind :auto}
                 :tag_editor {:kind :auto}
                 :preview_buffer {:kind :tab}
                 :popup {:kind :tab}
                 : git_services
                 : signs
                 : integrations
                 : sections
                 : ignored_settings
                 : mappings}))
