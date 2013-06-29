%%%--------------------------------------
%%% @Module  : config_data
%%% @Author  : ys
%%% @Email   : 4932004@qq.com
%%% @Created : 2013.06.20
%%% @Description: 配置文件等数值
%%%--------------------------------------

-module(config_data).
-include("common.hrl").

%% ====================================================================
%% API functions
%% ====================================================================
-export([init/0,read/1,save/0]).
-record(config,{key,value}).
-define(CONFIG_ACTORR_SEQUENCE, 1).             			 %%当前分配角色ID序列号
-define(CONFIG_GOODS_SEQUENCE, 2).              			 %%当前分配物品ID序列号
-define(CONFIG_PET_SEQUENCE, 3).              		    	 %%当前分配宠物ID序列号

init() ->
	ets:new(ets_config, [public, set, named_table, 
							  {keypos,#config.key}, 
							  {write_concurrency,true},
							  {read_concurrency,true}]),                 
	Sql1 = io_lib:format(<<"SELECT config_value FROM xy_config WHERE config_id = '~p'">>,[?CONFIG_ACTORR_SEQUENCE]),
		case mysql_lib:recv(Sql1, ?DB_GAME) of
			 [] ->
				 error_logger:format("actor_sequence = null");
			 [[Value1]] ->
				 Seq1 = list_to_integer(binary_to_list(Value1)),
				 SeqConfig1 = #config{key = ?CONFIG_ACTORR_SEQUENCE,
									   value = Seq1},
				 ets:insert(ets_config, SeqConfig1)
		end,
	Sql2 = io_lib:format(<<"SELECT config_value FROM xy_config WHERE config_id = '~p'">>,[?CONFIG_GOODS_SEQUENCE]),
		case mysql_lib:recv(Sql2, ?DB_GAME) of
			 [] ->
				 error_logger:format("goods_sequence = null");
			 [[Value2]] ->
				  Seq2 = list_to_integer(binary_to_list(Value2)),
				  SeqConfig2 = #config{key = ?CONFIG_GOODS_SEQUENCE,
									   value = Seq2},
				  ets:insert(ets_config, SeqConfig2)
		end,
	Sql3 = io_lib:format(<<"SELECT config_value FROM xy_config WHERE config_id = '~p'">>,[?CONFIG_PET_SEQUENCE]),
	case mysql_lib:recv(Sql3, ?DB_GAME) of
		 [] ->
			 error_logger:format("pet_sequence = null");
		 [[Value3]] ->
			Seq3 = list_to_integer(binary_to_list(Value3)),
			SeqConfig3 = #config{key = ?CONFIG_PET_SEQUENCE,
									   value = Seq3},
				  ets:insert(ets_config, SeqConfig3)
	end,

    ok.
%%读取角色序列号
read(actor_sequence) ->
	[Config] = ets:lookup(ets_config, ?CONFIG_ACTORR_SEQUENCE),
	Seq = Config#config.value,
	ets:update_element(ets_config, ?CONFIG_ACTORR_SEQUENCE, {#config.value, Seq+1}),
	Seq;
%%读取物品序列号
read(goods_sequence)->
	[Config] = ets:lookup(ets_config, ?CONFIG_GOODS_SEQUENCE),
	Seq = Config#config.value,
	ets:update_element(ets_config, ?CONFIG_GOODS_SEQUENCE, {#config.value, Seq+1}),
	Seq;
%%读取宠物序列号
read(pet_sequence)->
    [Config] = ets:lookup(ets_config, ?CONFIG_PET_SEQUENCE),
	Seq = Config#config.value,
	ets:update_element(ets_config, ?CONFIG_PET_SEQUENCE, {#config.value, Seq+1}),
	Seq.

%%角色序列号保存到数据库
save(actor_sequence)->
	[Config] = ets:lookup(ets_config, ?CONFIG_ACTORR_SEQUENCE),
	Value = integer_to_list(Config#config.value),
	Sql = io_lib:format(<<"UPDATE `xy_config` SET `config_value`='~s' WHERE (`config_id`='~p')">>, [Value, ?CONFIG_ACTORR_SEQUENCE]),
	mysql_lib:write(Sql, ?DB_GAME);

%%物品序列号保存到数据库
save(goods_sequence)->
	[Config] = ets:lookup(ets_config, ?CONFIG_GOODS_SEQUENCE),
	Value = integer_to_list(Config#config.value),
	Sql = io_lib:format(<<"UPDATE `xy_config` SET `config_value`='~s' WHERE (`config_id`='~p')">>, [Value, ?CONFIG_GOODS_SEQUENCE]),
	mysql_lib:write(Sql, ?DB_GAME);

%%物品序列号保存到数据库
save(pet_sequence)->
	[Config] = ets:lookup(ets_config, ?CONFIG_PET_SEQUENCE),
	Value = integer_to_list(Config#config.value),
	Sql = io_lib:format(<<"UPDATE `xy_config` SET `config_value`='~s' WHERE (`config_id`='~p')">>, [Value, ?CONFIG_PET_SEQUENCE]),
	mysql_lib:write(Sql, ?DB_GAME).

save() ->
	save(actor_sequence),
	save(goods_sequence),
	save(pet_sequence),
	ok.