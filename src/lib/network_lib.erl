%%%--------------------------------------
%%% @Module  : network_lib
%%% @Author  : ys
%%% @Email   : 4932004@qq.com
%%% @Created : 2013.05.29
%%% @Description: 网络模块
%%%--------------------------------------

-module(network_lib).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/1,send/2]).
%%开启网络服务
start([LogicNode,Port,NodeName]) ->
	{ok,Listen} = gen_tcp:listen(Port, [binary, {active,true}, {packet,4}, {packet_size, 1024}]),
	spawn(fun()-> accept(Listen,LogicNode,NodeName) end).

%% ====================================================================
%% Internal functions
%% ====================================================================
%%接收连接

%%循环读取数据
loop(Session,LogicNode,NodeName) ->
	receive
		{tcp, Socket, Bin} ->
			try cmd_data:cmd(Bin, Socket) of
				    {66, _} ->                %%心跳
							  loop(Session, LogicNode, NodeName);
					{Index, Data} ->
									gen_server:cast({NodeName,LogicNode}, {player_recv,self(), Index, Data}),
									loop(Session, LogicNode, NodeName)
						
				catch
					__ ->  
							gen_server:cast({NodeName, LogicNode}, {player_error,self()}),
						    gen_tcp:close(Session)
				end;
		{tcp_closed, _}->
			gen_server:cast({NodeName, LogicNode}, {player_close, self()});
		{tcp_send,Bin}->
			gen_tcp:send(Session, Bin),
			loop(Session,LogicNode,NodeName);
		_ ->
			loop(Session,LogicNode,NodeName)
	after 60500 ->
			gen_server:cast({NodeName,LogicNode}, {player_close,self()}),
			gen_tcp:close(Session)
	end.

accept(Listen,LogicNode,NodeName)->
	case gen_tcp:accept(Listen) of
		{ok, Session} ->
			inet:setopts(Session, [binary,{active,true}, {packet,4},{packet_size, 1024}]),
		    spawn(fun()-> accept(Listen,LogicNode,NodeName) end),
			loop(Session,LogicNode,NodeName);
		_ ->
			ok
	end.
send(PID, Data)->
	PID !Data.
