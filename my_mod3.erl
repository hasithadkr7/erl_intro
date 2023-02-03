-module(my_mod3).

-export([test/0, server/1]).

test() ->
	S = spawn(my_mod3, server, [good_key]),
	S ! {ping, bad_key, self()},
	receive
		Something -> 
			error({unexpected, Something})
	after 100 -> 
		ok	
	end,
	S ! {ping, good_key, self()},
	receive
		pong -> 
			ok	
	end.

server(Key) ->
	receive
		{ping, Key, Caller} ->
			Caller ! pong
	end.