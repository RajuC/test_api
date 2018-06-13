-module(data_handler).
% -include("comet_logger.hrl").
-export([init/2,terminate/3]).

init(Req, Opts) ->
	io:format("||ReqReqReqReq : ~p~n", [Req]),
	Path = cowboy_req:path(Req),
	Resp =
		case Path of
			<<"/data">> ->
			   cowboy_req:reply(200, #{
		<<"content-type">> => <<"text/plain; charset=utf-8">>
			}, <<"data-endpoint">>, Req);
			<<"/">> ->
			   cowboy_req:reply(200, #{
		<<"content-type">> => <<"text/plain; charset=utf-8">>
			}, <<"Welcome to TEST API">>, Req);
		   true ->
			   cowboy_req:reply(405,Req)
		end,
	{ok, Resp, Opts}.

terminate(_Reason, _Req, _State) ->
    ok.



% init(Req0, Opts) ->
% 	Method = cowboy_req:method(Req0),
% 	#{echo := Echo} = cowboy_req:match_qs([{echo, [], undefined}], Req0),
% 	Req = echo(Method, Echo, Req0),
% 	{ok, Req, Opts}.

% echo(<<"GET">>, undefined, Req) ->
% 	cowboy_req:reply(400, #{}, <<"Missing echo parameter.">>, Req);
% echo(<<"GET">>, Echo, Req) ->
% 	cowboy_req:reply(200, #{
% 		<<"content-type">> => <<"text/plain; charset=utf-8">>
% 	}, Echo, Req);
% echo(_, _, Req) ->
% 	%% Method not allowed.
% 	cowboy_req:reply(405, Req).