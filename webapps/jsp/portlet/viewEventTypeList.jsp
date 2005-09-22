<%@ include file="adminHeader.jsp" %>

		<h2><ww:property value="this.getLabel('labels.internal.eventType.subHeader')"/></h2>

		<ww:iterator value="eventTypes" status="rowstatus">
		
			<ww:set name="eventTypeId" value="id" scope="page"/>
			<portlet:renderURL var="eventTypeUrl">
				<portlet:param name="action" value="ViewEventType"/>
				<portlet:param name="eventTypeId" value="<%= pageContext.getAttribute("eventTypeId").toString() %>"/>
			</portlet:renderURL>
			
			<portlet:actionURL var="deleteEventTypeUrl">
				<portlet:param name="action" value="DeleteEventType"/>
				<portlet:param name="eventTypeId" value="<%= pageContext.getAttribute("eventTypeId").toString() %>"/>
			</portlet:actionURL>
			
		<p class="nobreak">
			<ww:if test="#rowstatus.odd == true">
		    	<span class="marked"><ww:property value="id"/>. <a href="<c:out value="${eventTypeUrl}"/>"><ww:property value="name"/></a> 
		    	<a href="<c:out value="${eventTypeUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a>
		    	<a href="<c:out value="${deleteEventTypeUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a></span>
		    </ww:if>
		    <ww:else>
		    	<span><ww:property value="id"/>. <a href="<c:out value="${eventTypeUrl}"/>"><ww:property value="name"/></a> 
		    	<a href="<c:out value="${eventTypeUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a>
		    	<a href="<c:out value="${deleteEventTypeUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a></span>
		    </ww:else>
		</p>
		</ww:iterator>

		<portlet:renderURL var="createEventTypeUrl">
			<portlet:param name="action" value="CreateEventType!input"/>
		</portlet:renderURL>
		
		<a href="<c:out value="${createEventTypeUrl}"/>"><ww:property value="this.getLabel('labels.internal.eventType.addEventType')"/></a>

<%@ include file="adminFooter.jsp" %>
