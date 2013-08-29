<div id="zmm_tbl_menu">
  <input id="zmm_filter" type="text" placeholder="I am looking for.." class="input-xlarge pull-left">
  <div class="pull-right">
       {% button class="btn" action={dialog_close} text=_"Close" tag="a" %}
       <button class="btn btn-primary" id="zmm_refresh_btn" type="submit">{_ Refresh _}</button>
       <button class="btn btn-primary" id="zmm_install_btn" type="submit">{_ Install _}</button>
  </div>
</div>


<table class="table table-bordered table-condensed" id="zmm_tbl">
  <thead>
  <tr>
   <th>Module</th>
   <th>Description</th>
  </tr>
 </thead>
 <tbody id="zmm_tbl_body"><tr><td>Fecthing modules...</tr></td></tbody>
</table>

<div id="zmm_tbl_pager"  class="pagination pagination-centered"></div>


{% lib "css/zmm_admin.css" %}
{% lib "js/zmm_admin.js" %}
