<%@ include file="adminHeader.jsp" %>

		<h2><ww:property value="this.getLabel('labels.internal.calendar.subHeader')"/></h2>

		<ww:iterator value="calendars" status="rowstatus">
			
			<ww:set name="calendarId" value="id" scope="page"/>
			<portlet:renderURL var="calendarUrl">
				<portlet:param name="action" value="ViewCalendar"/>
				<portlet:param name="calendarId" value="<%= pageContext.getAttribute("calendarId").toString() %>"/>
			</portlet:renderURL>

			<portlet:actionURL var="deleteCalendarUrl">
				<portlet:param name="action" value="DeleteCalendar"/>
				<portlet:param name="calendarId" value="<%= pageContext.getAttribute("calendarId").toString() %>"/>
			</portlet:actionURL>

		<p class="nobreak">
			<ww:if test="#rowstatus.odd == true">
		    	<span class="marked"><ww:property value="id"/>. <a href="<c:out value="${calendarUrl}"/>"><ww:property value="name"/></a> 
		    	<a href="<c:out value="${calendarUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a>
		    	<a href="<c:out value="${deleteCalendarUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a></span>
		    </ww:if>
		    <ww:else>
		    	<span><ww:property value="id"/>. <a href="<c:out value="${calendarUrl}"/>"><ww:property value="name"/></a> 
		    	<a href="<c:out value="${calendarUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a>
		    	<a href="<c:out value="${deleteCalendarUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a></span>
		    </ww:else>
		</p>
		</ww:iterator>

		<portlet:renderURL var="createCalendarUrl">
			<portlet:param name="action" value="CreateCalendar!input"/>
		</portlet:renderURL>
		
		<a href="<c:out value="${createCalendarUrl}"/>"><ww:property value="this.getLabel('labels.internal.calendar.addCalendar')"/></a>

<%@ include file="adminFooter.jsp" %>
