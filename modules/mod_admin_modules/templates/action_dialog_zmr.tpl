
<div id="zmr_tbl_menu">
  <input id="zmr_filter" type="text" placeholder="I am looking for.." class="input-xlarge float-right">
   <div class="pull-right">
	{% button class="btn" action={dialog_close} text=_"Close" tag="a" %}
	<button class="btn btn-primary" type="submit">{_ Refresh _} {{ catname }}</button>
    </div>

</div>


<table class="table table-striped table-bordered table-condensed" id="zmr_tbl">
  <thead>
  <tr>
   <th>Module</th>
   <th>Description</th>
  </tr> 
 </thead>
 <tbody id="zmr_tbl_body"></tbody>
</table>



{% lib "css/zmm_admin.css" %}
{% lib "js/zmm_admin.js" %}