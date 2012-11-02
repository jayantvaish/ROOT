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
	if (!isObjectEmpty(data.instancesSummary)) {
		$.each(data.instancesSummary, function (key, value) {
		hashMapNoti.push({
        				label: key,
        				value: parseInt(value),
    				});
		});
		var editeditems = [];
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
function createNotificationsChart(dataObj)
{
	nv.addGraph(function() {
    var width = 625,
        height = 400;

    var chart = nv.models.pieChart()
        .x(function(d) { return d.label })
        .y(function(d) { return d.value })
        .color(d3.scale.category10().range())
        .width(width)
        .height(height);
		d3.select("#chart4")
        .datum(dataObj)
        .transition().duration(1200)
        .attr('width', width)
        .attr('height', height)
        .call(chart);
		return chart;
	});
}	
</script>
</head>
<body>
<div id="processdashlet1">
		<div style="position:relative; padding-top:1%" >
    			<svg id="chart4" style="word-wrap: break-word;"></svg>
  		</div>
</div>
</body>	</html>
