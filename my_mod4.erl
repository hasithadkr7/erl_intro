-module(my_mod4).

-export([test/0]).

test() ->
	process_flag(trap_exit, true),
	S = spawn_link(my_mod4, server, [good_key]),
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