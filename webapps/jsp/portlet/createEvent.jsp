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
	<title>Calendar information</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendar.css" />
	<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/applications/jscalendar/calendar-system.css" title="system" />
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/calendar.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/lang/calendar-en.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/calendar-setup.js"></script>
	
</head>

<body>

<div id="inputForm">
	
	<div id="contentListHeader">
		Create new event
	</div>

	<div id="contentList">

		<portlet:actionURL var="createEventUrl">
			<portlet:param name="action" value="CreateEvent"/>
		</portlet:actionURL>
		
		<form name="inputForm" method="POST" action="<c:out value="${createEventUrl}"/>">
			<input type="hidden" name="calendarId" value="<ww:property value="calendarId"/>"/>
			<input type="hidden" name="mode" value="<ww:property value="mode"/>"/>
			<input type="hidden" name="date" value="<ww:property value="date"/>"/>
			<input type="hidden" name="time" value="<ww:property value="time"/>"/>
			
			<p>
				name:<br>
				<input type="textfield" name="name" value="" class="normalInput">
			</p>
			<p>
				description:<br> 
				<input type="textfield" name="description" value="" class="normalInput">
			</p>
			<p>
				<div style="position: relative; height: 25px;">
					<div style="float: left">
						startDateTime:<br> 
						<input type="textfield" id="startDateTime" name="startDateTime" value="<ww:property value="startDateTime"/>" class="dateInput">
						<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_startDateTime" style="cursor: pointer; border: 0px solid black;" title="Date selector" />
					</div>
					<div style="float: left">
						StartTime:<br> 
						<input type="textfield" name="startTime" value="<ww:property value="time"/>" class="hourInput">
	      			</div>
				</div>
			</p>    
			<p>
				<div style="position: relative; height: 25px;">
					<div style="float: left">
						endDateTime:<br>
						<input type="textfield" id="endDateTime" name="endDateTime" value="<ww:property value="endDateTime"/>" class="dateInput">
						<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_endDateTime" style="cursor: pointer; border: 0px solid black;" title="Date selector" />
					</div>
					<div style="float: left">
		      			EndTime:<br>
		      			<input type="textfield" name="endTime" value="<ww:property value="time"/>" class="hourInput">
	      			</div>
				</div>
			</p>
      		<p>
	      		Location (Hold shift to select multiple):<br>
	      		<select name="locationId" multiple="true" class="listBox">
		      		<ww:iterator value="locations">
		      			<option value="<ww:property value='top.id'/>"><ww:property value="top.name"/></option>
		      		</ww:iterator>
	      		</select>
			</p>
			<p>
	      		Category (Hold shift to select multiple):<br>
	      		<select name="categoryId" multiple="true" class="listBox">
		      		<ww:iterator value="categories">
		      			<option value="<ww:property value='top.id'/>"><ww:property value="top.name"/></option>
		      		</ww:iterator>
	      		</select>
    		</p>
    		<p>  		
      			Participants (Hold shift to select multiple):<br>
	      		<select name="participantUserName" multiple="true" class="listBox">
		      		<ww:iterator value="infogluePrincipals">
		      			<option value="<ww:property value='top.name'/>"><ww:property value="top.firstName"/> <ww:property value="top.lastName"/></option>
		      		</ww:iterator>
	      		</select>
			</p>
			<p>
				<input type="submit" value="Create">
			</p>
		</form>
	</div>

</div>

<script type="text/javascript">
    Calendar.setup({
        inputField     :    "startDateTime",     // id of the input field
        ifFormat       :    "%Y-%m-%d",      // format of the input field
        button         :    "trigger_startDateTime",  // trigger for the calendar (button ID)
        align          :    "Tl",           // alignment (defaults to "Bl")
        singleClick    :    true
    });
</script>

<script type="text/javascript">
    Calendar.setup({
        inputField     :    "endDateTime",     // id of the input field
        ifFormat       :    "%Y-%m-%d",      // format of the input field
        button         :    "trigger_endDateTime",  // trigger for the calendar (button ID)
        align          :    "Tl",           // alignment (defaults to "Bl")
        singleClick    :    true
    });
</script>

</body>
</html>
