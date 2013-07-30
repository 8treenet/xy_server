%%%--------------------------------------
%%% @Module  : gameServer_mod
%%% @Author  : ys
%%% @Email   : 4932004@qq.com
%%% @Created : 2013.06.17
%%% @Description: 处理通用功能
%%%--------------------------------------

-module(game_pro).
-include("common.hrl").
-include("record.hrl").
%% ====================================================================
%% API functions
%% ====================================================================
-export([login/1,get_actor/1,create_actor/1,enter_game/1]).



%% ====================================================================
%% Internal functions
%% ====================================================================
login([PID, Name, SessionKey]) ->
	io:format("1~n"),
	Sql = io_lib:format(<<"SELECT * FROM xy_user WHERE user_name = '~s'">>, [Name]),
	io:format("2:~p~n",[Sql]),
	case mysql_lib:recv(Sql, ?DB_USER) of
		 [] -> 
			 io:format("2~n"),
			 game_server:send(PID, <<10003:32,2:8>>);
		 [[_, _, _, _,Status, Key, _, Time]|_] ->
			 io:format("3~n"),
 			 CurrentTime = system_data:get(second),
 			 UserTime = list_to_integer(binary_to_list(Time)),
			 Sec = CurrentTime - UserTime,
			 CheckLogin = ets:match(?ETS_ONLINE_USER, #online_user{pid='$1', user=Name}),
			 if 
				CheckLogin /= [] ->
					  io:format("login user_online  ~n"),
					  game_server:send(PID, <<10003:32,2:8>>); 		
				(Status == 1) and (Key == SessionKey) and ((Sec < 1800) and (Sec > 0)) ->
					 User = #online_user{pid=PID, user=Name},
					 ets:insert(?ETS_ONLINE_USER, User),
					 io:format("login ok~n"),
					 game_server:send(PID, <<10003:32,1:8>>);
				true->
					io:format("login user_error status:~p key:~p sec:~p ~n",[Status,Key,Sec]),
					 game_server:send(PID, <<10003:32,2:8>>)
			 end
		end,
ok.
  
%%获取角色
get_actor([PID]) ->
	 Packet = fun(ID, PName, VT, Sex, Grade,Image) ->
					  PName_Bin = system_data:format_Binary(8, PName),
					  <<ID:32, Grade:32, VT:8, Sex:8, PName_Bin/binary,Image:16>>
			  end,
	case ets:lookup(?ETS_ONLINE_USER, PID) of
		[] ->
			io:format("user_error,get_actor1~n"),
			ok;
		[User]->
			Sql = io_lib:format(<<"SELECT xy_actor.actor_id, xy_actor.actor_pname, xy_actor.actor_vocational, xy_actor.actor_sex,
xy_actor.actor_grade actor_image FROM xy_actor WHERE xy_actor.actor_user = '~s'">>, [User#online_user.user]),
			io:format("get_actor sql:~s~n",[Sql]),
			case mysql_lib:recv(Sql, ?DB_GAME) of
				 [] -> 
					 io:format("get_actor:0~n"),
					 game_server:send(PID, <<10004:32>>);
				 List ->
					 ListData = [Packet(ID, PName, VT, Sex, Grade,Image) || [ID, PName, VT, Sex, Grade, Image] <-List],
					 ListBin  = list_to_binary(ListData),
					 io:format("get_actor:~p~n",[List]),
					 game_server:send(PID, <<10004:32, ListBin/binary>>)
				end
		end,
	ok.

%%创建角色
create_actor([PID, PName, VT, Sex]) ->
	case ets:lookup(?ETS_ONLINE_USER, PID) of
		[] ->
			ok;
		[User]-> 
			CountPNameSql = io_lib:format(<<"SELECT Count(*) FROM `xy_actor` WHERE actor_pname= '~s'">>, [PName]),
			[[PNameCount]] = mysql_lib:recv(CountPNameSql, ?DB_GAME),
			CountActorSql = io_lib:format(<<"SELECT Count(*) FROM `xy_actor` WHERE actor_user= '~s'">>, [User#online_user.user]),
			[[ActorCount]] = mysql_lib:recv(CountActorSql, ?DB_GAME),
			case {PNameCount, ActorCount} of
				 {_, 4} ->
					  io:format("create actor max ok~n"),
					  game_server:send(PID, <<10005:32, 3:8>>);
				 {0, _} ->
					 ID = config_data:read(actor_sequence),
				   	 Sql = game_data_1:get_actor_birth_sql(User#online_user.user, ID, PName, Sex, VT),
					 mysql_lib:write(Sql, ?DB_GAME),
					 io:format("create actor ok~n"),
					 game_server:send(PID, <<10005:32, 1:8>>);
				   _ ->
					  io:format("create pname error~n"),
					 game_server:send(PID, <<10005:32, 2:8>>)
				end
			
		end,
	ok.

%%进入游戏
enter_game([PID, Actor_ID]) ->
	case ets:lookup(?ETS_ONLINE_USER, PID) of
		[] ->
			io:format("error enter_game1~n"),
			ok;
		[User]-> 
			ReadActor = io_lib:format(<<"SELECT * FROM xy_actor WHERE actor_id = '~p' AND  actor_user='~s'">>, [Actor_ID, User#online_user.user]),
			io:format("~s~n",[ReadActor]),
			case mysql_lib:recv(ReadActor, ?DB_GAME) of
				 [] ->
					 io:format("error enter_game2~n"),
					 game_server:send(PID, <<10005:32, 2:8>>);
				 [ActorList|_] ->
						actor_mod:enter([PID,ActorList])
			end
		end,
	ok.