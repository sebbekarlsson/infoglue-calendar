<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Categories" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.category.createNewCategory')"/></div>

<%@ include file="functionMenu.jsp" %>

<div class="portlet_margin">
	<portlet:actionURL var="createCategoryActionUrl">
		<portlet:param name="action" value="CreateCategory"/>
	</portlet:actionURL>
	
	<form name="inputForm" method="POST" action="<c:out value="${createCategoryActionUrl}"/>">
		<input type="hidden" name="parentCategoryId" value="<ww:property value="parentCategoryId"/>"/>
	
		<calendar:textField label="labels.internal.category.name" name="name" value="category.name" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.category.description" name="description" value="category.description" cssClass="longtextfield"/>
		<div style="height:10px"></div>
		<input type="submit" value="<ww:property value="this.getLabel('labels.internal.category.createButton')"/>" class="button">
	</form>
</div>

<%@ include file="adminFooter.jsp" %>
