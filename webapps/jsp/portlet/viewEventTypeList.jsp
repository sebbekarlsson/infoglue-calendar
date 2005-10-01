<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="EventTypes" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.eventType.subHeader')"/></div>

<%@ include file="functionMenu.jsp" %>

<portlet:renderURL var="createEventTypeUrl">
	<portlet:param name="action" value="CreateEventType!input"/>
</portlet:renderURL>

<div class="subfunctionarea">
	<a href="<c:out value="${createEventTypeUrl}"/>" title="Skapa ny post"><ww:property value="this.getLabel('labels.internal.eventType.addEventType')"/></a>
</div>

<div class="columnlabelarea">
	<div class="columnLong"><p><ww:property value="this.getLabel('labels.internal.eventType.name')"/></p></div>
	<div class="columnMedium"><p><ww:property value="this.getLabel('labels.internal.eventType.description')"/></p></div>
	<div class="clear"></div>
</div>

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

	<ww:if test="#rowstatus.odd == true">
    	<div class="oddrow">
    </ww:if>
    <ww:else>
		<div class="evenrow">
    </ww:else>

       	<div class="columnLong">
       		<p class="portletHeadline"><a href="<c:out value="${eventTypeUrl}"/>" title="Visa Eventtyp"><ww:property value="name"/></a></p>
       	</div>
       	<div class="columnMedium">
       		<p><ww:property value="description"/></p>
       	</div>
       	<div class="columnEnd">
       		<a href="<c:out value="${deleteEventTypeUrl}"/>" title="Radera Eventtyp" class="delete"></a>
       	   	<a href="<c:out value="${eventTypeUrl}"/>" title="Redigera Eventtyp" class="edit"></a>
       	</div>
       	<div class="clear"></div>
    </div>

</ww:iterator>

<ww:if test="eventTypes == null || eventTypes.size() == 0">
	<div class="oddrow">
		<div class="columnLong"><p class="portletHeadline"><ww:property value="this.getLabel('labels.internal.applicationNoItemsFound')"/></a></p></div>
       	<div class="columnMedium"></div>
       	<div class="columnEnd"></div>
       	<div class="clear"></div>
    </div>
</ww:if>

<%@ include file="adminFooter.jsp" %>
