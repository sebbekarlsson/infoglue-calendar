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
		Anmälan till event
	</div>

	<div id="contentList">

		<portlet:actionURL var="createEntryActionUrl">
			<portlet:param name="action" value="CreateEntry"/>
		</portlet:actionURL>

		<form name="inputForm" method="POST" action="<c:out value="${createEntryActionUrl}"/>">
		<input type="hidden" name="eventId" value="<ww:property value="eventId"/>">
		<p>	
			Förnamn: <br/><input type="textfield" class="normalInput" name="firstName" value="">
		</p>
		<p>
			Efternamn: <br/><input type="textfield" class="normalInput" name="lastName" value="">
		</p>
		<p>
			E-post: <br/><input type="textfield" class="normalInput" name="email" value="">
		</p>
		<p>
			Organisation: <br/><input type="textfield" class="normalInput" name="organisation" value="">
		</p>
		<p>
			Address: <br/><input type="textfield" class="normalInput" name="address" value="">
		</p>
		<p>
			Postnummer: <br/><input type="textfield" class="normalInput" name="zipcode" value="">
		</p>
		<p>
			Ort: <br/><input type="textfield" class="normalInput" name="city" value="">
		</p>
		<p>
			Telefon: <br/><input type="textfield" class="normalInput" name="phone" value="">
		</p>
		<p>
			Fax: <br/><input type="textfield" class="normalInput" name="fax" value="">
		</p>
		<p>
			Message: <br/><input type="textfield" class="normalInput" name="message" value="">
		</p>
		<p>
			<input type="submit" value="Spara">
		</p>
		</form>
	</div>

</div>

</body>
</html>
