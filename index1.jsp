<!doctype html>
 
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Intalio|BPMS</title>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.0/themes/base/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="http://code.jquery.com/ui/1.9.0/jquery-ui.js"></script>
    <script type="text/javascript" src="js/lib/jquery.dashboard.min.js"></script>
    <script type="text/javascript" src="js/lib/themeroller.js"></script>
    <style>
    #dialog label, #dialog input { display:block; }
    #dialog label { margin-top: 0.5em; }
    #dialog input, #dialog textarea { width: 95%; }
    #tabs { margin-top: 1em; }
    #tabs li .ui-icon-close { float: left; margin: 0.4em 0.2em 0 0; cursor: pointer; }
    </style>
    <script>
    $(function() {
    	//Initialize the tabCounter value based on last counter.
    	var tabCounter = 1;
    	// load the templates
        $('body').append('<div id="templates"></div>');
        $("#templates").hide();
        $("#templates").load("templates.html", initDashboard);

        function initDashboard() {

          // to make it possible to add widgets more than once, we create clientside unique id's
          // this is for demo purposes: normally this would be an id generated serverside
          var startId = 100;
      
          var dashboard = $('#tabs-' + tabCounter).dashboard({
            // layout class is used to make it possible to switch layouts
            layoutClass:'layout',
            debuglevel : 1,
            // feed for the widgets which are on the dashboard when opened
            json_data : {
              url: "jsonfeed/mywidgets.json"
            },
            // json feed; the widgets whcih you can add to your dashboard
            addWidgetSettings: {
              widgetDirectoryUrl:"jsonfeed/widgetcategories.json"
            },

            // Definition of the layout
            // When using the layoutClass, it is possible to change layout using only another class. In this case
            // you don't need the html property in the layout

            layouts :
              [
                { title: "Layout1",
                  id: "layout1",
                  image: "layouts/layout1.png",
                  html: '<div class="layout layout-a"><div class="column first column-first"></div></div>',
                  classname: 'layout-a'
                },
                { title: "Layout2",
                  id: "layout2",
                  image: "layouts/layout2.png",
                  html: '<div class="layout layout-aa"><div class="column first column-first"></div><div class="column second column-second"></div></div>',
                  classname: 'layout-aa'
                },
                { title: "Layout3",
                  id: "layout3",
                  image: "layouts/layout3.png",
                  html: '<div class="layout layout-ba"><div class="column first column-first"></div><div class="column second column-second"></div></div>',
                  classname: 'layout-ba'
                },
                { title: "Layout4",
                  id: "layout4",
                  image: "layouts/layout4.png",
                  html: '<div class="layout layout-ab"><div class="column first column-first"></div><div class="column second column-second"></div></div>',
                  classname: 'layout-ab'
                },
                { title: "Layout5",
                  id: "layout5",
                  image: "layouts/layout5.png",
                  html: '<div class="layout layout-aaa"><div class="column first column-first"></div><div class="column second column-second"></div><div class="column third column-third"></div></div>',
                  classname: 'layout-aaa'
                }
              ]

          }); // end dashboard call

          // binding for a widgets is added to the dashboard
          dashboard.element.live('dashboardAddWidget',function(e, obj){
            var widget = obj.widget;

            dashboard.addWidget({
              "id":startId++,
              "title":widget.title,
              "url":widget.url,
              "metadata":widget.metadata
              }, dashboard.element.find('.column:first'));
          });
          //
          dashboard.element.live('dashboardStateChange',function(e, obj){
  	  		alert("Layout  Changed by widgetDeleted.... " + dashboard.serialize() + " ," + obj);
 	  	   });          
          
          dashboard.element.live('dashboardLayoutChanged',function(e, obj){
  	  		alert("Layout  Changed by dashboardLayoutChanged.... " + dashboard.serialize() + " ," + obj);
 	  	   });
          // the init builds the dashboard. This makes it possible to first unbind events before the dashboars is built.
          dashboard.init();
        }

        //Here starts the logic to add tab.	
        var tabTitle = $( "#tab_title" ),
            tabTemplate = "<li><a href='#{href}'>#{label}</a> <span class='ui-icon ui-icon-close'>Remove Tab</span></li>";
 
        var tabs = $( "#tabs" ).tabs();
 
        // modal dialog init: custom buttons and a "close" callback reseting the form inside
        var dialog = $( "#dialog" ).dialog({
            autoOpen: false,
            modal: true,
            buttons: {
                Add: function() {
                    addTab();
                    $( this ).dialog( "close" );
                },
                Cancel: function() {
                    $( this ).dialog( "close" );
                }
            },
            close: function() {
                form[ 0 ].reset();
            }
        });
 
        // addTab form: calls addTab function on submit and closes the dialog
        var form = dialog.find( "form" ).submit(function( event ) {
            addTab();
            dialog.dialog( "close" );
            event.preventDefault();
        });
 
        // actual addTab function: adds new tab using the input from the form above
        function addTab() {
            var label = tabTitle.val() || "Tab " + tabCounter,
                id = "tabs-" + tabCounter,
                li = $( tabTemplate.replace( /#\{href\}/g, "#" + id ).replace( /#\{label\}/g, label ) );
 
            tabs.find( ".ui-tabs-nav" ).append( li );
            tabs.append( "<div id='" + id + "' class='dashboard'><div class='layout'><div class='column first column-first'></div><div class='column second column-second'></div><div class='column third column-third'></div></div></div>" );
            
            //After adding the dashboard call init to populate the default values.
            initDashboard();
            tabs.tabs( "refresh" );
            //Increment the counter.
            tabCounter++;
            //Select the new tab added.
            $('#tabs').tabs('select', '#'+ id +'');

        }
 
        // addtab just opens the dialog
        $('.addtab').click(function() {
            // open the lightbox for active tab
            dialog.dialog( "open" );
            return false;
        });
        
        // close icon: removing the tab on click
        $( "#tabs span.ui-icon-close" ).live( "click", function() {
            var panelId = $( this ).closest( "li" ).remove().attr( "aria-controls" );
            $( "#" + panelId ).remove();
            tabs.tabs( "refresh" );
        });
    });
    </script>
    
    <link rel="stylesheet" type="text/css" href="themes/default/dashboardui.css" />
    <link rel="stylesheet" type="text/css" href="themes/default/jquery-ui-1.8.2.custom.css" />
    
</head>
<body>
 
  <div id="dialog" title="Tab data">
    <form>
        <fieldset class="ui-helper-reset">
            <label for="tab_title">Title</label>
            <input type="text" name="tab_title" id="tab_title" value="" class="ui-widget-content ui-corner-all" />
        </fieldset>
    </form>
  </div>
 
  <div class="io-header">
	<img class="io-header-logo" alt="Intalio Inc." src="images/logo.png" />
    <div class="headerlinks">
      <a class="addtab headerlink" href="#">Add Tab</a>&nbsp;<span class="headerlink">|</span>&nbsp;
      <a class="openaddwidgetdialog headerlink" href="#">Add Widget</a>&nbsp;<span class="headerlink">|</span>&nbsp;
      <a class="editlayout headerlink" href="#">Edit layout</a>
    </div>
  </div>
 
  <div id="tabs">
    <ul></ul>
  </div>

</body>
</html>