<%@ page import="javax.portlet.PortletURL,
				 java.util.Map,
				 java.util.Iterator,
				 java.util.List,
				 java.util.Locale,
				 java.util.ResourceBundle,
				 org.infoglue.common.util.ResourceBundleHelper"%>

<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>


<portlet:defineObjects/>

<ww:set name="languageCode" value="languageCode" scope="page"/>
<% 
	Locale locale = new Locale(pageContext.getAttribute("languageCode").toString());
	ResourceBundle resourceBundle = ResourceBundleHelper.getResourceBundle("infoglueCalendar", locale);
%>


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
				<span class="label">Namn:</span><span class="alert"><ww:property value="nameErrorMessage"/></span><br>
				<input type="textfield" name="name" value="<ww:property value="event.name"/>" class="normalInput">
			</p>
			<p>
				<span class="label">Beskrivning:</span><span class="alert"><ww:property value="descriptionErrorMessage"/></span><br> 
				<input type="textfield" name="description" value="<ww:property value="event.description"/>" class="normalInput">
			</p>
			<p>
				<table border="0" cellspacing="0">
				<tr>
					<td><span class="label">Startdatum:</span></td> 
					<td><span class="label">Starttid:</span></td> 
				</tr>
				<tr>
					<td width="20%" nowrap>
						<input type="textfield" id="startDateTime" name="startDateTime" value="<ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/>" class="dateInput">
						<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_startDateTime" style="cursor: pointer; border: 0px solid black;" title="Date selector" />
					</td>				
					<td>
						<input type="textfield" name="startTime" value="<ww:property value="this.formatDate(event.startDateTime.time, 'HH')"/>" class="hourInput">
					</td>				
				</tr>
				</table>
			</p>    
			<p>
				<table border="0">
				<tr>
					<td><span class="label">Slutdatum:</span></td> 
					<td><span class="label">Sluttid:</span></td> 
				</tr>
				<tr>
					<td width="20%" nowrap>
						<input type="textfield" id="endDateTime" name="endDateTime" value="<ww:property value="this.formatDate(event.endDateTime.time, 'yyyy-MM-dd')"/>" class="dateInput">
						<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_endDateTime" style="cursor: pointer; border: 0px solid black;" title="Date selector" />
					</td>				
					<td>
		      			<input type="textfield" name="endTime" value="<ww:property value="this.formatDate(event.endDateTime.time, 'HH')"/>" class="hourInput">
					</td>				
				</tr>
				</table>				
			</p>
			
       		<p>
	      		<span class="label">Plats (Håll ner Ctrl för att välja flera):</span><span class="alert"><ww:property value="locationErrorMessage"/></span><br>
				<select name="locationId" multiple="true" class="listBox">
      				<ww:iterator value="selectedLocations">
		      			<option value="<ww:property value='top.id'/>" selected="1"><ww:property value="top.name"/></option>
		      		</ww:iterator>
		      		<option value="">-------------------</option>
		      		<ww:iterator value="remainingLocations">
		      			<option value="<ww:property value='top.id'/>"><ww:property value="top.name"/></option>
		      		</ww:iterator>		      		
				</select>
  			</p>
			<p>
	      		<span class="label">Kategori (Håll ner Ctrl för att välja flera):</span><span class="alert"><ww:property value="categoryErrorMessage"/></span><br>
				<select name="categoryId" multiple="true" class="listBox">
					<ww:iterator value="selectedCategories">
		      			<option value="<ww:property value='top.id'/>" selected="1"><ww:property value="top.name"/></option>
		      		</ww:iterator>
		      		<option value="">-------------------</option>
		      		<ww:iterator value="remainingCategories">
		      			<option value="<ww:property value='top.id'/>"><ww:property value="top.name"/></option>
		      		</ww:iterator>		      		
	      		</select>
	       	</p>
	       	<p>  		
      			<span class="label">Deltagare (Håll ner Ctrl för att välja flera):</span><span class="alert"><ww:property value="principalsErrorMessage"/></span><br>
	      		<select name="participantUserName" multiple="true" class="listBox">
	      			<ww:iterator value="participatingPrincipals">
		      			<option value="<ww:property value='top.name'/>" selected="1"><ww:property value="top.firstName"/> <ww:property value="top.lastName"/></option>
		      		</ww:iterator>
		      		<option value="">-------------------</option>
		      		<ww:iterator value="infogluePrincipals">
		      			<option value="<ww:property value='top.name'/>"><ww:property value="top.firstName"/> <ww:property value="top.lastName"/></option>
		      		</ww:iterator>
	      		</select>
      		</p>
			<p>
				<span class="label">Attached files:</span><br>
				<ww:iterator value="event.resources">
					<a href="<ww:property value='this.getResourceUrl(top.id)'/>"><ww:property value='assetKey'/></a><br>     			
	      		</ww:iterator>
	      		<a href="javascript:showUploadForm();">Add resource</a>
			</p>
			<p>
				<br>
				<ww:set name="eventId" value="eventId" scope="page"/>
				<portlet:renderURL var="createEntryRenderURL">
					<portlet:param name="action" value="CreateEntry!input"/>
					<portlet:param name="eventId" value="<%= pageContext.getAttribute("eventId").toString() %>"/>
				</portlet:renderURL>
				<a href="<c:out value="${createEntryRenderURL}"/>">Sign up for this event</a>
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
