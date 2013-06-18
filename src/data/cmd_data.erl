%%%--------------------------------------
%%% @Module  : cmd_data
%%% @Author  : ys
%%% @Email   : 4932004@qq.com
%%% @Created : 2013.06.7
%%% @Description: 解析协议
%%%--------------------------------------

-module(cmd_data).

%% ====================================================================
%% API functions
%% ====================================================================
-export([cmd/2]).

%% ====================================================================
%% Internal functions
%% ====================================================================

%%解析命令头
%%返回{命令头, 二进制数据}
cmd(_bin, _socket)->
	<<_index:32, _bin2/binary>> = _bin,
	case _index of
		  66->
			  {66,_bin2};
		   _->
			  {_index, get(_index, _bin2, _socket)}
	end.

%%解析角色列表
%%返回{}
get(10004, _bin, Socket)->
	 {};


%%解析登陆游戏服务器
%%返回{用户名和key}
get(10003, _bin, Socket)->
	<<_nameSize:8, _name:_nameSize/binary,SessionKeySize:8/binary,SessionKey:SessionKeySize/binary>> = _bin,
	 {_name, SessionKey};

%%解析获取分区信息
%%返回{}
get(10002, _bin, Socket)->
	 {};


%%解析注册
%%返回{用户名,密码}
get(10000, _bin, Socket)->
	<<_nameSize:8,_name:_nameSize/binary,_pw:32/binary>> = _bin,
	 {_name, _pw};

%%解析登陆
%%返回{用户名,密码}
get(10001, _bin, Socket)->
	<<_nameSize:8,_name:_nameSize/binary,_pw:32/binary>> = _bin,
	{ok,{{A,B,C,D},_}} = inet:peername(Socket),
	Addr_String = lists:concat([A,".",B,".",C,".",D]),
	{_name, _pw, Addr_String}.
