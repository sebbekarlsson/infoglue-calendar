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
		Create new event
	</div>

	<div id="contentList">
		<form name="inputForm" method="GET" action="CreateEvent.action">
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
						<img src="images/calendar.gif" id="trigger_startDateTime" style="cursor: pointer; border: 0px solid black;" title="Date selector" />
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
						<img src="images/calendar.gif" id="trigger_endDateTime" style="cursor: pointer; border: 0px solid black;" title="Date selector" />
					</div>
					<div style="float: left">
		      			EndTime:<br>
		      			<input type="textfield" name="endTime" value="<ww:property value="time"/>" class="hourInput">
	      			</div>
				</div>
			</p>
      		<p>
	      		Location (Hold shift to select multiple):<br>
	      		<ww:select name="'locationId'" listKey="id" listValue="name" list="locations" value="id" multiple="true" cssClass="'listBox'"/> 
			</p>
			<p>
	      		Category (Hold shift to select multiple):<br>
	      		<ww:select name="'categoryId'" listKey="id" listValue="name" list="categories" value="id" multiple="true" cssClass="'listBox'"/> 
    		</p>
    		<p>  		
      			Participants (Hold shift to select multiple):<br>
	      		<select name="participantUserName" multiple="true" class="listBox">
		      		<ww:iterator value="{'Per', 'Mattias', 'Claes', 'Lena', 'Helena', 'Håkan'}">
		      			<option value="<ww:property value='top'/>"><ww:property value="top"/></option>
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
