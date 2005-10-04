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

<div class="head"><ww:property value="this.getLabel('labels.internal.applicationTitle')"/> - <ww:property value="this.getLabel('labels.internal.category.updateCategory')"/> <ww:property value="category.name"/> - <a href="<c:out value="${viewBackUrl}"/>">Back</a></div>

<%@ include file="functionMenu.jsp" %>

<div class="portlet_margin">

	<portlet:actionURL var="updateCategoryActionUrl">
		<portlet:param name="action" value="UpdateCategory"/>
	</portlet:actionURL>
	
	<form name="inputForm" method="POST" action="<c:out value="${updateCategoryActionUrl}"/>">
		<input type="hidden" name="updateCategoryId" value="<ww:property value="category.id"/>">

		<calendar:textField label="labels.internal.category.name" name="name" value="category.name" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.category.description" name="description" value="category.description" cssClass="longtextfield"/>
		<div style="height:10px"></div>
		<input type="submit" value="<ww:property value="this.getLabel('labels.internal.category.updateButton')"/>" class="button">
	</form>
</div>


<portlet:renderURL var="createCategoryUrl">
	<portlet:param name="action" value="CreateCategory!input"/>
	<calendar:evalParam name="parentCategoryId" value="${param.categoryId}"/>
</portlet:renderURL>

<div class="subfunctionarea">
	<a href="<c:out value="${createCategoryUrl}"/>" title="Skapa ny post"><ww:property value="this.getLabel('labels.internal.category.addCategory')"/></a>
</div>

<div class="columnlabelarea">
	<div class="columnLong"><p><ww:property value="this.getLabel('labels.internal.category.childCategories')"/></p></div>
	<div class="columnMedium"><p><ww:property value="this.getLabel('labels.internal.category.description')"/></p></div>
	<div class="clear"></div>
</div>

<ww:iterator value="category.children" status="rowstatus">

	<ww:set name="categoryId" value="id" scope="page"/>
	<ww:set name="name" value="name" scope="page"/>
	<portlet:renderURL var="categoryUrl">
		<portlet:param name="action" value="ViewCategory"/>
		<portlet:param name="categoryId" value="<%= pageContext.getAttribute("categoryId").toString() %>"/>
	</portlet:renderURL>
	
	<portlet:actionURL var="deleteUrl">
		<portlet:param name="action" value="DeleteCategory"/>
		<portlet:param name="deleteCategoryId" value="<%= pageContext.getAttribute("categoryId").toString() %>"/>
	</portlet:actionURL>
	
	<portlet:renderURL var="viewListUrl">
		<portlet:param name="action" value="ViewCategory"/>
		<calendar:evalParam name="categoryId" value="${param.categoryId}"/>
	</portlet:renderURL>

	<portlet:renderURL var="confirmUrl">
		<portlet:param name="action" value="Confirm"/>
		<portlet:param name="confirmTitle" value="Radera - bekräfta"/>
		<calendar:evalParam name="confirmMessage" value="Är du säker på att du vill radera &quot;${name}&quot;"/>
		<portlet:param name="okUrl" value="<%= java.net.URLEncoder.encode(pageContext.getAttribute("deleteUrl").toString(), "utf-8") %>"/>
		<portlet:param name="cancelUrl" value="<%= java.net.URLEncoder.encode(pageContext.getAttribute("viewListUrl").toString(), "utf-8") %>"/>
	</portlet:renderURL>
	
	<ww:if test="#rowstatus.odd == true">
    	<div class="oddrow">
    </ww:if>
    <ww:else>
		<div class="evenrow">
    </ww:else>

       	<div class="columnLong">
       		<p class="portletHeadline"><a href="<c:out value="${categoryUrl}"/>" title="Visa kategori"><ww:property value="name"/></a></p>
       	</div>
       	<div class="columnMedium">
       		<p><ww:property value="description"/></p>
       	</div>
       	<div class="columnEnd">
       		<a href="<c:out value="${confirmUrl}"/>" title="Radera kategori" class="delete"></a>
       	   	<a href="<c:out value="${categoryUrl}"/>" title="Redigera kategori" class="edit"></a>
       	</div>
       	<div class="clear"></div>
    </div>
</ww:iterator>

<ww:if test="category.children == null || category.children.size() == 0">
	<div class="oddrow">
		<div class="columnLong"><p class="portletHeadline"><ww:property value="this.getLabel('labels.internal.applicationNoItemsFound')"/></a></p></div>
       	<div class="columnMedium"></div>
       	<div class="columnEnd"></div>
       	<div class="clear"></div>
    </div>
</ww:if>


<%@ include file="adminFooter.jsp" %>