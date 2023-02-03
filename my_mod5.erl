-module(my_mod5).

-export([test/0]).

test() ->
	{S, _} = spawn_monitor(my_mod5, server, [good_key]),
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

% server(Key) ->
% 	receive
% 		{ping, Key, Caller} ->
% 			Caller ! pong
% 	end.