<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Calendars" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.calendar.createNewCalendar')"/></div>

<%@ include file="functionMenu.jsp" %>

<div class="portlet_margin">

	<portlet:actionURL var="createCalendarActionUrl">
		<portlet:param name="action" value="CreateCalendar"/>
	</portlet:actionURL>
	
	<form name="inputForm" method="POST" action="<c:out value="${createCalendarActionUrl}"/>">

		<calendar:textField label="labels.internal.calendar.name" name="name" value="calendar.name" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.calendar.description" name="description" value="calendar.description" cssClass="longtextfield"/>
	    <calendar:selectField label="labels.internal.calendar.owner" name="owner" multiple="false" value="infogluePrincipals" cssClass="listBox"/>
	    <calendar:selectField label="labels.internal.calendar.eventType" name="eventTypeId" multiple="false" value="eventTypes" selectedValue="calendar.eventType" cssClass="listBox"/>
		<div style="height:10px"></div>
		<input type="submit" value="<ww:property value="this.getLabel('labels.internal.calendar.createButton')"/>" class="button">
	</form>
</div>

<%@ include file="adminFooter.jsp" %>
