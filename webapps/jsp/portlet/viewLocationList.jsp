<%@ include file="adminHeader.jsp" %>

		<h2><ww:property value="this.getLabel('labels.internal.location.subHeader')"/></h2>

		<ww:iterator value="locations" status="rowstatus">
		
			<ww:set name="locationId" value="id" scope="page"/>
			<portlet:renderURL var="locationUrl">
				<portlet:param name="action" value="ViewLocation"/>
				<portlet:param name="locationId" value="<%= pageContext.getAttribute("locationId").toString() %>"/>
			</portlet:renderURL>
			
			<portlet:actionURL var="deleteLocationUrl">
				<portlet:param name="action" value="DeleteLocation"/>
				<portlet:param name="locationId" value="<%= pageContext.getAttribute("locationId").toString() %>"/>
			</portlet:actionURL>
			
		<p class="nobreak">
			<ww:if test="#rowstatus.odd == true">
		    	<span class="marked"><ww:property value="id"/>. <a href="<c:out value="${locationUrl}"/>"><ww:property value="name"/></a> 
		    	<a href="<c:out value="${locationUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a>
		    	<a href="<c:out value="${deleteLocationUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a></span>
		    </ww:if>
		    <ww:else>
		    	<span><ww:property value="id"/>. <a href="<c:out value="${locationUrl}"/>"><ww:property value="name"/></a> 
		    	<a href="<c:out value="${locationUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a>
		    	<a href="<c:out value="${deleteLocationUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a></span>
		    </ww:else>
		</p>
		</ww:iterator>

		<portlet:renderURL var="createLocationUrl">
			<portlet:param name="action" value="CreateLocation!input"/>
		</portlet:renderURL>
		
		<a href="<c:out value="${createLocationUrl}"/>"><ww:property value="this.getLabel('labels.internal.location.addLocation')"/></a>

<%@ include file="adminFooter.jsp" %>
