%%%--------------------------------------
%%% @Module  : common
%%% @Author  : ys
%%% @Email   : 4932004@qq.com
%%% @Created : 2013.06.7
%%% @Description: 宏
%%%--------------------------------------


%%ets表名
-define(ETS_ONLINE_USER, ets_online_user).                   %%在线用户
-define(ETS_ONLINE_ACTOR, ets_online_actor).                 %%在线角色
-define(ETS_SCREEN, ets_screen).                             %%场景
-define(ETS_ACTOR, ets_actor).                               %%角色
-define(ETS_MON, ets_mon).                   		         %%怪物
-define(ETS_NPC, ets_npc).                   		         %%npc

%%config信息ID
-define(DB_USER, db_user).                      			 %%用户数据库连接标示
-define(DB_GAME, db_game).                     			     %%游戏数据库连接标示
-define(CONFIG_ACTORR_SEQUENCE, 1).             			 %%当前分配角色ID序列号
-define(CONFIG_GOODS_SEQUENCE, 1).              			 %%当前分配物品ID序列号