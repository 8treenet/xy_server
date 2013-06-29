%% @author Administrator
%% @doc @todo Add description to actor_mod.


-module(actor_mod).
-include("common.hrl").
-include("record.hrl").
%% ====================================================================
%% API functions
%% ====================================================================
-export([enter/1]).



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
	ReadPet = io_lib:format(<<"SELECT * FORM `xy_pet` WHERE pet_master_actor='~p'">>, [Actor#online_actor.id]),
	FunPet = fun(Pet)-> << <<PetX:32>> || PetX<-Pet>>,
						ASD = #actor_pet{
										 	pid = PID,             				   %%在线角色的PID
										    id = lists:nth(1, Pet),                %%宠物的ID
											actor = lists:nth(2, Pet),             %%所属角色
						                    fight = lists:nth(3, Pet),             %%是否参战 1未参战,2参战
											grade = lists:nth(4, Pet),             %%等级
											attack_min = lists:nth(5, Pet),        %%最小攻击
											attack_max = lists:nth(6, Pet),        %%最大攻击
											mattack_min = lists:nth(7, Pet),       %%最小魔法攻击
											mattack_max = lists:nth(8, Pet),       %%最大魔法攻击
											defense = lists:nth(9, Pet),           %%防御
											mdefense = lists:nth(10, Pet),          %%魔法防御 
											loyalty = lists:nth(11, Pet),		   %%忠诚度
											hit = lists:nth(12, Pet),               %%命中率 
											dodge = lists:nth(13, Pet),             %%闪避率
											crit = lists:nth(14, Pet),              %%暴击率
											batter = lists:nth(15, Pet),            %%连击率
											attack_speed = lists:nth(16, Pet),      %%攻击速度
											hp_max = lists:nth(17, Pet),            %%血槽
											hp = lists:nth(18, Pet),                %%血量
											mp_max = lists:nth(19, Pet),            %%魔槽
											mp = lists:nth(20, Pet),                %%魔量
											exp = lists:nth(21, Pet),               %%经验值
											attack_talent = lists:nth(22, Pet),     %%攻击天赋
						                    mattack_talent = lists:nth(23, Pet),    %%魔法攻击天赋
											defense_talent = lists:nth(24, Pet),    %%防御天赋
											mdefense_talent = lists:nth(25, Pet),   %%魔法防御天赋
											hp_talent = lists:nth(26, Pet),         %%血量天赋
											mp_talent = lists:nth(27, Pet),         %%魔量天赋
										    attack_speed_talent = lists:nth(28, Pet),%%攻击速度天赋      
											image = lists:nth(29, Pet),             %%形象
											head = lists:nth(30, Pet)               %%头像ID
										 },
						io:format("enter game pet:~p~n",[ASD]),
						ets:insert(?ETS_ACTOR_PET, ASD)
			  end,
	Actor_Pet_Bin = case mysql_lib:recv(ReadPet, ?DB_GAME) of
						 [] ->
							 <<0:32>>;
						 PetList->
							 Num = length(PetList),
							 PList = [FunPet(P) ||P<-PetList],
							 PList_Bin = list_to_binary(PList),
							 <<Num:32, PList_Bin/binary>>
	 				end,
	
	game_server:send(PID,<<10006:32,Actor_Info_Bin/binary,Actor_Pet_Bin/binary>>),
	ok.