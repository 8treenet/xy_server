%% @author Administrator
%% @doc @todo Add description to game_save.


-module(game_save).
-include("record.hrl").
-include("common.hrl").
%% ====================================================================
%% API functions
%% ====================================================================
-export([start/0]).



%% ====================================================================
%% Internal functions
%% ====================================================================


start() ->
	config_data:save().