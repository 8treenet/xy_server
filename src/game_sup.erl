%% @author Administrator
%% @doc @todo Add description to logic_sup.


-module(game_sup).
-behaviour(supervisor).
-export([init/1]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start_link/0,start_child/2]).



%% ====================================================================
%% Behavioural functions 
%% ====================================================================

%% init/1
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/supervisor.html#Module:init-1">supervisor:init/1</a>
-spec init(Args :: term()) -> Result when
	Result :: {ok, {SupervisionPolicy, [ChildSpec]}} | ignore,
	SupervisionPolicy :: {RestartStrategy, MaxR :: non_neg_integer(), MaxT :: pos_integer()},
	RestartStrategy :: one_for_all
					 | one_for_one
					 | rest_for_one
					 | simple_one_for_one,
	ChildSpec :: {Id :: term(), StartFunc, RestartPolicy, Type :: worker | supervisor, Modules},
	StartFunc :: {M :: module(), F :: atom(), A :: [term()] | undefined},
	RestartPolicy :: permanent
				   | transient
				   | temporary,
	Modules :: [module()] | dynamic.
%% ====================================================================
init([]) ->
    AChild = {game_server,{game_server,start_link,[["36469805","localhost","36469805"]]},
	      permanent,2000,worker,[game_server]},
    {ok,{{one_for_one,1,60}, []}}.

%% ====================================================================
%% Internal functions
%% ====================================================================

start_link()->
	supervisor:start_link({local,?MODULE},?MODULE,[]).

%%加入监控的server模块,
%%server模块名,参数
start_child(Server,Permanent)->
	supervisor:start_child(?MODULE, {Server,{Server,start_link,[Permanent]},
	      temporary,infinity,worker,[Server]}).