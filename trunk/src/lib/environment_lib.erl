%%% @Module  : environment_lib
%%% @Author  : ys
%%% @Email   : 4932004@qq.com
%%% @Created : 2013.05.29
%%% @Description: 游戏环境相关
%%%--------------------------------------

-module(environment_lib).
-include("record.hrl").
-include("common.hrl").
%% ====================================================================
%% API functions
%% ====================================================================
-export([init/0,save/0]).



%% ====================================================================
%% Internal functions
%% ====================================================================

%%游戏全局初始化
init() ->
	ets:new(?ETS_ONLINE_USER, [public, set, named_table, 
							  {keypos,#online_user.pid}, 
							  {write_concurrency,true},
							  {read_concurrency,true}]),                 %%初始化在线用户
	ets:new(?ETS_ONLINE_ACTOR, [public, set, named_table, 
							  {keypos,#online_actor.pid}, 
							  {write_concurrency,true},
							  {read_concurrency,true}]),                 %%初始化在线角色
	ets:new(?ETS_ACTOR_PET,  [public, set, named_table, 
							  {keypos,#actor_pet.pid}, 
							  {write_concurrency,true},
							  {read_concurrency,true}]),                 %%初始化角色宠物
	ets:new(?ETS_ACTOR_PID,  [public, set, named_table, 
							  {keypos,#actor_pid.id}, 
							  {write_concurrency,true},
							  {read_concurrency,true}]),                 %%初始化角色对应pid
	config_data:init(),
	ok.

%%游戏全局保存
save() ->
	config_data:save().