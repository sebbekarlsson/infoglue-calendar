<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Calendars" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.calendar.headline')"/> <ww:property value="location.name"/></div>

<%@ include file="functionMenu.jsp" %>

<div class="portlet_margin">

	<ww:set name="calendarId" value="calendar.id" scope="page"/>

	<portlet:actionURL var="updateCalendarActionUrl">
		<portlet:param name="action" value="UpdateCalendar"/>
	</portlet:actionURL>

	<portlet:renderURL var="viewCalendarUrl">
		<portlet:param name="action" value="ViewCalendar!gui"/>
		<portlet:param name="calendarId" value="<%= pageContext.getAttribute("calendarId").toString() %>"/>
		<portlet:param name="mode" value="day"/>
	</portlet:renderURL>
			
	<form name="inputForm" method="POST" action="<c:out value="${updateCalendarActionUrl}"/>">
		<input type="hidden" name="calendarId" value="<ww:property value="calendar.id"/>">
		
		<calendar:textField label="labels.internal.calendar.name" name="name" value="calendar.name" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.calendar.description" name="description" value="calendar.description" cssClass="longtextfield"/>
	    <calendar:selectField label="labels.internal.calendar.owner" name="owner" multiple="false" value="infogluePrincipals" selectedValue="calendar.owner" cssClass="listBox"/>
	    <calendar:selectField label="labels.internal.calendar.eventType" name="eventTypeId" multiple="false" value="eventTypes" selectedValue="calendar.eventType" cssClass="listBox"/>
		<div style="height:10px"></div>
		<input type="submit" value="<ww:property value="this.getLabel('labels.internal.calendar.updateButton')"/>" class="button">
		<input onclick="document.location.href='<c:out value="${viewCalendarUrl}"/>';" type="button" value="<ww:property value="this.getLabel('labels.internal.calendar.viewGUICalendarButton')"/>" class="button">
	</form>
</div>


<%@ include file="adminFooter.jsp" %>