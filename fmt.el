;(message "%s" command-line-args-left)
(load "erlang-start")
(find-file (elt argv 0))
(require 'cl) ; required with Emacs < 23 for ignore-errors
(erlang-mode)
(toggle-debug-on-error)
(erlang-indent-current-buffer)
(save-buffer)
