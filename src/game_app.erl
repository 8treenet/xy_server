%% @author Administrator
%% @doc @todo Add description to logic_app.


-module(game_app).
-behaviour(application).
-export([start/2, stop/1]).
-include("record.hrl").

%% ====================================================================
%% API functions
%% ====================================================================
-export([]).



%% ====================================================================
%% Behavioural functions
%% ====================================================================

%% start/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/apps/kernel/application.html#Module:start-2">application:start/2</a>
-spec start(Type :: normal | {takeover, Node} | {failover, Node}, Args :: term()) ->
	{ok, Pid :: pid()}
	| {ok, Pid :: pid(), State :: term()}
	| {error, Reason :: term()}.
%% ====================================================================
%%应用程序启动参数 StartArgs=[本机数据库密码,登陆数据库IP,登陆数据库密码,网关节点]
start(Type, StartArgs) ->
    case logic_sup:start_link() of
		{ok, Pid} ->
			[LocalPW,LoginHost,LoginPW]=StartArgs,
			
			logic_sup:start_child(game_server, []),
			{ok, Pid};
		Error ->
			Error
    end.

%% stop/1
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/apps/kernel/application.html#Module:stop-1">application:stop/1</a>
-spec stop(State :: term()) ->  Any :: term().
%% ====================================================================
stop(State) ->
    ok.

%% ====================================================================
%% Internal functions
%% ====================================================================

