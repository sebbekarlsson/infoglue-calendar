<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Calendars" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.applicationTitle')"/> - <ww:property value="this.getLabel('labels.internal.location.subHeader')"/></div>

<%@ include file="functionMenu.jsp" %>

<portlet:renderURL var="createCalendarUrl">
	<portlet:param name="action" value="CreateCalendar!input"/>
</portlet:renderURL>

<div class="subfunctionarea">
	<a href="<c:out value="${createCalendarUrl}"/>" title="Skapa ny post"><ww:property value="this.getLabel('labels.internal.calendar.addCalendar')"/></a>
</div>

<div class="columnlabelarea">
	<div class="columnLong"><p><ww:property value="this.getLabel('labels.internal.calendar.name')"/></p></div>
	<div class="columnMedium"><p><ww:property value="this.getLabel('labels.internal.calendar.description')"/></p></div>
	<div class="clear"></div>
</div>

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
	
	<ww:if test="#rowstatus.odd == true">
    	<div class="oddrow">
    </ww:if>
    <ww:else>
		<div class="evenrow">
    </ww:else>

       	<div class="columnLong">
       		<p class="portletHeadline"><a href="<c:out value="${calendarUrl}"/>" title="Visa Kalender"><ww:property value="name"/></a></p>
       	</div>
       	<div class="columnMedium">
       		<p><ww:property value="description"/></p>
       	</div>
       	<div class="columnEnd">
       		<a href="<c:out value="${deleteCalendarUrl}"/>" title="Radera KalenderNamn" class="delete"></a>
       	   	<a href="<c:out value="${calendarUrl}"/>" title="Redigera Kalender" class="edit"></a>
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
