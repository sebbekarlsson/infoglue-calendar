<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="EventTypes" scope="page"/>

<%@ include file="adminHeader.jsp" %>
<%@ include file="functionMenu.jsp" %>

<portlet:renderURL var="createEventTypeUrl">
	<portlet:param name="action" value="CreateEventType!input"/>
</portlet:renderURL>

<div class="subfunctionarea">
<span class="left"></span>	
<span class="right">
	<a href="<c:out value="${createEventTypeUrl}"/>" title="Skapa ny post"><ww:property value="this.getLabel('labels.internal.eventType.addEventType')"/></a>
</span>	
<div class="clear"></div>
</div>

<div class="columnlabelarea">
	<div class="columnLong"><p><ww:property value="this.getLabel('labels.internal.eventType.name')"/></p></div>
	<div class="columnMedium"><p><ww:property value="this.getLabel('labels.internal.eventType.description')"/></p></div>
	<div class="clear"></div>
</div>

<ww:iterator value="eventTypes" status="rowstatus">

	<ww:set name="eventTypeId" value="id" scope="page"/>
	<ww:set name="name" value="name" scope="page"/>
	
	<portlet:renderURL var="eventTypeUrl">
		<portlet:param name="action" value="ViewEventType"/>
		<portlet:param name="eventTypeId" value="<%= pageContext.getAttribute("eventTypeId").toString() %>"/>
	</portlet:renderURL>
	
	<portlet:actionURL var="deleteUrl">
		<portlet:param name="action" value="DeleteEventType"/>
		<portlet:param name="eventTypeId" value="<%= pageContext.getAttribute("eventTypeId").toString() %>"/>
	</portlet:actionURL>

	<portlet:renderURL var="viewListUrl">
		<portlet:param name="action" value="ViewEventTypeList"/>
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
       		<p class="portletHeadline"><a href="<c:out value="${eventTypeUrl}"/>" title="Redigera '<ww:property value="name"/>'"><ww:property value="name"/></a></p>
       	</div>
       	<div class="columnMedium">
       		<p><ww:property value="description"/></p>
       	</div>
       	<div class="columnEnd">
       		<a href="<c:out value="${confirmUrl}"/>" title="Radera '<ww:property value="name"/>'" class="delete"></a>
       	   	<a href="<c:out value="${eventTypeUrl}"/>" title="Redigera '<ww:property value="name"/>'" class="edit"></a>
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
