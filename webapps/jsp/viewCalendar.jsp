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
		      window.location = "ViewCalendar.action?calendarId=<ww:property value="calendar.id"/>&mode=day&startDate=" + date + "&endDate=" + date;
		    }
		};
	
		var oldTabId;
		
		function setActiveTab(id)
		{
			if(oldTabId)
				document.getElementById(oldTabId).style.display = "none";
				
			document.getElementById(id).style.display 		= "block";
			oldTabId = id;
		}
	
		function addEvent(time)
		{
			url = "CreateEvent!input.action?calendarId=<ww:property value="calendar.id"/>&mode=day&startDate=<ww:property value="startDate"/>&endDate=<ww:property value="endDate"/>&time=" + time;
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
			      date		   : "<ww:property value="formattedDate"/>"
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


<div style="float: left; margin-left: 1em; margin-bottom: 1em;" id="calendarArea">
<a href="javascript:setActiveTab('day');">Day</a><a href="javascript:setActiveTab('calendar');">Month</a>
<div style="position: absolute; overflow:auto; left: 0px; display: none; width: 200px; height: 200px; background: silver" id="day">

<ww:iterator value="{'00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23'}">
<ww:set name="this" value="this" />
<p>
<ww:property/>.00 <span onClick="javascript:addEvent('<ww:property/>');">____________________</span> <ww:property value="this.getEvents(<ww:property/>)"/>
</p>
</ww:iterator>
</div>

<ww:property value="calendar.getEvents().size()"/>

<br><br><br><br><br><br><br><br><br><br><br><br><br>
<ww:iterator value="calendar.events" status="rowstatus">
Event: <ww:property value="id"/>. <ww:property value="name"/> (<ww:property value="startDateTime.getTime()"/> - <ww:property value="endDateTime.getTime()"/>)
</ww:iterator>
<br>
<br>

Events for <ww:property value="startDate"/> - <ww:property value="endDate"/><br>
<ww:iterator value="events" status="rowstatus">
Event: <ww:property/> <ww:property value="id"/>. <ww:property value="name"/> (<ww:property value="startDateTime.getTime()"/> - <ww:property value="endDateTime.getTime()"/>)<br>
</ww:iterator>

<div style="position: absolute; left: 0px; display: none;" id="calendar"></div>

</div>

</body>
</html>
