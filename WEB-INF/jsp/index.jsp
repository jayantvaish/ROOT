<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Intalio|BPMS-DashBoard</title>
<script type="text/javascript" src="scripts/plugin/jquery.js"></script>
<script type="text/javascript" src="scripts/plugin/jquery.dataTables.js"></script>
<link class="include" rel="stylesheet" type="text/css" href="style/custom/dashboard.css" />
<link class="include" rel="stylesheet" type="text/css" href="style/plugin/jquery.dataTables.css"/>
<link class="include" rel="stylesheet" type="text/css" href="style/chart/jquery.jqplot.min.css" />
<link href="style/plugin/nv.d3.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="scripts/chart/jquery.jqplot.min.js"></script>
<script type="text/javascript" src="scripts/chart/jqplot.barRenderer.min.js"></script>
<script type="text/javascript" src="scripts/chart/jqplot.categoryAxisRenderer.min.js"></script>
<script type="text/javascript" src="scripts/chart/jqplot.pointLabels.min.js"></script>
<script src="scripts/plugin/d3.v2.js"></script>
<script src="scripts/plugin/nv.d3.js"></script>
<script src="scripts/plugin/tooltip.js"></script>
<script src="scripts/plugin/utils.js"></script>
<script src="scripts/plugin/legend.js"></script>
<script src="scripts/plugin/axis.js"></script>
<script src="scripts/plugin/multiBar.js"></script>
<script src="scripts/plugin/multiBarChart.js"></script>
<script src="scripts/plugin/discreteBar.js"></script>
<script src="scripts/plugin/discreteBarChart.js"></script>
<script src="scripts/plugin/scatter.js"></script>
<script src="scripts/plugin/line.js"></script>
<script src="scripts/plugin/historicalBar.js"></script>
<script src="scripts/plugin/linePlusBarChart.js"></script>
<script src="scripts/plugin/multiBarHorizontal.js"></script>
<script src="scripts/plugin/multiBarHorizontalChart.js"></script>
<script type="text/javascript" src="scripts/chart/excanvas.js"></script>
<script type="text/javascript" src="scripts/custom/dashboard.js"></script>
<script type="text/javascript" language="javascript" src="scripts/plugin/jquery-dateFormat.js"></script>
<script type="text/javascript">
 $(document).ready(function(){
    
    var offsetY = 10;
    var offsetX = -340;

    $('.io-footer').hide().appendTo('body');

    $('img.imagepopupcontext').hover(function (e) {
           //$('div.footer').hide().find('p').text($(this).data('message'));
           $('div.io-footer').fadeIn(400);
           $('div.io-footer').css('top', e.pageY + offsetY).css('left', e.pageX + offsetX);
       }, function () {
       $('div.io-footer').hide();
    });

    $('img.imagepopupcontext').mousemove(function (e) {
         $('div.io-footer').css('top', e.pageY + offsetY).css('left', e.pageX + offsetX);
    });

    showDashboard();
  });
 $(window).resize(showDashboard);
</script>
</head>
<body>
	<form id="dashform" style="display:inline;" method="POST" name="dashform">
	<input type="hidden" id="actionName" name="actionName"/>
<div id="header" class="io-header">
	<img src="images/logo.png" alt="Intalio Inc." class="io-header-logo">
	<div class= "io-header-links">
	    <table>
		    <tr>
			    <td id ="console"><fmt:message key="com_intalio_bpms_dashboard_monitoring"/></td>
			    <td>|</td>
			    <td id ="uifw"><fmt:message key="com_intalio_bpms_dashboard_uifw"/></td>
			    <td>|</td>
			    <td id ="bam"><fmt:message key="com_intalio_bpms_dashboard_bam"/></td>
		    </tr>  
	    </table>
	</div>
	<table class = "io-header-icons">
		<tr>
			<td><img src="images/user_suit.png" title="Curent user" alt="Curent user"  /></td><td>&nbsp;</td>	
			<td><a id="user" style=""></a></td><td>&nbsp;</td>	
			<td><img src="images/refresh.png" title="Refresh" alt="Intalio Inc." onClick="showDashboard();"></td><td>&nbsp;</td>
			<td><img class="imagepopupcontext" src="images/information.png" alt="version" /></td><td>&nbsp;</td>
			<td><img src="images/logout.gif"  title="Log out" alt="Intalio Inc." onclick="javascript:submitActionToURL('login.htm','logOut')"></td>
		</tr>
	</table>
	
</div>

<div id="pager" class="io-pager">
<table class = "io-pager-links">
		<tr>
			<td><button  type="button" id="pager-process" class = "io-pager-links-rows"><fmt:message key="com_intalio_bpms_console_processes_menu"/></button></td>
			<td><button  type="button" id="pager-task" class = "io-pager-links-rows"><fmt:message key="com_intalio_bpms_dashboard_tasks"/></button></td>
		</tr>
	</table>
</div>

<div id="versionInfo" class="io-footer" style="display:none">
        <span>&nbsp;&nbsp;<fmt:message key="com_intalio_bpms_console_pageFooter_poweredByLbl" />&nbsp;&nbsp;
                <a ><span style="color: #000000"><fmt:message key="com_intalio_bpms_console_pageFooter_poweredByValue" /></span></a>
                (<fmt:message key="com_intalio_bpms_dashboard_version"/>
                <label id="version"></label>
                <fmt:message key="com_intalio_bpms_dashboard_build"/>
                <label id="build"></label>)
           </span>
                                
</div>
<div id="dashlet-process-body" class="io-dashlet-body" style="display:none;">
	<div id="processdashlet1" class="io-dashlet io-dashlet1" style="display:none;">
		<img src="images/notification.png" alt="" class="io-dashlet-image">
		<a class="io-dashlet-heading"><fmt:message key="com_intalio_bpms_dashboard_notifications"/></a>
		<b id="not1m"><fmt:message key="com_intalio_bpms_dashboard_filter_1m"/></b>
		<b> | </b>
		<b id="not1w"><fmt:message key="com_intalio_bpms_dashboard_filter_1w"/></b>
		<b> | </b>
		<b id="not2d"><fmt:message key="com_intalio_bpms_dashboard_filter_2d"/></b>
		<b> | </b>
		<b id="not1d"><fmt:message key="com_intalio_bpms_dashboard_filter_1d"/></b>
		<ul id="nots">
		</ul>
	</div>
	<div id="processdashlet2" class="io-dashlet io-dashlet2" style="display:none;">
		<img src="images/barchart.jpg" alt="" class="io-dashlet-image">
		<a class="io-dashlet-heading"><fmt:message key="com_intalio_bpms_dashboard_process_bar"/></a>
		<b id="cha1m"><fmt:message key="com_intalio_bpms_dashboard_filter_1m"/></b>
		<b> | </b>
		<b id="cha1w"><fmt:message key="com_intalio_bpms_dashboard_filter_1w"/></b>
		<b> | </b>  
		<b id="cha2d"><fmt:message key="com_intalio_bpms_dashboard_filter_2d"/></b>
		<b> | </b>
		<b id="cha1d"><fmt:message key="com_intalio_bpms_dashboard_filter_1d"/></b>
		<div id="barChart" class="io-dashlet-inner"></div>
	</div>
	<div id="processdashlet3" class="io-dashlet io-dashlet3" style="display:none">
		<img src="images/holiday.png" alt="" class="io-dashlet-image">
		<a class="io-dashlet-heading"><fmt:message key="com_intalio_bpms_dashboard_vacation_summary"/></a>
		<b><img src="images/refresh.png" title="Refresh" alt="Fetch Vacation Summary" onClick="fetchData('1d','vacation');"></b>
                <div id="vacationDashlet" class="io-dashlet-inner" style="top:-8%;">
                        <table cellpadding="0" cellspacing="0"  id="vacationTable" width="100%">
	                        <thead>
		                        <th colspan="15" align="left" style="width:100%"></th>
		                        <tr>
			                        <th><fmt:message key="com_intalio_bpms_console_login_username"/></th>
                                                <th><fmt:message key="com_intalio_bpms_dashboard_vacation_from"/></th>
                                                <th><fmt:message key="com_intalio_bpms_dashboard_vacation_to"/></th>
                                                <th><fmt:message key="com_intalio_bpms_dashboard_vacation_comment"/></th>
			                </tr>
	                        </thead>
	                        <tbody></tbody>
	                        <tfoot><tr></tr></tfoot>
                        </table>
                </div>
	</div>
	<div id="processdashlet4" class="io-dashlet io-dashlet4" style="display:none">
		<img src="images/barchart.jpg" alt="" class="io-dashlet-image">
		<a class="io-dashlet-heading"><fmt:message key="com_intalio_bpms_dashboard_instance_bar"/></a>
		<div id="chart1" style="height:85%;padding-top:1%" >
    			<svg style="word-wrap: break-word;"></svg>
  		</div>
	</div>
	<div id="processdashlet5" class="io-dashlet io-dashlet5" style="display:none">
		<img src="images/barchart.jpg" alt="" class="io-dashlet-image">
		<a class="io-dashlet-heading"> 
		<fmt:message key="com_intalio_bpms_dashboard_discrete_bar" /></a>
		<div id="chart2" style="height:85%;padding-top:1%" >
    			<svg style="word-wrap: break-word;"></svg>
  		</div>
	</div>
	<div id="processdashlet6" class="io-dashlet io-dashlet6" style="display:none">
		<img src="images/barchart.jpg" alt="" class="io-dashlet-image">
		<a class="io-dashlet-heading"> 
		<fmt:message key="com_intalio_bpms_dashboard_ws_res_time_bar" /></a>
		<div id="chart3" style="height:85%;padding-top:1%" >
    			<svg style="word-wrap: break-word;"></svg>
  		</div>
	</div>
</div>
<div id="dashlet-task-body" class="io-dashlet-body" style="display:none;">
	
	<div id="taskdashlet1" class="io-dashlet io-dashlet1" >
		<img src="images/tick.png" alt="" class="io-dashlet-image">
		<a class="io-dashlet-heading"><fmt:message key="com_intalio_bpms_dashboard_tasks"/></a>
		<b id="task1m"><fmt:message key="com_intalio_bpms_dashboard_filter_1m"/></b>		
		<b> | </b>
		<b id="task1w"><fmt:message key="com_intalio_bpms_dashboard_filter_1w"/></b>
		<b> | </b>
		<b id="task2d"><fmt:message key="com_intalio_bpms_dashboard_filter_2d"/></b>
		<b> | </b>
		<b id="task1d"><fmt:message key="com_intalio_bpms_dashboard_filter_1d"/></b>
		<div id="taskChart" class="io-dashlet-inner"></div>
	</div>
	<div id="taskdashlet2" class="io-dashlet io-dashlet2">
		<img src="images/event.png" alt="" class="io-dashlet-image">
		<a class="io-dashlet-heading"><fmt:message key="com_intalio_bpms_dashboard_events"/></a>
		<b id="eve1m"><fmt:message key="com_intalio_bpms_dashboard_filter_1m"/></b>
		<b> | </b>
		<b id="eve1w"><fmt:message key="com_intalio_bpms_dashboard_filter_1w"/></b>
		<b> | </b>
		<b id="eve2d"><fmt:message key="com_intalio_bpms_dashboard_filter_2d"/></b>
		<b> | </b>
		<b id="eve1d"><fmt:message key="com_intalio_bpms_dashboard_filter_1d"/></b>
		<ul id="events">
		</ul>
	</div>
	<div id="taskdashlet3" class="io-dashlet io-dashlet3" style="display:none">
		<img src="images/barchart.jpg" alt="" class="io-dashlet-image">
		<a class="io-dashlet-heading"> 
		<fmt:message key="com_intalio_bpms_dashboard_pending_claimed_tasks" /></a>
		<div id="chart4" style="height:85%;padding-top:5%" >
    			<svg style="word-wrap: break-word;"></svg>
  		</div>
	</div>
</div>
</div>
</body>