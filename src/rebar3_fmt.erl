-module(rebar3_fmt).

-export([init/1]).

-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State) ->
    %% initialize all commands here
    {ok, State1} = rebar3_fmt_prv:init(State),
    {ok, State1}.
