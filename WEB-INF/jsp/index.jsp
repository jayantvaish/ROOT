<%@page  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
        <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
        <html>
            
            <head>
                <title>Intalio|BPMS-DashBoard</title>
                <script type="text/javascript" src="scripts/plugin/jquery-1.8.2.js"></script>
                <script type="text/javascript" src="scripts/plugin/jquery-ui.js"></script>
                <script type="text/javascript" src="scripts/plugin/jquery.ui.core.js"></script>
                <script type="text/javascript" src="scripts/plugin/jquery.ui.widget.js"></script>
                <script type="text/javascript" src="scripts/plugin/jquery.ui.button.js"></script>
                <script type="text/javascript" src="scripts/plugin/jquery.qtip.js"></script>
                <script type="text/javascript" src="scripts/plugin/jquery.dashboard.min.js"></script>
                <script type="text/javascript" src="scripts/plugin/themeroller.js"></script>
                <script type="text/javascript" src="scripts/plugin/d3.v2.js"></script>
                <script type="text/javascript" src="scripts/plugin/nv.d3.js"></script>
                <script type="text/javascript" src="scripts/plugin/tooltip.js"></script>
                <script type="text/javascript" src="scripts/plugin/utils.js"></script>
                <script type="text/javascript" src="scripts/plugin/axis.js"></script>
                <script type="text/javascript" src="scripts/plugin/discreteBar.js"></script>
                <script type="text/javascript" src="scripts/plugin/discreteBarChart.js"></script>
                <script type="text/javascript" src="scripts/plugin/multiBar.js"></script>
                <script type="text/javascript" src="scripts/plugin/multiBarChart.js"></script>
                <script type="text/javascript" src="scripts/plugin/legend.js"></script>
                <script type="text/javascript" src="scripts/plugin/scatter.js"></script>
                <script type="text/javascript" src="scripts/plugin/line.js"></script>
                <script type="text/javascript" src="scripts/plugin/multiBarHorizontal.js"></script>
                <script type="text/javascript" src="scripts/plugin/multiBarHorizontalChart.js"></script>
                <script type="text/javascript" src="scripts/plugin/pie.js"></script>
				<script type="text/javascript" src="scripts/plugin/pieChart.js"></script>
                <script type="text/javascript" src="scripts/custom/dashboard.js"></script>
                <link class="include" rel="stylesheet" href="style/plugin/jquery-ui-1.9.0.css"/>
                <script src="scripts/plugin/historicalBar.js"></script>
                <script src="scripts/plugin/linePlusBarChart.js"></script>
                <script type="text/javascript" src="scripts/plugin/jquery.dataTables.js"></script>
                <link rel="stylesheet" type="text/css" href="style/plugin/jquery.dataTables.css"/>
                <script type="text/javascript" language="javascript" src="scripts/plugin/jquery-dateFormat.js"></script>
                <link class="include" rel="stylesheet" type="text/css" href="style/plugin/jquery.ui.theme.css">
                <link class="include" rel="stylesheet" type="text/css" href="style/plugin/jquery.qtip.css">
                <link href="style/plugin/nv.d3.css" rel="stylesheet" type="text/css">
                <link class="include" rel="stylesheet" type="text/css" href="style/custom/dashboardui.css">
                <script>
                    
                </script>
            </head>
            
            <body>
                <form id="dashform" style="display:inline;" method="POST" name="dashform">
                    <input type="hidden" id="actionName" name="actionName" />
                    <img src="images/logo.png" alt="Intalio Inc." class="io-header-logo">&nbsp;
                    <div id="radioTab" style="margin-top:-5px;">
                        <input type="radio" id="radio1" name="radio" />
                        <label for="radio1">
                            <fmt:message key="com_intalio_bpms_dashboard_monitoring" />
                        </label>&nbsp;
                        <input type="radio" id="radio2" name="radio" />
                        <label for="radio2">
                            <fmt:message key="com_intalio_bpms_dashboard_uifw" />
                        </label>&nbsp;
                        <input type="radio" id="radio3" name="radio" />
                        <label for="radio3">
                            <fmt:message key="com_intalio_bpms_dashboard_bam" />
                        </label>&nbsp;</div>
                    <div style="margin-top:-30px;float:right;margin-right:10px;">
				<button id="options" >Options</button>                        
				<button id="userProfile"></button>
				
                    </div>
                    <div id="div1" class="io-footer" style="float:right"></div>
		    <div id="div2" class="io-footer-options" style="float:right"></div>

                    <div class="optionContent" style="display:none"> 
			<table id="optionTable" cellpadding="5">
			<tr><td>
			<a class="addtab headerlink" href="#"><fmt:message key="com_intalio_bpms_dashboard_add_tab"/></a>&nbsp;
                        &nbsp;</td></tr>
			<tr><td><a class="dmopenaddwidgetdialog headerlink" href="#"><fmt:message key="com_intalio_bpms_dashboard_add_widget"/></a>&nbsp;
                        &nbsp;</td></tr>
			<tr><td><a class="dmeditLayout headerlink" href="#"><fmt:message key="com_intalio_bpms_dashboard_edit_layout"/></a></td></tr>
			<tr><td><a class="dmsaveDashboard headerlink" href="#"><fmt:message key="com_intalio_bpms_dashboard_save_dashboard"/></a></td></tr>
                    	</table>
		    </div>

                    <div class="tooltipContent" style="float:center;display:none;margin-left:-4px;margin-top:-2px;">
                        <button id="btnHelp" style="width:80px">
                            <fmt:message key="com_intalio_bpms_dashboard_help"/>
                        </button>
                        </br></br>
                        <button id="btnLogout" style="width:80px">
                            <fmt:message key="com_intalio_bpms_console_pageHeader_logout"/>
                        </button>
                    </div>
                    <div id="dialog" title="Add Tab" style="display:none;">
                        <form>
                            <fieldset class="ui-helper-reset">
                                <label for="tab_title">
                                    <fmt:message key="com_intalio_bpms_dashboard_tab_title" />
                                </label>
                                <input type="text" name="tab_title" id="tab_title" value=""  maxlength="25"  class="ui-widget-content ui-corner-all"
                                />
                            </fieldset>
                        </form>
                    </div>
                    <div id="tabs">
                        <ul id="tablist"></ul>
                    </div>
                    <div id="templates"></div>
		    <input type="hidden" name="accessible" id="accessible"/>
		    <div id="messageDialog">
		    </div>
		    <div id="loaderDiv"></div>
                </form>
            </body>
        
        </html>
