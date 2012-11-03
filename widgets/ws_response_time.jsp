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
								if(data.isConsoleAccessible == "true")
								{
									createWsResTimeChartData(data);
								}
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
    d3.select('#chart6 svg')
      .datum(data)
      .transition().duration(500).call(chart);
      nv.utils.windowResize(chart.update);
    return chart;
	});
}
</script>
</head>	
<body>
<div id="processdashlet6">
		<div id="chart6" style="position:relative; padding-top:1%" >
    			<svg style="word-wrap: break-word;"></svg>
  		</div>
</div>
</body>
</html>

