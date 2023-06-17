;; エラーが出るときは `emacsclient -t` でCLIで起動すると上手く動作するかも...

;;       _             _       _     _
;;   ___| |_ _ __ __ _(_) __ _| |__ | |_
;;  / __| __| '__/ _` | |/ _` | '_ \| __|
;;  \__ \ |_| | | (_| | | (_| | | | | |_
;;  |___/\__|_|  \__,_|_|\__, |_| |_|\__|
;;                       |___/
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;;              _ _
;;    _____   _(_) |
;;   / _ \ \ / / | |
;;  |  __/\ V /| | |
;;   \___| \_/ |_|_|
(straight-use-package 'evil)
(require 'evil)
(evil-mode 1)
