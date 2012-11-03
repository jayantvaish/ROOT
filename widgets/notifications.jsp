<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<script type="text/javascript">
getData();
function getData()
{
	var url = '../data.json?filter=1d';
	$.ajax({
		  url: url,
		  cache:false,
		  async: true,
		  dataType: 'json',
		  error:function(e){
			  console.log("Error occured");
		  },
		  success: function (data) {	
									$("#accessible").val(data.isConsoleAccessible);
									showNotification(data);
									}
		});
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
/* * @Function Name : showNotification 
 * @Description     : Paints the Notification with new data.
 * @param           : data : Response of AJAX call.
 * @returns         :  
 * */
function showNotification(data)
{
	
	var dataArr = new Array();
	var hashMapNoti = [];
	var editeditems = [];
	if (!isObjectEmpty(data.instancesSummary)) {
		$.each(data.instancesSummary, function (key, value) {
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
	createNotificationsChart(editeditems);
}
/**
 * @Function Name   : createNotificationsChart 
 * @Description     : creates notification chart (pie chart)
 * @param           : object
 * @returns         : 
 * */
function createNotificationsChart(data)
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
      chart.yAxis.axisLabel('Count');
	d3.select('#chart3 svg')
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
<div id="processdashlet1">
		<div id="chart3" style="position:relative; padding-top:1%" >
    			<svg  style="word-wrap: break-word;"></svg>
  		</div>
</div>
</body>	</html>
