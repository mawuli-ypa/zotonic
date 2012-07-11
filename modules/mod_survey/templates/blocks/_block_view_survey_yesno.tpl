<div class="control-group survey-yesno">
    <label class="control-label">{{ blk.prompt }}</label>
    <div class="controls">
        <label class="radio inline">
            <input type="radio" id="{{ #yes }}" name="{{ blk.name}}" {% if answers[blk.name] %}checked="checked"{% endif %}/> {{ blk.yes|default:_"Yes" }}
        </label>
        <label class="radio inline">
            <input type="radio" id="{{ #no }}" name="{{ blk.name}}" {% if answers and not answers[blk.name] %}checked="checked"{% endif %}/> {{ blk.yes|default:_"No" }}
        </label>
    </div>
</div>
{% if blk.is_required %}
    {% validate id=#yes name=blk.name type={presence} %}
{% endif %}

