%%%-------------------------------------------------------------------
%% @doc test_api public API
%% @end
%%%-------------------------------------------------------------------

-module(test_api_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_Type, _Args) ->
		Dispatch = cowboy_router:compile([
									  {'_', [
											 {"/data", data_handler, []},
											 {"/", data_handler, []}

											]}
									 ]),
	{ok, _} = cowboy:start_clear(http,[{port, get_port()}], #{
				env => #{dispatch => Dispatch}
	}),
	test_api_sup:start_link().





stop(_State) ->
	ok.
%%====================================================================
%% Internal functions
%%====================================================================



get_port() ->
        case application:get_env(test_api, port) of
            {ok, Port}      ->    list_to_integer(Port);
            undefined       ->    io:format("||Fetching Env vars Failed||undefined"),
                                  8088
        end.