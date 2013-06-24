%% @author ys
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


get_actor_birth_sql(Name, ID , PName, Sex, VT) ->
	{Attack_min, Attack_Max, Mattack_min, Mattack_Max,
	 Defense, Mdefense, Hit, Dodge, Crit, Attack_speed,
	 HP_Max, MP_Max} = case VT of
						    1 ->
							  samurai_data:get_attribute(1);
						    2 ->
							  sorcerer_data:get_attribute(1);
						    3 ->
							  bowman_data:get_attribute(1)
						end, 
	 Sql = io_lib:format(<<"INSERT INTO `xy_actor` (`actor_id`, `actor_user`, `actor_pname`,
 `actor_vocational`, `actor_sex`, `actor_grade`, `actor_attack_min`, `actor_attack_max`,
 `actor_mattack_min`, `actor_mattack_max`, `actor_defense`, `actor_mdefense`, `actor_hit`,
 `actor_dodge`, `actor_crit`, `actor_attack_speed`, `actor_attack_addition`, `actor_mattack_addition`, 
`actor_speed`, `actor_hp_max`, `actor_hp`, `actor_mp_max`, `actor_mp`, `actor_exp`, `actor_money`, 
`actor_screen`, `actor_x`, `actor_y`) VALUES ('~s', '~s', '~s', '~p', '~p', '1', '~p', '~p', '~p', '~p', '~p', '~p',
 '~p', '~p', '~p', '~p', '0', '0', '10', '~p', '~p', '~p', '~p', '0', '0', '1', '240', '240')">>,
		 [ID, Name, PName, VT, Sex, Attack_min, Attack_Max, Mattack_min, Mattack_Max,
		  Defense, Mdefense, Hit, Dodge, Crit, Attack_speed, HP_Max, HP_Max,
		  MP_Max, MP_Max]).