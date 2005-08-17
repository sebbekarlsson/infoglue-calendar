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
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="calendar" prefix="calendar" %>

<portlet:defineObjects/>

<ww:set name="event" value="event" scope="page"/>
<ww:set name="eventId" value="event.id" scope="page"/>
<ww:set name="calendarId" value="calendarId" scope="page"/>
<ww:set name="mode" value="mode" scope="page"/>


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

	function createEventFromCopy(action)
	{
		document.updateForm.action = action;
		document.updateForm.submit();
	} 
</script>

<div id="inputDiv">
	
	<portlet:actionURL var="deleteEventUrl">
		<portlet:param name="action" value="DeleteEvent"/>
	</portlet:actionURL>

	<portlet:renderURL var="publishEventUrl">
		<portlet:param name="action" value="ViewEvent"/>
		<portlet:param name="eventId" value="{eventId}"/>
	</portlet:renderURL>

	<%
	Object requestObject = request.getAttribute("javax.portlet.request");
	javax.portlet.PortletRequest renderRequestIG = (javax.portlet.PortletRequest)requestObject;
	String hostName = (String)renderRequestIG.getProperty("host");
	%>		

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
		
		<form name="updateForm" method="POST" action="<c:out value="${updateEventActionUrl}"/>">
			<input type="hidden" name="eventId" value="<ww:property value="event.id"/>"/>
			<input type="hidden" name="calendarId" value="<ww:property value="event.calendar.id"/>"/>
			<input type="hidden" name="mode" value="<ww:property value="mode"/>"/>
			<input type="hidden" name="publishEventUrl" value="http://<%=hostName%><c:out value="${publishEventUrl}"/>"/>
						
			<p>
				<calendar:textField label="labels.internal.event.name" name="name" value="event.name" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.event.description" name="description" value="event.description" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.event.isInternal" name="isInternal" value="event.isInternal" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.event.isOrganizedByGU" name="isOrganizedByGU" value="event.isOrganizedByGU" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.event.organizerName" name="organizerName" value="event.organizerName" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.event.lecturer" name="lecturer" value="event.lecturer" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.event.customLocation" name="customLocation" value="event.customLocation" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.event.shortDescription" name="shortDescription" value="event.shortDescription" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.event.longDescription" name="longDescription" value="event.longDescription" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.event.eventUrl" name="eventUrl" value="event.eventUrl" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.event.contactName" name="contactName" value="event.contactName" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.event.contactEmail" name="contactEmail" value="event.contactEmail" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.event.contactPhone" name="contactPhone" value="event.contactPhone" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.event.price" name="price" value="event.price" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.event.maximumParticipants" name="maximumParticipants" value="event.maxumumParticipants" cssClass="normalInput"/>
			</p>

			<p>
				<table border="0" cellspacing="0">
				<tr>
					<td><span class="label"><ww:property value="this.getLabel('labels.internal.event.startDate')"/></span></td> 
					<td><span class="label"><ww:property value="this.getLabel('labels.internal.event.startTime')"/></span></td> 
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
					<td><span class="label"><ww:property value="this.getLabel('labels.internal.event.endDate')"/></span></td> 
					<td><span class="label"><ww:property value="this.getLabel('labels.internal.event.endTime')"/></span></td> 
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
				<table border="0">
				<tr>
					<td><span class="label"><ww:property value="this.getLabel('labels.internal.event.lastRegistrationDate')"/></span></td> 
					<td><span class="label"><ww:property value="this.getLabel('labels.internal.event.lastRegistrationTime')"/></span></td> 
				</tr>
				<tr>
					<td width="20%" nowrap>
						<input type="textfield" id="lastRegistrationDateTime" name="lastRegistrationDateTime" value="<ww:property value="this.formatDate(event.lastRegistrationDateTime.time, 'yyyy-MM-dd')"/>" class="dateInput">
						<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_lastRegistrationDateTime" style="cursor: pointer; border: 0px solid black;" title="Date selector" />
					</td>				
					<td>
		      			<input type="textfield" name="lastRegistrationTime" value="<ww:property value="this.formatDate(event.lastRegistrationDateTime.time, 'HH')"/>" class="hourInput">
					</td>				
				</tr>
				</table>				
			</p>

			<!-- END NEW -->

      		<p>
      			<calendar:selectField label="labels.internal.event.location" name="locationId" multiple="true" value="locations" selectedValueSet="event.locations" cssClass="listBox"/>
			</p>
			<p>
      			<calendar:selectField label="labels.internal.event.category" name="categoryId" multiple="true" value="categories" selectedValueSet="event.categories" cssClass="listBox"/>
    		</p>
    		<p>  		
      			<calendar:selectField label="labels.internal.event.participants" name="participantUserName" multiple="true" value="infogluePrincipals" selectedValueSet="calendar.participants" cssClass="listBox"/>
			</p>
			
			<p>
				<span class="label"><ww:property value="this.getLabel('labels.internal.event.attachedFiles')"/></span><br>
				<ww:iterator value="event.resources">
				
					<ww:set name="resourceId" value="top.id" scope="page"/>
					<calendar:resourceUrl id="url" resourceId="${resourceId}"/>
			
					<portlet:actionURL var="deleteResourceUrl">
						<calendar:evalParam name="action" value="DeleteResource"/>
						<calendar:evalParam name="resourceId" value="${resourceId}"/>
						<calendar:evalParam name="eventId" value="${eventId}"/>
						<calendar:evalParam name="calendarId" value="${calendarId}"/>
						<calendar:evalParam name="mode" value="${mode}"/>
					</portlet:actionURL>
						
					<a href="<c:out value="${url}"/>"><ww:property value='assetKey'/></a>&nbsp;<a href="<c:out value="${deleteResourceUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a><br>     			
	      		</ww:iterator>
	      		<br/>
	      		<a href="javascript:showUploadForm();"><ww:property value="this.getLabel('labels.internal.event.attachFile')"/></a>
			</p>
			<p>
				<br>
				<ww:set name="eventId" value="eventId" scope="page"/>
				<portlet:renderURL var="createEntryRenderURL">
					<calendar:evalParam name="action" value="CreateEntry!input"/>
					<calendar:evalParam name="eventId" value="${eventId}"/>
					<calendar:evalParam name="calendarId" value="${calendarId}"/>
					<calendar:evalParam name="mode" value="${mode}"/>
				</portlet:renderURL>
				<a href="<c:out value="${createEntryRenderURL}"/>"><ww:property value="this.getLabel('labels.internal.event.signUpForThisEvent')"/></a>
			</p>
			<p>
				<input type="submit" value="Update">

				<ww:if test="event.isPublished == false">
					<portlet:actionURL var="publishEventActionUrl">
						<calendar:evalParam name="action" value="UpdateEvent!publishEvent"/>
						<calendar:evalParam name="eventId" value="${eventId}"/>
						<calendar:evalParam name="calendarId" value="${calendarId}"/>
						<calendar:evalParam name="mode" value="${mode}"/>
					</portlet:actionURL>
					<a href="<c:out value="${publishEventActionUrl}"/>"><input type="button" value="<ww:property value="this.getLabel('labels.internal.event.publishEvent')"/>"/></a>
				</ww:if>

				<portlet:actionURL var="createEventAsCopyActionUrl">
					<calendar:evalParam name="action" value="CreateEvent!copy"/>
				</portlet:actionURL>
				<a href="javascript:createEventFromCopy('<c:out value="${createEventAsCopyActionUrl}"/>')"><input type="button" value="<ww:property value="this.getLabel('labels.internal.event.createNewEvent')"/>"/></a>
			</p>
		</form>
	</div>
	
	<portlet:actionURL var="createResourceUploadActionUrl">
		<portlet:param name="action" value="CreateResource"/>
	</portlet:actionURL>
	
	<div id="upload" style="display: none;">
		
		<form enctype="multipart/form-data" name="inputForm" method="POST" action="<c:out value="${createResourceUploadActionUrl}"/>">
			<input type="hidden" name="eventId" value="<ww:property value="event.id"/>"/>
			<input type="hidden" name="calendarId" value="<ww:property value="calendarId"/>"/>
			<input type="hidden" name="mode" value="<ww:property value="mode"/>"/>
			<input type="hidden" name="startDateTime" value="<ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/>"/>
			<input type="hidden" name="endDateTime" value="<ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/>"/>
			
			<p>
				<ww:property value="this.getLabel('labels.internal.event.assetKey')"/><br>
				<select name="assetKey" class="normalInput">
					<ww:iterator value="assetKeys">
		      			<option value="<ww:property value='top'/>"><ww:property value="top"/></option>
		      		</ww:iterator>
				</select>
			</p>
			<p>
				<ww:property value="this.getLabel('labels.internal.event.fileToAttach')"/><br>
				<input type="file" name="file" id="file"/>
			</p>
			<p>
				<input type="submit" value="<ww:property value="this.getLabel('labels.internal.event.updateButton')"/>">
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

<script type="text/javascript">
    Calendar.setup({
        inputField     :    "lastRegistrationDateTime",     // id of the input field
        ifFormat       :    "%Y-%m-%d",      // format of the input field
        button         :    "trigger_lastRegistrationDateTime",  // trigger for the calendar (button ID)
        align          :    "Tl",           // alignment (defaults to "Bl")
        singleClick    :    true
    });
</script>
