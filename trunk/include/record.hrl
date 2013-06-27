%%%--------------------------------------
%%% @Module  : record
%%% @Author  : ys
%%% @Email   : 4932004@qq.com
%%% @Created : 2013.06.7
%%% @Description: 结构体
%%%--------------------------------------

%%在线角色
-record(online_actor,{
					pid,               %%在线角色的PID
					id,                %%在线角色的ID
					user,              %%在线角色所属user
				 	name,              %%角色名称
					job,               %%身份
					vt,                %%职业
					sex,               %%性别
					grade,             %%等级
					attack_min,        %%最小攻击
					attack_max,        %%最大攻击
					mattack_min,       %%最小魔法攻击
					mattack_max,       %%最大魔法攻击
					defense,           %%防御
					mdefense,          %%魔法防御 
					hit,               %%命中率 
					dodge,             %%闪避率
					crit,              %%暴击率
					batter,            %%连击率
					attack_speed,      %%攻击速度
					attack_addition,   %%攻击加成
					mattack_addition,  %%魔法攻击加成
					speed,             %%移动速度
					hp_max,            %%血槽
					hp,                %%血量
					mp_max,            %%魔槽
					mp,                %%魔量
					exp,               %%经验值
					money,             %%vip金币
					screen,            %%所属场景
					x,                 %%坐标X
					y,                 %%坐标Y
					faction,           %%帮派ID
					image,             %%形象ID
					head,              %%头像ID
					spouse,            %%配偶的ID
					gold,              %%金币            
                    fight_pid          %%战斗进程的PID
					 }).



%%在线角色ID对应PID
-record(actor_pid,{ 
				   id,                %%在线角色ID
				   pid                %%在线用户的PID
				   }). 


%%角色的宠物
-record(actor_pet,{
				  	pid,               %%在线角色的PID
				    id,                %%宠物的ID
					actor,             %%所属角色
                    fight,             %%是否参战 1未参战,2参战
					grade,             %%等级
					attack_min,        %%最小攻击
					attack_max,        %%最大攻击
					mattack_min,       %%最小魔法攻击
					mattack_max,       %%最大魔法攻击
					defense,           %%防御
					mdefense,          %%魔法防御 
					loyalty,		   %%忠诚度
					hit,               %%命中率 
					dodge,             %%闪避率
					crit,              %%暴击率
					batter,            %%连击率
					attack_speed,      %%攻击速度
					hp_max,            %%血槽
					hp,                %%血量
					mp_max,            %%魔槽
					mp,                %%魔量
					exp,               %%经验值
					attack_talent,     %%攻击天赋
                    mattack_talent,    %%魔法攻击天赋
					defense_talent,    %%防御天赋
					mdefense_talent,   %%魔法防御天赋
					hp_talent,         %%血量天赋
					mp_talent,         %%魔量天赋
				    attack_speed_talent,%%攻击速度天赋      
					image,              %%形象
					head                %%头像ID
				   }).


%%aoi结构
-record(aoi_actor, {
					id,                 %%actorID
				     x,                 %%位置X
                     y,                 %%位置Y
                    type,               %%分类
                    node_name}).        %%所属四叉树


%%在线用户
-record(online_user,{
					pid,               %%在线用户的PID
				    user}).            %%在线用户的用户名

