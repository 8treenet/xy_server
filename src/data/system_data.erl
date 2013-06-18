%%%--------------------------------------
%%% @Module  : cmd_data
%%% @Author  : ys
%%% @Email   : 4932004@qq.com
%%% @Created : 2013.06.17
%%% @Description: 获取数据
%%%--------------------------------------

-module(system_data).

%% ====================================================================
%% API functions
%% ====================================================================
-export([get/1,format_Binary/2,md5/1]).



%% ====================================================================
%% Internal functions
%% ====================================================================

%%获取时间秒
get(second)->
	calendar:datetime_to_gregorian_seconds(erlang:localtime());

%%获取唯一ID
get(guid)->
	{A,B,C}=now(),
	lists:concat([A,B,C]).

%%组包长度和数据
format_Binary(Head,Bin)->
	Size = size(Bin),
	<<Size:Head,Bin/binary>>.

md5(Data)->
	MD5_16 = erlang:md5(Data),
	lists:flatten([io_lib:format("~2.16.0b", [C]) || <<C>> <= MD5_16]).
