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
	
</head>

<body>

<div id="inputForm">
	
	<div id="contentListHeader">
		 <ww:property value="event.name"/> <a href="DeleteEvent.action?eventId=<ww:property value="event.id"/>&calendarId=<ww:property value="calendarId"/>&mode=<ww:property value="mode"/>">Delete</a>
	</div>

	<div id="contentList">
		<form name="inputForm" method="GET" action="UpdateEvent.action">
			<input type="hidden" name="eventId" value="<ww:property value="event.id"/>"/>
			<input type="hidden" name="calendarId" value="<ww:property value="calendarId"/>"/>
			<input type="hidden" name="mode" value="<ww:property value="mode"/>"/>
			
			
			name: <input type="textfield" name="name" value="<ww:property value="event.name"/>"><br>
			description: <input type="textfield" name="description" value="<ww:property value="event.description"/>"><br>
			startDateTime: <input type="textfield" id="startDateTime" name="startDateTime" value="<ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/>">
			<img src="images/calendar.gif" id="trigger_startDateTime" style="cursor: pointer; border: 0px solid black;" title="Date selector" /><br>
      
			endDateTime: <input type="textfield" id="endDateTime" name="endDateTime" value="<ww:property value="this.formatDate(event.endDateTime.time, 'yyyy-MM-dd')"/>">
			<img src="images/calendar.gif" id="trigger_endDateTime" style="cursor: pointer; border: 0px solid black;" title="Date selector" /><br>

			StartTime: <input type="textfield" name="startTime" value="<ww:property value="this.formatDate(event.startDateTime.time, 'HH')"/>">
      		EndTime: <input type="textfield" name="endTime" value="<ww:property value="this.formatDate(event.endDateTime.time, 'HH')"/>">
			
			Location: 
      		
      		<select name="locationId" multiple="true">
	      		<ww:iterator value="locations">
	      			<ww:set name="location" value="top"/>
		      		<ww:iterator value="event.locations">
		      			<ww:if test="top.id == #location.id">
		      				<option value="<ww:property value='#location.id'/>" selected="1"><ww:property value="#location.name"/></option>
						</ww:if>
						
						<ww:else>
						   <option value="<ww:property value='#location.id'/>"><ww:property value="#location.name"/></option>
						</ww:else>
					</ww:iterator>
	      		</ww:iterator>
      		</select>
      		   
      		Category:
      		
      		<select name="categoryId" multiple="true">
	      		<ww:iterator value="categories">
	      			<ww:set name="category" value="top"/>
		      		<ww:iterator value="event.categories">
		      			<ww:if test="top.id == #category.id">
		      				<option value="<ww:property value='#category.id'/>" selected="1"><ww:property value="#category.name"/></option>
						</ww:if>
						
						<ww:else>
						   <option value="<ww:property value='#category.id'/>"><ww:property value="#category.name"/></option>
						</ww:else>
					</ww:iterator>
	      		</ww:iterator>
      		</select>
      		
			<input type="submit">
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
