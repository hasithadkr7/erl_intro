-module(my_kv).

-export([test/0]).
-export([start/0, get/2, set/3, stop/1]).
-export([init/1, handle_call/3, handle_cast/2]).
-behaviour(gen_server).


%%% TEST -----------------------------------------------
test() ->
	{ok, Kv} = my_kv:start(),
	not_found = my_kv:get(a, Kv),
	ok = my_kv:set(a, 1, Kv),
	1 = my_kv:get(a, Kv),
	ok = my_kv:set(a, 2, Kv),
	2 = my_kv:get(a, Kv),
	not_found = my_kv:get(b, Kv),
	ok = my_kv:stop(Kv).

%%% API ------------------------------------------------
start() ->
	gen_server:start_link(my_kv, noarg, []).

get(Key, Kv) ->
	gen_server:call(Kv, {get, Key}).

set(Key, Value, Kv) ->
	gen_server:cast(Kv, {set, Key, Value}).

stop(Kv) ->
	gen_server:stop(Kv).

%%% Call Backs ----------------------------------------
init(noarg) -> {ok, #{}}.

handle_call({get, Key}, _From, St) ->
	{reply, maps:get(Key, St, not_found), St}.

handle_cast({set, Key, Value}, St) -> 
	{noreply, St#{Key => Value}}.

% loop(State) ->
% 	receive
% 		{call, {get, Key}, Caller} ->
% 			Caller ! maps:get(Key, State, not_found),
% 			loop(State);
% 		{cast, {set, Key, Value}} -> 
% 			loop(State#{Key => Value});
% 		stop -> done,ok
% 	end.
