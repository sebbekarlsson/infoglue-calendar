<%@ include file="adminHeader.jsp" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendar.css" />
<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/applications/jscalendar/calendar-system.css" title="system" />


<div id="searchForm" class="marginalizedDiv">

	<span class="headline"><ww:property value="this.getLabel('labels.internal.event.searchResult')"/></span>

	<ww:iterator value="events" status="rowstatus">
	
		<ww:set name="eventId" value="id" scope="page"/>
		<portlet:renderURL var="eventUrl">
			<portlet:param name="action" value="ViewEvent"/>
			<portlet:param name="eventId" value="<%= pageContext.getAttribute("eventId").toString() %>"/>
		</portlet:renderURL>
		
		<portlet:actionURL var="deleteEventUrl">
			<portlet:param name="action" value="DeleteEvent"/>
			<portlet:param name="eventId" value="<%= pageContext.getAttribute("eventId").toString() %>"/>
		</portlet:actionURL>
		
	<p class="nobreak">
		<ww:if test="#rowstatus.odd == true">
	    	<span class="marked"><ww:property value="id"/>. <a href="<c:out value="${eventUrl}"/>"><ww:property value="name"/></a> 
	    	<a href="<c:out value="${eventUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a>
	    	<a href="<c:out value="${deleteEventUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a></span>
	    </ww:if>
	    <ww:else>
	    	<span><ww:property value="id"/>. <a href="<c:out value="${eventUrl}"/>"><ww:property value="name"/></a> 
	    	<a href="<c:out value="${eventUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a>
	    	<a href="<c:out value="${deleteEventUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a></span>
	    </ww:else>
	</p>
	</ww:iterator>

</div>

<%@ include file="adminFooter.jsp" %>