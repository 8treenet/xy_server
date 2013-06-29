%%%--------------------------------------
%%% @Module  : common
%%% @Author  : ys
%%% @Email   : 4932004@qq.com
%%% @Created : 2013.06.7
%%% @Description: 宏
%%%--------------------------------------

%%mnesia表名
-define(MNESIA_ACTOR,mnesia_actor).
%%ets表名
-define(ETS_ONLINE_USER, ets_online_user).                   %%在线用户
-define(ETS_ONLINE_ACTOR, ets_online_actor).                 %%在线角色
-define(ETS_ACTOR_PET, ets_actor_pet).                       %%角色宠物
-define(ETS_ACTOR_PID,ets_actor_pid).          				 %%角色ID对PID
-define(ETS_SCREEN, ets_screen).                             %%场景
-define(ETS_MON, ets_mon).                   		         %%怪物
-define(ETS_NPC, ets_npc).                   		         %%npc

%%config信息ID
-define(DB_USER, db_user).                      			 %%用户数据库连接标示
-define(DB_GAME, db_game).                     			     %%游戏数据库连接标示


