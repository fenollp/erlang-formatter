(load "erlang-start")

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
