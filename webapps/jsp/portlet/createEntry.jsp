<%@ page import="javax.portlet.PortletURL,
				 java.util.Map,
				 java.util.Iterator,
				 java.util.List"%>

<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<portlet:defineObjects/>
<?xml version="1.0" encoding="utf-8"?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Create Entry</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendar.css" />
	<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/applications/jscalendar/calendar-system.css" title="system" />
</head>

<body>

<div id="inputForm">
	
	<div id="contentListHeader">
		Create new entry
	</div>

	<div id="contentList">

		<portlet:actionURL var="createEntryActionUrl">
			<portlet:param name="action" value="CreateEntry"/>
		</portlet:actionURL>

		<form name="inputForm" method="POST" action="<c:out value="${createEntryActionUrl}"/>">
			<input type="hidden" name="eventId" value="<ww:property value="eventId"/>">
			First name: <input type="textfield" class="normalInput" name="firstName" value="">
			Last name: <input type="textfield" class="normalInput" name="lastName" value="">
			E-mail: <input type="textfield" class="normalInput" name="email" value="">
			<br><br>
			<input type="submit">
		</form>
	</div>

</div>

</body>
</html>
