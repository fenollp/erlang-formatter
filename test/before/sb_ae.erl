-module(sb_ae).
-export([test_fmt/0]).
test_fmt() ->
  io:format("test ~p~n", [
                          {test_atom}
                         ]).
