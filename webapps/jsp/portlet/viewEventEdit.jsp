<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Event" scope="page"/>

<%@ include file="adminHeader.jsp" %>
<%@ include file="functionMenu.jsp" %>

<ww:set name="event" value="event" scope="page"/>
<ww:set name="eventId" value="event.id" scope="page"/>
<ww:set name="calendarId" value="calendarId" scope="page"/>
<ww:set name="mode" value="mode" scope="page"/>

<div class="portlet_margin">
	
	<%
	Object requestObject = request.getAttribute("javax.portlet.request");
	javax.portlet.PortletRequest renderRequestIG = (javax.portlet.PortletRequest)requestObject;
	String hostName = (String)renderRequestIG.getProperty("host");
	%>		

	<portlet:actionURL var="updateEventActionUrl">
		<portlet:param name="action" value="UpdateEvent"/>
	</portlet:actionURL>
	
	<ww:if test="eventCopy == true">
		<span style="color: red"><ww:property value="this.getLabel('labels.internal.event.createEventCopyMessage')"/></span>
	</ww:if>	
	
	<form name="updateForm" method="POST" action="<c:out value="${updateEventActionUrl}"/>">
		<input type="hidden" name="eventId" value="<ww:property value="event.id"/>"/>
		<input type="hidden" name="calendarId" value="<ww:property value="event.owningCalendar.id"/>"/>
		<input type="hidden" name="mode" value="<ww:property value="mode"/>"/>
		<input type="hidden" name="publishEventUrl" value="http://<%=hostName%><c:out value="${publishEventUrl}"/>"/>
					
		<calendar:textField label="labels.internal.event.name" name="'name'" value="event.name" cssClass="longtextfield"/>

		<calendar:selectField label="labels.internal.event.entryForm" name="'entryFormId'" multiple="false" value="entryFormEventTypes" selectedValue="event.entryFormId" headerItem="Choose entry form" cssClass="listBox"/>

		<div class="fieldrow">
			<label for="startDateTime"><ww:property value="this.getLabel('labels.internal.event.startDate')"/></label><span class="redstar">*</span>
			<ww:if test="#fieldErrors.startDateTime != null"><span class="errorMessage"><ww:property value="this.getLabel('#fieldErrors.startDateTime.get(0)')"/></span></ww:if><br />
			<input readonly="1" id="startDateTime" name="startDateTime" value="<ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/>" class="datefield" type="textfield">
			<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_startDateTime" style="border: 0px solid black; cursor: pointer;" title="Date selector">
			<input name="startTime" value="<ww:if test="this.formatDate(event.startDateTime.time, 'HH:mm') != '12:34'"><ww:property value="this.formatDate(event.startDateTime.time, 'HH:mm')"/></ww:if>" class="hourfield" type="textfield">	
		</div>

		<div class="fieldrow">
			<label for="endDateTime"><ww:property value="this.getLabel('labels.internal.event.endDate')"/></label><!--<span class="redstar">*</span>-->
			<ww:if test="#fieldErrors.endDateTime != null"><span class="errorMessage"><ww:property value="this.getLabel('#fieldErrors.endDateTime.get(0)')"/></span></ww:if><br />
			<input readonly="1" id="endDateTime" name="endDateTime" value="<ww:property value="this.formatDate(event.endDateTime.time, 'yyyy-MM-dd')"/>" class="datefield" type="textfield">
			<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_endDateTime" style="border: 0px solid black; cursor: pointer;" title="Date selector">
			<input name="endTime" value="<ww:if test="this.formatDate(event.endDateTime.time, 'HH:mm') != '13:34'"><ww:property value="this.formatDate(event.endDateTime.time, 'HH:mm')"/></ww:if>" class="hourfield" type="textfield">					
		</div>

		<calendar:textAreaField label="labels.internal.event.shortDescription" name="shortDescription" value="event.shortDescription" cssClass="smalltextarea" required="false"/>

		<calendar:textAreaField label="labels.internal.event.longDescription" name="longDescription" value="event.longDescription" cssClass="largetextarea" required="false"/>
		
		<ww:if test="this.isActiveEventField('lecturer')">
			<calendar:textAreaField label="labels.internal.event.lecturer" name="lecturer" value="event.lecturer" cssClass="smalltextarea"/>
		</ww:if>

		<ww:if test="this.isActiveEventField('organizerName')">
			<calendar:textField label="labels.internal.event.organizerName" name="'organizerName'" value="event.organizerName" cssClass="longtextfield" required="false"/>
		</ww:if>

		<ww:if test="this.isActiveEventField('isInternal')">
			<calendar:radioButtonField label="labels.internal.event.isInternal" name="isInternal" required="true" valueMap="internalEventMap" selectedValue="event.isInternal"/>
		</ww:if>
		
		<ww:if test="this.isActiveEventField('isOrganizedByGU')">
			<calendar:checkboxField label="labels.internal.event.isOrganizedByGU" name="isOrganizedByGU" valueMap="isOrganizedByGUMap" selectedValues="event.isOrganizedByGU"/>
		</ww:if>
	
		<ww:if test="this.isActiveEventField('eventUrl')">
			<calendar:textField label="labels.internal.event.eventUrl" name="'eventUrl'" value="event.eventUrl" cssClass="longtextfield"/>
		</ww:if>
		
		<ww:if test="this.isActiveEventField('locationId')">
			<calendar:selectField label="labels.internal.event.location" name="locationId" multiple="true" value="locations" selectedValueSet="event.locations" headerItem="Anger annan plats istället nedan" cssClass="listBox"/>
		</ww:if>

		<ww:if test="this.isActiveEventField('alternativeLocation')">
			<calendar:textField label="labels.internal.event.alternativeLocation" name="'alternativeLocation'" value="event.alternativeLocation" cssClass="longtextfield"/>
		</ww:if>
		
		<ww:if test="this.isActiveEventField('customLocation')">
			<calendar:textField label="labels.internal.event.customLocation" name="'customLocation'" value="event.customLocation" cssClass="longtextfield"/>
		</ww:if>
	
		<ww:if test="this.isActiveEventField('price')">
			<calendar:textField label="labels.internal.event.price" name="'price'" value="event.price" cssClass="longtextfield"/>
		</ww:if>
	
		<calendar:textField label="labels.internal.event.maximumParticipants" name="'maximumParticipants'" value="event.maximumParticipants" cssClass="longtextfield"/>
	
		<div class="fieldrow">
			<label for="lastRegistrationDateTime"><ww:property value="this.getLabel('labels.internal.event.lastRegistrationDate')"/></label><!--<span class="redstar">*</span>-->
			<ww:if test="#fieldErrors.lastRegistrationDateTime != null"><span class="errorMessage"><ww:property value="this.getLabel('#fieldErrors.lastRegistrationDateTime.get(0)')"/></span></ww:if><br />
			<input readonly="1" id="lastRegistrationDateTime" name="lastRegistrationDateTime" value="<ww:property value="this.formatDate(event.lastRegistrationDateTime.time, 'yyyy-MM-dd')"/>" class="datefield" type="textfield">
			<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_lastRegistrationDateTime" style="border: 0px solid black; cursor: pointer;" title="Date selector">
			<input name="lastRegistrationTime" value="<ww:property value="this.formatDate(event.lastRegistrationDateTime.time, 'HH:mm')"/>" class="hourfield" type="textfield">
		</div>
	
		<ww:if test="this.isActiveEventField('contactName')">
			<calendar:textField label="labels.internal.event.contactName" name="'contactName'" value="event.contactName" cssClass="longtextfield"/>
		</ww:if>
		<ww:if test="this.isActiveEventField('contactEmail')">
			<calendar:textField label="labels.internal.event.contactEmail" name="'contactEmail'" value="event.contactEmail" cssClass="longtextfield"/>
		</ww:if>
		<ww:if test="this.isActiveEventField('contactPhone')">
			<calendar:textField label="labels.internal.event.contactPhone" name="'contactPhone'" value="event.contactPhone" cssClass="longtextfield"/>
		</ww:if>

		<hr>

		<ww:set name="count" value="0"/>
		<ww:iterator value="attributes" status="rowstatus">
			<ww:set name="attribute" value="top"/>
			<ww:set name="title" value="top.getContentTypeAttribute('title').getContentTypeAttributeParameterValue().getLocalizedValueByLanguageCode('label', currentContentTypeEditorViewLanguageCode)" scope="page"/>
			<ww:set name="attributeName" value="this.concat('attribute_', top.name)"/>
			<ww:if test="#errorEvent != null">
				<ww:set name="attributeValue" value="this.getAttributeValue(#errorEvent.attributes, top.name)"/>
			</ww:if>
			<ww:else>
				<ww:set name="attributeValue" value="this.getAttributeValue(event.attributes, top.name)"/>
			</ww:else>
			
			<c:set var="required" value="false"/>
			<ww:iterator value="#attribute.validators" status="rowstatus">
				<ww:set name="validator" value="top"/>
				<ww:set name="validatorName" value="#validator.name"/>
				<ww:if test="#validatorName == 'required'">
					<c:set var="required" value="true"/>
				</ww:if>
			</ww:iterator>

			<input type="hidden" name="attributeName_<ww:property value="#count"/>" value="attribute_<ww:property value="top.name"/>"/>

			<ww:if test="#attribute.inputType == 'textfield'">
				<calendar:textField label="${title}" name="#attributeName" value="#attributeValue" required="${required}" cssClass="longtextfield"/>
			</ww:if>		

			<ww:if test="#attribute.inputType == 'textarea'">
				<calendar:textAreaField label="${title}" name="#attributeName" value="#attributeValue" required="${required}" cssClass="smalltextarea"/>
			</ww:if>		

			<ww:if test="#attribute.inputType == 'select'">
				<ww:set name="attributeValues" value="#attributeValue"/>
				<ww:if test="#attributeValue != null">
					<ww:set name="attributeValues" value="#attributeValue.split(',')"/>
				</ww:if>
				<calendar:selectField label="${title}" name="#attributeName" multiple="true" value="#attribute.contentTypeAttributeParameterValues" selectedValues="#attributeValues" required="${required}" cssClass="listBox"/>
			</ww:if>		

			<ww:if test="#attribute.inputType == 'radiobutton'">
				<calendar:radioButtonField label="${title}" name="#attributeName" valueMap="#attribute.contentTypeAttributeParameterValuesAsMap" selectedValue="#attributeValue" required="${required}"/>
			</ww:if>		

			<ww:if test="#attribute.inputType == 'checkbox'">
				<ww:set name="attributeValues" value="#attributeValue"/>
				<ww:if test="#attributeValue != null">
					<ww:set name="attributeValues" value="#attributeValue.split(',')"/>
				</ww:if>
				<calendar:checkboxField label="${title}" name="#attributeName" valueMap="#attribute.contentTypeAttributeParameterValuesAsMap" selectedValues="#attributeValues" required="${required}"/>
			</ww:if>		

			<ww:if test="#attribute.inputType == 'hidden'">
				<calendar:hiddenField name="#attributeName" value="#attributeValue"/>
			</ww:if>		
		
			<ww:set name="count" value="#count + 1"/>
		</ww:iterator>

		<hr>
			
		<ww:iterator value="event.owningCalendar.eventType.categoryAttributes" status="rowstatus">
			<ww:set name="categoryAttribute" value="top" scope="page"/>
			<ww:set name="categoryAttributeIndex" value="#rowstatus.index" scope="page"/>
			<ww:set name="selectedCategories" value="this.getEventCategories(top)"/>
			<c:set var="categoryAttributeName" value="categoryAttribute_${categoryAttribute.id}_categoryId"/>
			<input type="hidden" name="categoryAttributeId_<ww:property value="#rowstatus.index"/>" value="<ww:property value="top.id"/>"/>
			<calendar:selectField label="top.name" name="${categoryAttributeName}" multiple="true" value="top.category.children" selectedValues="getCategoryAttributeValues(top.id)" selectedValueList="#selectedCategories" cssClass="listBox" required="true"/>
   		</ww:iterator>

		<!--
		<calendar:selectField label="labels.internal.event.participants" name="participantUserName" multiple="true" value="infogluePrincipals" cssClass="listBox"/>
		-->
		
		<div style="height:10px"></div>
		
		<input type="submit" value="<ww:property value="this.getLabel('labels.internal.event.updateButton')"/>" class="button">
		
		<portlet:renderURL var="viewEventUrl">
			<portlet:param name="action" value="ViewEvent"/>
			<calendar:evalParam name="eventId" value="${eventId}"/>
			<calendar:evalParam name="calendarId" value="${calendarId}"/>
			<calendar:evalParam name="mode" value="${mode}"/>
		</portlet:renderURL>
	
	    <input onclick="document.location.href='<c:out value="${viewEventUrl}"/>';" type="submit" value="<ww:property value="this.getLabel('labels.internal.applicationCancel')"/>" class="button">

	</form>		

</div>

<script type="text/javascript">
    Calendar.setup({
        inputField     :    "startDateTime",     // id of the input field
        ifFormat       :    "%Y-%m-%d",      // format of the input field
        button         :    "trigger_startDateTime",  // trigger for the calendar (button ID)
        align          :    "Bl",           // alignment (defaults to "Bl")
        singleClick    :    true,
        firstDay  	   : 	1        
    });
</script>

<script type="text/javascript">
    Calendar.setup({
        inputField     :    "endDateTime",     // id of the input field
        ifFormat       :    "%Y-%m-%d",      // format of the input field
        button         :    "trigger_endDateTime",  // trigger for the calendar (button ID)
        align          :    "Bl",           // alignment (defaults to "Bl")
        singleClick    :    true,
        firstDay  	   : 	1    
    });
</script>

<script type="text/javascript">
    Calendar.setup({
        inputField     :    "lastRegistrationDateTime",     // id of the input field
        ifFormat       :    "%Y-%m-%d",      // format of the input field
        button         :    "trigger_lastRegistrationDateTime",  // trigger for the calendar (button ID)
        align          :    "Bl",           // alignment (defaults to "Bl")
        singleClick    :    true,
        firstDay  	   : 	1    
    });
</script>

<%@ include file="adminFooter.jsp" %>