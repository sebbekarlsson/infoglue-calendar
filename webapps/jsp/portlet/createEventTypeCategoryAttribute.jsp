<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="EventTypes" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.applicationTitle')"/> - <ww:property value="this.getLabel('labels.internal.eventTypeCategoryAttribute.createNewEventTypeCategoryAttribute')"/></div>

<%@ include file="functionMenu.jsp" %>

<div class="portlet_margin">
	
	<portlet:actionURL var="createEventTypeCategoryAttributeActionUrl">
		<portlet:param name="action" value="CreateEventTypeCategoryAttribute"/>
	</portlet:actionURL>
	
	<form name="inputForm" method="POST" action="<c:out value="${createEventTypeCategoryAttributeActionUrl}"/>">
		<input type="hidden" name="eventTypeId" value="<ww:property value="eventTypeId"/>">

		<calendar:textField label="labels.internal.eventTypeCategoryAttribute.name" name="name" value="eventTypeCategoryAttribute.name" cssClass="longtextfield"/>
		<calendar:selectField label="labels.internal.eventTypeCategoryAttribute.BaseCategory" name="categoryId" multiple="false" value="categories" cssClass="listBox"/>
		<div style="height:10px"></div>
		<input type="submit" value="<ww:property value="this.getLabel('labels.internal.eventTypeCategoryAttribute.createButton')"/>" class="button">
	</form>
</div>

<%@ include file="adminFooter.jsp" %>
