<%@ include file="adminHeader.jsp" %>
	
	<div id="contentListHeader">
		<ww:property value="this.getLabel('labels.internal.eventType.createNewEventType')"/>
	</div>

	<div id="contentList">
		<portlet:actionURL var="createEventTypeActionUrl">
			<portlet:param name="action" value="CreateEventType"/>
		</portlet:actionURL>
		
		<form name="inputForm" method="POST" action="<c:out value="${createEventTypeActionUrl}"/>">
		<p>
			<calendar:textField label="labels.internal.eventType.name" name="name" value="eventType.name" cssClass="normalInput"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.eventType.description" name="description" value="eventType.description" cssClass="normalInput"/>
		</p>
		<p>
			<input type="submit" value="<ww:property value="this.getLabel('labels.internal.eventType.createButton')"/>" class="calendarButton">
		</p>
		</form>
	</div>

<%@ include file="adminFooter.jsp" %>
