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
	<title><ww:property value="this.getLabel('labels.internal.entry.createEntry.title')"/></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendar.css" />
	<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/applications/jscalendar/calendar-system.css" title="system" />
</head>

<body>

<div id="inputForm">
	
	<div id="contentListHeader">
		<ww:property value="this.getLabel('labels.internal.entry.createNewEntry')"/>
	</div>

	<div id="contentList">

		<portlet:actionURL var="createEntryActionUrl">
			<portlet:param name="action" value="CreateEntry"/>
		</portlet:actionURL>

		<form name="inputForm" method="POST" action="<c:out value="${createEntryActionUrl}"/>">
		<input type="hidden" name="eventId" value="<ww:property value="eventId"/>">
		<p>	
			<calendar:textField label="labels.internal.entry.firstName" name="firstName" value="entry.firstName" cssClass="normalInput"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.entry.lastName" name="lastName" value="entry.lastName" cssClass="normalInput"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.entry.email" name="email" value="entry.email" cssClass="normalInput"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.entry.organisation" name="organisation" value="entry.organisation" cssClass="normalInput"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.entry.address" name="address" value="entry.address" cssClass="normalInput"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.entry.zipcode" name="zipcode" value="entry.zipcode" cssClass="normalInput"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.entry.city" name="city" value="entry.city" cssClass="normalInput"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.entry.phone" name="phone" value="entry.phone" cssClass="normalInput"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.entry.fax" name="fax" value="entry.fax" cssClass="normalInput"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.entry.message" name="message" value="entry.message" cssClass="normalInput"/>
		</p>
		<p>
			<input type="submit" value=" value="<ww:property value="this.getLabel('labels.internal.entry.createButton')"/>"">
		</p>
		</form>
	</div>

</div>

</body>
</html>
