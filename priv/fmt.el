(load "erlang-start")
(require 'cl)

(setq-default indent-tabs-mode nil)
(setq c-basic-offset 4)

(defun fmt-file (arg)
  (message "fmt %s" arg)
  (find-file arg)
  (erlang-mode)
  ;; (toggle-debug-on-error)
  (font-lock-fontify-buffer)
  (untabify (point-min) (point-max))
  (condition-case ex
      (erlang-indent-current-buffer)
    ('error (message "%s" (error-message-string ex))))
  (save-buffer 0)
  (kill-buffer)
  )

(cl-mapc 'fmt-file command-line-args-left)
