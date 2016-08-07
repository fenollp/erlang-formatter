-module(cb_api_endpoints2).

a() ->
    "\$".

q() ->
    true =:= (a() =:= "$").
