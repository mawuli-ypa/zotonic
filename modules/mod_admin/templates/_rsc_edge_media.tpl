{# Show a thumbnail with an unlink option. Used in the admin_edit #}

{% sortable id=#unlink_wrapper tag=edge_id %}
<li id="{{ #unlink_wrapper }}">
    <div class="thumbnail">
        {% image object_id width=187 height=200 extent %}

        <div class="caption">
            {% with m.rsc[object_id].title|striptags|default:_"untitled" as title %}
            <div class="pull-right">
                <button id="{{ #unlink.object_id }}" class="btn btn-mini" title="{_ Disconnect _} {{title}}."><i class="icon-remove"></i></button>
            </div>
            <h5><a href="#" id="{{ #edit }}">{{ title }}</a></h5>
            {% endwith %}
	</div>
    </div>
</li>

{% wire id=#unlink.object_id
        action={unlink 
        subject_id=subject_id 
        predicate="depiction" 
        object_id=object_id 
        hide=#unlink_wrapper
        undo_message_id=unlink_message 
        undo_action={postback postback={reload_media rsc_id=id div_id=div_id} delegate="resource_admin_edit"}} 
%}
{% wire id=#edit action={dialog_edit_basics edge_id=edge_id template="_rsc_edge_media.tpl"} %}
