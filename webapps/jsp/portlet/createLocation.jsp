<%@ page import="javax.portlet.PortletURL,
				 java.util.Map,
				 java.util.Iterator,
				 java.util.List"%>

<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="calendar" prefix="calendar" %>

<portlet:defineObjects/>

<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Calendar information</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendar.css" />
	<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/applications/jscalendar/calendar-system.css" title="system" />
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/calendar.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/lang/calendar-en.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/calendar-setup.js"></script>
	<style type="text/css">
		.errorMessage {
		    color: red;
		}
	</style>
</head>

<body>

<div id="inputForm">
	
	<div id="contentListHeader">
		Create new location
	</div>

	<div id="contentList">
		<portlet:actionURL var="createLocationActionUrl">
			<portlet:param name="action" value="CreateLocation"/>
		</portlet:actionURL>
		
		<form name="inputForm" method="POST" action="<c:out value="${createLocationActionUrl}"/>">
		<p>
			<calendar:textField label="Name:" name="name" value="location.name" cssClass="normalInput"/>
		</p>
		<p>
			<calendar:textField label="Description:" name="description" value="location.description" cssClass="normalInput"/>
		</p>
		<p>
			<input type="submit">
		</p>
		</form>
	</div>

</div>

</body>
</html>
