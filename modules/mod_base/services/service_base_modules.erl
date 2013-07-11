%% @author Mawuli Adzaku <mawuli@mawuli.me>
%% @copyright 2013
%% Date: 2013-07-04
%% @doc API for managing modules

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
    Modules = z_context:get_q(modules, Context),    
    io:format("API call: ~p, ~p ~n", [Command,Modules]),
    ok.
