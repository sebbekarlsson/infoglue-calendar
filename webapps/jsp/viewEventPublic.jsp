<%@ taglib uri="webwork" prefix="ww" %>


<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Calendar information</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="css/calendar.css" />
	<link rel="stylesheet" type="text/css" media="all" href="applications/jscalendar/calendar-system.css" title="system" />
		
</head>

<body>

<div id="inputForm">
	
	<div id="contentListHeader">
		 <ww:property value="event.name"/>
	</div>

	<div id="contentList" style="display: block;">
			<p>
				name: <ww:property value="event.name"/>
			</p>
			<p>
				description: <ww:property value="event.description"/>
			</p>
			<p>
				startDateTime: <ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/> kl: <ww:property value="this.formatDate(event.startDateTime.time, 'HH:mm')"/>
			</p>    
			<p>
				endDateTime: <ww:property value="this.formatDate(event.endDateTime.time, 'yyyy-MM-dd')"/> kl: <ww:property value="this.formatDate(event.endDateTime.time, 'HH:mm')"/>
			</p>
			
       		<p>
	      		Location:
	      		<ww:iterator value="event.locations">
      				<ww:property value="top.name"/>
				</ww:iterator>
	     	</p>
			<p>
	      		Category:
				<ww:iterator value="event.categories">
      				<ww:property value="top.name"/>
				</ww:iterator>
	       	</p>
    		<p>  		
      			Participants:<br>
	      		<ww:iterator value="event.participants">
      				<ww:property value="top.name"/>
				</ww:iterator>				
      		</select>
			</p>
			<p>
				Attached files:<br>
				<ww:iterator value="event.resources">
					<a href="<ww:property value='this.getResourceUrl(top.id)'/>"><ww:property value='assetKey'/></a><br>     			
	      		</ww:iterator>
			</p>
			<p>
				If you want to participate click <a href="CreateEntry!input.action?eventId=<ww:property value="event.id"/>">here</a>				
			</p>
	</div>
	
</div>


</body>
</html>
