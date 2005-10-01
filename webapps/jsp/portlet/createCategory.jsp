<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Categories" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.category.createNewCategory')"/></div>

<%@ include file="functionMenu.jsp" %>

<div>
	<portlet:actionURL var="createCategoryActionUrl">
		<portlet:param name="action" value="CreateCategory"/>
	</portlet:actionURL>
	
	<form name="inputForm" method="POST" action="<c:out value="${createCategoryActionUrl}"/>">
		<input type="hidden" name="parentCategoryId" value="<ww:property value="parentCategoryId"/>"/>
	<p>
		<calendar:textField label="labels.internal.category.name" name="name" value="category.name" cssClass="longtextfield"/>
	</p>
	<p>
		<calendar:textField label="labels.internal.category.description" name="description" value="category.description" cssClass="longtextfield"/>
	</p>
	<p>
		<input type="submit" value="<ww:property value="this.getLabel('labels.internal.category.createButton')"/>" class="button">
	</p>
	</form>
</div>

<%@ include file="adminFooter.jsp" %>
