%%%--------------------------------------
%%% @Module  : number_mod
%%% @Author  : ys
%%% @Email   : 4932004@qq.com
%%% @Created : 2013.06.20
%%% @Description: 分配id和随机数等
%%%--------------------------------------

-module(number_mod).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start_link/1, create_actor_id/0, create_goods_id/0, create_random/2,create_pet_id/0]).



%% ====================================================================
%% Behavioural functions 
%% ====================================================================
-record(state, {actor_sequence=undefined, goods_sequence=undefined, pet_sequence=undefined}).

%% init/1
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:init-1">gen_server:init/1</a>
-spec init(Args :: term()) -> Result when
	Result :: {ok, State}
			| {ok, State, Timeout}
			| {ok, State, hibernate}
			| {stop, Reason :: term()}
			| ignore,
	State :: term(),
	Timeout :: non_neg_integer() | infinity.
%% ====================================================================
init([]) ->
	process_flag(trap_exit, true),
	random:seed(now()),
	ActorSequence = config_data:read(actor_sequence),
	GoodsSequence = config_data:read(goods_sequence),
	PetSequence = config_data:read(pet_sequence),
    {ok, #state{actor_sequence = ActorSequence, goods_sequence = GoodsSequence, pet_sequence = PetSequence}}.


%% handle_call/3
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_call-3">gen_server:handle_call/3</a>
-spec handle_call(Request :: term(), From :: {pid(), Tag :: term()}, State :: term()) -> Result when
	Result :: {reply, Reply, NewState}
			| {reply, Reply, NewState, Timeout}
			| {reply, Reply, NewState, hibernate}
			| {noreply, NewState}
			| {noreply, NewState, Timeout}
			| {noreply, NewState, hibernate}
			| {stop, Reason, Reply, NewState}
			| {stop, Reason, NewState},
	Reply :: term(),
	NewState :: term(),
	Timeout :: non_neg_integer() | infinity,
	Reason :: term().
%% ====================================================================
handle_call(1, From, State) ->
    Reply = State#state.actor_sequence,
	NewState = State#state{actor_sequence = Reply+1},
    {reply, Reply, NewState};

handle_call(2, From, State) ->
    Reply = State#state.goods_sequence,
    NewState = State#state{goods_sequence = Reply + 1},
    {reply, Reply, NewState};

handle_call(4, From, State) ->
    Reply = State#state.pet_sequence,
    NewState = State#state{pet_sequence = Reply + 1},
    {reply, Reply, NewState};

handle_call({3, Min, Max}, From, State) ->
	 Reply = round(random:uniform() * (Max - Min) + Min),
	 {reply, Reply, State};

handle_call(Request, From, State) ->
    Reply = ok,
    {reply, Reply, State}.


%% handle_cast/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_cast-2">gen_server:handle_cast/2</a>
-spec handle_cast(Request :: term(), State :: term()) -> Result when
	Result :: {noreply, NewState}
			| {noreply, NewState, Timeout}
			| {noreply, NewState, hibernate}
			| {stop, Reason :: term(), NewState},
	NewState :: term(),
	Timeout :: non_neg_integer() | infinity.
%% ====================================================================
handle_cast(Msg, State) ->
    {noreply, State}.


%% handle_info/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:handle_info-2">gen_server:handle_info/2</a>
-spec handle_info(Info :: timeout | term(), State :: term()) -> Result when
	Result :: {noreply, NewState}
			| {noreply, NewState, Timeout}
			| {noreply, NewState, hibernate}
			| {stop, Reason :: term(), NewState},
	NewState :: term(),
	Timeout :: non_neg_integer() | infinity.
%% ====================================================================
handle_info(Info, State) ->
    {noreply, State}.


%% terminate/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:terminate-2">gen_server:terminate/2</a>
-spec terminate(Reason, State :: term()) -> Any :: term() when
	Reason :: normal
			| shutdown
			| {shutdown, term()}
			| term().
%% ====================================================================
terminate(Reason, State) ->
	config_data:save(actor_sequence, State#state.actor_sequence),
	config_data:save(goods_sequence, State#state.goods_sequence),
	config_data:save(pet_sequence,   State#state.pet_sequence),
    ok.


%% code_change/3
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/gen_server.html#Module:code_change-3">gen_server:code_change/3</a>
-spec code_change(OldVsn, State :: term(), Extra :: term()) -> Result when
	Result :: {ok, NewState :: term()} | {error, Reason :: term()},
	OldVsn :: Vsn | {down, Vsn},
	Vsn :: term().
%% ====================================================================
code_change(OldVsn, State, Extra) ->
    {ok, State}.


start_link(StartArgs)->
	gen_server:start({local,?MODULE}, ?MODULE, StartArgs, []).

create_actor_id()->
	gen_server:call(?MODULE, 1).

create_goods_id()->
	gen_server:call(?MODULE, 2).

create_pet_id()->
	gen_server:call(?MODULE, 4).

create_random(Min, Max)->
	gen_server:call(?MODULE, {3,Min,Max}).