-module(my_mod).

-export([test/0, server/1]).

test() ->
	register(server, spawn(my_mod, server, [gk])),
	server ! {ping, 0, bad_key, self()},
	receive
		Something -> error({unexpected, Something})
	after 100 -> ok	
	end,
	lists:foreach(fun test/1, lists:seq(1, 11)).

test(MsgId) ->
	io:format("Test run #~p~n", [MsgId]),
	server ! {ping, MsgId, gk, self()},
	receive
		{pong, MsgId} -> ok
	after 100 -> error({no_pong, MsgId})
	end.


server(Key) ->
	% receive
	% 	{ping, MsgId, Key, Caller} ->
	% 		Caller ! {pong, MsgId}
	% end,
	receive
		{ping, MsgId, Key, Caller} ->
			Caller ! {pong, MsgId},
			server(Key)
		after 1000 ->
			done		
	end.