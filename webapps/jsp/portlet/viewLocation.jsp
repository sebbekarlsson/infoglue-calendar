<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Locations" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.location.updateLocation')"/> <ww:property value="location.name"/></div>

<%@ include file="functionMenu.jsp" %>

<div>
	<portlet:actionURL var="updateLocationActionUrl">
		<portlet:param name="action" value="UpdateLocation"/>
	</portlet:actionURL>
	
	<form name="inputForm" method="POST" action="<c:out value="${updateLocationActionUrl}"/>">
		<input type="hidden" name="locationId" value="<ww:property value="location.id"/>">
		
		<p>
			<calendar:textField label="labels.internal.category.name" name="name" value="location.name" cssClass="normalInput"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.category.description" name="description" value="location.description" cssClass="normalInput"/>
		</p>
		<p>
			<input type="submit" value="<ww:property value="this.getLabel('labels.internal.location.updateButton')"/>" class="calendarButton">
		</p>
	</form>
</div>

<%@ include file="adminFooter.jsp" %>