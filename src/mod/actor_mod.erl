%% @author Administrator
%% @doc @todo Add description to actor_mod.


-module(actor_mod).
-include("common.hrl").
-include("record.hrl").
%% ====================================================================
%% API functions
%% ====================================================================
-export([enter/1, leave/1]).



%% ====================================================================
%% Internal functions
%% ====================================================================


%%进入游戏时调用,
enter([PID,ActorList]) ->
	Actor = #online_actor{
					 		pid = PID,            					      %%在线角色的PID
							id = lists:nth(1, ActorList),                 %%在线角色的ID
							user = lists:nth(2, ActorList),               %%在线角色所属user
						 	name = lists:nth(3, ActorList),               %%角色名称
							job = lists:nth(4, ActorList),                %%身份
							vt = lists:nth(5, ActorList),                 %%职业
							sex = lists:nth(6, ActorList),                %%性别
							grade = lists:nth(7, ActorList),              %%等级
							attack_min = lists:nth(8, ActorList),         %%最小攻击
							attack_max = lists:nth(9, ActorList),         %%最大攻击
							mattack_min = lists:nth(10, ActorList),       %%最小魔法攻击
							mattack_max = lists:nth(11, ActorList),       %%最大魔法攻击
							defense = lists:nth(12, ActorList),           %%防御
							mdefense = lists:nth(13, ActorList),          %%魔法防御 
							hit = lists:nth(14, ActorList),               %%命中率 
							dodge = lists:nth(15, ActorList),             %%闪避率
							crit = lists:nth(16, ActorList),              %%暴击率
							batter = lists:nth(17, ActorList),            %%连击率
							attack_speed = lists:nth(18, ActorList),      %%攻击速度
							attack_addition = lists:nth(19, ActorList),   %%攻击加成
							mattack_addition = lists:nth(20, ActorList),  %%魔法攻击加成
							speed = lists:nth(21, ActorList),             %%移动速度
							hp_max = lists:nth(22, ActorList),            %%血槽
							hp = lists:nth(23, ActorList),                %%血量
							mp_max = lists:nth(24, ActorList),            %%魔槽
							mp = lists:nth(25, ActorList),                %%魔量
							exp = lists:nth(26, ActorList),               %%经验值
							money = lists:nth(27, ActorList),             %%VIP金币
							screen = lists:nth(28, ActorList),            %%所属场景
							x = lists:nth(29, ActorList),                 %%坐标X
							y = lists:nth(30, ActorList),                 %%坐标Y
							faction = lists:nth(31, ActorList),           %%帮派ID
							image = lists:nth(32, ActorList),             %%角色形象
							head = lists:nth(33, ActorList),              %%角色形象
							spouse = lists:nth(34, ActorList),            %%配偶的ID
							gold = lists:nth(35, ActorList),              %%金币
		                    fight_pid = undefined                         %%战斗进程的PID
						 },
	ets:insert(?ETS_ONLINE_ACTOR, Actor),
	Actor_ID = #actor_pid{id=(Actor#online_actor.id), pid=PID},
	ets:insert(?ETS_ACTOR_PID, Actor_ID),
	PName = system_data:format_Binary(8, Actor#online_actor.name),
	Job   = system_data:format_Binary(8, Actor#online_actor.job),

	Actor_Info_Bin = <<(Actor#online_actor.id):32,PName/binary,Job/binary,(Actor#online_actor.vt):32,
					   (Actor#online_actor.sex):32,(Actor#online_actor.grade):32,(Actor#online_actor.attack_min):32,
					   (Actor#online_actor.attack_max):32,(Actor#online_actor.mattack_min):32,(Actor#online_actor.mattack_max):32,
					   (Actor#online_actor.defense):32,(Actor#online_actor.mdefense):32,(Actor#online_actor.hit):32,
					   (Actor#online_actor.dodge):32,(Actor#online_actor.crit):32,(Actor#online_actor.batter):32,
					   (Actor#online_actor.attack_speed):32,(Actor#online_actor.attack_addition):32,
					   (Actor#online_actor.mattack_addition):32,(Actor#online_actor.speed):32,(Actor#online_actor.hp_max):32,
					   (Actor#online_actor.hp):32,(Actor#online_actor.mp):32,(Actor#online_actor.exp):32,
					   (Actor#online_actor.money):32,(Actor#online_actor.faction):32,(Actor#online_actor.image):32,
					   (Actor#online_actor.head):32,(Actor#online_actor.spouse):32,(Actor#online_actor.gold):32>>,
	io:format("enter game actor:~p~n",[Actor]),
	game_server:send(PID,<<10006:32, Actor_Info_Bin/binary>>),
	ok.


leave([PID]) ->
	ok.