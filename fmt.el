(load "erlang-start")
(find-file "test/bla.erl")
(require 'cl) ; required with Emacs < 23 for ignore-errors
(erlang-mode)
(toggle-debug-on-error)
(erlang-indent-current-buffer)
(write-file "bla.erl")
