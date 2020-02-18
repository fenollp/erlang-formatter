#!/usr/bin/env escript
%%!
%% -*- coding: utf-8 -*-

-mode(compile).
-export([main/1]).

%% erl_tidy.escript: does not support HRL ESCRIPT APP.SRC.

main([]) ->
    io:format(standard_error
             ,"Usage: ~s  <ERL files or folders>\n"
             ,[filename:dirname(escript:script_name())]
             ),
    halt(1);
main(Files) ->
    tidy_files(Files).

%% Internals

tidy_files(Paths) ->
    lists:foreach(fun tidy/1, Paths).

printer(AST, Options) ->
    erl_prettypr:format(AST, [{paper, 115}
                             ,{ribbon, 100}
                             | Options
                             ]).

tidy(Path) ->
    case {filelib:is_regular(Path), filelib:is_dir(Path)} of
        {true, _} ->
            case filename:extension(Path) of
                ".erl" ->
                    erl_tidy:file(Path, [{backups, false}
                                        ,{quiet, false}
                                        ,{verbose, false}
                                        ,{printer, fun printer/2}

                                        ,{keep_unused, true}
                                        ,{auto_export_vars, false}
                                        ,{auto_list_comp, true}
                                        ,{new_guard_tests, true}
                                        ,{no_imports, true}

                                        ,{idem, true}
                                        ]);
                _ ->
                    skip(Path)
            end;
        {_, true} ->
            RegExp = "\\.erl$",
            Paths = filelib:fold_files(Path, RegExp, true, fun cons/2, []),
            tidy_files(Paths);
        _ ->
            skip(Path)
    end.

cons(H, T) -> [H | T].

skip(Path) ->
    io:format(standard_error, "Skipping ~s\n", [Path]).

%% End of Module
