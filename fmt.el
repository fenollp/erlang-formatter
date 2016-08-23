(load "erlang-start")
(require 'cl)

(setq-default indent-tabs-mode nil)

(defun fmt-file (arg)
  (message "fmt %s" arg)
  (find-file arg)
  (erlang-mode)
  ;; (toggle-debug-on-error)
  (untabify (point-min) (point-max))
  (erlang-indent-current-buffer)
  (save-buffer)
  (kill-buffer)
  )

(cl-mapc 'fmt-file command-line-args-left)
