-module(my_app).

-behaviour(application).
-export([start/2, stop/1]).

start(_, noarg) -> my_sup:start().

stop(_) -> ok.

