<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Calendars" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.applicationTitle')"/><!--  - <ww:property value="this.getLabel('labels.internal.location.subHeader')"/>--></div>

<%@ include file="functionMenu.jsp" %>

<portlet:renderURL var="createCalendarUrl">
	<portlet:param name="action" value="CreateCalendar!input"/>
</portlet:renderURL>

<div class="subfunctionarea">
<span class="left"></span>	
<span class="right">
	<a href="<c:out value="${createCalendarUrl}"/>" title="Skapa ny post"><ww:property value="this.getLabel('labels.internal.calendar.addCalendar')"/></a>
</span>	
<div class="clear"></div>
</div>

<div class="columnlabelarea">
	<div class="columnLong"><p><ww:property value="this.getLabel('labels.internal.calendar.name')"/></p></div>
	<div class="columnMedium"><p><ww:property value="this.getLabel('labels.internal.calendar.description')"/></p></div>
	<div class="clear"></div>
</div>

<ww:iterator value="calendars" status="rowstatus">

	<ww:set name="calendarId" value="id" scope="page"/>
	<ww:set name="name" value="name" scope="page"/>
			
	<portlet:renderURL var="calendarUrl">
		<portlet:param name="action" value="ViewCalendar"/>
		<portlet:param name="calendarId" value="<%= pageContext.getAttribute("calendarId").toString() %>"/>
	</portlet:renderURL>

	<portlet:actionURL var="deleteUrl">
		<portlet:param name="action" value="DeleteCalendar"/>
		<portlet:param name="calendarId" value="<%= pageContext.getAttribute("calendarId").toString() %>"/>
	</portlet:actionURL>
	
	<portlet:renderURL var="viewListUrl">
		<portlet:param name="action" value="ViewCalendarList"/>
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
       		<p class="portletHeadline"><a href="<c:out value="${calendarUrl}"/>" title="Redigera '<ww:property value="name"/>'"><ww:property value="name"/></a></p>
       	</div>
       	<div class="columnMedium">
       		<p><ww:property value="description"/></p>
       	</div>
       	<div class="columnEnd">
       		<a href="<c:out value="${confirmUrl}"/>" title="Radera '<ww:property value="name"/>'" class="delete"></a>
       	   	<a href="<c:out value="${calendarUrl}"/>" title="Redigera '<ww:property value="name"/>'" class="edit"></a>
       	</div>
       	<div class="clear"></div>
    </div>
		
</ww:iterator>

<ww:if test="calendars == null || calendars.size() == 0">
	<div class="oddrow">
		<div class="columnLong"><p class="portletHeadline"><ww:property value="this.getLabel('labels.internal.applicationNoItemsFound')"/></a></p></div>
       	<div class="columnMedium"></div>
       	<div class="columnEnd"></div>
       	<div class="clear"></div>
    </div>
</ww:if>

<%@ include file="adminFooter.jsp" %>
