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
<%@ taglib uri="calendar" prefix="calendar" %>

<portlet:defineObjects/>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendar.css" />
<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/applications/jscalendar/calendar-system.css" title="system" />

<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/calendar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/lang/calendar-en.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/calendar-setup.js"></script>

<div id="inputForm">
	
	<div id="contentListHeader">
		<ww:property value="this.getLabel('labels.internal.event.createNewEvent')"/>
	</div>

	<div id="contentList">

		<portlet:actionURL var="createEventUrl">
			<portlet:param name="action" value="CreateEvent"/>
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
		<form name="inputForm" method="POST" action="<c:out value="${createEventUrl}"/>">
			<input type="hidden" name="calendarId" value="<ww:property value="calendarId"/>"/>
			<input type="hidden" name="mode" value="<ww:property value="mode"/>"/>
			<input type="hidden" name="date" value="<ww:property value="date"/>"/>
			<input type="hidden" name="time" value="<ww:property value="time"/>"/>
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
      			<calendar:checkboxField label="labels.internal.event.isInternal" name="isInternal" multiple="false" size="1" value="yesOrNo" selectedValue="event.isInternal"/>
			</p>
			<p>
      			<calendar:checkboxField label="labels.internal.event.isOrganizedByGU" name="isOrganizedByGU" multiple="false" size="1" value="yesOrNo" selectedValue="event.isInternal"/>
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
				<calendar:textField label="labels.internal.event.maximumParticipants" name="maximumParticipants" value="event.maxumumParticipants" cssClass="normalInput"/>
			</p>

			<p>
				<span class="errorMessage"><ww:property value="#fieldErrors.startDateTime"/></span>
			</p>
            <p>
				<table border="0" cellspacing="0">
				<tr>
					<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.startDate')"/></span></td> 
					<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.startTime')"/></span></td> 
				</tr>
				<tr>
					<td width="20%" nowrap>
						<input type="textfield" id="startDateTime" name="startDateTime" value="<ww:property value="startDateTime"/>" class="dateInput">
						<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_startDateTime" style="cursor: pointer; border: 0px solid black;" title="Date selector" />
					</td>				
					<td>
						<input type="textfield" name="startTime" value="<ww:property value="time"/>" class="hourInput">					
					</td>				
				</tr>
				</table>				
			</p>    
			<p>
				<table border="0" cellspacing="0">
				<tr>
					<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.endDate')"/></span></td> 
					<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.endTime')"/></span></td> 
				</tr>
				<tr>
					<td width="20%" nowrap>
						<input type="textfield" id="endDateTime" name="endDateTime" value="<ww:property value="endDateTime"/>" class="dateInput">
						<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_endDateTime" style="cursor: pointer; border: 0px solid black;" title="Date selector" />
					</td>				
					<td>
						<input type="textfield" name="endTime" value="<ww:property value="time"/>" class="hourInput">
					</td>				
				</tr>
				</table>
			</p>
			<p>
				<table border="0" cellspacing="0">
				<tr>
					<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.lastRegistrationDate')"/></span></td> 
					<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.lastRegistrationTime')"/></span></td> 
				</tr>
				<tr>
					<td width="20%" nowrap>
						<input type="textfield" id="lastRegistrationDateTime" name="lastRegistrationDateTime" value="<ww:property value="lastRegistrationDateTime"/>" class="dateInput">
						<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_lastRegistrationDateTime" style="cursor: pointer; border: 0px solid black;" title="Date selector" />
					</td>				
					<td>
						<input type="textfield" name="lastRegistrationTime" value="<ww:property value="lastRegistrationTime"/>" class="hourInput">					
					</td>				
				</tr>
				</table>				
			</p>    
      		<p>
      			<calendar:selectField label="labels.internal.event.location" name="locationId" multiple="true" value="locations" cssClass="listBox"/>
			</p>
			<p>
      			<calendar:selectField label="labels.internal.event.category" name="categoryId" multiple="true" value="categories" cssClass="listBox"/>
    		</p>
    		<p>  		
      			<calendar:selectField label="labels.internal.event.participants" name="participantUserName" multiple="true" value="infogluePrincipals" cssClass="listBox"/>
			</p>
			<p>
				<input type="submit" value="<ww:property value="this.getLabel('labels.internal.event.createButton')"/>">
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