function populate_zmr_table(){
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
           $("#zmr_tbl_body").append("<tr>" + columns + "</tr>");
           console.log(data);
         });
      });
}

function search_zmr(){
  $('input#zmr_filter').live('keyup', function() {
    var rex = new RegExp($(this).val(), 'i');
    $('#zmr_tbl tr').hide();
        $('#zmr_tbl tr').filter(function() {
            return rex.test($(this).text());
        }).show();
    });
 }

// Populate table with data from ZMR server
// Also filter user input
populate_zmr_table();
search_zmr();

