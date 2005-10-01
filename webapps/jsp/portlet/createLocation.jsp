<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Locations" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.location.createNewLocation')"/></div>

<%@ include file="functionMenu.jsp" %>

<div class="portlet_margin">
	<portlet:actionURL var="createLocationActionUrl">
		<portlet:param name="action" value="CreateLocation"/>
	</portlet:actionURL>
	
	<form name="inputForm" method="POST" action="<c:out value="${createLocationActionUrl}"/>">

		<calendar:textField label="labels.internal.location.name" name="name" value="location.name" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.location.description" name="description" value="location.description" cssClass="longtextfield"/>
	
		<div style="height:10px"></div>
	
		<input type="submit" value="<ww:property value="this.getLabel('labels.internal.location.createButton')"/>" class="button">
	</form>
</div>

<%@ include file="adminFooter.jsp" %>
