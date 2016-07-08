%% Copyright © 2016 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(blaaa).

%% blaaa: 

-export([b/1]).

-record(s, { a :: list()
	   , b :: other:thing()
	   }).


%% API

b (_1)
  when is_binary(_1) ->
    #s{}.

%% Internals

%% End of Module.
