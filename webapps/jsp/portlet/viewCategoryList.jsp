<%@ include file="adminHeader.jsp" %>

		<h2><ww:property value="this.getLabel('labels.internal.category.subHeader')"/></h2>

		<ww:iterator value="categories" status="rowstatus">
		
			<ww:set name="categoryId" value="id" scope="page"/>
			<portlet:renderURL var="categoryUrl">
				<portlet:param name="action" value="ViewCategory"/>
				<portlet:param name="categoryId" value="<%= pageContext.getAttribute("categoryId").toString() %>"/>
			</portlet:renderURL>
			
			<portlet:actionURL var="deleteCategoryUrl">
				<portlet:param name="action" value="DeleteCategory"/>
				<portlet:param name="categoryId" value="<%= pageContext.getAttribute("categoryId").toString() %>"/>
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
		</portlet:renderURL>
		
		<a href="<c:out value="${createCategoryUrl}"/>"><ww:property value="this.getLabel('labels.internal.category.addCategory')"/></a>

<%@ include file="adminFooter.jsp" %>
