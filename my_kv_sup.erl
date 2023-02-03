-module(my_kv_sup).
-export([test/0]).
-export([start/0, kv/0, stop/0]).
-export([init/1]).
-behaviour(supervisor).

test() ->
	{ok, _} = my_kv_sup:start(),
	Kv = my_kv_sup:kv(),
	ok = my_kv:set(a, 1, Kv),
	1 = my_kv:get(a, Kv),
	exit(Kv, kill),
	timer:sleep(100),
	Kv2 = my_kv_sup:kv(),
	false = Kv == Kv2,
	not_found = my_kv:get(a, Kv2),
	ok = my_kv_sup:stop(),
	ok.

start() ->
	supervisor:start_link({local, my_kv_sup}, my_kv_sup, noarg).

kv() ->
	[{kv, Kv, worker, [my_kv]}] = 
		supervisor:which_children(my_kv_sup),
	Kv.

stop() ->
	gen_server:stop(my_kv_sup).

init(noarg) ->
	{ok, {#{}, [#{id => kv, start => {my_kv, start, []}}]}}.

