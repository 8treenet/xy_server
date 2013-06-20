%%%--------------------------------------
%%% @Module  : config_data
%%% @Author  : ys
%%% @Email   : 4932004@qq.com
%%% @Created : 2013.06.20
%%% @Description: 配置文件等数值
%%%--------------------------------------

-module(config_data).
-include("common.hrl").
-include("record.hrl").
%% ====================================================================
%% API functions
%% ====================================================================
-export([read/1,save/2]).



%% ====================================================================
%% Internal functions
%% ====================================================================


%%读取数据库中的角色序列号
read(actor_sequence) ->
	Sql = io_lib:format(<<"SELECT config_value FROM xy_config WHERE config_id = '~p'">>,[?CONFIG_ACTORR_SEQUENCE]),
	case mysql_lib:recv(Sql, ?DB_GAME) of
		 [] ->
			 error_logger:format("actor_sequence = null");
		 [[Value]] ->
			 list_to_integer(binary_to_list(Value))
	end;

%%读取数据库中的物品序列号
read(goods_sequence)->
	Sql = io_lib:format(<<"SELECT config_value FROM xy_config WHERE config_id = '~p'">>,[?CONFIG_GOODS_SEQUENCE]),
	case mysql_lib:recv(Sql, ?DB_GAME) of
		 [] ->
			 error_logger:format("goods_sequence = null");
		 [[Value]] ->
			 list_to_integer(binary_to_list(Value))
	end.

%%角色序列号保存到数据库
save(actor_sequence, Number)->
	StringNumber = integer_to_list(Number),
	Sql = io_lib:format(<<"UPDATE `xy_config` SET `config_value`='~s' WHERE (`config_id`='~p')">>, [StringNumber, ?CONFIG_ACTORR_SEQUENCE]),
	mysql_lib:write(Sql, ?DB_GAME);

%%物品序列号保存到数据库
save(goods_sequence, Number)->
	StringNumber = integer_to_list(Number),
	Sql = io_lib:format(<<"UPDATE `xy_config` SET `config_value`='~s' WHERE (`config_id`='~p')">>, [StringNumber, ?CONFIG_GOODS_SEQUENCE]),
	mysql_lib:write(Sql, ?DB_GAME).