-module(issue45).

parse(Token) ->
    case Token of
        <<"$", Rest/binary>> -> {done, Rest};
        <<"1", Rest/binary>> -> {done, Rest};
        <<"2", Rest/binary>> -> {done, Rest}
    end.
