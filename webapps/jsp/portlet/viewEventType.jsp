<%@ include file="adminHeader.jsp" %>
	
	<div id="contentListHeader">
		<ww:property value="this.getLabel('labels.internal.eventType.updateEventType')"/> <ww:property value="eventType.name"/>
	</div>

	<div id="contentList">
		<portlet:actionURL var="updateEventTypeActionUrl">
			<portlet:param name="action" value="UpdateEventType"/>
		</portlet:actionURL>
		
		<form name="inputForm" method="POST" action="<c:out value="${updateEventTypeActionUrl}"/>">
			<input type="hidden" name="eventTypeId" value="<ww:property value="eventType.id"/>">
			
			<p>
				<calendar:textField label="labels.internal.category.name" name="name" value="eventType.name" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.category.description" name="description" value="eventType.description" cssClass="normalInput"/>
			</p>
			<p>
				<input type="submit" value="<ww:property value="this.getLabel('labels.internal.eventType.updateButton')"/>" class="calendarButton">
			</p>
		</form>
	</div>

	<div id="contentListHeader">
		<ww:property value="this.getLabel('labels.internal.eventType.AvailableCategories')"/>
	</div>

	<div id="contentList">
		<ww:iterator value="eventType.categoryAttributes" status="rowstatus">
			
			<ww:set name="attributeCategoryId" value="id" scope="page"/>
			<portlet:renderURL var="attributeCategoryUrl">
				<portlet:param name="action" value="ViewEventTypeCategoryAttribute"/>
				<portlet:param name="attributeCategoryId" value="<%= pageContext.getAttribute("attributeCategoryId").toString() %>"/>
			</portlet:renderURL>
			
			<portlet:actionURL var="deleteAttributeCategoryUrl">
				<portlet:param name="action" value="DeleteEventTypeAttributeCategory"/>
				<portlet:param name="attributeCategoryId" value="<%= pageContext.getAttribute("attributeCategoryId").toString() %>"/>
			</portlet:actionURL>
			
			<p class="nobreak">
				<ww:if test="#rowstatus.odd == true">
			    	<span class="marked"><ww:property value="id"/>. <a href="<c:out value="${attributeCategoryUrl}"/>"><ww:property value="name"/></a> 
			    	<a href="<c:out value="${attributeCategoryUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a>
			    	<a href="<c:out value="${deleteAttributeCategoryUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a></span>
			    </ww:if>
			    <ww:else>
			    	<span><ww:property value="id"/>. <a href="<c:out value="${attributeCategoryUrl}"/>"><ww:property value="name"/></a> 
			    	<a href="<c:out value="${attributeCategoryUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a>
			    	<a href="<c:out value="${deleteAttributeCategoryUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a></span>
			    </ww:else>
			</p>
		</ww:iterator>
		
		<portlet:renderURL var="createAttributeCategoryUrl">
			<portlet:param name="action" value="CreateEventTypeCategoryAttribute!input"/>
			<calendar:evalParam name="eventTypeId" value="${param.eventTypeId}"/>
		</portlet:renderURL>
		
		<a href="<c:out value="${createAttributeCategoryUrl}"/>"><ww:property value="this.getLabel('labels.internal.eventType.addAvailableCategory')"/></a>
				
	</div>

<%@ include file="adminFooter.jsp" %>