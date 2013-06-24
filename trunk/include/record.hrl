
%%在线角色
-record(online_actor,{
					pid,               %%在线角色IO的PID
					user,              %%在线角色所属user
				    id,                %%在线角色的ID
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
					attack_speed,      %%攻击速度
					attack_addition,   %%攻击加成
					mattack_addition,  %%魔法攻击加成
					speed,             %%移动速度
					hp_max,            %%血槽
					hp,                %%血量
					mp_max,            %%魔槽
					mp,                %%魔量
					exp,               %%经验值
					money,             %%金币
					screen,            %%所属场景
					x,                 %%坐标X
					y                  %%坐标Y
					fight,             %%是否在战斗
                    fight_pid          %%战斗进程PID
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

