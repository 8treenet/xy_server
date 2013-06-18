%%%--------------------------------------
%%% @Module  : gameServer_mod
%%% @Author  : ys
%%% @Email   : 4932004@qq.com
%%% @Created : 2013.06.17
%%% @Description: 处理逻辑服务器协议逻辑
%%%--------------------------------------
-module(gameServer_mod).

%% ====================================================================
%% API functions
%% ====================================================================
-export([process/1]).

-include("common.hrl").

%% ====================================================================
%% Internal functions
%% ====================================================================


process([PID, Index, Data])->
	process(Index,PID, Data).

process(10005, PID, {PName, VT, Sex})->
    spawn(common_logic, create_actor,[PID, PName, VT, Sex]);

process(10003, PID, {Name, SessionKey}) ->
	spawn(common_logic, login, [PID, Name, SessionKey]),
	ok;

process(10004, PID, _) ->
	spawn(common_logic, get_actor, [PID]),
	ok.
