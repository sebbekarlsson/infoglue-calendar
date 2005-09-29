<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Event" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<ww:set name="event" value="event" scope="page"/>
<ww:set name="eventId" value="event.id" scope="page"/>
<ww:set name="calendarId" value="calendarId" scope="page"/>
<ww:set name="mode" value="mode" scope="page"/>


<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendarPublic.css" />

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

	<portlet:renderURL var="viewCalendarUrl">
		<portlet:param name="action" value="ViewCalendar"/>
		<portlet:param name="calendarId" value="{event.calendarId}"/>
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
		 <ww:property value="event.name"/>
	</div>
	
	<div id="contentList" style="display: block;">
	
		<p>
			<calendar:textValue label="labels.internal.event.name" value="event.name" cssClass="textValue"/>
		</p>
		<!--
		<p>
			<calendar:textValue label="labels.internal.event.description" value="event.description" cssClass="textValue"/>
		</p>
		-->
		<p>
			<calendar:textValue label="labels.internal.event.isInternal" value="event.isInternal"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.isOrganizedByGU" value="event.isOrganizedByGU"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.organizerName" value="event.organizerName" cssClass="textValue"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.lecturer" value="event.lecturer" cssClass="textValue"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.customLocation" value="event.customLocation" cssClass="textValue"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.shortDescription" value="event.shortDescription" cssClass="textValue"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.longDescription" value="event.longDescription" cssClass="textValue"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.eventUrl" value="event.eventUrl" cssClass="textValue"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.contactName" value="event.contactName" cssClass="textValue"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.contactEmail" value="event.contactEmail" cssClass="textValue"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.contactPhone" value="event.contactPhone" cssClass="textValue"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.price" value="event.price" cssClass="textValue"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.maximumParticipants" value="event.maximumParticipants" cssClass="textValue"/>
		</p>

		<p>
			<table border="0" cellspacing="0">
			<tr>
				<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.startDate')"/></span></td> 
				<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.startTime')"/></span></td> 
			</tr>
			<tr>
				<td width="20%" nowrap>
					<ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/>
				</td>				
				<td>
					<ww:property value="this.formatDate(event.startDateTime.time, 'HH')"/>
				</td>				
			</tr>
			</table>
		</p>    
		<p>
			<table border="0">
			<tr>
				<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.endDate')"/></span></td> 
				<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.endTime')"/></span></td> 
			</tr>
			<tr>
				<td width="20%" nowrap>
					<ww:property value="this.formatDate(event.endDateTime.time, 'yyyy-MM-dd')"/>
				</td>				
				<td>
	      			<ww:property value="this.formatDate(event.endDateTime.time, 'HH')"/>
				</td>				
			</tr>
			</table>				
		</p>
		<p>
			<table border="0">
			<tr>
				<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.lastRegistrationDate')"/></span></td> 
				<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.lastRegistrationTime')"/></span></td> 
			</tr>
			<tr>
				<td width="20%" nowrap>
					<ww:property value="this.formatDate(event.lastRegistrationDateTime.time, 'yyyy-MM-dd')"/>
				</td>				
				<td>
	      			<ww:property value="this.formatDate(event.lastRegistrationDateTime.time, 'HH')"/>
				</td>				
			</tr>
			</table>				
		</p>

		<!-- END NEW -->

  		<p>
  			<calendar:textValue label="labels.internal.event.location" value="event.locations" cssClass="textValue"/>
		</p>

		<ww:iterator value="event.calendar.eventType.categoryAttributes" status="rowstatus">
		<p>
			<ww:set name="categoryAttribute" value="top" scope="page"/>
			<ww:set name="categoryAttributeIndex" value="#rowstatus.index" scope="page"/>
			<ww:set name="selectedCategories" value="this.getEventCategories(top)"/>
			<c:set var="categoryAttributeName" value="categoryAttribute_${categoryAttribute.id}_categoryId"/>
			<ww:property value="#categoryAttribute"/>
			<input type="hidden" name="categoryAttributeId_<ww:property value="#rowstatus.index"/>" value="<ww:property value="top.id"/>"/>
			<calendar:textValue label="top.name" value="#selectedCategories" cssClass="textValue"/>
   		</p>
		</ww:iterator>
			
		<p>  		
  			<calendar:textValue label="labels.internal.event.participants" value="event.participants" cssClass="textValue"/>
		</p>
		
		<p>
			<span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.attachedFiles')"/></span><br>
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
					
				<span class="calendarValue"><a href="<c:out value="${url}"/>"><ww:property value='assetKey'/></a></span>&nbsp;<a href="<c:out value="${deleteResourceUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a><br>     			
      		</ww:iterator>
      		<br/>
      		<span class="calendarValue"><a href="javascript:showUploadForm();"><ww:property value="this.getLabel('labels.internal.event.attachFile')"/></a></span>
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
			<span class="calendarValue"><a href="<c:out value="${createEntryRenderURL}"/>" class="calendarLink"><ww:property value="this.getLabel('labels.internal.event.signUpForThisEvent')"/></a></span>
		</p>
		<p>
			<portlet:renderURL var="editEventRenderURL">
				<calendar:evalParam name="action" value="ViewEvent!edit"/>
				<calendar:evalParam name="eventId" value="${eventId}"/>
				<calendar:evalParam name="calendarId" value="${calendarId}"/>
				<calendar:evalParam name="mode" value="${mode}"/>
			</portlet:renderURL>

			<a href="<c:out value="${editEventRenderURL}"/>"><input type="button" value="Edit" class="calendarButton"></a>
			
			<a href="javascript:document.deleteLinkForm.submit();"><input type="button" value="Delete" class="calendarButton"></a>

			<ww:if test="event.stateId == 2">
				<portlet:actionURL var="publishEventActionUrl">
					<calendar:evalParam name="action" value="UpdateEvent!publishEvent"/>
					<calendar:evalParam name="eventId" value="${eventId}"/>
					<calendar:evalParam name="calendarId" value="${calendarId}"/>
					<calendar:evalParam name="mode" value="${mode}"/>
				</portlet:actionURL>
				<a href="<c:out value="${publishEventActionUrl}"/>"><input type="button" value="<ww:property value="this.getLabel('labels.internal.event.publishEvent')"/>" class="calendarButton"/></a>
			</ww:if>

			<ww:if test="event.stateId == 0">
				<portlet:actionURL var="submitForPublishEventActionUrl">
					<calendar:evalParam name="action" value="UpdateEvent!submitForPublishEvent"/>
					<calendar:evalParam name="eventId" value="${eventId}"/>
					<calendar:evalParam name="calendarId" value="${calendarId}"/>
					<calendar:evalParam name="mode" value="${mode}"/>
				</portlet:actionURL>
				<a href="<c:out value="${submitForPublishEventActionUrl}"/>"><input type="button" value="<ww:property value="this.getLabel('labels.internal.event.submitForPublishEvent')"/>" class="calendarButton"/></a>
			</ww:if>

			<portlet:actionURL var="createEventAsCopyActionUrl">
				<calendar:evalParam name="action" value="CreateEvent!copy"/>
			</portlet:actionURL>
			<a href="javascript:createEventFromCopy('<c:out value="${createEventAsCopyActionUrl}"/>')"><input type="button" value="<ww:property value="this.getLabel('labels.internal.event.createNewEvent')"/>" class="calendarButton"/></a>
		
			<portlet:renderURL var="searchEntryActionUrl">
				<portlet:param name="action" value="ViewEntrySearch"/>
			</portlet:renderURL>
			<form name="searchForm" method="post" action="<c:out value="${searchEntryActionUrl}"/>">
				<input type="hidden" name="searchEventId" value="<c:out value="${eventId}"/>"/>
			</form>
			<a href="javascript:document.searchForm.submit();"><input type="button" value="<ww:property value="this.getLabel('labels.internal.event.entriesButton')"/>" class="calendarButton"></a>
		
		</p>
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
				<select name="assetKey" class="textValue">
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
				<input type="submit" value="<ww:property value="this.getLabel('labels.internal.event.updateButton')"/>" class="calendarButton">
			</p>
			</form>
	
	</div>
	
</div>

<%@ include file="adminFooter.jsp" %>