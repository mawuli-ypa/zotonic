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
		   <div class="dropdown">
       		   <button class="btn dropdown-toggle" role="button" data-toggle="dropdown" data-target="#">
		       Actions <b class="caret"></b>
	            </button>
		       <ul class="dropdown-menu pull-right" role="menu" aria-labelledby="dLabel">
                        {% if props.is_active %}
			   {% wire id=deactivate-#id.module action={module_toggle module=module status_id=#status.module} 
			      	    action={toggle_class id=#li.module class="enabled"} %}
			  <li id=deactivate-{{ #id.module }}><a tabindex="-1" href="#"> Deactivate </a></li>
                        {% else %}
			{% wire id=activate-#id.module action={module_toggle module=module status_id=#status.module} 
                           action={toggle_class id=#li.module class="enabled"} %}
                          <li id=activate-{{ #id.module }}><a tabindex="-1" href="#"> Activate </a></li>
                        {% endif %}

			   {% wire id=update-#id.module action={module_update module=module} %}
		           <li><a id=update-{{ #id.module }} tabindex="-1" href="#">Update</a></li>

			   {% wire id=reinstall-#id.module action={module_reinstall module=module} %}
		           <li><a id=reinstall-{{ #id.module }} tabindex="-1" href="#">Reinstall</a></li>

			   <li class="divider"></li>
			   {% wire id=uninstall-#id.module action={module_uninstall module=module} %}
			   <li><a id=uninstall-{{ #id.module }} tabindex="-1" href="#">Uninstall</a></li>
		        </ul>
			</div>
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
