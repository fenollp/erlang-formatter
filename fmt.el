(load "erlang-start")
(require 'cl) ; required with Emacs < 23 for ignore-errors

(defun fmt-file (arg)
  (message "fmt %s" arg)
  (find-file arg)
  (erlang-mode)
  ;; (toggle-debug-on-error)
  (erlang-indent-current-buffer)
  (save-buffer)
  (kill-buffer)
  )

(mapc 'fmt-file command-line-args-left)
