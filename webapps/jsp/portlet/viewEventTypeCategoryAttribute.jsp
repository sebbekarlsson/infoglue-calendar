<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="EventTypes" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.applicationTitle')"/> - <ww:property value="this.getLabel('labels.internal.eventTypeCategoryAttribute.updateEventTypeCategoryAttribute')"/> <ww:property value="eventType.name"/></div>

<%@ include file="functionMenu.jsp" %>

<div>
	<portlet:actionURL var="updateEventTypeCategoryAttributeActionUrl">
		<portlet:param name="action" value="UpdateEventTypeCategoryAttribute"/>
	</portlet:actionURL>
	
	<form name="inputForm" method="POST" action="<c:out value="${updateEventTypeCategoryAttributeActionUrl}"/>">
		<input type="hidden" name="eventTypeCategoryAttributeId" value="<ww:property value="eventTypeCategoryAttribute.id"/>">
		
		<p>
			<calendar:textField label="labels.internal.category.name" name="name" value="eventTypeCategoryAttribute.name" cssClass="longtextfield"/>
		</p>
		<p>
			<calendar:selectField label="labels.internal.eventTypeCategoryAttribute.BaseCategory" name="categoryId" multiple="false" value="categories" selectedValue="eventTypeCategoryAttribute.category.id" cssClass="listBox"/>
		</p>
		<p>
			<input type="submit" value="<ww:property value="this.getLabel('labels.internal.eventType.updateButton')"/>" class="button">
		</p>
	</form>
</div>

<%@ include file="adminFooter.jsp" %>