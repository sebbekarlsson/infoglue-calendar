<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="EventSearch" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.applicationTitle')"/><!--  - <ww:property value="this.getLabel('labels.internal.event.searchEvents')"/>--></div>

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
	<ww:set name="name" value="name" scope="page"/>
	<portlet:renderURL var="eventUrl">
		<portlet:param name="action" value="ViewEvent"/>
		<portlet:param name="eventId" value="<%= pageContext.getAttribute("eventId").toString() %>"/>
	</portlet:renderURL>
	
	<portlet:actionURL var="deleteUrl">
		<portlet:param name="action" value="DeleteEvent"/>
		<portlet:param name="eventId" value="<%= pageContext.getAttribute("eventId").toString() %>"/>
	</portlet:actionURL>
	
	<portlet:renderURL var="viewListUrl">
		<portlet:param name="action" value="ViewEventSearch"/>
		<c:if test="${searchEventId != null}">
			<portlet:param name="searchEventId" value="<%= pageContext.getAttribute("searchEventId").toString() %>"/>
		</c:if>
		<c:if test="${searchFirstName != null}">
			<portlet:param name="searchFirstName" value="<%= pageContext.getAttribute("searchFirstName").toString() %>"/>
		</c:if>
		<c:if test="${searchLastName != null}">
			<portlet:param name="searchLastName" value="<%= pageContext.getAttribute("searchLastName").toString() %>"/>
		</c:if>
		<c:if test="${searchEmail != null}">
			<portlet:param name="searchEmail" value="<%= pageContext.getAttribute("searchEmail").toString() %>"/>
		</c:if>
		
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
	   		<p class="portletHeadline"><a href="<c:out value="${eventUrl}"/>" title="Visa Evenemang"><ww:property value="name"/></a></p>
	   	</div>
	   	<div class="columnMedium">
	   		<p><ww:property value="description"/></p>
	   	</div>
	   	<div class="columnEnd">
	   		<a href="<c:out value="${confirmUrl}"/>" title="Radera Evenemang" class="delete"></a>
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