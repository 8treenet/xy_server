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