/**
 * Copyright (C) 2005, Intalio Inc.
 *
 * The program(s) herein may be used and/or copied only with
 * the written permission of Intalio Inc. or in accordance with
 * the terms and conditions stipulated in the agreement/contract
 * under which the program(s) have been supplied.
 */
/* * @Function Name : submitActionToURL 
 * @Description     : 
 * @param           : url,actionName example : logout.htm , logout
 * @returns         :  
 * */
function submitActionToURL(url, actionName) {
    formObj = document.getElementById('dashform');
    formObj.action = url;
    document.getElementById('actionName').value = actionName;
    formObj.submit();
}

function toggleQtip(id) {
    var div = $('#' + id);
    if (div.data('visible')) {
        div.qtip('hide');
        div.data('visible', false);
    } else {
        div.qtip('show');
        div.data('visible', true);
    }
}

var tabCounter = 1;
var currentTab;
var startId = 100;
var currentDashboard;
var istabExist = false; 
var dashboardStateUrl = 'dsState.json';
var defaultData = {
"result" :
  {
  "layout": "layout2",
  "data" : []
  }
}

function addNewDashboard(id, jsonData) {

    var dashboard1 = $('#' + id).dashboard({
        layoutClass: 'layout',
        json_data: jsonData,
        addWidgetSettings: {
            widgetDirectoryUrl: "jsonfeed/widgetcategories"
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
    //      dashboard1.element.live('dashboardAddWidget', function (e, obj) {
    //      	var widget = obj.widget;
    //      	dashboard1.addWidget({
    //      	          "id": startId++,
    //      	          "title": widget.title,
    //      	          "url": widget.url,
    //      	          "metadata": widget.metadata
    //      	        }, dashboard1.element.find('.column:first'));
    //      	});
    dashboard1.init();
    dashboardManager.addDashboard(dashboard1);
}

// DashboardManager which contains the dashboards
var dashboardManager = function () {
    var dashboards = new Array();

    function addDashboard(d) {
        dashboards.push(d);
    }

    function getDashboard(id) {
        var r;
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
	
    $("#radioTab").buttonset();
    $('[for=radio1]').click(function () {
        document.location.href = './monitoring/processes.htm';
        return false;
    });
    $('[for=radio2]').click(function () {
        document.location.href = './ui-fw/tasks.htm';
        return false;
    });
    $('[for=radio3]').click(function () {
        document.location.href = './bam/reports.htm';
        return false;
    });
    $("button:first").button({
        icons: {
            primary: "ui-icon-gear",
            secondary: "ui-icon-triangle-1-s"
        }
    });
    $('.io-footer').each(function () {
        showMyTT($(this).attr('id'));
    })
    $("#userProfile")
        .button()
        .click(function () {
        toggleQtip('div1');
        return false;
    });

    function showMyTT(id) {
        $('#' + id).qtip({
            content: $('.tooltipContent'),
            position: {
                my: 'top center',
                at: 'bottom right',
                adjust: {
                    x: 87,
                    y: 8
                },
                viewport: $(window),

            },
            show: false,
            hide: false,
        });
    }
    var url = './data.json?filter=1d';
    $.ajax({
        url: url,
        cache: false,
        async: true,
        dataType: 'json',
        error: function (e) {
            //alert("Error" + e);
        },
        success: function (data) {
			console.log("data"+data.currentUser);
            if(data.currentUser == undefined || data.currentUser == null || $.trim(data.currentUser) =='' )
			submitActionToURL('login.htm','logOut');
            else
            $("#userProfile span").text(data.currentUser);
        }

    });
    $("#btnLogout")
        .button()
        .click(function () {
        submitActionToURL('login.htm', 'logOut');
        return false;
    });
    $("#btnHelp")
        .button()
        .click(function () {
        window.open("http://wiki.intalio.com", '_blank');
        window.focus();
        return false;
    });
    /*dashboard function starts*/

    // load the templates
    $('body').append('<div id="templates"></div>');
    $("#templates").hide();
    $("#templates").load("templates.html", initDashboard);

    $('#tabs').tabs({
        select: function (evt, ui) {
            currentTab = $(ui.panel).attr('id');
            currentDashboard = dashboardManager.getDashboard(currentTab);
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


	$('.column').live('click', function () {
	  alert("column");
	    if (currentDashboard != null) {
		currentDashboard.element.live('dashboardStateChange',function(e, obj){
		  alert("Layout  Changed by widgetDeleted.... " + currentDashboard.serialize() + " ," + obj);
		  return false;
		});
            }
            return false;
        });

	
        $('.layoutchoice').live('click', function () {
	  alert("layoutchoice");
	    var eventCount = 0;
            if (currentDashboard != null) {
		currentDashboard.element.live('dashboardLayoutChanged',function(e, obj){
		alert("Layout  Changed by dashboardLayoutChanged.... " + currentDashboard.serialize() + " ," + obj);
		return false;
		});
            }
            return false;
        });

	
        $('.addwidget').live('click', function () {
	    //On a single click dashboardAddWidget event should be fired only once.
	    var eventCount = 0;
            if (currentDashboard != null) {
                currentDashboard.element.live('dashboardAddWidget', function (e, obj) {
		  if(eventCount == 0){
		    eventCount++;
		    var widget = obj.widget;
                    currentDashboard.addWidget({
                        "id": startId++,
                        "title": widget.title,
                        "url": widget.url,
                        "metadata": widget.metadata
                    }, currentDashboard.element.find('.column:first'));
		  }
                  return false;
                });
            }
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
        resizable: false,
        buttons: {
            Add: function () {
                addTab(defaultData, tabTitle.val(), istabExist);
                $(this).dialog("close");
            }
        },
        close: function () {
            $('#tab_title').val("");
            $(this).dialog("close");
        }
    });

    // addTab form: calls addTab function on submit and closes the dialog
    var form = dialog.find("form").submit(function (event) {
        addTab(defaultData, tabTitle.val(), istabExist);
        dialog.dialog("close");
        event.preventDefault();
    });

    // actual addTab function: adds new tab using the input from the form above
    function addTab(jsonData, tabName, istabExist) {
      alert("Adding tab");
        var label = tabName || "Tab " + tabCounter,
            id = "dashboard" + tabCounter,
            li = $(tabTemplate.replace(/#\{href\}/g, "#" + id).replace(/#\{label\}/g, label));

        tabs.find(".ui-tabs-nav").append(li);
        tabs.append("<div id='" + id + "' class='dashboard'><div class='layout'><div class='column first column-first'></div><div class='column second column-second'></div><div class='column third column-third'></div></div></div>");
        addNewDashboard(id, jsonData);
        tabs.tabs("refresh");
        //Increment the counter.
        tabCounter++;
        //Select the new tab added.
        $('#tabs').tabs('select', '#' + id + '');
	alert("istabExist: " + istabExist);
	if(!istabExist){
	    persistTab(label);
	}
        disableEnableLinks();
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
        disableEnableLinks();
    });
    
    //This will execute on page load.
    $(document).ready(function () {
        var jsonString = '{"tabs" :[ {  "tabName" : "tab1",  "info" : {  "result" : {  "layout":"layout2",  "data" : [    {      "id" : "cat-1-02",      "title" : "Processes-Instances Status Count",      "column" : "second",      "url" : "widgets/instance_status_cnt.jsp",      "open" : true    },    {      "id" :"cat-1-03",      "title" : "WS Response Time",      "column" : "first",      "url" : "widgets/ws_response_time.jsp",      "open" : true    }  ]  }  }  }  ]}'
	//var stateDataInJson = jQuery.parseJSON(jsonString);
	//alert('stateDataInJson: ' + stateDataInJson);	
	//alert('stateData: ' + JSON.stringify(stateDataInJson));
	//jsonString = '';
	//saveDashboardStateData(jsonString);
	getDashboardStateData();
	
	
    });
    
    function persistTab(tabName){
      alert("Adding tab tabName: " + tabName);
      $.getJSON(dashboardStateUrl + '?action=getState', function(data) {
	  var newTab = {
	      "tabName" : tabName,
	      "info" : defaultData
	    };
	  var stateDataInString = data.dsState.ds_state;
	  if(typeof stateDataInString != "undefined" && stateDataInString != "" && stateDataInString != null){
	    var stateDataInJson = jQuery.parseJSON(stateDataInString);
	    var tabsArray = stateDataInJson.tabs;	    
	    tabsArray.push(newTab);
	    alert('stateData persistTab: ' + JSON.stringify(stateDataInJson));
	    saveDashboardStateData(JSON.stringify(stateDataInJson));
	  } else {
	    saveDashboardStateData(JSON.stringify({"tabs" :[newTab]}));
	  }
      });
    }
    
    function saveDashboardStateData(jsonString){
      $.ajax({
	  url: dashboardStateUrl,
	  cache:false,
	  async: true,
	  dataType: 'json',
	  data: {
		action: "saveState",
		jsonString: jsonString
	  },
	  error:function(e){
		//alert("Error" + e);
	  },
	  success: function (data) {	
	    alert("data saved");
	  }
      });
    }

    
    
    JSON.stringify = JSON.stringify || function (obj) {
	var t = typeof (obj);
	if (t != "object" || obj === null) {
	    // simple data type
	    if (t == "string") obj = '"'+obj+'"';
	    return String(obj);
	}
	else {
	    // recurse array or object
	    var n, v, json = [], arr = (obj && obj.constructor == Array);
	    for (n in obj) {
		v = obj[n]; t = typeof(v);
		if (t == "string") v = '"'+v+'"';
		else if (t == "object" && v !== null) v = JSON.stringify(v);
		json.push((arr ? "" : '"' + n + '":') + String(v));
	    }
	    return (arr ? "[" : "{") + String(json) + (arr ? "]" : "}");
	}
    };

    


    function getDashboardStateData(){
      $.getJSON(dashboardStateUrl + '?action=getState', function(data) {
	  var stateDataInString = data.dsState.ds_state;
	  alert("stateDataInString: " + stateDataInString);
	  if(typeof stateDataInString != "undefined" && stateDataInString != "" && stateDataInString != null){
	    var stateDataInJson = jQuery.parseJSON(stateDataInString);
	    alert("stateDataInJson: " + stateDataInJson);	  
	    //alert(".serialize(): " + stateDataInJson.tabs[0].tabName);	      
	    var tabsArray = stateDataInJson.tabs;	    
	    alert("tabsArray.length: " + tabsArray.length);
	    for (var i = 0; i < tabsArray.length; i++) {
		alert("going to add tab");
		addTab(tabsArray[i].info, tabsArray[i].tabName, true);
	    }
	  }
	  disableEnableLinks();
      });
    }

});

function disableEnableLinks() {
    var count = $("#tablist li").length;
    alert("count is: " + count);
    if (parseInt(count) != 0) {
        $('.dmopenaddwidgetdialog').fadeTo("fast", 10).attr("href", "#");
        $('.dmeditLayout').fadeTo("fast", 10).attr("href", "#");

    } else {
        $('.dmopenaddwidgetdialog').fadeTo("fast", .5).removeAttr("href");
        $('.dmeditLayout').fadeTo("fast", .5).removeAttr("href");
    }
}




