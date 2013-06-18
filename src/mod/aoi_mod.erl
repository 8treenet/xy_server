%%%--------------------------------------
%%% @Module  : aoi_mod
%%% @Author  : ys
%%% @Email   : 4932004@qq.com
%%% @Created : 2013.05.29
%%% @Description: 基于四叉树的场景管理
%%%--------------------------------------
-module(aoi_mod).
-include("record.hrl").


%%四叉树节点
-record(node, {name, x, y, width, height, node1, node2, node3, node4, actors}).


-export([test_create/0, test_start/1, create_aoi/3, insert_actor/4, update_actor/3, delete_actor/1, get_actors/4]).

%%创建场景aoi
create_aoi(Width, Height, Layer) ->
	create_node(root_node, 0, 0, Width, Height, Layer),
	ok.

%%插入一个actor
insert_actor(ID,Type, X, Y) ->
	    case get(ID) of
			 undefined ->
							NodeName = point_is_node(X, Y),
							ActorPos = #aoi_actor{id=ID, x=X, y=Y, type=Type, node_name=NodeName},
							put(ID, ActorPos),
							Node = get(NodeName),
							Actors = Node#node.actors,
							NewActors =[ActorPos|Actors],
							NewNode = Node#node{actors=NewActors},
							put(NodeName, NewNode)
		end.

%%删除一个actor
delete_actor(ID)->
		case get(ID) of
				undefined -> {ok,undefined};
				ActorPos ->	 NodeName = ActorPos#aoi_actor.node_name,
							 Node = get(NodeName),
							 Actors = Node#node.actors,
							 NewActors = lists:delete(ActorPos, Actors),
							 NewNode = Node#node{actors=NewActors},
							 put(NodeName, NewNode),
							 erase(ID),
							 {ok,1}
			end.

%%更新一个actor
update_actor(ID, X ,Y) ->
	 case get(ID) of
			 undefined ->
							ok;
		 	 ActorPos  ->   NodeName = ActorPos#aoi_actor.node_name,
							Node = get(NodeName),
							Bool = cmp(X, Y, Node),
							if
								Bool == true ->  NewActorsPos = ActorPos#aoi_actor{x=X, y=Y},
										 		 put(ID, NewActorsPos),
												 {ok, update};
								true ->	 Actors = Node#node.actors,
										 NewActors = lists:delete(ActorPos, Actors),
										 NewNode = Node#node{actors=NewActors},
										 put(NodeName, NewNode),
										 
										 NextNodeName = point_is_node(X, Y),
										 NextNode = get(NextNodeName),
										 NextActors = NextNode#node.actors,
										 NewNextActors = [ActorPos|NextActors],
										 NewNextNode = NextNode#node{actors=NewNextActors},
										 put(NextNodeName, NewNextNode),
										 NewActorsPos = ActorPos#aoi_actor{x=X, y=Y, node_name=NextNodeName},
										 put(ID, NewActorsPos),
										 {ok,normal}
							end
							
	end.

%%获取一个范围的ID
get_actors(X, Y, Width, Height)->
	rectangle_is_actors(root_node, X, Y, Width, Height).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%创建四叉树节点
create_node(NodeName, X, Y, Width, Height, Layer) ->
	if
		Layer == 1 ->
					Node = #node{name=NodeName, x=X, y=Y, height=Height, width=Width,node1=undefined, node2=undefined, node3=unedfined, node4=undefined, actors=[]},
					put(NodeName, Node);
					
		true -> 
				N1 = system_data:get(guid),
				N2 = system_data:get(guid),
				N3 = system_data:get(guid),
				N4 = system_data:get(guid),
				Node = #node{name=NodeName, x=X, y=Y, height=Height, width=Width,node1=N1, node2=N2, node3=N3, node4=N4, actors=[]},
				put(NodeName, Node),
				{X1, Y1, W1, H1} = get_tree(1, X, Y, Width, Height),
				{X2, Y2, W2, H2} = get_tree(2, X, Y, Width, Height),
				{X3, Y3, W3, H3} = get_tree(3, X, Y, Width, Height),
				{X4, Y4, W4, H4} = get_tree(4, X, Y, Width, Height),
				create_node(N1, X1, Y1, W1, H1, Layer-1),
				create_node(N2, X2, Y2, W2, H2, Layer-1),
				create_node(N3, X3, Y3, W3, H3, Layer-1),
				create_node(N4, X4, Y4, W4, H4, Layer-1),
				ok
	end.

%%切割四叉树
get_tree(Pos,X, Y, Width, Height) ->
	case Pos of
		1->
			{X, Y, Width/2, Height/2};
		2-> 
			{X+Width/2, Y, Width/2, Height/2};
		3-> 
			{X, Y+Height/2, Width/2, Height/2};
		4->
			{X+Width/2, Y+Height/2, Width/2, Height/2}
		end.

%%通过某个点获得四叉树节点
point_is_node(X, Y) ->
			pin_node(root_node, X, Y).
pin_node(undefined, _, _) ->root_node;
pin_node(NodeName, X, Y) ->
		Node = get(NodeName),
		N1Name = Node#node.node1,
		N2Name = Node#node.node2,
		N3Name = Node#node.node3,
		N4Name = Node#node.node4,
		if
			N1Name == undefined ->
									NodeName;
			true ->
					N1 = get(N1Name),
					N2 = get(N2Name),
					N3 = get(N3Name),
					N4 = get(N4Name),
					B1 = cmp(X, Y, N1),
					B2 = cmp(X, Y, N2),
					B3 = cmp(X, Y, N3),
					B4 = cmp(X, Y, N4),
					N = if
							B1 == true-> N1#node.name;
							B2 == true-> N2#node.name;
							B3 == true-> N3#node.name;
							B4 == true-> N4#node.name;
							true -> undefined
						end,
					pin_node(N, X, Y)
		end.

%%点碰撞
cmp(X, Y, Node)->
	if
		(Node#node.x+Node#node.width > X) and
		(Node#node.x =< X) and
		(Node#node.y+Node#node.height > Y) and
		(Node#node.y =< Y) ->
											 true;
		true ->
				false
	end.

%%矩形碰撞
cmp(X, Y, Width, Height, Node)->
	if

		(X+Width > Node#node.x) and
		(X =< Node#node.x+Node#node.width) and
		(Y+Height > Node#node.y) and
		(Y =< Node#node.y+Node#node.height)->
							true;
		true ->
				false
	end.

%%矩形范围内的actor
rectangle_is_actors(NodeName, X, Y, Width, Height)->
	Node = get(NodeName),
	Collide = cmp(X, Y, Width, Height, Node),
	if
			Collide == true ->
						N1Name = Node#node.node1,
						N2Name = Node#node.node2,
						N3Name = Node#node.node3,
						N4Name = Node#node.node4,
						if
							N1Name == undefined ->
									  Node#node.actors;
							true ->
									  Actors1 = rectangle_is_actors(N1Name, X, Y, Width, Height),
									  Actors2 = rectangle_is_actors(N2Name, X, Y, Width, Height),
									  Actors3 = rectangle_is_actors(N3Name, X, Y, Width, Height),
									  Actors4 = rectangle_is_actors(N4Name, X, Y, Width, Height),
									  Actors1++Actors2++Actors3++Actors4
									 
						end;
			 true->[]
	end.
%%创建测试场景
test_create()->
	create_aoi(1200, 1200, 6),
	List=lists:seq(1, 1000),
	random:seed(now()),
	lists:foreach(fun(X)-> A = random:uniform(1200),
						   B = random:uniform(1200),
						   insert_actor(X,2, A, B)
				  end, List).

%%开始测试 测试查询次数
test_start(Max)->
	StratTime = now(),
	test(Max),
	EndTime = now(),
	Time= timer:now_diff(EndTime, StratTime),
	io:format("Time:~p~n",[Time]).
test(0)->ok;
test(Max)->
	A = random:uniform(1200),
	B = random:uniform(1200),
	get_actors(A, B, 20, 20),
	test(Max-1).