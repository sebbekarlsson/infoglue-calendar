<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="EventSearch" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.applicationTitle')"/> - <ww:property value="this.getLabel('labels.internal.event.searchEvents')"/></div>

<%@ include file="functionMenu.jsp" %>

<div class="portlet_margin">
	<h1><ww:property value="this.getLabel('labels.internal.event.searchResult')"/></h1>
</div>

<div class="columnlabelarea">
	<div class="columnLong"><p><ww:property value="this.getLabel('labels.internal.event.name')"/></p></div>
	<div class="columnMedium"><p><ww:property value="this.getLabel('labels.internal.event.description')"/></p></div>
	<div class="clear"></div>
</div>

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
	
	<ww:if test="#rowstatus.odd == true">
    	<div class="oddrow">
    </ww:if>
    <ww:else>
		<div class="evenrow">
    </ww:else>

	   	<div class="columnLong">
	   		<p class="portletHeadline"><a href="<c:out value="${eventUrl}"/>" title="Visa Evenemang"><ww:property value="name"/></a></p>
	   	</div>
	   	<div class="columnMedium">
	   		<p><ww:property value="description"/></p>
	   	</div>
	   	<div class="columnEnd">
	   		<a href="<c:out value="${deleteEventUrl}"/>" title="Radera Evenemang" class="delete"></a>
	   	   	<a href="<c:out value="${eventUrl}"/>" title="Redigera Evenemang" class="edit"></a>
	   	</div>
	   	<div class="clear"></div>
	</div>
</ww:iterator>

<ww:if test="events == null || events.size() == 0">
	<div class="oddrow">
		<div class="columnLong"><p class="portletHeadline"><ww:property value="this.getLabel('labels.internal.applicationNoItemsFound')"/></a></p></div>
       	<div class="columnMedium"></div>
       	<div class="columnEnd"></div>
       	<div class="clear"></div>
    </div>
</ww:if>

<%@ include file="adminFooter.jsp" %>