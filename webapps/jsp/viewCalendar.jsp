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
		      window.location = "ViewCalendar.action?calendarId=<ww:property value="calendar.id"/>&mode=day&date=" + date;
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
<div style="position: absolute; left: 0px; display: none; width: 200px; height: 300px; background: red" id="day">
<p>
07.00 ---------------
</p>
<p>
08.00 ---------------
</p>
<p>
09.00 ---------------
</p>
<p>
10.00 ---------------
</p>
<p>
11.00 ---------------
</p>
<p>
12.00 ---------------
</p>
<p>
13.00 ---------------
</p>
<p>
14.00 ---------------
</p>
<p>
15.00 ---------------
</p>
<p>
16.00 ---------------
</p>
<p>
17.00 ---------------
</p>
<p>
18.00 ---------------
</p>
<p>
19.00 ---------------
</p>
</div>

<div style="position: absolute; left: 0px; display: none;" id="calendar"></div>

</div>

</body>
</html>
