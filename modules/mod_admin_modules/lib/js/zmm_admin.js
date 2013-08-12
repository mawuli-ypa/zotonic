// global module manager config
Window.zmm = Window.zmm || {}
Window.zmm.cache = null

// function for the module manager
function z_populate_zmm_table(){
        /*
         * Todo: get zmr server from Zotonic node? 
         * Test in other browsers, especially mobile
         * Install modules: dynamic postback to server
         * Make zmr results table scrollable
         * Add info help button
         */
        Window.zmm.to_install = [];
        $("#zmm_tbl_body").empty().html("Fetching modules...");
        var ZMR = "http://modules.zotonic.com/api/zmr/repositories?callback=?"
        if(!Window.zmm.cache){
           $.getJSON(ZMR, {},function(data){
           Window.zmm.cache = data
           $("#zmm_tbl_body").empty();
           $.each(data,function(index, data){
               columns = "<td>" + data.title + "</td>" + "<td>" + data.repository + "</td>";       
               $("#zmm_tbl_body").append("<tr class='z_module_link' data-id='" + data.title + "'" + 
                                      "data-repo='" + data.repository + "'" + ">" + columns + "</tr>");
         });
      })}
}


function z_filter_zmm_table(){
  $('input#zmm_filter').live('keyup', function() {
    var rex = new RegExp($(this).val(), 'i');
    $('#zmm_tbl tr').hide();
        $('#zmm_tbl tr').filter(function() {
            return rex.test($(this).text());
        }).show();
    });
 }


function z_refresh_zmm(){
    z_growl_add("Fetching the latest the modules...");
    $("#zmm_tbl_body").empty();
    z_populate_zmm_table();
}

function z_install_module(module){
         // triger postback notify event on the server
         z_notify('install-module', { 
             z_delegate: 'mod_admin_modules', 
             title: module.title,
             repository: module.repository
     });
}

function z_zmm_queue_install(module){
    // add to list if it's not already added
    Window.zmm.to_install = Window.zmm.to_install || [];

    if($.grep(Window.zmm.to_install, function(m, i){
         return m.title == module.title;
    }) == false ){ Window.zmm.to_install.push(module)}
}

function z_zmm_unqueue_install(title){
    Window.zmm.to_install = $.grep(Window.zmm.to_install,
                                   function(m ,i){return m.title != title});
}

// Populate table with data from ZMR server
// Also filter user input
z_populate_zmm_table();
z_filter_zmm_table();


// CALLBACKS / EVENT LISTENERS
//attach event to the refresh button
$("button#zmm_refresh_btn").live('click', function(e){
    z_refresh_zmm();
    e.preventDefault();
});


$(".z_module_link").live('click', function(e){
    // mark module for installation
    $(this).toggleClass('to_install');
    
    // display install button if it's hidden
    if($("#zmm_install_btn").not(":visible")){
        $("#zmm_install_btn").show();
    }
    title = $(this).attr('data-id');

    // click highlight items to remove from install queue
    if($(this).hasClass("highlight")){
       return  z_zmm_unqueue_install(title);
    } 
    repository = $(this).attr('data-repo');
    module = {title:title, repository: repository};

    // add module to list of modules to install
    z_zmm_queue_install(module);
    e.preventDefault();

});


$("#zmm_install_btn").live('click', function(e){
    modules = '<ol id="zmm_to_install">';
    $.each(Window.zmm.to_install, function(i, m){ modules = modules +  '<li>' + m.title + '</li>'});
    install_confirm_text = '<h3>These modules will be installed: </h3> <br />' + modules + "</ol>";
    z_dialog_confirm({
        text: install_confirm_text,
        on_confirm: function(){
            $.each(Window.zmm.to_install, function(index, module){z_install_module(module)})
    }})
   e.preventDefault();
});
