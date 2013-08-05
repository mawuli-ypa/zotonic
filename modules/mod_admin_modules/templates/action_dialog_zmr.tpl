<div>

  <input id="zmr_filter" type="text" placeholder="I am looking for.." class="input-xlarge float-right">

</div>

<table class="table table-striped" id="zmr_tbl">
 
</table>

    <div class="modal-footer">
	{% button class="btn" action={dialog_close} text=_"Cancel" tag="a" %}
	<button class="btn btn-primary" type="submit">{_ Refresh _} {{ catname }}</button>
    </div>

<script type="text/javascript">
        /*
         * todo: get zmr server from Zotonic node, 
         * cache results 
         * test in other browsers, especially mobile
         * install modules: dynamic postback to server
         * refresh data
         * make zmr results table scrollable
         */
        var ZMR = "http://modules.zotonic.com/api/zmr/repositories?callback=?"
        $.getJSON(ZMR, {},function(data){
            Window.zmr_data = data;
            //console.log(Window.zmr_data);

        $.each(Window.zmr_data,function(index, data){
           columns = "<td>" + data.title + "</td>" + "<td>" + data.repository + "</td>";       
           $("#zmr_tbl").append("<tr>" + columns + "</tr>");
           console.log(data);
         });
      });


  $('input#zmr_filter').live('keyup', function() {
    var rex = new RegExp($(this).val(), 'i');
    $('#zmr_tbl tr').hide();
        $('#zmr_tbl tr').filter(function() {
            return rex.test($(this).text());
        }).show();
    });
   
</script>
