-module(passthrough).

-export([a/1]).

a(L) ->
    [<<>>
         || _ <- L
    ].
