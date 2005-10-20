<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Event" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<ww:set name="event" value="event" scope="page"/>
<ww:set name="eventId" value="event.id" scope="page"/>
<ww:set name="calendarId" value="calendarId" scope="page"/>

<div class="head"><ww:property value="this.getLabel('labels.internal.applicationTitle')"/><!--  - <ww:property value="event.name"/>--></div>

<%@ include file="functionMenu.jsp" %>

<div id="inputDiv">
	
	<ww:set name="eventId" value="event.id" scope="page"/>
	<ww:set name="name" value="event.name" scope="page"/>
	
	<portlet:actionURL var="deleteUrl">
		<portlet:param name="action" value="DeleteEvent"/>
		<calendar:evalParam name="eventId" value="${eventId}"/>
	</portlet:actionURL>

	<portlet:renderURL var="viewListUrl">
		<portlet:param name="action" value="ViewEvent"/>
		<calendar:evalParam name="eventId" value="${eventId}"/>
	</portlet:renderURL>

	<portlet:renderURL var="confirmUrl">
		<portlet:param name="action" value="Confirm"/>
		<%--
		<portlet:param name="confirmTitle" value="Radera - bekräfta"/>
		<calendar:evalParam name="confirmMessage" value="Är du säker på att du vill radera &quot;${name}&quot;"/>
		<portlet:param name="okUrl" value="<%= java.net.URLEncoder.encode(pageContext.getAttribute("deleteUrl").toString(), "utf-8") %>"/>
		<portlet:param name="cancelUrl" value="<%= java.net.URLEncoder.encode(pageContext.getAttribute("viewListUrl").toString(), "utf-8") %>"/>
		--%>
	</portlet:renderURL>

	<form name="deleteLinkForm" method="POST" action="<c:out value="${confirmUrl}"/>">
		<input type="hidden" name="confirmTitle" value="Radera - bekräfta"/>
		<input type="hidden" name="confirmMessage" value="Är du säker på att du vill radera &quot;<c:out value="${name}"/>&quot;"/>
		<input type="hidden" name="okUrl" value="<%= java.net.URLEncoder.encode(pageContext.getAttribute("deleteUrl").toString(), "utf-8") %>"/>
		<input type="hidden" name="cancelUrl" value="<%= java.net.URLEncoder.encode(pageContext.getAttribute("viewListUrl").toString(), "utf-8") %>"/>

		<input type="hidden" name="eventId" value="<ww:property value="event.id"/>"/>
		<input type="hidden" name="calendarId" value="<ww:property value="calendarId"/>"/>
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

		<ww:iterator value="event.owningCalendar.eventType.categoryAttributes" status="rowstatus">
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
			<span class="label"><ww:property value="this.getLabel('labels.internal.event.attachedFiles')"/></span><br>
			<ww:iterator value="event.resources">
			
				<ww:set name="resourceId" value="top.id" scope="page"/>
				<calendar:resourceUrl id="url" resourceId="${resourceId}"/>
				
				<portlet:actionURL var="deleteResourceUrl">
					<portlet:param name="action" value="DeleteResource"/>
					<portlet:param name="deleteResourceId" value="<%= pageContext.getAttribute("resourceId").toString() %>"/>
				</portlet:actionURL>
							
				<span class=""><a href="<c:out value="${url}"/>"><ww:property value='assetKey'/></a></span>&nbsp;
				<a href="<c:out value="${deleteResourceUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a><br/>
      		</ww:iterator>
      		
			<ww:if test="event.resources == null || event.resources.size() == 0">
				<span class="calendarValue"><ww:property value="this.getLabel('labels.internal.event.noAttachments')"/></span><br/>
			</ww:if>
		</p>

		<ww:set name="eventId" value="eventId" scope="page"/>
		<ww:if test="event.stateId == 3">
			<portlet:renderURL var="createEntryRenderURL">
				<calendar:evalParam name="action" value="CreateEntry!input"/>
				<calendar:evalParam name="eventId" value="${eventId}"/>
				<calendar:evalParam name="calendarId" value="${calendarId}"/>
			</portlet:renderURL>

      		<a href="<c:out value="${createEntryRenderURL}"/>"><input type="button" value="<ww:property value="this.getLabel('labels.internal.event.signUpForThisEvent')"/>" class="button"></a>
		</ww:if>

		<portlet:renderURL var="editEventRenderURL">
			<calendar:evalParam name="action" value="ViewEvent!edit"/>
			<calendar:evalParam name="eventId" value="${eventId}"/>
			<calendar:evalParam name="calendarId" value="${calendarId}"/>
		</portlet:renderURL>
		
		<portlet:renderURL var="uploadFormURL">
			<calendar:evalParam name="action" value="UpdateEvent!uploadForm"/>
			<calendar:evalParam name="eventId" value="${eventId}"/>
		</portlet:renderURL>

  		<input onclick="document.location.href='<c:out value="${uploadFormURL}"/>';" type="button" value="<ww:property value="this.getLabel('labels.internal.event.attachFile')"/>" class="button">
	
		<input onclick="document.location.href='<c:out value="${editEventRenderURL}"/>';" type="button" value="<ww:property value="this.getLabel('labels.internal.event.editButton')"/>" class="button">
		
		<input onclick="document.deleteLinkForm.submit();" type="button" value="<ww:property value="this.getLabel('labels.internal.event.deleteButton')"/>" class="button"></a>

		<%
		Object requestObject = request.getAttribute("javax.portlet.request");
		javax.portlet.PortletRequest renderRequestIG = (javax.portlet.PortletRequest)requestObject;
		String hostName = (String)renderRequestIG.getProperty("host");
		pageContext.setAttribute("hostName", hostName);
		%>		
		
		<ww:if test="event.stateId == 2">
			<portlet:renderURL var="publishedEventUrl">
				<portlet:param name="action" value="ViewEvent"/>
				<portlet:param name="eventId" value="{eventId}"/>
			</portlet:renderURL>
						
			<portlet:actionURL var="publishEventActionUrl">
				<calendar:evalParam name="action" value="UpdateEvent!publishEvent"/>
				<calendar:evalParam name="eventId" value="${eventId}"/>
				<calendar:evalParam name="calendarId" value="${calendarId}"/>
				<calendar:evalParam name="publishedEventUrl" value="http://${hostName}${publishedEventUrl}"/>
			</portlet:actionURL>
			<input onclick="document.location.href='<c:out value="${publishEventActionUrl}"/>';" type="button" value="<ww:property value="this.getLabel('labels.internal.event.publishEvent')"/>" class="button"/>
		</ww:if>

		<ww:if test="event.stateId == 0">
			<portlet:renderURL var="publishEventUrl">
				<portlet:param name="action" value="ViewEvent"/>
				<portlet:param name="eventId" value="{eventId}"/>
			</portlet:renderURL>
			
			<portlet:actionURL var="submitForPublishEventActionUrl">
				<calendar:evalParam name="action" value="UpdateEvent!submitForPublishEvent"/>
				<calendar:evalParam name="eventId" value="${eventId}"/>
				<calendar:evalParam name="calendarId" value="${calendarId}"/>
				<calendar:evalParam name="publishEventUrl" value="http://${hostName}${publishEventUrl}"/>
			</portlet:actionURL>
			<input onclick="document.location.href='<c:out value="${submitForPublishEventActionUrl}"/>';" type="button" value="<ww:property value="this.getLabel('labels.internal.event.submitForPublishEvent')"/>" class="button"/>
		</ww:if>

		<ww:if test="event.stateId == 3">
			<portlet:renderURL var="createEventAsCopyActionUrl">
				<calendar:evalParam name="action" value="ViewCalendarList!chooseCopyTarget"/>
				<calendar:evalParam name="eventId" value="${eventId}"/>
			</portlet:renderURL>
			<input onclick="document.location.href='<c:out value="${createEventAsCopyActionUrl}"/>';" type="button" value="<ww:property value="this.getLabel('labels.internal.event.createNewEvent')"/>" class="button"/>

			<portlet:renderURL var="linkEventActionUrl">
				<calendar:evalParam name="action" value="ViewCalendarList!chooseLinkTarget"/>
				<calendar:evalParam name="eventId" value="${eventId}"/>
			</portlet:renderURL>
			<input onclick="document.location.href='<c:out value="${linkEventActionUrl}"/>';" type="button" value="<ww:property value="this.getLabel('labels.internal.event.linkEvent')"/>" class="button"/>

		</ww:if>
				
		<ww:if test="event.stateId == 3">
			<portlet:renderURL var="searchEntryActionUrl">
				<portlet:param name="action" value="ViewEntrySearch"/>
				<calendar:evalParam name="searchEventId" value="${eventId}"/>
			</portlet:renderURL>
			
			<input onclick="document.location.href='<c:out value="${searchEntryActionUrl}"/>';" type="button" value="<ww:property value="this.getLabel('labels.internal.event.entriesButton')"/>" class="button">
		</ww:if>
	</div>
	
	
</div>

<%@ include file="adminFooter.jsp" %>