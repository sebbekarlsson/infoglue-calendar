<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Categories" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<ww:set name="category" value="category" scope="page"/>
<ww:if test="category.parent != null">
	<portlet:renderURL var="viewBackUrl">
		<portlet:param name="action" value="ViewCategory"/>
		<calendar:evalParam name="categoryId" value="${category.parent.id}"/>
	</portlet:renderURL>
</ww:if>
<ww:else>
	<portlet:renderURL var="viewBackUrl">
		<portlet:param name="action" value="ViewCategoryList"/>
	</portlet:renderURL>
</ww:else>

<div class="head"><ww:property value="this.getLabel('labels.internal.category.updateCategory')"/> <ww:property value="category.name"/> - <a href="<c:out value="${viewBackUrl}"/>">Back</a></div>

<%@ include file="functionMenu.jsp" %>

<div>
	<portlet:actionURL var="updateCategoryActionUrl">
		<portlet:param name="action" value="UpdateCategory"/>
	</portlet:actionURL>
	
	<form name="inputForm" method="POST" action="<c:out value="${updateCategoryActionUrl}"/>">
		<input type="hidden" name="updateCategoryId" value="<ww:property value="category.id"/>">

		<p>
			<calendar:textField label="labels.internal.category.name" name="name" value="category.name" cssClass="normalInput"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.category.description" name="description" value="category.description" cssClass="normalInput"/>
		</p>
		<p>
			<input type="submit" value="<ww:property value="this.getLabel('labels.internal.category.updateButton')"/>" class="calendarButton">
		</p>
	</form>
</div>

<div id="contentListHeader">
	<ww:property value="this.getLabel('labels.internal.category.childCategories')"/>
</div>

<div id="contentList">
	<ww:iterator value="category.children" status="rowstatus">

		<ww:set name="categoryId" value="id" scope="page"/>
		<portlet:renderURL var="categoryUrl">
			<portlet:param name="action" value="ViewCategory"/>
			<portlet:param name="categoryId" value="<%= pageContext.getAttribute("categoryId").toString() %>"/>
		</portlet:renderURL>
		
		<portlet:actionURL var="deleteCategoryUrl">
			<portlet:param name="action" value="DeleteCategory"/>
			<portlet:param name="deleteCategoryId" value="<%= pageContext.getAttribute("categoryId").toString() %>"/>
		</portlet:actionURL>
		
		<p class="nobreak">
			<ww:if test="#rowstatus.odd == true">
		    	<span class="marked"><ww:property value="id"/>. <a href="<c:out value="${categoryUrl}"/>"><ww:property value="name"/></a> 
		    	<a href="<c:out value="${categoryUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a>
		    	<a href="<c:out value="${deleteCategoryUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a></span>
		    </ww:if>
		    <ww:else>
		    	<span><ww:property value="id"/>. <a href="<c:out value="${categoryUrl}"/>"><ww:property value="name"/></a> 
		    	<a href="<c:out value="${categoryUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a>
		    	<a href="<c:out value="${deleteCategoryUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a></span>
		    </ww:else>
		</p>
	</ww:iterator>
	
	<portlet:renderURL var="createCategoryUrl">
		<portlet:param name="action" value="CreateCategory!input"/>
		<calendar:evalParam name="parentCategoryId" value="${param.categoryId}"/>
	</portlet:renderURL>
	
	<a href="<c:out value="${createCategoryUrl}"/>"><ww:property value="this.getLabel('labels.internal.category.addCategory')"/></a>
	
	
</div>

<%@ include file="adminFooter.jsp" %>