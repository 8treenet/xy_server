%% @author Administrator
%% @doc @todo Add description to game_data_1.


-module(game_data_1).
-compile(export_all).
%% ====================================================================
%% API functions
%% ====================================================================
-export([]).



%% ====================================================================
%% Internal functions
%% ====================================================================


get_actor_birth_sql(Name, Id , PName, Sex, VT) ->
	 Sql = io_lib:format(<<"">>, []).