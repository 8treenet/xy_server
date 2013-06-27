%%%--------------------------------------
%%% @Module  : login_mod
%%% @Author  : ys
%%% @Email   : 4932004@qq.com
%%% @Created : 2013.05.29
%%% @Description: 处理登陆服务器协议逻辑
%%%--------------------------------------
-module(loginServer_mod).

%% ====================================================================
%% API functions
%% ====================================================================
-export([process/1]).

-include("common.hrl").

%% ====================================================================
%% Internal functions
%% ====================================================================


process([PID, Index, Data])->
	process(Index,PID, Data).

%%查询分区信息
process(10002,PID,{})->
	Sql = io_lib:format(<<"SELECT xy_server.server_id, xy_server.server_name,xy_server.server_address,xy_server.server_actors_number FROM xy_server">>,[]),
	List = mysql_lib:recv(Sql, ?DB_USER),
	ListData = [lm_1(ID, Name, Addrs, Number) || [ID, Name, Addrs, Number]<-List],
	Data = list_to_binary(ListData),
	network_lib:send(PID, <<10002:32,Data/binary>>),
	ok;

%%登陆
process(10001,PID,{Name, PW, Addr})->
	Sql1 = io_lib:format(<<"SELECT Count(*) FROM `xy_ip` WHERE ip_addr='~s'">>, [Addr]),
	Counts = case mysql_lib:recv(Sql1, ?DB_USER) of
		 [[Count]] ->
			 	    Count;
		 _ ->
			 0
		end,
	Logic = if
			Counts >8 ->
						 io:format("login ip error~n"),
					     network_lib:send(PID, <<10000:32, 4:8>>),
					     false;
			true ->     
				  Sql8 = io_lib:format(<<"SELECT Count(*) FROM `xy_user` WHERE user_name='~s' AND user_status = ~p" >>, [Name,2]),
				  case mysql_lib:recv(Sql8, ?DB_USER) of
					   [[0]] ->
						   true;
					   _ ->
						    io:format("login user statu=2~n"),
						   network_lib:send(PID, <<10000:32, 3:8>>),
						   false
				  end
			
			end,
	if
		Logic == true ->
						Sql9 = io_lib:format(<<"SELECT xy_user.user_id FROM xy_user WHERE xy_user.user_name = '~s' AND xy_user.user_password = '~s'" >>,[Name,PW]),
									case mysql_lib:recv(Sql9, ?DB_USER) of
										[] -> 
											io:format("login password error~n"),
											network_lib:send(PID, <<10000:32, 2:8>>),
											Sql33 = io_lib:format(<<"INSERT INTO `xy_ip` (`ip_addr`) VALUES ('~s')">>, [Addr]),
											mysql_lib:write(Sql33, ?DB_USER);
											
										[[User_id]]  -> 
													io:format("login ok~n"),
													{_, _, Key} = now(),
													Time = integer_to_list(system_data:get(second)),
													SessionKey = system_data:md5(integer_to_list(Key)),
													SessionKeyBin = system_data:format_Binary(8, list_to_binary(SessionKey)),
													Sql22 = io_lib:format(<<"UPDATE `xy_user` SET `user_key`='~s', `user_login_time` = '~s'   WHERE `user_name` = '~s'">>, [SessionKey, Time, Name]),
													mysql_lib:write(Sql22, ?DB_USER),
													network_lib:send(PID, <<10000:32, 1:8, SessionKeyBin/binary>>)
											
										end;
		true ->
			ok
	end,
	ok;

%%注册
process(10000, PID, {Name, PW})->
	StrName = binary_to_list(Name),
	case re:run(StrName, "[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-z]{2,3}") of
		{match,[{0,_}]} -> 
				Sql = io_lib:format(<<"SELECT xy_user.user_id FROM xy_user WHERE xy_user.user_name = '~s'">>,[Name]),
				case mysql_lib:recv(Sql, ?DB_USER) of
					[] -> 
						Time = integer_to_list(system_data:get(second)),
						Sql2 = io_lib:format(<<"INSERT INTO `xy_user` (`user_name`, `user_password`, `user_money`, `user_status`, `user_key`, `user_register_time`, `user_login_time`) VALUES ('~s', '~s', '0', ~p, '0', '~s', '~s')">>, [Name,PW,1,Time,Time]),
						mysql_lib:write(Sql2, ?DB_USER),
						io:format("name ok~n"),
						network_lib:send(PID, <<10000:32,1:8>>);
					    
					_  -> 
						io:format("name not null~n"),
						network_lib:send(PID, <<10000:32,3:8>>)
					end;
			_ ->
				io:format("name error~n"),
				network_lib:send(PID, <<10000:32,2:8>>),
				ok
		end,
	ok;

process(_, _, _)->
	ok.

lm_1(ID, Name, Addrs, Number) ->
	io:format("ID:~p, Name:~p, Addrs:~p, Number:~p ~n",[ID,Name,Addrs,Number]),
	Name_Bin = system_data:format_Binary(8, Name),
	Addrs_Bin  =   system_data:format_Binary(8, Addrs),
	Number_Bin = if
					 Number >= 800 -> 
						 	3;
					 (Number =<800) and (Number >= 400) ->
						    2;
					 true ->
						 	1
				 end,
		<<ID:32, Name_Bin/binary, Addrs_Bin/binary, Number_Bin:8>>.