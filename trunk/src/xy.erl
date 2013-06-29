%%%--------------------------------------
%%% @Module  : xy
%%% @Author  : ys
%%% @Email   : 4932004@qq.com
%%% @Created : 2013.05.29
%%% @Description: 启动程序
%%%--------------------------------------


-module(xy).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start_gateway/0, start_game/0, start_login/0]).



%% ====================================================================
%% Internal functions
%% ====================================================================


start_gateway()->
	application:start(gateway).
start_game()->
	application:start(game).
start_login()->
	application:start(login).