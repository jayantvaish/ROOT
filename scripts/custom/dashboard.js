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
var isFirstTab = false;
var firstTabId;
var currentTabName;
var isConsoleAccessible;
var dashboardStateUrl = 'dsState.json';
var dsState;
var widgetArr = [];
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
            
        }
    }).next().button({
	icons: {
	    primary: "ui-icon-gear",
	    secondary: "ui-icon-triangle-1-s"
	}
    });
    $('.io-footer').each(function () {
        showMyTT($(this).attr('id'));
    })
    $('.io-footer-options').each(function () {
        showMyTT($(this).attr('id'));
    })
    $("#userProfile")
        .button()
        .click(function () {
        toggleQtip('div1');
        return false;
    });
    $("#options")
        .button()
        .click(function () {
        toggleQtip('div2');
        return false;
    });

	//Message Dialog initialization
    var messageDialog = $("#messageDialog").dialog({
		autoOpen: false,
		modal: true,
		resizable: false,
		close: function () {
		$(this).dialog("close");
		}
	});
    function showMyTT(id) {
	if(id == "div1")
	{
		$('#' + id).qtip({
		    content: $('.tooltipContent'),
		    position: {
		        my: 'top center',
		        at: 'bottom right',
		        adjust: {
		            x: 176,
		            y: 8
		        },
		        viewport: $(window),

		    },
		    show: false,
		    hide: false,
		});
	}
	else if(id == "div2")
	{
		$('#' + id).qtip({
		    content: $('.optionContent'),
		    position: {
		        my: 'top center',
		        at: 'bottom right',
		        adjust: {
		            x: 48,
		            y: 8
		        },
		        viewport: $(window),

		    },
		    show: false,
		    hide: false,
		});
	}
    }
    var url = './data.json?filter=1d';
    $.ajax({
        url: url,
        cache: false,
        async: false,
        dataType: 'json',
        error: function (e) {
        },
        success: function (data) {
            if(data.currentUser == undefined || data.currentUser == null || $.trim(data.currentUser) =='' )
			submitActionToURL('login.htm','logOut');
            else
            {
				isConsoleAccessible = data.isConsoleAccessible;
				$("#userProfile span").text(data.currentUser);
				if(isConsoleAccessible == "true")
					$('[for=radio1]').css('disabled','false');
				else $("[for=radio1]").css('display','none');
				$("#accessible").val(isConsoleAccessible);
			}	
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

    function initDashboard() {
        $("#tabs").tabs({
            cache: true
        });
		
	$('.dmsaveDashboard').click(function () {
	    persistLayoutChange(currentDashboard.serialize());
            return false;
        });

        $('.dmopenaddwidgetdialog').click(function () {
            // open the lightbox for active tab
            if (currentDashboard != null) {
	      currentDashboard.element.trigger("dashboardOpenWidgetDialog");
	    }
            return false;
        });

        $('.dmeditLayout').click(function () {
            // open the lightbox for active tab
            if (currentDashboard != null) {
	      currentDashboard.element.trigger("dashboardOpenLayoutDialog");
	    }
            return false;
        });

	//persist when widget dnd.
	$('.column').live('widgetDropped', function () {
	    if (currentDashboard != null) {
		setTimeout(function(){
		    persistLayoutChange(currentDashboard.serialize());
		},500);
            }
            return false;
        });

	//persist when layout changed.
	$('.layoutchoice').live('click', function () {
	    if (currentDashboard != null) {
		persistLayoutChange(currentDashboard.serialize());
            }
            return false;
        });
	
	//persist when widget deleted.
	$('.delete').live('click', function () {
	    setTimeout(function(){
		persistLayoutChange(currentDashboard.serialize());
	    },500);
        });

	//Add and persist widget.
        $('.addwidget').live('click', function () {
	    //On a single click dashboardAddWidget event should be fired only once.
	    var eventCount = 0;
            if (currentDashboard != null) {
                currentDashboard.element.live('dashboardAddWidget', function (e, obj) {
		  if(eventCount == 0){
		    eventCount++;
		    var widget = obj.widget;
		    var accessible = "";
		    if(widget.accessible!=null && widget.accessible!=undefined){
		      accessible = widget.accessible;
		    } else {
		      accessible = "false";
		    }
		    var widgetData;
		    if(accessible == "true"){
			widgetData = {
			    "id": startId++,
			    "title": widget.title,
			    "url": widget.url,
			    "column" : "first",
			    "open" : true,
			    "accessible": "true",
			    "metadata": widget.metadata
			}
		    } else {
			widgetData = {
			    "id": startId++,
			    "title": widget.title,
			    "url": widget.url,
			    "column" : "first",
			    "open" : true,
			    "metadata": widget.metadata
			}
		    }
		    currentDashboard.addWidget(widgetData, currentDashboard.element.find('.column:first'),accessible);
		    if(accessible == "true" || isConsoleAccessible == "true"){
		      persistWidget(widgetData);
		    }
		  }
                  return false;
                });
            }
            return false;
        });

    }
    var tabTitle = $("#tab_title"),
        tabTemplate = "<li name='#{label}'><a href='#{href}'>#{label}</a> <span class='ui-icon ui-icon-close'>Remove Tab</span></li>";

    var tabs = $("#tabs").tabs();

    $("#tabs").css("border-bottom","#ffffff");	

    // modal dialog init: custom buttons and a "close" callback reseting the form inside
    var dialog = $("#dialog").dialog({
        autoOpen: false,
        modal: true,
        resizable: false,
        buttons: {
            Add: function () {
                addTab(defaultData, tabTitle.val(), istabExist, isFirstTab, false);
                
            }
        },
        close: function () {
            $('#tab_title').val("");
            $(this).dialog("close");
        }
    });

    // addTab form: calls addTab function on submit and closes the dialog
    var form = dialog.find("form").submit(function (event) {
        addTab(defaultData, tabTitle.val(), istabExist, isFirstTab, false);
        dialog.dialog("close");
        event.preventDefault();
    });

    // actual addTab function: adds new tab using the input from the form above
    function addTab(jsonData, tabName, istabExist, isFirstTab, isLoading) {
	//dialog to show tab title mandatory
	
        if(tabName=="" || tabName==undefined){
	  messageDialog.html('<a style="font-family: verdana;font-size: 13px;">'+ defaults.tabTitleMessage1 +'</a>');
	  
	  messageDialog.dialog('open');
	  return false;	  
	} else {
	    //check whether this name exist or not? It will make tabName unique. 
	    var stateDataInJson = dsState;
	    if(stateDataInJson != null && stateDataInJson != 'undefined'){
	      var tabsArray = stateDataInJson.tabs;
	      var isAlreadyPresent = false;
	      for (var i = 0; i < tabsArray.length; i++) {
		  if(tabsArray[i] != null && tabsArray[i].tabName == tabName && !isLoading){
		    messageDialog.html('<a style="font-family: verdana;font-size: 13px;">'+ defaults.tabTitleMessage2 +'"' + tabName + '" exists.</a>');
		    $('#tab_title').val("");
		    messageDialog.dialog('open');
		    return false;
		  }
	      }
	    }
	}
	dialog.dialog("close");
	
	var label = tabName || "Tab " + tabCounter,
            id = "dashboard" + tabCounter,
            li = $(tabTemplate.replace(/#\{href\}/g, "#" + id).replace(/#\{label\}/g, label));

        tabs.find(".ui-tabs-nav").append(li);
        tabs.append("<div id='" + id + "' class='dashboard' name='" + label + "'><div class='layout'><div class='column first column-first'></div><div class='column second column-second'></div><div class='column third column-third'></div></div></div>");
        addNewDashboard(id, jsonData);
        tabs.tabs("refresh");
        //Increment the counter.
        tabCounter++;
        //Select the new tab added.
	if(isFirstTab){
	    firstTabId = id;
	}
        $('#tabs').tabs('select', '#' + id + '');
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
	if(confirm(defaults.deleteTabConfirmMessage)){
	  var tabName = $(this).closest("li").attr("name");
	  removeTab(tabName);
	  
	  var panelId = $(this).closest("li").remove().attr("aria-controls");
	  $("#" + panelId).remove();
	  tabs.tabs("refresh");
	  disableEnableLinks();
	}
    });
    
    //This will execute on page load.
    $(document).ready(function () {
        getDashboardStateData();
    });
    
    function persistLayoutChange(tabInfoResult){
	var stateDataInJson = dsState;
	var tabsArray = stateDataInJson.tabs;	    
	for (var i = 0; i < tabsArray.length; i++) {
	    if(tabsArray[i] != null && tabsArray[i].tabName == currentTabName){
	      var tabInfoResultInJson = jQuery.parseJSON(tabInfoResult);
	      //Before saving data adding rule: for widget 1 all column should be in first and for layout 2,3,4 all third columns should be in first.
	      checkLayoutColumns(tabInfoResultInJson);
	      tabsArray[i].info.result = tabInfoResultInJson;
	      dsState = stateDataInJson;
	      saveDashboardStateData(JSON.stringify(dsState));
	      break;
	    }
	}
    }
    
    function persistWidget(widgetData){
	var stateDataInJson = dsState;
	var tabsArray = stateDataInJson.tabs;
	//Checking whether it is already added or not?
	var isAlreadyPresent = false;
	var url = widgetData.url;
	for (var i = 0; i < tabsArray.length; i++) {
	    if(tabsArray[i] != null){
	      var widgets = tabsArray[i].info.result.data;
	      for(var j = 0; j < widgets.length; j++){
		if(widgets[j].url == url){
		  isAlreadyPresent = true;
		  break;
		}
	      }
	    }
	}
	if(!isAlreadyPresent){
	  for (var i = 0; i < tabsArray.length; i++) {
	      if(tabsArray[i] != null && tabsArray[i].tabName == currentTabName){
		tabsArray[i].info.result.data.push(widgetData);
		dsState = stateDataInJson;
		saveDashboardStateData(JSON.stringify(dsState));
		break;
	      }
	  }
	}
    }
    
    function removeTab(tabName){
	  var stateDataInJson = dsState;
	  var tabsArray = stateDataInJson.tabs;	    
	  for (var i = 0; i < tabsArray.length; i++) {
	      if(tabsArray[i] != null && tabsArray[i].tabName == tabName){
		var tabData = tabsArray[i].info.result.data;
		for(var j = 0; j < tabData.length; j++){
		  widgetArr.splice($.inArray(tabData[j].url, widgetArr),1);
		}
		tabsArray.splice($.inArray(tabsArray[i], tabsArray),1);
		dsState = stateDataInJson;
		saveDashboardStateData(JSON.stringify(dsState));
		break;
	      }
	  }
    }
    
    function persistTab(tabName){
	  var newTab = {
	      "tabName" : tabName,
	      "info" : {"result" : {"layout": "layout2", "data" : [] }}
	    };
	  var stateDataInString = JSON.stringify(dsState);
	  if(typeof stateDataInString != "undefined" && stateDataInString != "" && stateDataInString != null){
	    var stateDataInJson = jQuery.parseJSON(stateDataInString);
	    var tabsArray = stateDataInJson.tabs;	    
	    tabsArray.push(newTab);
	    dsState = stateDataInJson;
	  } else {
	    dsState = {"tabs" :[newTab]}
	  }
	  saveDashboardStateData(JSON.stringify(dsState));
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
		  messageDialog.html('<a style="font-family: verdana;font-size: 13px;">' + defaults.errorMessageOnSavingState + '</a>');
		  messageDialog.dialog('open');
	  },
	  success: function (data) {
		  if(data.response!=undefined && data.response!="" && data.response!="OK")
		  {
				messageDialog.html('<a style="font-family: verdana;font-size: 13px;">' + defaults.errorMessageOnSavingState + '</a>');
				messageDialog.dialog('open');
		  }
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
	  if(typeof stateDataInString != "undefined" && stateDataInString != "" && stateDataInString != null){
	    var stateDataInJson = jQuery.parseJSON(stateDataInString);	
	    dsState = stateDataInJson;
	    var tabsArray = stateDataInJson.tabs;
	    var j = 0;
	    for (var i = 0; i < tabsArray.length; i++) {
		if(tabsArray[i] != null){
		  if(j == 0){
		    j++;
		    addTab(tabsArray[i].info, tabsArray[i].tabName, true, true, true);
		  } else {
		    addTab(tabsArray[i].info, tabsArray[i].tabName, true, false, true);
		  }
		  
		  //Initialize the startId.  
		  var widgetsData = tabsArray[i].info.result.data;
		  for(var k = 0; k < widgetsData.length; k++){
		    if(widgetsData != null && widgetsData[k].id >= startId){
		       startId = widgetsData[k].id;
		       startId++;
		    }
		  }
		}
	    }
	    $('#tabs').tabs('select', '#' + firstTabId + '');
	  }
	  disableEnableLinks();
      });
    }

});

function disableEnableLinks() {
    var count = $("#tablist li").length;
    if (parseInt(count) != 0) {
        $('.dmopenaddwidgetdialog').fadeTo("fast", 10).attr("href", "#");
        $('.dmeditLayout').fadeTo("fast", 10).attr("href", "#");
	$('.dmsaveDashboard').fadeTo("fast", 10).attr("href", "#");

    } else {
        $('.dmopenaddwidgetdialog').fadeTo("fast", .5).removeAttr("href");
        $('.dmeditLayout').fadeTo("fast", .5).removeAttr("href");
	$('.dmsaveDashboard').fadeTo("fast", .5).removeAttr("href");
    }
}

function checkLayoutColumns(data){
  //Layout 1  have 1 column
  //Layout 2, 3, and 4  have 2 column
  //Layout 3 have 3 columns
  var layout = data.layout;
  var data = data.data;
  if(layout == 'layout1'){
    //Change all columns to first. 
    for(var i = 0; i < data.length; i++){
      if(data[i].column != 'first'){
	data[i].column = 'first';
	
      }
    }
  } else if(layout == 'layout2' || layout == 'layout3' || layout == 'layout4'){
    for(var i = 0; i < data.length; i++){
      if(data[i].column == 'third'){
	data[i].column = 'first';
	
      }
    }
  }
}

function reDrawTabsData(currentDashboard)
{
	currentDashboard.element.find(".widget").each(function () {
			var nWidget = currentDashboard.getWidget($(this).attr("id"));
			if(nWidget.url=="widgets/ws_response_time.jsp" || nWidget.url=="widgets/instance_status_cnt.jsp"){
					window.setTimeout(function () {
					nWidget.element.trigger("widgetRefresh", {
							widget: nWidget
						});
					}, 500); 
			}
			else{
			nWidget.element.trigger("widgetRefresh", {
					widget: nWidget
				});
			}
	});	
}

defaults = {
 deleteTabConfirmMessage: "Are you sure you want to delete this tab ?",
 errorMessageOnSavingState: "Unable to save the dashboard state. Please refresh the browser.",
 chartNotAccessibleMessage: "Chart is not accessible to you",
 tabTitleMessage1: "Please enter tab title",
 tabTitleMessage2: "Please enter another title ",
 loadingHtml: '<div class="loading"><img alt="Loading, please wait" src="images/loading.gif" /><p>Loading...</p></div>',
        
}
