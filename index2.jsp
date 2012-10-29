<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <title>Intalio | BPMS</title>
        <link rel="stylesheet" href="style/jquery-ui-1.9.0.css"
        />
        <script src="scripts/lib/jquery-1.8.2.js"></script>
        <script src="scripts/lib/jquery-ui.js"></script>
        <script type="text/javascript" src="js/lib/jquery.dashboard.min.js"></script>
        <script type="text/javascript" src="js/lib/themeroller.js"></script>
        <link href="style/plugin/nv.d3.css" rel="stylesheet" type="text/css">
        <script src="scripts/plugin/d3.v2.js"></script>
        <script src="scripts/plugin/nv.d3.js"></script>
        <script src="scripts/plugin/tooltip.js"></script>
        <script src="scripts/plugin/utils.js"></script>
        <script src="scripts/plugin/axis.js"></script>
        <script src="scripts/plugin/discreteBar.js"></script>
        <script src="scripts/plugin/discreteBarChart.js"></script>
        <script src="scripts/plugin/multiBar.js"></script>
        <script src="scripts/plugin/multiBarChart.js"></script>
        <script src="scripts/plugin/legend.js"></script>
        <script src="scripts/plugin/scatter.js"></script>
        <script src="scripts/plugin/line.js"></script>
        <script src="scripts/plugin/multiBarHorizontal.js"></script>
        <script src="scripts/plugin/multiBarHorizontalChart.js"></script>
        <script type="text/javascript">
	    var startId = 100;
	    var currentTab;
	    var tabCounter = 1;
            // DashboardManager which contains the dashboards
            var dashboardManager = function () {
                var dashboards = new Array();

                function addDashboard(d) {
                    dashboards.push(d);
                }

                function getDashboard(id) {
                    var r;
                    alert("dashboards.length: " + dashboards.length);
                    for (i = 0; i < dashboards.length; i++) {
                        if (dashboards[i].element.attr("id") == id) {
                            r = dashboards[i];
                        }
                    }
                    return r;
                }

                // Public methods and variables.
                return {
                    addDashboard: addDashboard,
                    getDashboard: getDashboard,
                }

            }();


            $(function () {            
                
                // load the templates
                $('body').append('<div id="templates"></div>');
                $("#templates").hide();
                $("#templates").load("templates.html", initDashboard);

                $('#tabs').tabs({
                    select: function (evt, ui) {
                        currentTab = $(ui.panel).attr('id');
                    }
                });


                function initDashboard() {
                    $("#tabs").tabs({
                        cache: true
                    });

                    $('.dmopenaddwidgetdialog').click(function () {
                        // open the lightbox for active tab
                        var dashboard = dashboardManager.getDashboard(currentTab);
                        dashboard.element.trigger("dashboardOpenWidgetDialog");

                        return false;
                    });

                    $('.dmeditLayout').click(function () {
                        // open the lightbox for active tab
                        var dashboard = dashboardManager.getDashboard(currentTab);
                        dashboard.element.trigger("dashboardOpenLayoutDialog");

                        return false;
                    });

                }


                var tabTitle = $("#tab_title"),
                    tabTemplate = "<li><a href='#{href}'>#{label}</a> <span class='ui-icon ui-icon-close'>Remove Tab</span></li>";

                var tabs = $("#tabs").tabs();

                // modal dialog init: custom buttons and a "close" callback reseting the form inside
                var dialog = $("#dialog").dialog({
                    autoOpen: false,
                    modal: true,
                    buttons: {
                        Add: function () {
                            addTab();
                            $(this).dialog("close");
                        },
                        Cancel: function () {
                            $(this).dialog("close");
                        }
                    },
                    close: function () {
                        form[0].reset();
                    }
                });

                // addTab form: calls addTab function on submit and closes the dialog
                var form = dialog.find("form").submit(function (event) {
                    addTab();
                    dialog.dialog("close");
                    event.preventDefault();
                });

                // actual addTab function: adds new tab using the input from the form above
                function addTab() {
                    var label = tabTitle.val() || "Tab " + tabCounter,
                        id = "dashboard" + tabCounter,
                        li = $(tabTemplate.replace(/#\{href\}/g, "#" + id).replace(/#\{label\}/g, label));

                    tabs.find(".ui-tabs-nav").append(li);
                    tabs.append("<div id='" + id + "' class='dashboard'><div class='layout'><div class='column first column-first'></div><div class='column second column-second'></div><div class='column third column-third'></div></div></div>");
                    addNewDashboard(id);
                    tabs.tabs("refresh");
                    //Increment the counter.
                    tabCounter++;
                    //Select the new tab added.
                    $('#tabs').tabs('select', '#' + id + '');

                }

                // addtab just opens the dialog
                $('.addtab').click(function () {
                    // open the lightbox for active tab
                    dialog.dialog("open");
                    return false;
                });

                // close icon: removing the tab on click
                $("#tabs span.ui-icon-close").live("click", function () {
                    var panelId = $(this).closest("li").remove().attr("aria-controls");
                    $("#" + panelId).remove();
                    tabs.tabs("refresh");
                });

            });
            
            
            function addNewDashboard(id) {
                var dashboard1 = $('#' + id).dashboard({
                    layoutClass: 'layout',
                    json_data: {
                        url: "jsonfeed/mywidgets.json"
                    },
                    addWidgetSettings: {
                        widgetDirectoryUrl: "jsonfeed/widgetcategories.json"
                    },
                    layouts: [{
                        title: "Layout1",
                        id: "layout1",
                        image: "layouts/layout1.png",
                        classname: 'layout-a'
                    }, {
                        title: "Layout2",
                        id: "layout2",
                        image: "layouts/layout2.png",
                        classname: 'layout-aa'
                    }, {
                        title: "Layout3",
                        id: "layout3",
                        image: "layouts/layout3.png",
                        classname: 'layout-ba'
                    }, {
                        title: "Layout4",
                        id: "layout4",
                        image: "layouts/layout4.png",
                        classname: 'layout-ab'
                    }, {
                        title: "Layout5",
                        id: "layout5",
                        image: "layouts/layout5.png",
                        classname: 'layout-aaa'
                    }]

                }); // end dashboard call


                

                // binding for a widgets is added to the dashboard
                dashboard1.element.live('dashboardAddWidget', function (e, obj) {
                    var widget = obj.widget;
		    alert("Adding widget id: " + startId);
                    dashboard1.addWidget({
                        "id": startId++,
                        "title": widget.title,
                        "url": widget.url,
                        "metadata": widget.metadata
                    }, dashboard1.element.find('.column:first'));
                });


                dashboard1.init();
                dashboardManager.addDashboard(dashboard1);

            }
        </script>
        <link rel="stylesheet" type="text/css" href="themes/default/dashboardui.css"
        />
        <link rel="stylesheet" type="text/css" href="themes/default/jquery-ui-1.8.2.custom.css"
        />
    </head>
    
    <body>
        <div id="dialog" title="Tab data">
            <form>
                <fieldset class="ui-helper-reset">
                    <label for="tab_title">Title</label>
                    <input type="text" name="tab_title" id="tab_title" value=""
                    class="ui-widget-content ui-corner-all" />
                </fieldset>
            </form>
        </div>
        <div class="io-header">
            <img class="io-header-logo" alt="Intalio Inc." src="images/logo.png" />
            <div class="headerlinks"> <a class="addtab headerlink" href="#">Add Tab</a>&nbsp;<span class="headerlink">|</span>&nbsp;
                <a
                class="dmopenaddwidgetdialog headerlink" href="#">Add Widget</a>&nbsp;<span class="headerlink">|</span>&nbsp; <a class="dmeditLayout headerlink"
                    href="#">Edit layout</a>

            </div>
        </div>
        <div id="tabs">
            <ul id="tablist"></ul>
        </div>
        <div id="templates"></div>
    </body>

</html>