(load "erlang-start")
(require 'cl)

(add-hook 'erlang-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'erlang-indent-current-buffer nil 'make-it-local)))

(setq-default indent-tabs-mode nil)
(setq c-basic-offset 4)

(defun fmt-file (arg)
  (message "fmt %s" arg)
  (find-file arg)
  (erlang-mode)
  ;; (toggle-debug-on-error)
  (untabify (point-min) (point-max))
  (save-buffer 0)
  (kill-buffer)
  )

(cl-mapc 'fmt-file command-line-args-left)
