<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Events" scope="page"/>
<c:set var="activeEventSubNavItem" value="NewEvent" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.applicationTitle')"/><!--  - <ww:property value="this.getLabel('labels.internal.event.createNewEvent')"/>--></div>

<%@ include file="functionMenu.jsp" %>

<%@ include file="eventSubFunctionMenu.jsp" %>

<div class="portlet_margin">

	<portlet:actionURL var="createEventUrl">
		<portlet:param name="action" value="CreateEvent"/>
	</portlet:actionURL>

	<form name="inputForm" method="POST" action="<c:out value="${createEventUrl}"/>">
		<input type="hidden" name="calendarId" value="<ww:property value="calendarId"/>"/>
		<input type="hidden" name="mode" value="<ww:property value="mode"/>"/>
		<input type="hidden" name="date" value="<ww:property value="date"/>"/>
		<input type="hidden" name="time" value="<ww:property value="time"/>"/>
		
		<calendar:textField label="labels.internal.event.name" name="name" value="event.name" cssClass="longtextfield" mandatory="true"/>
		
		<div class="fieldrow">
			<label for="startDateTime"><ww:property value="this.getLabel('labels.internal.event.startDate')"/></label><span class="redstar">*</span>
			<ww:if test="#fieldErrors.startDateTime != null"><span class="errorMessage"><ww:property value="#fieldErrors.startDateTime.get(0)"/></span></ww:if><br />
			<input id="startDateTime" name="startDateTime" value="<ww:property value="startDateTime"/>" class="datefield" type="textfield">
			<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_startDateTime" style="border: 0px solid black; cursor: pointer;" title="Date selector">
			<input name="startTime" value="<ww:property value="startTime"/>" class="hourfield" type="textfield">					
		</div>

		<div class="fieldrow">
			<label for="endDateTime"><ww:property value="this.getLabel('labels.internal.event.endDate')"/></label><span class="redstar">*</span>
			<ww:if test="#fieldErrors.endDateTime != null"><span class="errorMessage"><ww:property value="#fieldErrors.endDateTime.get(0)"/></span></ww:if><br />
			<input id="endDateTime" name="endDateTime" value="<ww:property value="endDateTime"/>" class="datefield" type="textfield">
			<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_endDateTime" style="border: 0px solid black; cursor: pointer;" title="Date selector">
			<input name="endTime" value="<ww:property value="endTime"/>" class="hourfield" type="textfield">					
		</div>
					
		<calendar:textAreaField label="labels.internal.event.shortDescription" name="shortDescription" value="event.shortDescription" cssClass="smalltextarea" mandatory="true"/>
		
		<calendar:textAreaField label="labels.internal.event.longDescription" name="longDescription" value="event.longDescription" cssClass="largetextarea" mandatory="true"/>
		
		<calendar:textAreaField label="labels.internal.event.lecturer" name="lecturer" value="event.lecturer" cssClass="smalltextarea"/>
		
		<calendar:textField label="labels.internal.event.organizerName" name="organizerName" value="event.organizerName" cssClass="longtextfield" mandatory="true"/>
		
		<calendar:radioButtonField label="labels.internal.event.isInternal" name="isInternal" mandatory="true" valueMap="internalEventMap" selectedValue="isInternal"/>
	
		<calendar:checkboxField label="labels.internal.event.isOrganizedByGU" name="isOrganizedByGU" valueMap="isOrganizedByGUMap" selectedValues="isOrganizedByGU"/>
		
		<calendar:textField label="labels.internal.event.eventUrl" name="eventUrl" value="event.eventUrl" cssClass="longtextfield"/>

		<calendar:selectField label="labels.internal.event.location" name="locationId" multiple="true" value="locations" cssClass="listBox"/>
	
		<calendar:textField label="labels.internal.event.customLocation" name="customLocation" value="event.customLocation" cssClass="longtextfield"/>
	
		<calendar:textField label="labels.internal.event.price" name="price" value="event.price" cssClass="longtextfield"/>
	
		<calendar:textField label="labels.internal.event.maximumParticipants" name="maximumParticipants" value="event.maximumParticipants" cssClass="longtextfield"/>
	

		<div class="fieldrow">
			<label for="lastRegistrationDateTime"><ww:property value="this.getLabel('labels.internal.event.lastRegistrationDate')"/></label><span class="redstar">*</span>
			<ww:if test="#fieldErrors.lastRegistrationDateTime != null"><span class="errorMessage"><ww:property value="#fieldErrors.lastRegistrationDateTime.get(0)"/></span></ww:if><br />
			<input id="lastRegistrationDateTime" name="lastRegistrationDateTime" value="<ww:property value="lastRegistrationDateTime"/>" class="datefield" type="textfield">
			<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_lastRegistrationDateTime" style="border: 0px solid black; cursor: pointer;" title="Date selector">
			<input name="lastRegistrationTime" value="<ww:property value="lastRegistrationTime"/>" class="hourfield" type="textfield">
		</div>
	
		<calendar:textField label="labels.internal.event.contactName" name="contactName" value="event.contactName" cssClass="longtextfield"/>

		<calendar:textField label="labels.internal.event.contactEmail" name="contactEmail" value="event.contactEmail" cssClass="longtextfield"/>

		<calendar:textField label="labels.internal.event.contactPhone" name="contactPhone" value="event.contactPhone" cssClass="longtextfield"/>

		<hr>
			
		<ww:iterator value="calendar.eventType.categoryAttributes" status="rowstatus">
			<ww:set name="categoryAttribute" value="top" scope="page"/>
			<ww:set name="categoryAttributeIndex" value="#rowstatus.index" scope="page"/>
			<input type="hidden" name="categoryAttributeId_<ww:property value="#rowstatus.index"/>" value="<ww:property value="top.id"/>"/>
			<c:set var="categoryAttributeName" value="categoryAttribute_${categoryAttribute.id}_categoryId"/>
			<calendar:selectField label="top.name" name="${categoryAttributeName}" multiple="true" value="top.category.children" cssClass="listBox" mandatory="true"/>
		</ww:iterator>

		<!--
		<calendar:selectField label="labels.internal.event.participants" name="participantUserName" multiple="true" value="infogluePrincipals" cssClass="listBox"/>
		-->
		
		<div style="height:10px"></div>
			
		<input type="submit" value="<ww:property value="this.getLabel('labels.internal.event.createButton')"/>" class="button">
		<input type="button" onclick="history.back();" value="<ww:property value="this.getLabel('labels.internal.applicationCancel')"/>" class="button">
	</form>
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

<%@ include file="adminFooter.jsp" %>