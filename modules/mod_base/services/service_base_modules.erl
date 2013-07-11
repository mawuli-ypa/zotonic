%% @author Mawuli Adzaku <mawuli@mawuli.me>
%% @copyright 2013
%% Date: 2013-07-04
%% @doc HTTP API for managing modules 

%% Copyright 2013 Mawuli Adzaku
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%% 
%%     http://www.apache.org/licenses/LICENSE-2.0
%% 
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

-module(service_base_modules).
-author("Mawuli Adzaku <mawuli@mawuli.me>").

-svc_title("API for managing modules.").
-svc_needauth(false).

-export([process_get/2]).
-include_lib("zotonic.hrl").


process_get(_ReqData, Context) ->
    Command = erlang:list_to_atom(z_context:get_q(command, Context, "")),
    Tokens = string:tokens(z_context:get_q(modules, Context, ""),"'"),   
    Modules = lists:filter(fun(X) -> lists:sublist(X,3) == "mod" end, Tokens).   
    Response = case command(Command, Modules, Context) of
                   {error, ErrorMessage} ->
                       {error, ErrorMessage};
                   Oks -> 
                       ok
               end,
    z_convert:to_json([Response]).

-type command :: activate | deactiavte | restart
%% @spec command(command(), list(), #context{}) -> list() || {error, list()} 
command(activate,Modules, Context) when is_list(Modules) ->
    lists:map(fun(Module)-> z_module_manager:activate(Module, Context) end, Modules);
command(deactivate,Modules, Context) when is_list(Modules) ->
    lists:map(fun(Module)-> z_module_manager:deactivate(Module, Context) end, Modules);
command(restart,Modules, Context) when is_list(Modules) ->
    lists:map(fun(Module)-> z_module_manager:restart(Module, Context) end, Modules);
command(_Command, _Modules, _Context) ->
    {error, "unsupported command"}.
