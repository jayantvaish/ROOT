<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<script type="text/javascript">
getData();
function getData()
{	
	if(dashboardData.isConsoleAccessible == "true"){
	  createMultiBarChartData(dashboardData);
	}
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
      	chart.color(['#1f77b4','#aec7e8','#ff7f0e','#FFD6AD']);
	chart.yAxis
       		.tickFormat(d3.format(',0.01f'));
        chart.showControls(false);
	d3.select('#chart2 svg')
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
	var editeditems = [];
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

		editeditems.push({
            		key: "InProgress",
            		values: statusArray0
        	});
		editeditems.push({
            		key: "Suspended",
            		values: statusArray1
        	});
		editeditems.push({
            		key: "Terminated",
            		values: statusArray2
        	});
		editeditems.push({
            		key: "Failed",
            		values: statusArray3
        	});
				
		
	}
	addMultiBarGraph(editeditems);
}
</script>
</head>	
<body>
<div id="processdashlet4">
		<div id="chart2" style="position:relative; padding-top:1%;" >
    			<svg style="word-wrap: break-word;"></svg>
  		</div>
	</div>
</body>
</html>
