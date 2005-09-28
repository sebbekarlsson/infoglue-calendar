<%@ include file="adminHeader.jsp" %>

<ww:set name="event" value="event" scope="page"/>
<ww:set name="eventId" value="event.id" scope="page"/>
<ww:set name="calendarId" value="calendarId" scope="page"/>
<ww:set name="mode" value="mode" scope="page"/>


<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendarPublic.css" />

<div id="inputDiv">
	
	<%
	Object requestObject = request.getAttribute("javax.portlet.request");
	javax.portlet.PortletRequest renderRequestIG = (javax.portlet.PortletRequest)requestObject;
	String hostName = (String)renderRequestIG.getProperty("host");
	%>		

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
			<!--
			<p>
				<calendar:textField label="labels.internal.event.description" name="description" value="event.description" cssClass="normalInput"/>
			</p>
			-->
			<p>
				<calendar:checkboxField label="labels.internal.event.isInternal" name="isInternal" value="yesOrNo" selectedValue="event.isInternal"/>
			</p>
			<p>
				<calendar:checkboxField label="labels.internal.event.isOrganizedByGU" name="isOrganizedByGU" value="yesOrNo" selectedValue="event.isOrganizedByGU"/>
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
				<calendar:textAreaField label="labels.internal.event.shortDescription" name="shortDescription" value="event.shortDescription" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textAreaField label="labels.internal.event.longDescription" name="longDescription" value="event.longDescription" cssClass="normalInput"/>
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
				<calendar:textField label="labels.internal.event.maximumParticipants" name="maximumParticipants" value="event.maximumParticipants" cssClass="normalInput"/>
			</p>

			<p>
				<table border="0" cellspacing="0">
				<tr>
					<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.startDate')"/></span></td> 
					<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.startTime')"/></span></td> 
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
					<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.endDate')"/></span></td> 
					<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.endTime')"/></span></td> 
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
					<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.lastRegistrationDate')"/></span></td> 
					<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.lastRegistrationTime')"/></span></td> 
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

			<ww:iterator value="event.calendar.eventType.categoryAttributes" status="rowstatus">
			<p>
				<ww:set name="categoryAttribute" value="top" scope="page"/>
				<ww:set name="categoryAttributeIndex" value="#rowstatus.index" scope="page"/>
				<ww:set name="selectedCategories" value="this.getEventCategories(top)"/>
				<c:set var="categoryAttributeName" value="categoryAttribute_${categoryAttribute.id}_categoryId"/>
				<input type="hidden" name="categoryAttributeId_<ww:property value="#rowstatus.index"/>" value="<ww:property value="top.id"/>"/>
				<calendar:selectField label="top.name" name="${categoryAttributeName}" multiple="true" value="top.category.children" selectedValueList="#selectedCategories" cssClass="listBox"/>
   			</p>
			</ww:iterator>
			
    		<p>  		
      			<calendar:selectField label="labels.internal.event.participants" name="participantUserName" multiple="true" value="infogluePrincipals" selectedValueSet="calendar.participants" cssClass="listBox"/>
			</p>
			
			<p>
				<input type="submit" value="Update" class="calendarButton">
				
				<portlet:renderURL var="viewEventUrl">
					<portlet:param name="action" value="ViewEvent"/>
					<calendar:evalParam name="eventId" value="${eventId}"/>
					<calendar:evalParam name="calendarId" value="${calendarId}"/>
					<calendar:evalParam name="mode" value="${mode}"/>
				</portlet:renderURL>
			
			    <a href="<c:out value="${viewEventUrl}"/>"><input type="submit" value="Cancel" class="calendarButton"></a>
			    
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

<%@ include file="adminFooter.jsp" %>