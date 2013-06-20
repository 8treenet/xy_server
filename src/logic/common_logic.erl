%%%--------------------------------------
%%% @Module  : gameServer_mod
%%% @Author  : ys
%%% @Email   : 4932004@qq.com
%%% @Created : 2013.06.17
%%% @Description: 处理通用功能
%%%--------------------------------------

-module(common_logic).
-include("common.hrl").
-include("record.hrl").
%% ====================================================================
%% API functions
%% ====================================================================
-export([login/1,get_actor/1,create_actor/1]).



%% ====================================================================
%% Internal functions
%% ====================================================================
login([PID, Name, SessionKey]) ->
	Sql = io:format(<<"SELECT * FROM xy_user WHERE user_name = '~s'">>, [Name]),
	case mysql_lib:recv(Sql, ?DB_USER) of
		 [] -> 
			 game_server:send(PID, <<10003:32,2:8>>);
		 [[_, _, _, _,Status, Key, _, Time]|_] ->
 			 CurrentTime = system_data:get(second),
 			 UserTime = list_to_integer(binary_to_list(Time)),
			 Sec = CurrentTime - UserTime,
			 if 
				 
				(Status == 1) and (Key == SessionKey) and ((Sec < 180) and (Sec > 0)) ->
					 User = #online_user{pid=PID, user=Name},
					 ets:insert(?ETS_ONLINE_USER, User),
					 game_server:send(PID, <<10003:32,1:8>>);
				true->
					 game_server:send(PID, <<10003:32,2:8>>)
			 end
		end,
ok.
  

get_actor([PID]) ->
	 Packet = fun(ID, PName, VT, Sex, Grade) ->
					  PName_Bin = system_data:format_Binary(8, PName),
					  <<ID:8, Grade:32, VT:8, Sex:8, PName_Bin/binary>>
			  end,
	case ets:lookup(?ETS_ONLINE_USER, PID) of
		[] ->
			ok;
		[User]->
			Sql = io:format(<<"SELECT xy_actor.actor_id, xy_actor.actor_pname, xy_actor.actor_vocational, xy_actor.actor_sex,
xy_actor.actor_grade FROM xy_actor WHERE xy_actor.actor_user = '~p'">>, [User#online_user.user]),
			case mysql_lib:recv(Sql, ?DB_GAME) of
				 [] -> 
					 game_server:send(PID, <<10004:32>>);
				 List ->
					 ListData = [Packet(ID, PName, VT, Sex, Grade) || [ID, PName, VT, Sex, Grade] <-List],
					 ListBin  = list_to_binary(ListData),
					 game_server:send(PID, <<10004:32, ListBin/binary>>)
				end
		end,
	ok.

create_actor([PID, PName, VT, Sex]) ->
	case ets:lookup(?ETS_ONLINE_USER, PID) of
		[] ->
			ok;
		[User]-> 
			CountSql = io_lib:format(<<"SELECT Count(*) FROM `xy_actor` WHERE actor_pname= '~s'">>, [PName]),
			case mysql_lib:recv(CountSql, ?DB_GAME) of
				 [[0]] ->
					 ID = integer_to_list(number_mod:create_actor_id()),
				   	 Sql = game_data_1:get_actor_birth_sql(User#online_user.user, ID, PName, Sex, VT),
					 mysql_lib:write(Sql, ?DB_GAME),
					 game_server:send(PID, <<10005:32, 1:8>>);
				   _ ->
					 game_server:send(PID, <<10005:32, 2:8>>)
				end
			
		end,
	ok.