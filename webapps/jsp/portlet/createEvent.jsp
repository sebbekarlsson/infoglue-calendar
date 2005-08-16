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

<div id="inputForm">
	
	<div id="contentListHeader">
		Create new event
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
				<calendar:textField label="Name:" name="name" value="event.name" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="Description:" name="description" value="event.description" cssClass="normalInput"/>
			</p>
			
			<p>
				<calendar:textField label="Internal:" name="isInternal" value="event.isInternal" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="Is organized by us:" name="isOrganizedByGU" value="event.isOrganizedByGU" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="Name of organizer:" name="organizerName" value="event.organizerName" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="Lecturer:" name="lecturer" value="event.lecturer" cssClass="normalInput"/>
			</p>

			<p>
				<calendar:textField label="Custom location:" name="customLocation" value="event.customLocation" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="Short description:" name="shortDescription" value="event.shortDescription" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="Long description:" name="longDescription" value="event.longDescription" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="Event URL:" name="eventUrl" value="event.eventUrl" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="Contact name:" name="contactName" value="event.contactName" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="Contact email:" name="contactEmail" value="event.contactEmail" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="Contact phone:" name="contactPhone" value="event.contactPhone" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="Price:" name="price" value="event.price" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="Contact name:" name="contactName" value="event.contactName" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="Maximum participants:" name="maxumumParticipants" value="event.maxumumParticipants" cssClass="normalInput"/>
			</p>

            <p>
				<table border="0" cellspacing="0">
				<tr>
					<td><span class="label">Startdatum:</span></td> 
					<td><span class="label">Starttid:</span></td> 
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
					<td><span class="label">Startdatum:</span></td> 
					<td><span class="label">Starttid:</span></td> 
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
					<td><span class="label">Sista anmälningsdatum:</span></td> 
					<td><span class="label">Tid:</span></td> 
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
      			<calendar:selectField label="Location (Hold shift to select multiple):" name="locationId" multiple="true" value="locations" cssClass="listBox"/>
			</p>
			<p>
	      		Category (Hold shift to select multiple): <span class="alert"><ww:property value="categoryErrorMessage"/></span><br>
	      		<select name="categoryId" multiple="true" class="listBox">
		      		<ww:iterator value="categories">
		      			<option value="<ww:property value='top.id'/>"><ww:property value="top.name"/></option>
		      		</ww:iterator>
	      		</select>
    		</p>
    		<p>  		
      			Participants (Hold shift to select multiple): <span class="alert"><ww:property value="participantsErrorMessage"/></span><br>
	      		<select name="participantUserName" multiple="true" class="listBox">
		      		<ww:iterator value="infogluePrincipals">
		      			<option value="<ww:property value='top.name'/>"><ww:property value="top.firstName"/> <ww:property value="top.lastName"/></option>
		      		</ww:iterator>
	      		</select>
			</p>
			<p>
				<input type="submit" value="Request publishing">
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