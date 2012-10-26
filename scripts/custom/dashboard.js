/**
 * Copyright (C) 2005, Intalio Inc.
 *
 * The program(s) herein may be used and/or copied only with
 * the written permission of Intalio Inc. or in accordance with
 * the terms and conditions stipulated in the agreement/contract
 * under which the program(s) have been supplied.
 */ 

/* * @Function Name : showDashboard
 * @Description     : Binds the page elemets with function calls. Shows the data on load and repaints the canvas on window resize.
 * @param           : 
 * @returns         :  
 * */
function showDashboard()
{
		$("#console").click(function () {
			
			document.location.href='./monitoring/processes.htm';
			return false;
		});
		$("#uifw").click(function () 
		{
			document.location.href='./ui-fw/tasks.htm';
			return false;

		});
		$("#bam").click(function () 
		{
			document.location.href='./bam/reports.htm';
			return false;

		});
		$("#pager-process").click(function () 
		{
			showProcessOnly();

		});
		$("#pager-task").click(function () 
		{
			showTaskOnly();

		});
		$("#task1d").click(function () {
			fetchData("1d","tasks");
			$("#task1d").css("text-decoration","underline");
			$("#task2d").css("text-decoration","none");
			$("#task1w").css("text-decoration","none");
			$("#task1m").css("text-decoration","none");
		});
		$("#task2d").click(function () {
			fetchData("2d","tasks");
			$("#task2d").css("text-decoration","underline");
			$("#task1d").css("text-decoration","none");
			$("#task1w").css("text-decoration","none");
			$("#task1m").css("text-decoration","none");
		});
		$("#task1w").click(function () {
			fetchData("1w","tasks");
			$("#task1w").css("text-decoration","underline");
			$("#task1d").css("text-decoration","none");
			$("#task2d").css("text-decoration","none");
			$("#task1m").css("text-decoration","none");
		});
		$("#task1m").click(function () {
			fetchData("1m","tasks");
			$("#task1m").css("text-decoration","underline");
			$("#task1d").css("text-decoration","none");
			$("#task2d").css("text-decoration","none");
			$("#task1w").css("text-decoration","none");
		});
		$("#not1d").click(function () {
			fetchData("1d","nots");
			$("#not1d").css("text-decoration","underline");
			$("#not2d").css("text-decoration","none");
			$("#not1w").css("text-decoration","none");
			$("#not1m").css("text-decoration","none");
		  
		});
		$("#not2d").click(function () {
			fetchData("2d","nots");
			$("#not2d").css("text-decoration","underline");
			$("#not1d").css("text-decoration","none");
			$("#not1w").css("text-decoration","none");
			$("#not1m").css("text-decoration","none");
		});
		$("#not1w").click(function () {
			fetchData("1w","nots");
			$("#not1w").css("text-decoration","underline");
			$("#not1d").css("text-decoration","none");
			$("#not2d").css("text-decoration","none");
			$("#not1m").css("text-decoration","none");
		});
		$("#not1m").click(function () {
			fetchData("1m","nots");
			$("#not1m").css("text-decoration","underline");
			$("#not1d").css("text-decoration","none");
			$("#not2d").css("text-decoration","none");
			$("#not1w").css("text-decoration","none");
		});
		$("#eve1d").click(function () {
		     fetchData("1d","events");
		     $("#eve1d").css("text-decoration","underline");
		     $("#eve2d").css("text-decoration","none");
		     $("#eve1w").css("text-decoration","none");
		     $("#eve1m").css("text-decoration","none");
		});
		$("#eve2d").click(function () {
		      fetchData("2d","events");
		     $("#eve2d").css("text-decoration","underline");
		     $("#eve1d").css("text-decoration","none");
		     $("#eve1w").css("text-decoration","none");
		     $("#eve1m").css("text-decoration","none");
		});
		$("#eve1w").click(function () {
		     fetchData("1w","events");
		     $("#eve1w").css("text-decoration","underline");
		     $("#eve1d").css("text-decoration","none");
		     $("#eve2d").css("text-decoration","none");
		     $("#eve1m").css("text-decoration","none");
		});
		$("#eve1m").click(function () {
		      fetchData("1m","events");
		     $("#eve1m").css("text-decoration","underline");
		     $("#eve1d").css("text-decoration","none");
		     $("#eve2d").css("text-decoration","none");
		     $("#eve1w").css("text-decoration","none");
		});

		$("#cha1d").click(function () {
		    fetchData("1d","charts");
		    $("#cha1d").css("text-decoration","underline");
		    $("#cha2d").css("text-decoration","none");
		    $("#cha1w").css("text-decoration","none");
		    $("#cha1m").css("text-decoration","none");
		});
		$("#cha2d").click(function () {
		     fetchData("2d","charts");
		    $("#cha2d").css("text-decoration","underline");
		    $("#cha1d").css("text-decoration","none");
		    $("#cha1w").css("text-decoration","none");
		    $("#cha1m").css("text-decoration","none");
		});
		$("#cha1w").click(function () {
		     fetchData("1w","charts");
		    $("#cha1w").css("text-decoration","underline");
		    $("#cha1d").css("text-decoration","none");
		    $("#cha2d").css("text-decoration","none");
		    $("#cha1m").css("text-decoration","none");
		});
		$("#cha1m").click(function () {
		    fetchData("1m","charts");
		    $("#cha1m").css("text-decoration","underline");
		    $("#cha1d").css("text-decoration","none");
		    $("#cha2d").css("text-decoration","none");
		    $("#cha1w").css("text-decoration","none");
		});
		showProcessOnly();
}
/* * @Function Name : showProcessOnly 
 * @Description     : Shows process tab.
 * @param           : 
 * @returns         :  
 * */
function showProcessOnly()
{
  $("#dashlet-task-body").css("display","none");
  $("#dashlet-process-body").css("display","block");
  
  $("#pager-process").css("background-color","#C4C4C4")
  $("#pager-process").css("color","#050505");
  
  $("#pager-task").css("background-color","#ffffff")
  $("#pager-process").css("color","#050505");
  var url = './data.json?filter=1d';
	$.ajax({
		  url: url,
		  cache:false,
		  async: true,
		  dataType: 'json',
		  error:function(e){
			  //alert("Error" + e);
		  },
		  success: function (data) {	
                                                if(data.currentUser == undefined || data.currentUser == null || $.trim(data.currentUser) =='' )
						      submitActionToURL('login.htm','logOut');
                                                else
						{
                                                        $("#header").css("display","block");
							$("#pager").css("display","block");
                                                        $("#footer").css("display","block");
                                                        $("#dashlet-process-body").css("display","block");                                                        
							$("#processdashlet1").css("display","block");
							$("#processdashlet2").css("display","block");
                                                        $("#user").text(data.currentUser);                                                
                                                        showVersionDetails(data);
                                                        showConsole(data);
                                                        showNotification(data);
					    		if(data.isConsoleAccessible == "true")
							{
							    $("#processdashlet3").css("display","block");
							    $("#processdashlet4").css("display","block");
								$("#processdashlet5").css("display","block");
								$("#processdashlet6").css("display","block");
							    showVacation(data);
								//for below chart we are using discreteBarChart from nvd3
							    createAvgProcessCompTimeChartData(data);
								createMultiBarChartData(data);  
								createWsResTimeChartData(data);
							}
							showCharts(data);                                                		
                                                }						
					    }
		});
}
/* * @Function Name : showTaskOnly 
 * @Description     : Shows Task tab.
 * @param           : 
 * @returns         :  
 * */
function showTaskOnly()
{
  $("#dashlet-task-body").css("display","block");
  $("#dashlet-process-body").css("display","none");
  
  $("#pager-task").css("background-color","#C4C4C4")
  $("#pager-task").css("color","#050505");
  
  $("#pager-process").css("background-color","#ffffff")
  $("#pager-process").css("color","#050505");
  var url = './data.json?filter=1d';
	$.ajax({
		  url: url,
		  cache:false,
		  async: true,
		  dataType: 'json',
		  error:function(e){
			  //alert("Error" + e);
		  },
		  success: function (data) {	
                                                if(data.currentUser == undefined || data.currentUser == null || $.trim(data.currentUser) =='' )
                                                submitActionToURL('login.htm','logOut');
                                                else{
                                                        showTasks(data);
					    		showEvents(data);
							if(data.isConsoleAccessible == "true")
							{
							    $("#taskdashlet3").css("display","block");
							    createUserwiseTaskGraph(data);
							}
                                                }						
					    }

		});
}
/* * @Function Name : showInstanceChart 
 * @Description     : Generates the instances chart.
 * @param           : Array containing the count of instances.
 * @returns         :  
 * */
function showInstanceChart(s1)
{
	$("#barChart").empty();		
	/*$.jqplot.config.enablePlugins = true;*/
	
	var ticks = ['Running', 'Completed', 'Failed', 'Suspended', 'Terminated' ];

	plot1 = $.jqplot("barChart", [s1], 
                {
	                // Only animate if we're not using excanvas (not in IE 7 or IE 8)..
	                animate: !$.jqplot.use_excanvas,
	                seriesDefaults:
                        {
	                        renderer:$.jqplot.BarRenderer,
                                rendererOptions: {fillToZero: true},
	                        pointLabels: { show: true }
	                },
	                axes: 
                        {
	                        xaxis: 
                                {
	                                renderer: $.jqplot.CategoryAxisRenderer,
	                                ticks: ticks
	                        },
                                yaxis: 
                                {
                                        padMin: 0
                                }
	
	},
	highlighter: { show: false }
	});

}
/* * @Function Name : chartTasks 
 * @Description     : Generates the chart for tasks associated to a user and its group.
 * @param           : Array containing the count of tasks.
 * @returns         :  
 * */
function chartTasks(s1)
{
	$("#taskChart").empty();		
	/*$.jqplot.config.enablePlugins = true;*/
	
	var ticks = ['Pending', 'Claimed', 'Notification', 'Completed', 'Completed by groups' ];

	plot1 = $.jqplot("taskChart", [s1], 
                {
	                // Only animate if we're not using excanvas (not in IE 7 or IE 8)..
	                animate: !$.jqplot.use_excanvas,
	                seriesDefaults:
                        {
	                        renderer:$.jqplot.BarRenderer,
                                rendererOptions: {fillToZero: true},
	                        pointLabels: { show: true }
	                },
	                axes: 
                        {
	                        xaxis: 
                                {
	                                renderer: $.jqplot.CategoryAxisRenderer,
	                                ticks: ticks
	                        },
                                yaxis: 
                                {
                                        padMin: 0
                                }
	
	},
	highlighter: { show: false }
	});
	$("#taskChart").show();
}
/* * @Function Name : fetchData 
 * @Description     : Generates the chart.
 * @param           : limit : Data for number of days
                      toshow: Whis dashlet to paint with new data.
 * @returns         :  
 * */
function fetchData(limit,toshow)
{
	var url = './data.json?filter='+limit;
	$.ajax({
		  url: url,
		  cache:false,
		  async: true,
		  dataType: 'json',
		  error:function(e){
			  //alert("Error" + e);
		  },
		  success: function (data) {if(toshow == "tasks")  showTasks(data);
					    else if(toshow == "nots") showNotification(data);
					   else if(toshow == "events") showEvents(data);
					   else if(toshow == "charts") showCharts(data); 
					   else if(toshow == "vacation") showVacation(data);   
		  }

		});
}
/* * @Function Name : showTasks 
 * @Description     : Paints the tasklist with new data.
 * @param           : data : Response of AJAX call.
 * @returns         :  
 * */
function showTasks(data)
{
	$.each(data.taskSummary, function(key, value) 
  	{
		if(key == "completedTaskCountByUser")
			$("#tasklist").append('<li>'+value+' tasks were completed by you.</li>');
		if(key == "pendingNotificationCount")
			$("#tasklist").append('<li>You have '+value+' notifications.</li>');
		if(key == "completedTaskCountByUserAssignedRoles")
			$("#tasklist").append('<li>'+value+' tasks were completed by your group.</li>');
		if(key == "claimedTaskCount")
			$("#tasklist").append('<li>You have claimed '+value+' tasks.</li>');
		if(key == "pendingTaskCount")
			$("#tasklist").append('<li>You have '+value+' tasks pending.</li>');	            
	
  	});
	var s1 = [parseInt($.trim(data.taskSummary.pendingTaskCount)),
	          parseInt($.trim(data.taskSummary.claimedTaskCount)),
	          parseInt($.trim(data.taskSummary.pendingNotificationCount)),
	          parseInt($.trim(data.taskSummary.completedTaskCountByUser)),
	          parseInt($.trim(data.taskSummary.completedTaskCountByUserAssignedRoles))];
	chartTasks(s1);           
        
}
/* * @Function Name : showNotification 
 * @Description     : Paints the Notification with new data.
 * @param           : data : Response of AJAX call.
 * @returns         :  
 * */
function showNotification(data)
{
	$("#nots").empty();
	$.each(data.instancesSummary, function(key, value) 
  	{
		if(key == "completedCount")
			$("#nots").append('<li>'+value+' instances got completed.</li>');
		if(key == "inProgressCount")
			$("#nots").append('<li>'+value+' instances are currently running.</li>');
		if(key == "terminatedCount")
			$("#nots").append('<li>'+value+' instances were terminated.</li>');
		if(key == "failedCount")
			$("#nots").append('<li>'+value+' instances got failed.</li>');
		if(key == "suspendedCount")
			$("#nots").append('<li>'+value+' instances were suspended.</li>');	
	});
					  	
}
/* * @Function Name : showEvents 
 * @Description     : Paints the events with new data.
 * @param           : data : Response of AJAX call.
 * @returns         :  
 * */
function showEvents(data)
{
	$("#events").empty();
	for(var i=0;i<data.events.eventDesc.length;i++)
	{
		$("#events").append('<li>'+data.events.eventDesc[i]+'.</li>');	
	}
}
/* * @Function Name : showCharts 
 * @Description     : Creates an array out of response and sends it to showInstanceChart
 * @param           : data : Response of AJAX call.
 * @returns         :  
 * */
function showCharts(data)
{
	var s1 = [parseInt($.trim(data.instancesSummary.inProgressCount)), 
	          parseInt($.trim(data.instancesSummary.completedCount)),
	          parseInt($.trim(data.instancesSummary.failedCount)),
	          parseInt($.trim(data.instancesSummary.suspendedCount)),
	          parseInt($.trim(data.instancesSummary.terminatedCount))];
        showInstanceChart(s1);           
        
}
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
/* * @Function Name : showConsole 
 * @Description     : Shows link to console only to admin users.
 * @returns         :  
 * */
function showConsole(data)
{
        if(data.isConsoleAccessible == "true")
        {
                $("#console").css("display","block");
                $("#dashlet5").css("display","block");
        }
        else
        {
               $("#console").css("display","none");
                $("#dashlet5").css("display","none");
        }
}
/* * @Function Name : showVacation 
 * @Description     : Displays the vacation sumamry to admin users.
 * @param           : data : Response of AJAX call.
 * @returns         :  
 * */
function showVacation(data)
{
        var oTable;
        var i=0;
        var j=1;
        var showData = new Array(4);
        oTable = $('#vacationTable').dataTable({
                "bPaginate": false,
                "bStateSave": false,
                "bProcessing": true,
                "bFilter": false,
                "aaSorting": [],
                "bInfo": false,
                "bDestroy":true,
                "aaData": [],
                "oLanguage": {
                                "sZeroRecords": "No data available.",
                                "sEmptyTable": "No data available."
                             }
        });
        $.each(data.leaves, function(key, value) 
		{
                var i=0;
                showData[i] = data.leaves[key].user;i++;
                showData[i] = $.format.date(data.leaves[key].fromDate,"dd/MM/yyyy");i++;
                showData[i] = $.format.date(data.leaves[key].toDate,"dd/MM/yyyy");i++;
                showData[i] = data.leaves[key].description;i++;
                oTable.fnAddData(showData, true);   
        });
         oTable.fnDraw(true);
}
/* * @Function Name : showVersionDetails 
 * @Description     : Displays the Version Details.
 * @param           : data : Response of AJAX call.
 * @returns         :  
 * */
function showVersionDetails(data)
{
	$('body').find('#version').text(data.version);
	$('body').find('#build').text(data.build);
}
/**
 * @Function Name   : isObjectEmpty 
 * @Description     : to check if the json object is empty or not
 * @param           : object
 * @returns         : 
 * */
function isObjectEmpty(object) {
    var isEmpty = true;
    for (keys in object) {
        isEmpty = false;
        break; // exiting since we found that the object is not empty
    }
    return isEmpty;
}
/**
 * @Function Name   : createAvgProcessCompTimeChartData 
 * @Description     : data massaging for avg completion time of a processes
 * @param           : Json object
 * @returns         : 
 * */
function createAvgProcessCompTimeChartData(data)
{
	var valuesArray= [];
	if (!isObjectEmpty(data.completedInstances)) {
		$.each(data.completedInstances, function (key, value) {
			  var seconds = (parseInt(value) / 1000);
			  var minutes = (seconds / 60);
			  if(parseInt(minutes)>0){
		      valuesArray.push({
					label: key,
					value: parseInt(minutes)
				});
			 }	
		});
		
		var array = {
		   		key: "Average Time",
           		values: valuesArray
        	}
        var jsonArray = [array];	
        createAvgProcessCompTimeChart(jsonArray);        
	}
}
/**
 * @Function Name   : createAvgProcessCompTimeChart 
 * @Description     : creating chart for average completion time of a process
 * @param           : Json object
 * @returns         : discreteBarChart
 * */
function createAvgProcessCompTimeChart(data)
{	
	nv.addGraph(function() {  
	var chart = nv.models.discreteBarChart();
      chart.x(function(d) { return d.label });
      chart.y(function(d) { return d.value });
      chart.staggerLabels(true);
      chart.tooltips(true);
      chart.showValues(true);
      chart.xAxis.showMaxMin(false);
      chart.yAxis.showMaxMin(false);
      chart.xAxis.axisLabel('Processes');
      chart.yAxis.axisLabel('Time (mins)');
	d3.select('#chart2 svg')
      .datum(data)
	  .transition().duration(500)
      .call(chart);
    nv.utils.windowResize(chart.update);
	return chart;
	});
}
/**
 * @Function Name   : addMultiBarGraph 
 * @Description     : to display mutibar chart showing process v/s instance count
 * @param           : object
 * @returns         : 
 * */
function addMultiBarGraph(dataObj)//array defining layers, number of processes, actual json data
{
	nv.addGraph(function() {
     
    	var chart = nv.models.multiBarChart()
      		.x(function(d) { return d.label})
      		.y(function(d) { return parseInt(d.value)});
	chart.xAxis.axisLabel('Processes');
        chart.yAxis.axisLabel('Instance Count');
      	chart.xAxis.rotateLabels(1);
	chart.color(['#1f77b4','#aec7e8','#ff7f0e','#FFD6AD']);

	chart.xAxis.showMaxMin(false);
    	chart.yAxis.showMaxMin(false);
	  
	chart.yAxis
       		.tickFormat(d3.format(',0.01f'));
        
	d3.select('#chart1 svg')
        	.datum(dataObj)
      		.transition().duration(500).call(chart);

    	nv.utils.windowResize(chart.update);

    	return chart;
});
}
/**
 * @Function Name   : createMultiBarChartData 
 * @Description     : to create array as required for multibar chart
 * @param           : object
 * @returns         : 
 * */
function createMultiBarChartData(data)
{
	if (!isObjectEmpty(data.processes)) {
		var statusArray0= []; // inprogress
		var statusArray1= []; // suspended
		var statusArray2= []; // terminated
		var statusArray3= []; // failed
		$.each(data.processes, function (key, value) {
			var pname = data.processes[key].name;
			
			if(pname.indexOf(":") >= 0)
			{
				var arr = pname.split(':');
				pname = arr[0];
			}
			statusArray0.push({
        			label: pname,
        			value: parseInt(data.processes[key].inProgressCount)
    			});

			statusArray1.push({
        			label: pname,
        			value: parseInt(data.processes[key].suspendedCount)
    			});

			statusArray2.push({
        			label: pname,
        			value: parseInt(data.processes[key].terminatedCount)
    			});

			statusArray3.push({
        			label: pname,
        			value: parseInt(data.processes[key].failedCount)
    			});
								
		});

		
		var editeditems = [];
		editeditems.push({
            		key: "inProgress",
            		values: statusArray0
        	});
		editeditems.push({
            		key: "suspended",
            		values: statusArray1
        	});
		editeditems.push({
            		key: "terminated",
            		values: statusArray2
        	});
		editeditems.push({
            		key: "failed",
            		values: statusArray3
        	});
				
		addMultiBarGraph(editeditems);
	}
}
/**
 * @Function Name   : createWsResTimeChartData 
 * @Description     : data massaging webservice response time
 * @param           : Json object
 * @returns         : 
 * */
function createWsResTimeChartData(data)
{
	var finDataArr = new Array();
	var hashMapTime = [];
	var hashMapTimeArr = [];
	var hashMapCount= [];
	var hashMapCountArr = [];
	var rowCnt = 0;
	if (!isObjectEmpty(data.wsResTime)) {
		$.each(data.wsResTime, function (key, value) {
			var  arr1 = new Array();
			var  arr2 = new Array();
			var seconds = (parseInt(data.wsResTime[key].resTime) / 1000);
			if(parseInt(seconds)>0){
				arr2[0] = data.wsResTime[key].serviceName;
				arr2[1] = seconds;
				arr1[0] = data.wsResTime[key].serviceName;
				arr1[1] = parseInt(data.wsResTime[key].operationCount);
				hashMapCountArr[rowCnt] = arr1;
				hashMapTimeArr[rowCnt] = arr2;
				rowCnt++;
			}
		});
		finDataArr.push({
				key:"Time Taken To Respond",
				bar : true,
				values : hashMapTimeArr
			});
		finDataArr.push({
				key:"No of Times called",
				values : hashMapCountArr
			});
		finDataArr.map(function(series) {
		series.values = series.values.map(function(d) { return {x: d[0], y: d[1] } });
		return series;
		});		
	}
	createWsResTimeChart(finDataArr);
}
/**
 * @Function Name   : createWsResTimeChart 
 * @Description     : creates chart of webservice response time
 * @param           : Json object
 * @returns         : linePlusBarChart
 * */
function createWsResTimeChart(data)
{
	nv.addGraph(function() {
    var chart = nv.models.linePlusBarChart()
        .margin({top: 30, right: 60, bottom: 50, left: 70})
        .x(function(d,i) { return i })
        .color(d3.scale.category10().range());
	  chart.xAxis.tickFormat(function(d) {
      var dx = data[0].values[d] && data[0].values[d].x;
      return dx;
    });
    chart.xAxis.axisLabel('WebServices');
    chart.y1Axis.axisLabel('Time (Seconds)');
	chart.y1Axis.tickFormat(d3.format(',100'));
	chart.y2Axis.tickFormat(function(d) { return d3.format(',100')(d) });
    chart.bars.forceY([0]);
    d3.select('#chart3 svg')
      .datum(data)
      .transition().duration(500).call(chart);
      nv.utils.windowResize(chart.update);
    return chart;
	});
}/*
 * @Function Name   : displayUserwiseTaskGraph 
 * @Description     : to display horizontal mutibar chart showing count of pending/claimed tasks of all users
 * @param           : object
 * @returns         : 
 * */
function displayUserwiseTaskGraph(dataObj)
{
	nv.addGraph(function() {
  var chart = nv.models.multiBarHorizontalChart()
      .x(function(d) { return d.label })
      .y(function(d) { return d.value })
      .margin({top: 30, right: 20, bottom: 50, left: 175})
      .showValues(true)
      .tooltips(false)
      .showControls(false);

  chart.yAxis
      .tickFormat(d3.format(',.2f'));

  d3.select('#chart4 svg')
      .datum(dataObj)
    .transition().duration(500)
      .call(chart);

  nv.utils.windowResize(chart.update);

  return chart;
});
}
/**
 * @Function Name   : createMultiBarChartData 
 * @Description     : to create array as required for multibar chart
 * @param           : object
 * @returns         : 
 * */
function createUserwiseTaskGraph(data)
{
	if (!isObjectEmpty(data.userTaskCount)) {
		var pendingArray= []; // pending count
		var claimedArray= []; // claimed count
		
		$.each(data.userTaskCount, function (key, value) {
			if(data.userTaskCount[key].State == "READY")
			{
				pendingArray.push({
        				label: data.userTaskCount[key].User,
        				value: parseInt(data.userTaskCount[key].Count)
    				});
			}
			else if(data.userTaskCount[key].State == "CLAIMED")
			{
				claimedArray.push({
        				label: data.userTaskCount[key].User,
        				value: parseInt(data.userTaskCount[key].Count)
    				});
			}

								
		});

		
		var editeditems = [];
		editeditems.push({
            		key: 'Pending',
			color: '#d62728',
            		values: pendingArray
        	});
		editeditems.push({
            		key: 'Claimed',
			color: '#1f77b4',
            		values: claimedArray
        	});
						
		displayUserwiseTaskGraph(editeditems);
	}
}