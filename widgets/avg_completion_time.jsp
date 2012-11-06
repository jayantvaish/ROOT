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
			  //alert("Error" + e);
		  },
		  success: function (data) {	
								if(data.isConsoleAccessible == "true")
									createAvgProcessCompTimeChartData(data);
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
 /**
 * @Function Name   : createAvgProcessCompTimeChartData 
 * @Description     : data massaging for avg completion time of a processes
 * @param           : Json object
 * @returns         : 
 * */
function createAvgProcessCompTimeChartData(data)
{
	var jsonArray = [];
	var valuesArray= [];
	if (!isObjectEmpty(data.completedInstances)) {
		$.each(data.completedInstances, function (key, value) {
			  var seconds = (parseInt(value) / 1000);
			  //var minutes = (seconds / 60);
			  //if(parseInt(minutes)>0){
		      valuesArray.push({
					label: key,
					value: parseInt(seconds)
				});
			 //}	
		});
		
		var array = {
		   		key: "Average Time",
           		values: valuesArray
        	}
			jsonArray = [array];	
                
	}
	createAvgProcessCompTimeChart(jsonArray);
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
      chart.yAxis.axisLabel('Time(s)');
	d3.select('#chart1 svg')
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
<div id="processdashlet5">
		<div id="chart1" style="position:relative; padding-top:1%" >
    			<svg style="word-wrap: break-word;"></svg>
  		</div>
	</div>
</body>
</html>
