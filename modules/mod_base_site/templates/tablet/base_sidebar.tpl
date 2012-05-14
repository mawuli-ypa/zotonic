{% extends "base.tpl" %}

{% block content %}
{% block above %}{# {% include "_breadcrumb.tpl" %} #}{% endblock %}
<div class="row-fluid">
    <div class="span3">
        {% block subnavbar %}&nbsp;{% endblock %}
    </div>

    <div class="span6">
        {% block main %}{% endblock %}
    </div>
    
    <div class="span3">
        {% block sidebar %}&nbsp;{% endblock %}
    </div>
</div>
{% block below %}{% endblock %}
{% endblock %}

{% block related %}
{% include "_content_list.tpl" list=id.o.hasdocument title=_"Documents"%}

{% with id.o.haspart, id.s.haspart as sub,super %}
{% if sub or super %}
	<h3>{_ Related _}</h3>
    {% include "_content_list.tpl" list=sub %}
    {% include "_content_list.tpl" list=super %}
{% endif %}
{% endwith %}
{% endblock %}