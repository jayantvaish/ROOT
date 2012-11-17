<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<script type="text/javascript">
getData();
function getData()
{
	$("#accessible").val(dashboardData.isConsoleAccessible);
	showTaskSummary(dashboardData);
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
/* * @Function Name : showTaskSummary 
 * @Description     : Paints the task summary with  data.
 * @param           : data : Response of AJAX call.
 * @returns         :  
 * */
function showTaskSummary(data)
{
	
	var dataArr = new Array();
	var hashMapNoti = [];
	var editeditems = [];
	if (!isObjectEmpty(data.taskSummary)) {
		$.each(data.taskSummary, function (key, value) {
		 if(parseInt(value)!=0){
			hashMapNoti.push({
        				label: key,
        				value: parseInt(value),
    				});
			}
		});
		editeditems.push({
            		key: 'Cumulative Return',
					values: hashMapNoti
        	});
	}
	createTaskSummaryChart(editeditems);
}
/**
 * @Function Name   : createNotificationsChart 
 * @Description     : creates notification chart (pie chart)
 * @param           : object
 * @returns         : 
 * */
function createTaskSummaryChart(data)
{	
	nv.addGraph(function() {  
	var chart = nv.models.discreteBarChart();
      chart.x(function(d) { return d.label });
      chart.y(function(d) { return d.value });
      chart.staggerLabels(true);
      chart.tooltips(true);
      chart.showValues(false);
      chart.xAxis.showMaxMin(false);
      chart.yAxis.showMaxMin(false);
      chart.yAxis.axisLabel('Count');
      chart.yAxis.tickFormat(d3.format('f:'));
	d3.select('#chart4 svg')
      .datum(data)
	  .transition().duration(500)
      .call(chart);
    nv.utils.windowResize(chart.update);
	return chart;
	});
}
</script>
</head>
<body>
<div id="taskdashlet1">
		<div id="chart4" style="position:relative; padding-top:1%" >
    			<svg  style="word-wrap: break-word;"></svg>
  		</div>
</div>
</body>	</html>
