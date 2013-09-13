%% @author Mawuli Adzaku <mawuli@mauwli.me>
%% @copyright 2013, Mawuli Adzaku
%% @date 2013-09-8
%% @doc List all installed modules from the Zotonic Modules Repository 

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

-module(service_admin_modules_list).
-author("Mawuli Adzaku <mawuli@mawuli.me>").

-svc_title("List all installed Zotonic Modules.").
-svc_needauth(false).

-export([process_get/2]).

-include_lib("zotonic.hrl").

process_get(_ReqData, Context) ->
    Sites = z_sites_manager:get_sites(),
    Modules = lists:filter(fun({_Module, ModulePath}) ->
				   z_string:contains("priv", ModulePath) end,
			   z_module_manager:scan(Context)),
    Modules1 = lists:filter(fun(Module) -> lists:member(Module, Sites) =:= false end,
			    lists:map(fun({Module, _ModulePath}) -> Module end, Modules)),
    z_convert:to_json(Modules1).

