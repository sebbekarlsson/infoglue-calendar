<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Calendars" scope="page"/>

<%@ include file="adminHeader.jsp" %>

		<h2><ww:property value="this.getLabel('labels.internal.calendar.subHeader')"/></h2>

		<ww:iterator value="calendars" status="rowstatus">
			
			<ww:set name="calendarId" value="id" scope="page"/>
			<portlet:renderURL var="calendarUrl">
				<portlet:param name="action" value="CreateEvent!input"/>
				<portlet:param name="calendarId" value="<%= pageContext.getAttribute("calendarId").toString() %>"/>
			</portlet:renderURL>

		<p class="nobreak">
			<ww:if test="#rowstatus.odd == true">
		    	<span class="marked"><ww:property value="id"/>. <a href="<c:out value="${calendarUrl}"/>"><ww:property value="name"/></a> 
		    	<a href="<c:out value="${calendarUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a>
		    </ww:if>
		    <ww:else>
		    	<span><ww:property value="id"/>. <a href="<c:out value="${calendarUrl}"/>"><ww:property value="name"/></a> 
		    	<a href="<c:out value="${calendarUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a>
		    </ww:else>
		</p>
		</ww:iterator>

<%@ include file="adminFooter.jsp" %>
