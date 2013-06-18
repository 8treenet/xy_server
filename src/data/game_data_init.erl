%% @author Administrator
%% @doc @todo Add description to game_data_init.


-module(game_data_init).
-include("record.hrl").
-include("common.hrl").
%% ====================================================================
%% API functions
%% ====================================================================
-export([start/3]).



%% ====================================================================
%% Internal functions
%% ====================================================================


start(LocalPW,LoginHost,LoginPW)->
	mysql_lib:conn(?DB_GAME, "localhost", LocalPW),                     %%连接游戏数据
	mysql_lib:conn(?DB_USER,  LoginHost, LoginPW),                      %%连接用户数据库
	ets:new(?ETS_ONLINE_USER, [public, set, named_table, 
							  {keypos,#online_user.pid}, 
							  {write_concurrency,true},
							  {read_concurrency,true}]),                 %%初始化在线用户表
	ok.
	