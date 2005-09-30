<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Event" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<ww:set name="event" value="event" scope="page"/>
<ww:set name="eventId" value="event.id" scope="page"/>
<ww:set name="calendarId" value="calendarId" scope="page"/>
<ww:set name="mode" value="mode" scope="page"/>

<div class="head"><ww:property value="event.name"/></div>

<%@ include file="functionMenu.jsp" %>

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
			
	<div class="portlet_margin">
	
		<p>
			<calendar:textValue label="labels.internal.event.name" value="event.name" labelCssClass="label"/>
		</p>
		<p>
			<span class="label"><ww:property value="this.getLabel('labels.internal.event.startDate')"/></span><br />
			<ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/> kl. <ww:property value="this.formatDate(event.startDateTime.time, 'HH')"/>
		</p>

		<p>
			<span class="label"><ww:property value="this.getLabel('labels.internal.event.endDate')"/></span><br />
			<ww:property value="this.formatDate(event.endDateTime.time, 'yyyy-MM-dd')"/> kl. <ww:property value="this.formatDate(event.endDateTime.time, 'HH')"/>
		</p>
		
		<p>
			<calendar:textValue label="labels.internal.event.shortDescription" value="event.shortDescription" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.longDescription" value="event.longDescription" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.isInternal" value="event.isInternal" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.isOrganizedByGU" value="event.isOrganizedByGU" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.organizerName" value="event.organizerName" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.lecturer" value="event.lecturer" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.customLocation" value="event.customLocation" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.eventUrl" value="event.eventUrl" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.contactName" value="event.contactName" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.contactEmail" value="event.contactEmail" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.contactPhone" value="event.contactPhone" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.price" value="event.price" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.internal.event.maximumParticipants" value="event.maximumParticipants" labelCssClass="label"/>
		</p>


		<p>
			<span class="label"><ww:property value="this.getLabel('labels.internal.event.lastRegistrationDate')"/></span><br />
			<ww:property value="this.formatDate(event.lastRegistrationDateTime.time, 'yyyy-MM-dd')"/> kl. <ww:property value="this.formatDate(event.lastRegistrationDateTime.time, 'HH')"/>
		</p>

		<!-- END NEW -->

  		<p>
  			<calendar:textValue label="labels.internal.event.location" value="event.locations" labelCssClass="label"/>
		</p>

		<ww:iterator value="event.calendar.eventType.categoryAttributes" status="rowstatus">
		<p>
			<ww:set name="categoryAttribute" value="top" scope="page"/>
			<ww:set name="categoryAttributeIndex" value="#rowstatus.index" scope="page"/>
			<ww:set name="selectedCategories" value="this.getEventCategories(top)"/>
			<c:set var="categoryAttributeName" value="categoryAttribute_${categoryAttribute.id}_categoryId"/>
			<ww:property value="#categoryAttribute"/>
			<input type="hidden" name="categoryAttributeId_<ww:property value="#rowstatus.index"/>" value="<ww:property value="top.id"/>"/>
			<calendar:textValue label="top.name" value="#selectedCategories" labelCssClass="label"/>
   		</p>
		</ww:iterator>
			
		<p>  		
  			<calendar:textValue label="labels.internal.event.participants" value="event.participants" labelCssClass="label"/>
		</p>
		
		<p>
			<span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.attachedFiles')"/></span><br>
			<ww:iterator value="event.resources">
			
				<ww:set name="resourceId" value="top.id" scope="page"/>
				<calendar:resourceUrl id="url" resourceId="${resourceId}"/>
				
				<portlet:actionURL var="deleteResourceUrl">
					<portlet:param name="action" value="DeleteResource"/>
					<portlet:param name="deleteResourceId" value="<%= pageContext.getAttribute("resourceId").toString() %>"/>
				</portlet:actionURL>
							
				<span class="calendarValue"><a href="<c:out value="${url}"/>"><ww:property value='assetKey'/></a></span>&nbsp;
				<a href="<c:out value="${deleteResourceUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a><br>     			
      		</ww:iterator>
      		
			<ww:if test="event.resources == null || event.resources.size() == 0">
			<tr>
				<td colspan="3"><span class="calendarValue	"><ww:property value="this.getLabel('labels.internal.event.noAttachments')"/></span></td>
			</tr>
			</ww:if>
		</p>
		<p>
			<ww:if test="event.stateId == 3">
				<ww:set name="eventId" value="eventId" scope="page"/>
				<portlet:renderURL var="createEntryRenderURL">
					<calendar:evalParam name="action" value="CreateEntry!input"/>
					<calendar:evalParam name="eventId" value="${eventId}"/>
					<calendar:evalParam name="calendarId" value="${calendarId}"/>
					<calendar:evalParam name="mode" value="${mode}"/>
				</portlet:renderURL>
	
	      		<a href="<c:out value="${createEntryRenderURL}"/>"><input type="button" value="<ww:property value="this.getLabel('labels.internal.event.signUpForThisEvent')"/>" class="calendarButton"></a>
			</ww:if>

			<portlet:renderURL var="editEventRenderURL">
				<calendar:evalParam name="action" value="ViewEvent!edit"/>
				<calendar:evalParam name="eventId" value="${eventId}"/>
				<calendar:evalParam name="calendarId" value="${calendarId}"/>
				<calendar:evalParam name="mode" value="${mode}"/>
			</portlet:renderURL>

			<portlet:renderURL var="uploadFormURL">
				<calendar:evalParam name="action" value="UpdateEvent!uploadForm"/>
				<calendar:evalParam name="eventId" value="${eventId}"/>
			</portlet:renderURL>

      		<a href="<c:out value="${uploadFormURL}"/>"><input type="button" value="<ww:property value="this.getLabel('labels.internal.event.attachFile')"/>" class="calendarButton"></a>
		
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

			<ww:if test="event.stateId == 3">
				<portlet:actionURL var="createEventAsCopyActionUrl">
					<calendar:evalParam name="action" value="CreateEvent!copy"/>
				</portlet:actionURL>
				<a href="javascript:createEventFromCopy('<c:out value="${createEventAsCopyActionUrl}"/>')"><input type="button" value="<ww:property value="this.getLabel('labels.internal.event.createNewEvent')"/>" class="calendarButton"/></a>
			</ww:if>
					
			<ww:if test="event.stateId == 3">
				<portlet:renderURL var="searchEntryActionUrl">
					<portlet:param name="action" value="ViewEntrySearch"/>
				</portlet:renderURL>
				<form name="searchForm" method="post" action="<c:out value="${searchEntryActionUrl}"/>">
					<input type="hidden" name="searchEventId" value="<c:out value="${eventId}"/>"/>
				</form>
				<a href="javascript:document.searchForm.submit();"><input type="button" value="<ww:property value="this.getLabel('labels.internal.event.entriesButton')"/>" class="calendarButton"></a>
			</ww:if>
			
		</p>
	</div>
	
	
</div>

<%@ include file="adminFooter.jsp" %>