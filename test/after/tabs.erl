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
