-module(my_lists).
-export([test/0]).
-export([even/1, double/1, half/1]).

test() ->
	{L0, L1, L2} = {[], [1], [2, 3]},
	[] = my_lists:even(L0),
	[false] = my_lists:even(L1),
	[true, false] = my_lists:even(L2),
	[] = my_lists:double(L0),
	[2] = my_lists:double(L1),
	[4, 6] = my_lists:double(L2),
	[] = my_lists:half(L0),
	[0.5] = my_lists:half(L1),
	[1.0, 1.5] = my_lists:half(L2),
	ok.

even(Xs) -> [(X rem 2) == 0 || X <- Xs].

double(Xs) -> [X * 2 || X <- Xs].

half(Xs) -> [X/2 || X <- Xs].

% map(G, Xs) -> [G(X) || X <- Xs].

% map(_G, []) -> [];
% map(G, [H|T]) ->
% 	[G(H) | map(G, T)].

% even(Xs) -> 
% 	map(fun is_even/1, Xs).
% is_even(H) -> (H rem 2) == 0.

% double(Xs) -> 
% 	map(fun do_duble/1, Xs).
% do_duble(H) -> H * 2.

% half(Xs) -> 
% 	map(fun do_half/1, Xs).
% do_half(H) -> H/2.

% even(Xs) -> 
% 	map(fun(X) -> is_even(X) end, Xs).
% is_even(H) -> (H rem 2) == 0.

% double(Xs) -> 
% 	map(fun(X) -> do_duble(X) end, Xs).
% do_duble(H) -> H * 2.

% half(Xs) -> 
% 	map(fun(X) -> do_half(X) end, Xs).
% do_half(H) -> H/2.

% even([]) -> [];
% even([H|T]) ->
% 	[is_even(H) | even(T)].
% is_even(H) -> (H rem 2) == 0.

% double([]) -> [];
% double([H|T]) -> 
% 	[do_duble(H) | double(T)].
% do_duble(H) -> H * 2.

% half([]) -> [];
% half([H|T]) ->
% 	[do_half(H) | half(T)].
% do_half(H) -> H/2.
