<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Categories" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.category.subHeader')"/></div>

<%@ include file="functionMenu.jsp" %>

<portlet:renderURL var="createCategoryUrl">
	<portlet:param name="action" value="CreateCategory!input"/>
</portlet:renderURL>

<div class="subfunctionarea">
	<a href="<c:out value="${createCategoryUrl}"/>" title="Skapa ny post"><ww:property value="this.getLabel('labels.internal.category.addCategory')"/></a>
</div>

<div class="columnlabelarea">
	<div class="columnLong"><p><ww:property value="this.getLabel('labels.internal.category.name')"/></p></div>
	<div class="columnMedium"><p><ww:property value="this.getLabel('labels.internal.category.description')"/></p></div>
	<div class="clear"></div>
</div>

<ww:iterator value="categories" status="rowstatus">

	<ww:set name="categoryId" value="id" scope="page"/>
	<portlet:renderURL var="categoryUrl">
		<portlet:param name="action" value="ViewCategory"/>
		<portlet:param name="categoryId" value="<%= pageContext.getAttribute("categoryId").toString() %>"/>
	</portlet:renderURL>
	
	<portlet:actionURL var="deleteCategoryUrl">
		<portlet:param name="action" value="DeleteCategory"/>
		<portlet:param name="deleteCategoryId" value="<%= pageContext.getAttribute("categoryId").toString() %>"/>
	</portlet:actionURL>
	
	<ww:if test="#rowstatus.odd == true">
    	<div class="oddrow">
    </ww:if>
    <ww:else>
		<div class="evenrow">
    </ww:else>

       	<div class="columnLong">
       		<p class="portletHeadline"><a href="<c:out value="${categoryUrl}"/>" title="Visa Kategori"><ww:property value="name"/></a></p>
       	</div>
       	<div class="columnMedium">
       		<p><ww:property value="description"/></p>
       	</div>
       	<div class="columnEnd">
       		<a href="<c:out value="${deleteCategoryUrl}"/>" title="Radera Kategori" class="delete"></a>
       	   	<a href="<c:out value="${categoryUrl}"/>" title="Redigera Kategori" class="edit"></a>
       	</div>
       	<div class="clear"></div>
    </div>
    
</ww:iterator>

<ww:if test="categories == null || categories.size() == 0">
	<div class="oddrow">
		<div class="columnLong"><p class="portletHeadline"><ww:property value="this.getLabel('labels.internal.applicationNoItemsFound')"/></a></p></div>
       	<div class="columnMedium"></div>
       	<div class="columnEnd"></div>
       	<div class="clear"></div>
    </div>
</ww:if>

<%@ include file="adminFooter.jsp" %>
