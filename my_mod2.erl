-module(my_mod2).

-export([test/0, min/1]).
-compile({no_auto_import,[min/2]}).

test()->
	LongRow = lists:seq(0, 100000),
	LargeMatrix = lists:duplicate(10000, LongRow),
	{T, 0} = timer:tc(my_mod2, min, [LargeMatrix]),
	{ok, T}.


min([Row|Rows]) -> catch min(row_min(Row), Rows).

min(Min, []) -> Min;
min(Min, [Row|Rows]) ->
	case row_min(Row) of
		NewMin when NewMin < Min -> min(NewMin, Rows);
		_ -> min(Min, Rows)
	end.

row_min([H|T]) -> row_min(H, T).

row_min(0, _) -> throw(0);
row_min(Min, []) -> Min;
row_min(Min, [H|T]) when Min > H -> row_min(H, T);
row_min(Min, [_|T]) -> row_min(Min, T).