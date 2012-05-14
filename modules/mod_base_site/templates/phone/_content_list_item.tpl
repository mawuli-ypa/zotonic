{% if id.is_visible and id.is_published and not id|member:exclude %}
<tr {% if counter % 2 %}class="odd"{% else %}class="even"{% endif %}>
    <td {% include "_language_attrs.tpl" id=id %}>
        {% with id.depiction as dep %}
        {# {% if dep %} #}
        {#     <img src="{% image_url dep mediaclass="base-list-item-small" %}" alt="" /> #}
        {# {% endif %} #}
        {% endwith %}
        <h3><a href="{{ id.page_url }}">{{ id.title|default:"&mdash;" }}</a></h3>
        {% if id.summary %}<p>{{id.summary|truncate:120}} <a href="{{ id.page_url }}">{_ more… _}</a></p>
        {% elseif id.body %}<p>{{ id.body|striptags|truncate:120 }} <a href="{{ id.page_url }}">{_ more… _}</a></p>
        {% endif %}
    </td>
</tr>
{% endif %}
