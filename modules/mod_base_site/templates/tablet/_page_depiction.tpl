{% with id.depiction as dep %}
{% if dep and not dep.id.is_a.document %}
{% if id.body or id.blocks %}
	<div class="thumbnail depiction {% if dep.width < 400 or 10*dep.width / dep.height < 5 %}portrait{% else %}landscape{% endif %}">
		{% if dep.width < 400 %}
			<img src="{% image_url dep mediaclass="base-page-main-small" %}" alt="{{ dep.id.title }}" />
		{% else %}
			<img src="{% image_url dep mediaclass="base-page-main" %}" alt="{{ dep.id.title }}" />
		{% endif %}
		{% if dep.id.summary %}
		<p class="caption"><span class="icon icon-camera"></span> <a href="{{ dep.id.page_url }}">{{ dep.id.summary }}</a></p>
		{% endif %}
	</div>
{% else %}
<div class="thumbnail depiction landscape">
	<img src="{% image_url dep mediaclass="base-page-main" %}" alt="{{ dep.id.title }}" />
	{% if dep.id.summary %}
	<p class="caption"><span class="icon icon-camera"></span> <a href="{{ dep.id.page_url }}">{{ dep.id.summary }}</a></p>
	{% endif %}
</div>
{% endif %}
{% endif %}
{% endwith %}
