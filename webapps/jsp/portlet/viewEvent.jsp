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

<div id="inputForm">
	
	<portlet:actionURL var="deleteEventUrl">
		<portlet:param name="action" value="DeleteEvent"/>
	</portlet:actionURL>

	<form name="deleteLinkForm" method="POST" action="<c:out value="${deleteEventUrl}"/>">
		<input type="hidden" name="eventId" value="<ww:property value="event.id"/>"/>
		<input type="hidden" name="calendarId" value="<ww:property value="calendarId"/>"/>
		<input type="hidden" name="mode" value="<ww:property value="mode"/>"/>
		<input type="hidden" name="startDateTime" value="<ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/>">
		<input type="hidden" name="endDateTime" value="<ww:property value="this.formatDate(event.endDateTime.time, 'yyyy-MM-dd')"/>">
	</form>		
	
	<div id="contentListHeader">
		 <ww:property value="event.name"/> <a href="javascript:document.deleteLinkForm.submit();">Delete</a>
	</div>

	<div id="contentList" style="display: block;">
	
		<portlet:actionURL var="updateEventActionUrl">
			<portlet:param name="action" value="UpdateEvent"/>
		</portlet:actionURL>
		
		<form name="inputForm" method="POST" action="<c:out value="${updateEventActionUrl}"/>">
			<input type="hidden" name="eventId" value="<ww:property value="event.id"/>"/>
			<input type="hidden" name="calendarId" value="<ww:property value="calendarId"/>"/>
			<input type="hidden" name="mode" value="<ww:property value="mode"/>"/>
			
			<p>
				name:<br>
				<input type="textfield" name="name" value="<ww:property value="event.name"/>" class="normalInput">
			</p>
			<p>
				description:<br> 
				<input type="textfield" name="description" value="<ww:property value="event.description"/>" class="normalInput">
			</p>
			<p>
				<div style="position: relative; height: 25px;">
					<div style="float: left">
						startDateTime:<br> 
						<input type="textfield" id="startDateTime" name="startDateTime" value="<ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/>" class="dateInput">
						<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_startDateTime" style="cursor: pointer; border: 0px solid black;" title="Date selector" />
					</div>
					<div style="float: left">
						StartTime:<br> 
						<input type="textfield" name="startTime" value="<ww:property value="this.formatDate(event.startDateTime.time, 'HH')"/>" class="hourInput">
	      			</div>
				</div>
			</p>    
			<p>
				<div style="position: relative; height: 25px;">
					<div style="float: left">
						endDateTime:<br>
						<input type="textfield" id="endDateTime" name="endDateTime" value="<ww:property value="this.formatDate(event.endDateTime.time, 'yyyy-MM-dd')"/>" class="dateInput">
						<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_endDateTime" style="cursor: pointer; border: 0px solid black;" title="Date selector" />
					</div>
					<div style="float: left">
		      			EndTime:<br>
		      			<input type="textfield" name="endTime" value="<ww:property value="this.formatDate(event.endDateTime.time, 'HH')"/>" class="hourInput">
	      			</div>
				</div>
			</p>
			
       		<p>
	      		Location (Hold shift to select multiple):<br>
				<select name="locationId" multiple="true" class="listBox">
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
  			</p>
			<p>
	      		Category (Hold shift to select multiple):<br>
				<select name="categoryId" multiple="true" class="listBox">
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
	       	</p>
    		<p>  		
      			Participants (Hold shift to select multiple):<br>
	      		<select name="participantUserName" multiple="true" class="listBox">
	      		<ww:iterator value="{'Per', 'Mattias', 'Claes', 'Lena', 'Helena', 'Håkan'}">
	      			
	      			<option value="<ww:property value='top'/>" selected="1"><ww:property value="top"/></option>
	      			<!--
	      			<ww:set name="userName" value="top"/>
		      		<ww:iterator value="event.participants">
		      			<ww:if test="top.userName == #userName">
		      				<option value="<ww:property value='#userName'/>" selected="1"><ww:property value="#userName"/></option>
						</ww:if>
						
						<ww:else>
						   <option value="<ww:property value='#userName'/>"><ww:property value="#userName"/></option>
						</ww:else>
					</ww:iterator>
					-->
	      		</ww:iterator>
      		</select>
			</p>
			<p>
				Attached files:<br>
				<ww:iterator value="event.resources">
					<a href="<ww:property value='this.getResourceUrl(top.id)'/>"><ww:property value='assetKey'/></a><br>     			
	      		</ww:iterator>
	      		<a href="javascript:showUploadForm();">Add resource</a>
			</p>
			<p>
				<input type="submit" value="Update">
			</p>
		</form>
	</div>
	
	<div id="upload" style="display: none;">
		<form name="inputForm" method="POST" action="UpdateEvent!upload.action" enctype="multipart/form-data">
			<input type="hidden" name="eventId" value="<ww:property value="event.id"/>"/>
			<input type="hidden" name="calendarId" value="<ww:property value="calendarId"/>"/>
			<input type="hidden" name="mode" value="<ww:property value="mode"/>"/>
			<input type="hidden" name="startDateTime" value="<ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/>"/>
			<input type="hidden" name="endDateTime" value="<ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/>"/>
			
			<p>
				Attachment key:<br>
				<input type="textfield" name="assetKey" class="normalInput">
			</p>
			<p>
				Attach file:<br>
				<input type="file" name="file"/>
			</p>
			<p>
				<input type="submit" value="Update">
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
