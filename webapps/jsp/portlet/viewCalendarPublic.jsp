<%@ page import="javax.portlet.PortletURL,
				 java.util.Map,
				 java.util.Iterator,
				 java.util.List,
				 org.infoglue.cms.portal.information.RenderRequestIG"%>

<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<portlet:defineObjects/>

<ww:set name="calendarId" value="calendar.id" scope="page"/>

<portlet:renderURL var="viewCalendarUrl">
	<portlet:param name="action" value="ViewCalendar!public"/>
	<portlet:param name="calendarId" value="<%= pageContext.getAttribute("calendarId").toString() %>"/>
	<portlet:param name="mode" value="day"/>
	<portlet:param name="startDateTime" value="$startDateTime"/>
	<portlet:param name="endDateTime" value="$endDateTime"/>
</portlet:renderURL>

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

		function dateChanged<ww:property value="componentId"/>(calendar) 
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
		      
		      //document.helpForm<ww:property value="componentId"/>.mode.value = "day";
		      //document.helpForm<ww:property value="componentId"/>.startDateTime.value = date;
		      //document.helpForm<ww:property value="componentId"/>.endDateTime.value = date;
		      //document.helpForm<ww:property value="componentId"/>.submit();
		      
		      // redirect...
		      var url = "<c:out value="${viewCalendarUrl}"/>";
		      convertedUrl = url.replace("$startDateTime", date);
		      convertedUrl = convertedUrl.replace("$endDateTime", date);
		      //alert("convertedUrl:" + convertedUrl);
		      window.location = convertedUrl;
		    	
		    }
		};
		
		var edit<ww:property value="componentId"/> = false;
		
		function toggleShowEditForm<ww:property value="componentId"/>()
		{
			if(!edit<ww:property value="componentId"/>)
			{
				document.getElementById("calendarArea<ww:property value="componentId"/>").style.display = "none";
				document.getElementById("contentList<ww:property value="componentId"/>").style.display = "block";
				edit<ww:property value="componentId"/> = true;
			}
			else
			{
				document.getElementById("calendarArea<ww:property value="componentId"/>").style.display = "block";
				document.getElementById("contentList<ww:property value="componentId"/>").style.display = "none";
				edit<ww:property value="componentId"/> = false;
			}
		}
	
		var oldTab<ww:property value="componentId"/>Id;
		
		function setActiveTab<ww:property value="componentId"/>(id)
		{
			//alert("id:" + id);
			//alert("oldTab<ww:property value="componentId"/>Id:" + oldTab<ww:property value="componentId"/>Id);
			
			if(oldTab<ww:property value="componentId"/>Id)
			{
				document.getElementById(oldTab<ww:property value="componentId"/>Id).style.display = "none";
				document.getElementById(oldTab<ww:property value="componentId"/>Id + "Tab").setAttribute("class", "tab");
				document.getElementById(oldTab<ww:property value="componentId"/>Id + "Link").setAttribute("class", "tabText");
			}
				
			document.getElementById(id).style.display 		= "block";
			document.getElementById(id + "Tab").setAttribute("class", "activeTab");
			document.getElementById(id + "Link").setAttribute("class", "activeTabText");
			oldTab<ww:property value="componentId"/>Id = id;
			//alert("oldTab<ww:property value="componentId"/>Id becomes:" + id);
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
		
		var previousDiv<ww:property value="componentId"/>;	
		function toggleDiv<ww:property value="componentId"/>(id)
		{
			if(previousDiv<ww:property value="componentId"/>)
				previousDiv<ww:property value="componentId"/>.style.visibility = "hidden";
			
			element = document.getElementById(id);
			element.style.visibility = "visible";
			previousDiv<ww:property value="componentId"/> = element;
		}

		function hideDiv(id)
		{
			if(previousDiv)
				previousDiv.style.visibility = "hidden";
		}

		function init<ww:property value="componentId"/>()
		{
		  	if("<ww:property value="mode"/>" == "events")
		  		setActiveTab<ww:property value="componentId"/>("events<ww:property value="componentId"/>");
		  	if("<ww:property value="mode"/>" == "day")
		  		setActiveTab<ww:property value="componentId"/>("day<ww:property value="componentId"/>");
		  	else if("<ww:property value="mode"/>" == "week")
		  		setActiveTab<ww:property value="componentId"/>("week<ww:property value="componentId"/>");
		  	else
		  		setActiveTab<ww:property value="componentId"/>("calendar<ww:property value="componentId"/>");
			
			/*
			var params = {
			      flat         : document.getElementById("calendar<ww:property value="componentId"/>"), // ID of the parent element
			      flatCallback : dateChanged<ww:property value="componentId"/>,// our callback function
			      onSelect 	   : dateChanged<ww:property value="componentId"/>,// our callback function
			      firstDay     : 1,
			      ifFormat 	   : "%Y-%m-%d",
			      daFormat     : "%Y-%m-%d",
			      date		   : "<ww:property value="formattedStartDate"/>"
			    };
			
			function onSelect<ww:property value="componentId"/>(cal) {
				alert("cal i onSelect...");
				var p = cal.params;
				var update = (cal.dateClicked || p.electric);
				if (update && p.flat) {
					alert("update and p.flat");
					if (typeof p.flatCallback == "function")
						p.flatCallback(cal);
					else
						alert("No flatCallback given -- doing nothing.");
					return false;
				}
				if (update && p.inputField) {
					p.inputField.value = cal.date.print(p.ifFormat);
					if (typeof p.inputField.onchange == "function")
						p.inputField.onchange();
				}
				if (update && p.displayArea)
					p.displayArea.innerHTML = cal.date.print(p.daFormat);
				if (update && p.singleClick && cal.dateClicked)
					cal.callCloseHandler();
				if (update && typeof p.onUpdate == "function")
					p.onUpdate(cal);
			};    
			
			var calendar<ww:property value="componentId"/> = new Calendar(params.firstDay, params.date, onSelect<ww:property value="componentId"/>);
			//calendar<ww:property value="componentId"/>.flat = params.flat;
			calendar<ww:property value="componentId"/>.flatCallback = params.flatCallback;
			calendar<ww:property value="componentId"/>.params = params;
			calendar<ww:property value="componentId"/>.weekNumbers = params.weekNumbers;
			calendar<ww:property value="componentId"/>.ifFormat = params.ifFormat;
			calendar<ww:property value="componentId"/>.daFormat = params.daFormat;
			calendar<ww:property value="componentId"/>.create(params.flat);
			calendar<ww:property value="componentId"/>.show();
			*/
			
			Calendar.setup
			(
			    {
			      flat         : "calendar<ww:property value="componentId"/>", // ID of the parent element
			      flatCallback : dateChanged<ww:property value="componentId"/>,// our callback function
			      firstDay     : 1,
			      ifFormat 	   : "%Y-%m-%d",
			      daFormat     : "%Y-%m-%d",
			      date		   : "<ww:property value="formattedStartDate"/>"
			    }
		  	);
		  	//alert("calendar<ww:property value="componentId"/>:" + calendar<ww:property value="componentId"/>);
		}
		
	</script>
</head>

<body>

<div id="inputForm<ww:property value="componentId"/>">
	
	<div id="contentListHeader<ww:property value="componentId"/>">
		Calendar <ww:property value="calendar.name"/><br>
		<ww:property value="calendar.description"/>
		<br>
	</div>
</div>
	
<div style="float: left; display: block; border: 0px solid black;" id="calendarArea<ww:property value="componentId"/>">
<table cellspacing="0" cellpadding="0" border="0">
<tr>
	<td><div id="events<ww:property value="componentId"/>Tab" class="tab"><a id="events<ww:property value="componentId"/>Link" href="javascript:setActiveTab<ww:property value="componentId"/>('events<ww:property value="componentId"/>');" onFocus="this.blur();" class="tabText">Events</a></div></td>
	<td><div id="day<ww:property value="componentId"/>Tab" class="tab"><a id="day<ww:property value="componentId"/>Link" href="javascript:setActiveTab<ww:property value="componentId"/>('day<ww:property value="componentId"/>');" onFocus="this.blur();" class="tabText">Day</a></div></td>
	<td><div id="week<ww:property value="componentId"/>Tab" class="tab"><a id="week<ww:property value="componentId"/>Link" href="javascript:setActiveTab<ww:property value="componentId"/>('week<ww:property value="componentId"/>');" onFocus="this.blur();" class="tabText">Week</a></div></td>
	<td><div id="calendar<ww:property value="componentId"/>Tab" class="tab"><a id="calendar<ww:property value="componentId"/>Link" href="javascript:setActiveTab<ww:property value="componentId"/>('calendar<ww:property value="componentId"/>');" onFocus="this.blur();" class="tabText">Month</a></div></td>
</tr>
</table>

<!-- *********************************** -->
<!-- *   HERE COMES THE COMING EVENTS  * -->
<!-- *********************************** -->

<div style="position: relative; float: left; overflow:auto; left: 0px; display: none; width: 300px; height: 250px; background: silver; border: 0px black solid;" id="events<ww:property value="componentId"/>">
<table border="0" width="100%" cellpadding="2" cellspacing="0">
<tr>
	<td align="left" colspan="2" style="border-bottom: 0px solid black; height: 20px;">
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
		<portlet:param name="action" value="ViewEvent!public"/>
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

<div style="float: left; overflow:auto; left: 0px; display: none; width: 300px; height: 250px; background: silver; border: 1px black solid;" id="day<ww:property value="componentId"/>">

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
	
<div class="dayItem<ww:property value="componentId"/>" onClick="javascript:addEvent('<c:out value="${createEventUrl}"/>');" onmouseover="javascript:markElement(this);" style="border-bottom: 1px solid black;">
	<ww:property/>.00 
		<ww:if test="#hourEvents.size > 0">
		   	<ww:iterator value="#hourEvents">
		   		
	   			<ww:set name="eventId" value="id" scope="page"/>
				<portlet:renderURL var="eventUrl">
					<portlet:param name="action" value="ViewEvent!public"/>
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

<div style="float: left; overflow:auto; left: 0px; display: none; width: 300px; height: 250px; background: silver; border: 1px black solid;" id="week<ww:property value="componentId"/>">
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
							<portlet:param name="action" value="ViewEvent!public"/>
							<portlet:param name="eventId" value="<%= pageContext.getAttribute("eventId").toString() %>"/>
						</portlet:renderURL>
						<a href="<c:out value="${eventUrl}"/>" onmouseover="javascript:toggleDiv<ww:property value="componentId"/>('event_<ww:property value="id"/>');" onmouseout="javascript:hideDiv('event_<ww:property value="id"/>');"><img src="<%=request.getContextPath()%>/images/trans.gif" width="10" height="12" style="background-color: blue; aborder: 1px solid black; margin: 0px 1px 0px 1px;" border="0"></a><div id="event_<ww:property value="id"/>" style="position: absolute; overflow: auto; visibility:hidden; width: 100px; height: 50px; background: white"><ww:property value="name"/><br><ww:property value="description"/></div>
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


<div style="float: left; left: 0px; display: none;" id="calendar<ww:property value="componentId"/>"></div>

</div>

<script type="text/javascript">
  //alert("apa");
  init<ww:property value="componentId"/>();
</script>


</body>
</html>
