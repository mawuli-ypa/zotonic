{% extends "admin_base.tpl" %}

{% block title %}{_ Edit _} “{{ m.rsc[id].title }}”{% endblock %}


{% block content %}
{% with m.rsc[id] as r %}
{% with r.is_editable as is_editable %}
{% with m.config.i18n.language_list.list as languages %}

<div>
    <div class="pull-right">
        <div class="alert alert-info">
	    {_ Modified _} {{ r.modified|timesince }}
	    {_ by _} {{ m.rsc[r.modifier_id].title }}.<br/>
	    {_ Created by _} {{ m.rsc[r.creator_id].title }}.
        </div>
    </div>

    {% if not is_editable %}
    <h2>
	{_ You are not allowed to edit the _} {{ m.rsc[r.category_id].title|lower }} “<span {% include "_language_attrs.tpl" %}>{{ r.title|striptags }}</span>”
    </h2>
    {% else %}
    <p class="admin-chapeau">
        {_ editing _}:
    </p>
    
    <h2 {% include "_language_attrs.tpl" %}>{{ r.title|striptags|default:_"<em>untitled</em>" }}

    {% if m.acl.insert[r.category.name|as_atom] and not r.is_a.meta %}
    <small>
        {{ m.rsc[r.category_id].title|lower }}
        <a class="btn btn-mini" href="javascript:;" id="changecategory" title="{_ Change category _}">
        {_ change _}</a>
        {% wire id="changecategory" action={dialog_open title=_"Change category" template="_action_dialog_change_category.tpl" id=id} %}
    </small>
    {% endif %}

    </h2>
    {% endif %}{# editable #}
</div>

    {% block admin_edit_form_pre %}{% endblock %}

    {% wire id="rscform" type="submit" postback="rscform" %}
    <form id="rscform" method="post" action="postback" class="row">
        <button style="display:none"></button><!-- for saving on press enter -->
	<input type="hidden" name="id" value="{{ id }}" />

	<div class="span8" id="poststuff">

	    {% all catinclude "_admin_edit_basics.tpl" id is_editable=is_editable languages=languages %}
	    {% all catinclude "_admin_edit_content.tpl" id is_editable=is_editable languages=languages %}

	    {% if r.is_a.media or r.medium %}
                {% include "_admin_edit_content_media.tpl" %}

		{% if is_editable %}
                    {% include "_admin_edit_content_website.tpl" %}
		{% endif %}
	    {% endif %}{# medium #}


	    {% catinclude "_admin_edit_body.tpl" id is_editable=is_editable languages=languages %}

	    {% catinclude "_admin_edit_depiction.tpl" id is_editable=is_editable languages=languages %}

	    {% include "_admin_edit_content_advanced.tpl" %}
	    {% include "_admin_edit_content_seo.tpl" %}
        </div>

	<div class="span4" id="sidebar">
	    <div id="sort">	{# also sidebar #}

	    {# Publish page #}
	    {% include "_admin_edit_content_publish.tpl" headline="simple" %}

	    {# Access control #}
	    {% include "_admin_edit_content_acl.tpl" %}

	    {% if not r.is_a.meta %}
                {# Publication period #}
		{% include "_admin_edit_content_pub_period.tpl" %}

		{# Date range #}
		{% include "_admin_edit_content_date_range.tpl" %}
	    {% endif %}	{# not r.is_a.meta #}

	    {% all catinclude "_admin_edit_sidebar.tpl" id languages=languages %}

	    {# Page connections #}
	    {% include "_admin_edit_content_page_connections.tpl" %}
	    </div>
	</div>
    </form>

    {% block admin_edit_form_post %}{% endblock %}

</div>

{% endwith %}
{% endwith %}
{% endwith %}

{% endblock %}
