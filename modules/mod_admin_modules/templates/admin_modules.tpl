{% extends "admin_base.tpl" %}

{% block title %}{_ Modules _}{% endblock %}

{% block content %}

<div class="edit-header">
    <h2>{_ Modules _}</h2>
    <p>{_ Zotonic is a modular web development framework. Most functionality is encapsulated inside modules. A set of basic modules are shipped with the Zotonic distribution,
    while others are externally developed. This page shows an overview of all modules which are currently known to this Zotonic installation. _}</p>

{% button class="btn btn-primary pull-right" text="Install modules" 
action={dialog_open title="Zotonic Module Repository" template="action_dialog_zmr.tpl"} %}
</div>

<div {% include "_language_attrs.tpl" language=`en` %}>
    <table class="table table-striped">
        <thead>
            <tr>
                <th width="20%">{_ Title _}</th>
                <th width="45%">{_ Description _}</th>
                <th width="5%">{_ Prio _}</th>
                <th width="30%">{_ Author _}</th>
            </tr>
        </thead>
        
        <tbody>
            {% for sort, prio, module, props in modules %}
            <tr id="{{ #li.module }}" class="{% if not props.is_active %}unpublished{% endif %}">
                <td>{% include "_icon_status.tpl" status_title=status[module] status=status[module] status_id=#status.module %} {{ props.mod_title|default:props.title }}</td>
                <td>{{ props.mod_description|default:"-" }}</td>
                <td>{{ prio }}</td>
                <td>
                   <div class="pull-right">
		  {% if props.path|match:"priv/modules" or props.path|match:"priv/sites/" %}
		   <div class="dropdown">
       		   <button class="btn dropdown-toggle" role="button" data-toggle="dropdown" data-target="#">
		       Actions <b class="caret"></b>
	            </button>
		       <ul class="dropdown-menu pull-right" role="menu" aria-labelledby="dLabel">
                        {% if props.is_active %}
			   {% wire id=#id.module action={module_toggle module=module status_id=#status.module} 
			      	    action={toggle_class id=#li.module class="enabled"} %}
			  <li><a tabindex="-1" href="#" id={{ #id.module }}> Deactivate </a></li>
                        {% else %}
			{% wire id=#id.module action={module_toggle module=module status_id=#status.module} 
                           action={toggle_class id=#li.module class="enabled"} %}
                          <li><a id={{ #id.module }} tabindex="-1" href="#"> Activate </a></li>
                        {% endif %}

			{% with "up" ++ #id.module, "re" ++ #id.module, "un" ++ #id.module as updateid, reinstallid, uninstallid %} 
			   {% wire id=updateid action={module_update module=module} %}
		           <li><a id={{ updateid }} tabindex="-1" href="#">Update</a></li>

			   {% wire id=reinstallid action={module_reinstall module=module} %}
		           <li><a id={{ reinstallid }} tabindex="-1" href="#">Reinstall</a></li>

			   <li class="divider"></li>
			   {% wire id=uninstallid action={module_uninstall module=module} %}
			   <li><a id={{ uninstallid }} tabindex="-1" href="#">Uninstall</a></li>
			{% endwith %}
		        </ul>
			</div>
		  {% else %}
                        {% if props.is_active %}
                        {% button text=_"Deactivate"
                           class="btn btn-mini"
                           action={module_toggle module=module status_id=#status.module}
                           action={toggle_class id=#li.module class="enabled"} %}
                        {% else %}
                        {% button text=_"Activate"
                           class="btn btn-mini btn-success"
                           action={module_toggle module=module status_id=#status.module} 
                           action={toggle_class id=#li.module class="enabled"} %}
                        {% endif %}		  
		  {% endif %}
                    </div>

                    {{ props.author|escape|default:"-" }}
                </td>
            </tr>
            {% empty %}
            <tr>
                <td colspan="4">
                    {_ No modules found _}
                </td>
            </tr>
            {% endfor %}
        </tbody>
    </table>

</div>
{% endblock %}
