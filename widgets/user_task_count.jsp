<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<script>
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
						{
							createUserwiseTaskGraph(data);
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

  d3.select('#chart5 svg')
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
	var editeditems = [];
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
						
		
	}
	displayUserwiseTaskGraph(editeditems);
}
</script>
</head>        
<body>
       <div id="taskdashlet3">
		<div id="chart5" style="position:relative; margin-left:5px">
    			<svg style="word-wrap: break-word;"></svg>
  		</div>
	</div>
</body>
</html>
