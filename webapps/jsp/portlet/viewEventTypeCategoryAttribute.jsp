<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="EventTypes" scope="page"/>

<%@ include file="adminHeader.jsp" %>
	
	<div id="contentListHeader">
		<ww:property value="this.getLabel('labels.internal.eventType.updateEventType')"/> <ww:property value="eventType.name"/>
	</div>

	<div id="contentList">
		<portlet:actionURL var="updateEventTypeCategoryAttributeActionUrl">
			<portlet:param name="action" value="UpdateEventTypeCategoryAttribute"/>
		</portlet:actionURL>
		
		<form name="inputForm" method="POST" action="<c:out value="${updateEventTypeCategoryAttributeActionUrl}"/>">
			<input type="hidden" name="eventTypeCategoryAttributeId" value="<ww:property value="eventTypeCategoryAttribute.id"/>">
			
			<p>
				<calendar:textField label="labels.internal.category.name" name="name" value="eventTypeCategoryAttribute.name" cssClass="normalInput"/>
			</p>
			<p>
				<input type="submit" value="<ww:property value="this.getLabel('labels.internal.eventType.updateButton')"/>" class="calendarButton">
			</p>
		</form>
	</div>

<%@ include file="adminFooter.jsp" %>