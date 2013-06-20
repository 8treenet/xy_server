%%%--------------------------------------
%%% @Module  : 宏
%%% @Author  : ys
%%% @Email   : 4932004@qq.com
%%% @Created : 2013.06.7
%%% @Description: 全局ets表名
%%%--------------------------------------


%%ets表
-define(DB_USER, db_user).                       %%用户数据库
-define(DB_GAME, db_game).                       %%游戏数据库
-define(ETS_ONLINE_USER, ets_online_user).       %%在线用户
-define(ETS_SCREEN, ets_screen).                 %%场景
-define(ETS_ACTOR, ets_actor).                   %%角色
-define(ETS_AI, ets_ai).                   		 %%怪物


%%config信息ID
-define(CONFIG_ACTORR_SEQUENCE, 1).              %%当前分配角色ID序列号
-define(CONFIG_GOODS_SEQUENCE, 1).              %%当前分配物品ID序列号