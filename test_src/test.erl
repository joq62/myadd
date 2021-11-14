%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description :  
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(test).   
   
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
%-include_lib("eunit/include/eunit.hrl").
%% --------------------------------------------------------------------

%% External exports
-export([start/0]). 


%% ====================================================================
%% External functions
%% ====================================================================


%% --------------------------------------------------------------------
%% Function:tes cases
%% Description: List of test cases 
%% Returns: non
%% --------------------------------------------------------------------
start()->
    io:format("~p~n",[{"Start setup",?MODULE,?FUNCTION_NAME,?LINE}]),
    ok=setup(),
    io:format("~p~n",[{"Stop setup",?MODULE,?FUNCTION_NAME,?LINE}]),

    io:format("~p~n",[{"Start pass_0()",?MODULE,?FUNCTION_NAME,?LINE}]),
    ok=pass_0(),
    io:format("~p~n",[{"Stop pass_0()",?MODULE,?FUNCTION_NAME,?LINE}]),

    io:format("~p~n",[{"Start pass_1()",?MODULE,?FUNCTION_NAME,?LINE}]),
    ok=pass_1(),
    io:format("~p~n",[{"Stop pass_1()",?MODULE,?FUNCTION_NAME,?LINE}]),

%    io:format("~p~n",[{"Start pass_2()",?MODULE,?FUNCTION_NAME,?LINE}]),
%    ok=pass_2(),
%    io:format("~p~n",[{"Stop pass_2()",?MODULE,?FUNCTION_NAME,?LINE}]),

%    io:format("~p~n",[{"Start pass_3()",?MODULE,?FUNCTION_NAME,?LINE}]),
%    ok=pass_3(),
%    io:format("~p~n",[{"Stop pass_3()",?MODULE,?FUNCTION_NAME,?LINE}]),

  %  io:format("~p~n",[{"Start pass_4()",?MODULE,?FUNCTION_NAME,?LINE}]),
  %  ok=pass_4(),
  %  io:format("~p~n",[{"Stop pass_4()",?MODULE,?FUNCTION_NAME,?LINE}]),

  %  io:format("~p~n",[{"Start pass_5()",?MODULE,?FUNCTION_NAME,?LINE}]),
  %  ok=pass_5(),
  %  io:format("~p~n",[{"Stop pass_5()",?MODULE,?FUNCTION_NAME,?LINE}]),
 
    
   
      %% End application tests
    io:format("~p~n",[{"Start cleanup",?MODULE,?FUNCTION_NAME,?LINE}]),
    ok=cleanup(),
    io:format("~p~n",[{"Stop cleaup",?MODULE,?FUNCTION_NAME,?LINE}]),
   
    io:format("------>"++atom_to_list(?MODULE)++" ENDED SUCCESSFUL ---------"),
    ok.


%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
pass_0()->
    
    PidA=slave_start(a,"-pa ebin -config a.config -setcookie cookie"),
    PidB=slave_start(b,"-pa ebin -config b.config -setcookie cookie"),

    receive
	{PidA,{ok,A}}->
	    ok=rpc:call(A,application,start,[myadd])
    end,
    receive
	{PidB,{ok,B}}->
	    ok=rpc:call(B,application,start,[myadd])
    end,
    
    true=net_kernel:connect_node(A),
    true=net_kernel:connect_node(B),

 %   ok=rpc:call(A,application,start,[myadd]),
 %   ok=rpc:call(B,application,start,[myadd]),

    io:format("A ~p~n",[rpc:call(A,application,which_applications,[],2000)]),
    io:format("B ~p~n",[rpc:call(B,application,which_applications,[],2000)]),  

    42=rpc:call(A,myadd,add,[20,22]),
    {badrpc,_}=rpc:call(B,myadd,add,[20,22]),    
    
    slave:stop(A),
    timer:sleep(600),
    io:format("A ~p~n",[rpc:call(A,application,which_applications,[],2000)]),
    io:format("B ~p~n",[rpc:call(B,application,which_applications,[],2000)]),  

    {badrpc,_}=rpc:call(A,myadd,add,[20,22]),
    42=rpc:call(B,myadd,add,[20,22]),      

    {ok,A}=slave:start("c100", a,"-pa ebin -config a.config -setcookie cookie"),
    ok=rpc:call(A,application,start,[myadd]),
    timer:sleep(600),
    io:format("A ~p~n",[rpc:call(A,application,which_applications,[],2000)]),
    io:format("B ~p~n",[rpc:call(B,application,which_applications,[],2000)]),  

   
    slave:stop(B),
    timer:sleep(1000),
    io:format("A ~p~n",[rpc:call(A,application,which_applications,[],2000)]),
    io:format("B ~p~n",[rpc:call(B,application,which_applications,[],2000)]),  

    42=rpc:call(A,myadd,add,[20,22]),
    {badrpc,_}=rpc:call(B,myadd,add,[20,22]),  
    
    ok.

slave_start(Name,Args)->
    S=self(),
    Pid=spawn(fun()-> slave_start(S,Name,Args) end).

slave_start(Pid,Name,Args)->
    R=slave:start("c100", Name, Args),
    S=self(),
    Pid!{S,R}.
    
    
  
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
pass_1()->
   
    ok.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
pass_5()->

    ok.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
pass_3()->
  
    ok.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
pass_4()->
  
    ok.


%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
pass_2()->
  
    
    ok.


%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
-define(APP,kubelet). 
setup()->
   
    ok.


%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------    

cleanup()->
  
    ok.
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
