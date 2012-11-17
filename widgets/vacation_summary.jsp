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
	  showVacation(data);
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
</script>
</head>	
<body>
	<div id="processdashlet3">
		<div id="vacationDashlet">
                        <table cellpadding="0" cellspacing="0"  id="vacationTable" width="100%" height="100%">
	                        <thead>
		                        <th colspan="15" align="left" style="width:100%"></th>
		                        <tr>
			                        <th>UserName</th>
                                                <th>Vacation From</th>
                                                <th>Vacation To</th>
                                                <th>Comments</th>
			                </tr>
	                        </thead>
	                        <tbody></tbody>
	                        <tfoot><tr></tr></tfoot>
                        </table>
                </div>
	</div>
</body>
</html>
