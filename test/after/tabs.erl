%% Copyright © 2016 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(tabs).

%% tabs: 

-export([t/1
        ,a/0,
         b/1
        ,s/0
        ]).

-record(s, { a :: list()
           , b :: other:thing()
           , c :: other:thang()
           }).


%% API

%%------------------------------------------------------------------------------
%% @doc
%% @end
%%------------------------------------------------------------------------------

-spec release(kz_term:ne_binaries()) -> ret().
release(Nums) ->
    release(Nums, knm_number_options:default()).

-spec release(kz_term:ne_binaries(), knm_number_options:options()) -> ret().
release(Nums, Options) ->
    ret(pipe(do_get_pn(Nums, Options)
            ,[fun try_release/1
             ,fun knm_number:new/1
             ,fun knm_providers:delete/1
             ,fun unwind_maybe_disconnect/1
             ,fun save_phone_numbers/1
             ])).



t(ABS) -> erlang:abs(
            ABS
           ).

a () ->
    amqp:callect(
      dst
     ,meta
     ,[{<<"blip">>, <<"bloop">>}
      ,{<<"blop">>, 1}
      ,{<<"blup">>, 42}
      ]
     ).

b(Arg) ->
    fun () ->
            [Arg
            ,Arg
            ,Arg
            ,Arg
            ,Arg
            ]
    end.

s() ->

    k.

%% Internals

%% End of Module.
