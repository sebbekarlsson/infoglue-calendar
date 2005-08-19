<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="calendar" prefix="calendar" %>

<portlet:defineObjects/>

	
<ww:iterator value="events" status="rowstatus">

	<ww:set name="eventId" value="id" scope="page"/>
	<portlet:renderURL var="eventDetailUrl">
		<portlet:param name="action" value="ViewEvent!publicGU"/>
		<portlet:param name="eventId" value="<%= pageContext.getAttribute("eventId").toString() %>"/>
	</portlet:renderURL>
		
	<div class="newspadding">
		<a href="<c:out value="${eventDetailUrl}"/>" class="Headline"><ww:property value="name"/></a><br />
		<span class="newsdate"><ww:property value="this.formatDate(top.startDateTime.getTime(), 'dd MMM')"/> kl <ww:property value="this.formatDate(top.startDateTime.getTime(), 'HH.mm')"/>
		<ww:if test="top.isInternal == true">
			[intern föreläsning]
		</ww:if>
		<ww:if test="top.isInternal != true">
			[öppen föreläsning]
		</ww:if>
		</span>
	</div>

</ww:iterator>
