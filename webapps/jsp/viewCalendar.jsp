<%@ taglib uri="webwork" prefix="ww" %>

<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Calendar information</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="css/calendar.css" />
	<link rel="stylesheet" type="text/css" media="all" href="applications/jscalendar/calendar-system.css" title="system" />
	
	<script type="text/javascript" src="applications/jscalendar/calendar.js"></script>
	<script type="text/javascript" src="applications/jscalendar/lang/calendar-en.js"></script>
	<script type="text/javascript" src="applications/jscalendar/calendar-setup.js"></script>
	
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
		      
		      // redirect...
		      window.location = "ViewCalendar.action?calendarId=<ww:property value="calendar.id"/>&mode=day&startDateTime=" + date + "&endDateTime=" + date;
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
			alert("Calling:" + url);
			document.location.href = url;
		}
		
		
		function init()
		{
		  	if("<ww:property value="mode"/>" == "day")
		  		setActiveTab("day");
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
		<form name="inputForm" method="POST" action="UpdateCalendar.action">
		<input type="hidden" name="calendarId" value="<ww:property value="calendar.id"/>">
			name: <input type="textfield" name="name" value="<ww:property value="calendar.name"/>">
			description: <input type="textfield" name="description" value="<ww:property value="calendar.description"/>">
			<input type="submit">
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

<div style="float: left; overflow:auto; left: 0px; display: none; width: 300px; height: 250px; background: silver" id="events">
<span class="event">
<ww:iterator value="calendar.events">
<ww:property value="id"/>. <ww:property value="name"/> (<ww:property value="startDateTime.getTime()"/> - <ww:property value="endDateTime.getTime()"/>)<br>
</ww:iterator>
</span>
</div>

<div style="float: left; overflow:auto; left: 0px; display: none; width: 300px; height: 250px; background: silver" id="day">

<ww:iterator value="{'00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23'}">

<ww:set name="hourEvents" value="this.getEvents(top)" />

<span class="dayItem">
	<ww:property/>.00 
		<ww:if test="#hourEvents.size > 0">
		   <ww:iterator value="#hourEvents"><a href="ViewEvent.action?eventId=<ww:property value="id"/>"><ww:property value="name"/></a></ww:iterator>
		   <span onClick="javascript:addEvent('<ww:property/>');">New event</span>
		</ww:if>
		<ww:else>
			<span onClick="javascript:addEvent('<ww:property/>');">______________</span>
		</ww:else>		
	<br>
</span>
</ww:iterator>
</div>


<div style="float: left; overflow:auto; left: 0px; display: none; width: 300px; height: 250px; background: silver" id="week">
<table border="0" width="100%">
<tr>
	<td align="right" width="100%" colspan="2">
		<span class="dayItem">Week <ww:property value="this.getFormattedDate(startDateTime, 'w')"/></span>
	
	</td>
</tr>
<tr>
	<td width="20px">
		<table border="0" width="10%">
			<tr>
				<td>
					<span class="dayItem">&nbsp;</span>
				</td>
			</tr>
			<ww:iterator value="{'08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20'}">
			<tr>
				<td>
					<span class="dayItem"><ww:property/></span>
				</td>
			</tr>
			</ww:iterator>
		</table>
	</td>
	<td>
		<table border="0" width="100%">
		<tr>
			<ww:iterator value="{'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'}">
			<td><span class="dayItem"><ww:property/></span></td>
			</ww:iterator>
		</tr>

		<ww:iterator value="{'08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20'}">
		<tr>
			<ww:set name="hourEvents" value="this.getEvents(top)" />
			<ww:iterator value="{'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'}">
			<td>
				<span class="dayItem"> 
					<ww:if test="#hourEvents.size > 0">
					   <ww:iterator value="#hourEvents"><a href="ViewEvent.action?eventId=<ww:property value="id"/>"><ww:property value="name"/></a></ww:iterator>
					   <span onClick="javascript:addEvent('<ww:property/>');">New event</span>
					</ww:if>
					<ww:else>
						<span onClick="javascript:addEvent('<ww:property/>');"></span>
					</ww:else>		
					<br>
				</span>
				</ww:iterator>
			</td>
		</tr>
		</ww:iterator>
		</table>
	</td>
</tr>
</table>

</div>


<div style="float: left; left: 0px; display: none;" id="calendar"></div>

</div>

<div style="position: absolute; bottom: 10px; margin-left: 1em; margin-bottom: 1em;" id="calendarArea">
<ww:property value="calendar.getEvents().size()"/>

All Events<br>
<ww:iterator value="calendar.events" status="rowstatus">
Event: <ww:property value="id"/>. <ww:property value="name"/> (<ww:property value="startDateTime.getTime()"/> - <ww:property value="endDateTime.getTime()"/>)<br>
</ww:iterator>
<br>
<br>

Events for <ww:property value="startDateTime"/> - <ww:property value="endDateTime"/><br>
<ww:iterator value="events" status="rowstatus">
Event: <ww:property/> <ww:property value="id"/>. <ww:property value="name"/> (<ww:property value="startDateTime.getTime()"/> - <ww:property value="endDateTime.getTime()"/>)<br>
</ww:iterator>

</div>

</body>
</html>
