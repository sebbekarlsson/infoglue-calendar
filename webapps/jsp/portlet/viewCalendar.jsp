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
	
	<script type="text/javascript">

		function dateChanged(calendar) 
		{
		    // Beware that this function is called even if the end-user only
		    // changed the month/year.  In order to determine if a date was
		    // clicked you can use the dateClicked property of the calendar:
		    if (calendar.dateClicked) 
		    {
		      var y = calendar.date.getFullYear();
		      var m = calendar.date.getMonth();     // integer, 0..11
		      var d = calendar.date.getDate();      // integer, 1..31
		      
		      month = m + 1;
		      day = d;
		      if(d < 10) 
		      	day = "0" + day
		      
		      var date = "" + y + "-" + month + "-" + day;
		      
		      document.getForm.mode.value = "day";
		      document.getForm.startDateTime.value = date;
		      document.getForm.endDateTime.value = date;
		      document.getForm.submit();
		      
		      // redirect...
		      //window.location = "ViewCalendar.action?calendarId=<ww:property value="calendar.id"/>&mode=day&startDateTime=" + date + "&endDateTime=" + date;
		    	
		    }
		};
	
		var oldTabId;
		
		function setActiveTab(id)
		{
			if(oldTabId)
			{
				document.getElementById(oldTabId).style.display = "none";
				document.getElementById(oldTabId + "Tab").setAttribute("class", "tab");
				document.getElementById(oldTabId + "Link").setAttribute("class", "tabText");
			}
				
			document.getElementById(id).style.display 		= "block";
			document.getElementById(id + "Tab").setAttribute("class", "activeTab");
			document.getElementById(id + "Link").setAttribute("class", "activeTabText");
			oldTabId = id;
		}
	
		function addEvent(time)
		{
			url = "CreateEvent!input.action?calendarId=<ww:property value="calendar.id"/>&mode=day&startDateTime=<ww:property value="startDateTime"/>&endDateTime=<ww:property value="endDateTime"/>&time=" + time;
			//alert("Calling:" + url);
			document.location.href = url;
		}

		function addEvent(url)
		{
			//url = "CreateEvent!input.action?calendarId=<ww:property value="calendar.id"/>&mode=week&startDateTime=" + date + "&endDateTime=" + date + "&time=" + time;
			//alert("Calling:" + url);
			document.location.href = url;
		}


		var previousElement;	
		function markElement(element)
		{
			if(previousElement)
			{
				previousElement.bgColor = '';
				previousElement.style.background = '';
			}
			
			element.bgColor = 'gray';
			element.style.background = 'gray';
			previousElement = element;
		}
		
		var previousDiv;	
		function toggleDiv(id)
		{
			if(previousDiv)
				previousDiv.style.visibility = "hidden";
			
			element = document.getElementById(id);
			element.style.visibility = "visible";
			previousDiv = element;
		}

		function hideDiv(id)
		{
			if(previousDiv)
				previousDiv.style.visibility = "hidden";
		}

		
		function init()
		{
		  	if("<ww:property value="mode"/>" == "events")
		  		setActiveTab("events");
		  	if("<ww:property value="mode"/>" == "day")
		  		setActiveTab("day");
		  	else if("<ww:property value="mode"/>" == "week")
		  		setActiveTab("week");
		  	else
		  		setActiveTab("calendar");

			Calendar.setup
			(
			    {
			      flat         : "calendar", // ID of the parent element
			      flatCallback : dateChanged,          // our callback function
			      firstDay     : 1,
			      ifFormat 	   : "%Y-%m-%d",
			      daFormat     : "%Y-%m-%d",
			      date		   : "<ww:property value="formattedStartDate"/>"
			    }
		  	);
		  	
		  		
		}
		
	</script>
</head>

<body onload="init();">

<div id="inputForm">
	
	<div id="contentListHeader">
		Update calendar <ww:property value="calendar.name"/>
	</div>

	<div id="contentList">
		<portlet:actionURL var="updateCalendarActionUrl">
			<portlet:param name="action" value="UpdateCalendar"/>
		</portlet:actionURL>
		
		<form name="inputForm" method="POST" action="<c:out value="${updateCalendarActionUrl}"/>">
	
		<input type="hidden" name="calendarId" value="<ww:property value="calendar.id"/>">
		<p>
			Name:<br> <input type="textfield" name="name" class="normalInput" value="<ww:property value="calendar.name"/>">
		</p>
		<p>
			Description:<br> <textarea name="description"><ww:property value="calendar.description"/></textarea>
		</p>
		<p>
			<input type="submit" value="Save">
		</p>
		</form>
	</div>

</div>


<div style="float: left; id="calendarArea">
<table cellspacing="0" cellpadding="0" border="0">
<tr>
	<td><div id="eventsTab" class="tab"><a id="eventsLink" href="javascript:setActiveTab('events');" onFocus="this.blur();" class="tabText">Events</a></div></td>
	<td><div id="dayTab" class="tab"><a id="dayLink" href="javascript:setActiveTab('day');" onFocus="this.blur();" class="tabText">Day</a></div></td>
	<td><div id="weekTab" class="tab"><a id="weekLink" href="javascript:setActiveTab('week');" onFocus="this.blur();" class="tabText">Week</a></div></td>
	<td><div id="calendarTab" class="tab"><a id="calendarLink" href="javascript:setActiveTab('calendar');" onFocus="this.blur();" class="tabText">Month</a></div></td>
</tr>
</table>

<!-- *********************************** -->
<!-- *   HERE COMES THE COMING EVENTS  * -->
<!-- *********************************** -->

<div style="float: left; overflow:auto; left: 0px; display: none; width: 300px; height: 250px; background: silver; border: 1px black solid;" id="events">
<table border="0" width="100%" cellpadding="2" cellspacing="0">
<tr>
	<td align="left" colspan="2" style="border-bottom: 1px solid black; height: 20px;">
		<div style="float: left;">
			<span class="dayItem">Coming events</span>
		</div>
	</td>
</tr>
</table>

<div class="event" style="margin: 10px 10px 10px 10px;">
<ww:iterator value="calendar.events">

	<ww:set name="eventId" value="id" scope="page"/>
	<portlet:renderURL var="eventUrl">
		<portlet:param name="action" value="ViewEvent"/>
		<portlet:param name="eventId" value="<%= pageContext.getAttribute("eventId").toString() %>"/>
	</portlet:renderURL>

	<p>
	<a href="<c:out value="${eventUrl}"/>"><ww:property value="name"/> <ww:property value="this.getFormattedDate(startDateTime.getTime(), 'yyyy-MM-dd')"/> - <ww:property value="this.getFormattedDate(endDateTime.getTime(), 'yyyy-MM-dd')"/></a><br>
	<ww:property value="description"/>
	</p>
	
</ww:iterator>
</div>
</div>

<!-- *********************************** -->
<!-- *   HERE COMES THE DAYS EVENTS  * -->
<!-- *********************************** -->

<div style="float: left; overflow:auto; left: 0px; display: none; width: 300px; height: 250px; background: silver; border: 1px black solid;" id="day">

<table border="0" width="100%" cellpadding="2" cellspacing="0">
<tr>
	<td align="left" colspan="2" style="border-bottom: 1px solid black; height: 20px;">
		<div style="float: left;">
			<span class="dayItem"><ww:property value="this.getFormattedDate(startDateTime, 'dd MMM yyyy')"/></span>
		</div>
	</td>
</tr>
</table>

<ww:iterator value="{'08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20'}">

	<ww:set name="hourEvents" value="this.getEvents(startCalendar.time, top)" />

	<ww:set name="calendarId" value="calendar.id" scope="page"/>
	<ww:set name="startDateTime" value="this.getFormattedDate(startCalendar.time, 'yyyy-MM-dd')" scope="page"/>
	<ww:set name="endDateTime" value="this.getFormattedDate(startCalendar.time, 'yyyy-MM-dd')" scope="page"/>
	<ww:set name="time" value="top" scope="page"/>
	
	<portlet:renderURL var="createEventUrl">
		<portlet:param name="action" value="CreateEvent!input"/>
		<portlet:param name="calendarId" value="<%= pageContext.getAttribute("calendarId").toString() %>"/>
		<portlet:param name="mode" value="week"/>
		<portlet:param name="startDateTime" value="<%= pageContext.getAttribute("startDateTime").toString() %>"/>
		<portlet:param name="endDateTime" value="<%= pageContext.getAttribute("endDateTime").toString() %>"/>
		<portlet:param name="time" value="<%= pageContext.getAttribute("time").toString() %>"/>
	</portlet:renderURL>
	
<div class="dayItem" onClick="javascript:addEvent('<c:out value="${createEventUrl}"/>');" onmouseover="javascript:markElement(this);" style="border-bottom: 1px solid black;">
	<ww:property/>.00 
		<ww:if test="#hourEvents.size > 0">
		   	<ww:iterator value="#hourEvents">
		   		
	   			<ww:set name="eventId" value="id" scope="page"/>
				<portlet:renderURL var="eventUrl">
					<portlet:param name="action" value="ViewEvent"/>
					<portlet:param name="eventId" value="<%= pageContext.getAttribute("eventId").toString() %>"/>
				</portlet:renderURL>
					   		
		   		<a href="<c:out value="${eventUrl}"/>"><ww:property value="name"/></a> 
			</ww:iterator>
		</ww:if>
</div>
</ww:iterator>
</div>

<!-- *********************************** -->
<!-- *   HERE COMES THE WEEK CALENDAR  * -->
<!-- *********************************** -->

<div style="float: left; overflow:auto; left: 0px; display: none; width: 300px; height: 250px; background: silver; border: 1px black solid;" id="week">
<table border="0" width="100%" cellpadding="0" cellspacing="0">
<tr>
	<td align="left" colspan="2" style="border-bottom: 1px solid black; height: 20px;">
		<div style="float: left;">
		<span class="dayItem"><ww:property value="this.getFormattedDate(startDateTime, 'MMM yyyy')"/></span>
		</div>
		<div style="float: right;">
		<span class="dayItem">Week <ww:property value="this.getFormattedDate(startDateTime, 'ww')"/></span>
		</div>
	</td>
</tr>
<tr>
	<td colspan="2"><img src="<%=request.getContextPath()%>/images/trans.gif" height="5" width="1"></td>
</tr>
<tr>
	<td width="20px" valign="top">
		<table border="0" width="10%" cellpadding="0" cellspacing="0" style="border: 1px solid silver;">
			<tr>
				<td>
					<span class="dayItem">&nbsp;<br/>&nbsp;</span>
				</td>
			</tr>
			<ww:iterator value="{'08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18'}">
			<tr>
				<td style="border-top: 1px solid black;">
					<span class="dayItem"><ww:property/>.00</span>
				</td>
			</tr>
			</ww:iterator>
		</table>
	</td>
	<td valign="top">
		<table style="border: 1px solid black;" border="0" width="100%" cellpadding="0" cellspacing="0">
		<tr>
			<ww:iterator value="dates">
			<td align="center" style="border-right: 1px solid black;">
				<span class="dayItem"><ww:property value="this.getFormattedDate(top, 'EE')"/><br/>
				<ww:property value="this.getFormattedDate(top, 'dd')"/></span>
			</td>
			</ww:iterator>
		</tr>

		<ww:iterator value="{'08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18'}">
		<tr>
			<ww:set name="hour" value="top" />
			<ww:iterator value="dates">
				<ww:set name="hourEvents" value="this.getWeekEvents(top, #hour)" />

				<ww:set name="calendarId" value="calendar.id" scope="page"/>
				<ww:set name="startDateTime" value="this.getFormattedDate(top, 'yyyy-MM-dd')" scope="page"/>
				<ww:set name="endDateTime" value="this.getFormattedDate(top, 'yyyy-MM-dd')" scope="page"/>
				<ww:set name="time" value="#hour" scope="page"/>
	
				<portlet:renderURL var="createEventUrl">
					<portlet:param name="action" value="CreateEvent!input"/>
					<portlet:param name="calendarId" value="<%= pageContext.getAttribute("calendarId").toString() %>"/>
					<portlet:param name="mode" value="week"/>
					<portlet:param name="startDateTime" value="<%= pageContext.getAttribute("startDateTime").toString() %>"/>
					<portlet:param name="endDateTime" value="<%= pageContext.getAttribute("endDateTime").toString() %>"/>
					<portlet:param name="time" value="<%= pageContext.getAttribute("time").toString() %>"/>
				</portlet:renderURL>
				
				<td width="14%" valign="bottom" style=" bottom-padding: 0px; border-top: 1px solid black; border-right: 1px solid black;" onclick="javascript:addEvent('<c:out value="${createEventUrl}"/>');" onmouseover="javascript:markElement(this);">
					<span class="dayItem"><ww:if test="#hourEvents.size > 0"><ww:iterator value="#hourEvents">
						<ww:set name="eventId" value="top.id" scope="page"/>
						<portlet:renderURL var="eventUrl">
							<portlet:param name="action" value="ViewEvent"/>
							<portlet:param name="eventId" value="<%= pageContext.getAttribute("eventId").toString() %>"/>
						</portlet:renderURL>
						<a href="<c:out value="${eventUrl}"/>" onmouseover="javascript:toggleDiv('event_<ww:property value="id"/>');" onmouseout="javascript:hideDiv('event_<ww:property value="id"/>');"><img src="<%=request.getContextPath()%>/images/trans.gif" width="10" height="12" style="background-color: blue; aborder: 1px solid black; margin: 0px 1px 0px 1px;" border="0"></a><div id="event_<ww:property value="id"/>" style="position: absolute; overflow: auto; visibility:hidden; width: 100px; height: 50px; background: white"><ww:property value="name"/><br><ww:property value="description"/></div>
						</ww:iterator></ww:if><img src="<%=request.getContextPath()%>/images/trans.gif" width="1" height="12">
					</span>
				</td>
			</ww:iterator>
		</tr>
		</ww:iterator>
		</table>
	</td>
</tr>
<tr>
	<td colspan="2"><img src="<%=request.getContextPath()%>/images/trans.gif" height="5" width="1"></td>
</tr>
<tr>
	<td align="left" colspan="2" style="border-top: 1px solid black; height: 50px; background-color: silver;">
		<div style="float: left;">
			<span class="dayItem"><ww:property value="this.getFormattedDate(startDateTime, 'MMM yyyy')"/></span>
		</div>
		<div style="float: right;">
			<span class="dayItem">Week <ww:property value="this.getFormattedDate(startDateTime, 'ww')"/></span>
		</div>
	</td>
</tr>
</table>

</div>


<div style="float: left; left: 0px; display: none;" id="calendar"></div>

</div>

<portlet:renderURL var="viewCalendarUrl">
	<portlet:param name="action" value="ViewCalendar"/>
</portlet:renderURL>

<form name="getForm" method="POST" action="<c:out value="${viewCalendarUrl}"/>">
	<input type="hidden" name="calendarId" value="<ww:property value="calendar.id"/>">
	<input type="hidden" name="mode" value="day">
	<input type="hidden" name="startDateTime" value="">
	<input type="hidden" name="endDateTime" value="">
</form>
	
</body>
</html>
