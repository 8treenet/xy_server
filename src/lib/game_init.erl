%% @author Administrator
%% @doc @todo Add description to game_data_init.


-module(game_init).
-include("record.hrl").
-include("common.hrl").
%% ====================================================================
%% API functions
%% ====================================================================
-export([start/0]).



%% ====================================================================
%% Internal functions
%% ====================================================================


start()->

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
	