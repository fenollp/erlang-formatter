-module(rebar3_fmt_prv).
-behaviour(provider).

-export([init/1, do/1, format_error/1]).

-define(PROVIDER, fmt).
-define(DEPS, [version]).

%% ===================================================================
%% Public API
%% ===================================================================
-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State) ->
    Provider =
        providers:create(
          [{name, ?PROVIDER}       %% The 'user friendly' name of the task
          ,{module, ?MODULE}       %% The module implementation of the task
          ,{bare, true}            %% The task can be run by the user, always true
          ,{deps, ?DEPS}           %% The list of dependencies
          ,{example, "rebar3 fmt"} %% How to use the plugin
          ,{opts,                  %% list of options understood by the plugin
            [
             %% {'only-modified', $m, {boolean,false}, "only run against modified files"}
            ]}
          ,{short_desc, "Formats Erlang source files"}
          ,{desc,
            "Scans top-level application source and finds"
            " files matching glob app, app.src, app.src.script,"
            " config, config.script, erl, escript, hrl, xrl, yrl"
            " files then formats them à la `gofmt`."
           }
          ]),
    {ok, rebar_state:add_provider(State, Provider)}.

-spec do(rebar_state:t()) -> {ok, rebar_state:t()} | {error, string()}.
do(State) ->
    case os:find_executable("emacs") of
        false -> {error, "Could not find `emacs`"};
        Exe ->
            Apps = rebar_state:project_apps(State),
            case do_fmt(Exe, Apps) of
                ok -> {ok, State};
                {error,_}=E -> E
            end
    end.

-spec format_error(any()) -> iolist().
format_error(Reason) ->
    io_lib:format("~p", [Reason]).


do_fmt(_, []) -> ok;
do_fmt(Exe, [App|Apps]) ->
    Path = rebar_app_info:dir(App),
    Paths = find_source_files(Path),
    rebar_api:debug("found ~p files: ~p", [length(Paths), Paths]),
    case fmt(Exe, Paths) of
        ok -> do_fmt(Exe, Apps);
        {error,_}=E -> E
    end.

find_source_files(Path) ->
    Pattern =
        ".*\\.(" "app"
        "|" "app\\.src"
        "|" "app\\.src\\.script"
        "|" "config"
        "|" "config\\.script"
        "|" "erl"
        "|" "escript"
        "|" "hrl"
        "|" "xrl"
        "|" "yrl"
        ")$",
    rebar_api:debug("looking for files matching: '~s'", [Pattern]),
    filelib:fold_files(Path, Pattern, true, fun maybe_cons/2, []).

maybe_cons(Path, Acc) ->
    case lists:any(fun match_blacklist/1, filename:split(Path)) of
        true -> Acc;
        false -> [Path|Acc]
    end.

match_blacklist(".erlang.mk") -> true;
match_blacklist(".eunit") -> true;
match_blacklist(".rebar") -> true;
match_blacklist(".rebar3") -> true;
match_blacklist("_build") -> true;
match_blacklist("_rel") -> true;
match_blacklist("deps") -> true;
match_blacklist("ebin") -> true;
match_blacklist(_) -> false.

fmt(Exe, Paths) ->
    BEAM = [_|_] = code:which(?MODULE),
    Priv = filename:join([filename:dirname(BEAM), "..", "priv"]),
    Args = ["--batch"
           ,"--quick"
           ,"--directory", Priv
           ,"--load", filename:join(Priv,"fmt.el")
            | Paths
           ],
    rebar_api:debug("running ~s ~p", [Exe, Args]),
    collect(
      [], 250 * length(Paths)
     ,open_port({spawn_executable, Exe}
               ,[exit_status
                ,use_stdio
                ,{args, Args}
                ,{line, 64 * 64}
                ]
               )
     ).

collect(Acc, Timeout, Port) ->
    receive
        {Port, {data,{eol,Line}}} ->
            NewAcc = [Line | Acc],
            collect(NewAcc, Timeout, Port);
        {Port, {exit_status,0}} -> ok;
        {Port, {exit_status,_}} ->
            {error, "emacs exited with non-zero status code"}
    after Timeout ->
            port_close(Port),
            {error, "emacs took too long"}
    end.
