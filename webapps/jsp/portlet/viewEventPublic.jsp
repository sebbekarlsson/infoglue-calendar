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
	
		function showUploadForm()
		{
			document.getElementById("contentList").style.display = "none";
			document.getElementById("upload").style.display = "block";
		}
	
	</script>
	
</head>

<body>

<div class="marginalizedDiv" id="inputForm">
		
	<h1><ww:property value="event.name"/></h1>
	<hr/>
	<div id="contentList" style="display: block;">
		<p>
			<span class="label">Beskrivning:</span><br> 
			<ww:property value="event.description"/>
		</p>
		<p>
			<div style="position: relative; height: 25px;">
				<div style="float: left">
					<span class="label">Datum/tid:</span><br>
					<ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/> : <ww:property value="this.formatDate(event.startDateTime.time, 'HH')"/>
					till 
					<ww:property value="this.formatDate(event.endDateTime.time, 'yyyy-MM-dd')"/> : <ww:property value="this.formatDate(event.endDateTime.time, 'HH')"/>
				</div>
			</div>
		</p>    			
   		<p>
      		<span class="label">Plats:</span><br>
			<ww:iterator value="event.locations">
	      		<ww:set name="location" value="top"/>
 				<ww:property value='#location.id'/>
      		</ww:iterator>
  		</p>
		<p>
      		<span class="label">Kategori:</span><br>
			<ww:iterator value="event.categories">
	      		<ww:set name="category" value="top"/>
 				<ww:property value='#category.id'/>
      		</ww:iterator>
       	</p>
		<p>  		
  			<span class="label">Deltagare:</span><br>
      		<ww:iterator value="event.participants">
	      		<ww:set name="participant" value="top"/>
 				<ww:property value="top.userName"/>,
      		</ww:iterator>
		</p>
		<p>
			<span class="label">Bifogade filer:</span><br>
			<ww:iterator value="event.resources">
				<a href="<ww:property value='this.getResourceUrl(top.id)'/>"><ww:property value='assetKey'/></a><br>     			
      		</ww:iterator>
		</p>
		<p>
			<ww:set name="eventId" value="eventId" scope="page"/>
			<portlet:renderURL var="createEntryRenderURL">
				<portlet:param name="action" value="CreateEntry!inputPublic"/>
				<portlet:param name="eventId" value="<%= pageContext.getAttribute("eventId").toString() %>"/>
			</portlet:renderURL>
			
			<a href="<c:out value="${createEntryRenderURL}"/>">Sign up for this event</a>
		</p>
		
		<a href="<%=request.getContextPath()%>/<ww:property value="this.getVCalendar(event)"/>"><img src="<%=request.getContextPath()%>/images/calendarIcon.jpg" border="0"> Add to my calendar (vCal)</a>
		<hr/>
	</div>		

</div>

</body>
</html>
