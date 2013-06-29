%% @author Administrator
%% @doc @todo Add description to mysql_lib.


-module(mysql_lib).
-define(DB, mysql_conn_poll).
-define(DB_PORT, 3306).
-define(DB_NAME, "xy").
-define(DB_USER, "root").
%%-define(DB_PASS, "36469805").
-define(DB_ENCODE, utf8).
%% ====================================================================
%% API functions
%% ====================================================================
-export([conn/3, write/2, recv/2]).



%% ====================================================================
%% Internal functions
%% ====================================================================
%%连接mysql数据库
%%CONN_NAME=连接名,HOST=IP,PASS=密码, DB_NAME=数据库名称
conn(CONN_NAME, HOST, PASS)->
		mysql:start_link(CONN_NAME, HOST, ?DB_PORT, ?DB_USER, PASS, ?DB_NAME,fun(_, _, _, _) -> ok end).
		


%%写入数据库 
%%Sql=sql语句, Conn_Name=连接原子名称
write(Sql,Conn_Name)->
	mysql:fetch(Conn_Name, Sql).

%%读数据库 
%%Sql=sql语句,Conn_Name=连接原子名称
%%返回查询数据列表
recv(Sql, Conn_Name)->
	case mysql:fetch(Conn_Name, Sql) of
			{data,MySQLRes}-> case mysql:get_result_rows(MySQLRes) of
							  []->[];
							  List->List
							  end;
		_->[]
	end.

