<%--
 Copyright (c) 2005-2008 Intalio inc.

 All rights reserved. This program and the accompanying materials
 are made available under the terms of the Eclipse Public License v1.0
 which accompanies this distribution, and is available at
 http://www.eclipse.org/legal/epl-v10.html

 Contributors:
 Intalio inc. - initial API and implementation
--%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="intalio" uri="http://www.intalio.com/tagfiles"%>

<%@ taglib prefix="intalio" uri="http://www.intalio.com/tagfiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<!--META-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<!--STYLESHEETS-->
<link href="style/custom/customLogin.css" rel="stylesheet" type="text/css" />

<!--SCRIPTS-->
<script type="text/javascript" src="scripts/plugin/jquery-1.8.2.js"></script>

<!--Slider-in icons-->
<script type="text/javascript">
$(document).ready(function() {
	$(".username").focus(function() {
		$(".user-icon").css("left","-48px");
	});
	$(".username").blur(function() {
		$(".user-icon").css("left","0px");
		
	});
	
	$(".password").focus(function() {
		$(".pass-icon").css("left","-48px");
	});
	$(".password").blur(function() {
		$(".pass-icon").css("left","0px");
	});
	    
	$('.username').bind("keydown", function(e) {
   		if (e.which == 9)
   		{ //tab key
     			e.preventDefault(); //to skip default behavior of the enter key
			$(".username").blur();
			$(".username").css('background','#ffffff');
			$('.password').focus();
     		}
	});
	$('.password').bind("keydown", function(e) {
   		if (e.which == 9)
   		{ //tab key
     			e.preventDefault(); //to skip default behavior of the tab key
			$(".password").blur();
			$(".password").css('background','#ffffff');
			$('#btnSubmit').focus();			
     		}
		if (e.which == 13)
   		{ //enter key
     			e.preventDefault(); //to skip default behavior of the enter key
			$(".password").blur();
			$(".password").css('background','#ffffff');
			$('#btnSubmit').click();			
     		}
	});
});
</script>
</head>
<body>
<c:set var="logoPath" value="images/logo.png" />

<!--WRAPPER-->
<div id="wrapper">

	<!--SLIDE-IN ICONS-->
    <div class="user-icon"></div>

    <div class="pass-icon"></div>
    <!--END SLIDE-IN ICONS-->

<!--LOGIN FORM-->
<form id="form" class="login-form" method="POST" onSubmit="document.getElementById('actionName').value = 'logIn';">
	<input type="hidden" id="actionName" name="actionName" value="logIn"/>

	<!--HEADER-->
    <div class="header">
    <img src="${logoPath}"  alt="Intalio Inc" />    
    </div>
    <!--END HEADER-->
	
	<!--CONTENT-->
    <div class="content">
    <table>
	<tr>
	   <spring:bind path="login.username">
		<td ><input type="text" size=16 name="username" onfocus="this.value=''"
					value="${login.username}" class="input username"  />
				<font color="red">${status.errorMessage}</font></td>
	   </spring:bind>
	   </tr>
	
	   <tr>			
	   <spring:bind path="login.password">
		<td class="io-login-loginBox-password"><input type="password" name="password" onfocus="this.value=''"
				value="${login.password}" class="input password"/>
			<font color="red">${status.errorMessage}</font></td>
		</spring:bind>
	    </tr>
	<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<spring:bind path="login">
			<c:forEach items="${status.errorMessages}" var="errorMessage">
				<tr>
					<td colspan="3"><font color="red"> ${errorMessage} </font></td>
				</tr>
			</c:forEach>
		</spring:bind>
	</td>
	</tr>
	</table>
    </div>
    <!--END CONTENT-->
    
    <!--FOOTER-->

    <div class="footer">
    <table>
	<td class="io-login-loginBox-autoLoginchk" style="left:20px; top:95px;">
			<c:choose>
				<c:when test="${login.autoLogin}">
					<input type="checkbox" name="autoLogin" value="true"
						checked="checked" />
				</c:when>
				<c:otherwise>
					<input type="checkbox" name="autoLogin" value="true" />
				</c:otherwise>
			</c:choose> <fmt:message key="com_intalio_bpms_console_auto_login" />
	</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
    	<td ><input type="submit" name="submit"id="btnSubmit" value="Login" class="button"
				value="<fmt:message key="com_intalio_bpms_console_login_loginBtn"/>" />
	</td>
	
    </table>
    </div>
    <!--END FOOTER-->

</form>
<!--END LOGIN FORM-->

</div>
<!--END WRAPPER-->

</body>
</html>
