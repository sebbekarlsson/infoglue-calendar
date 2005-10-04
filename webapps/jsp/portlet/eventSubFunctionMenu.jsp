<portlet:renderURL var="createEventUrl">
	<portlet:param name="action" value="ViewCalendarList!choose"/>
</portlet:renderURL>
<portlet:renderURL var="viewPublishedEventsUrl">
	<portlet:param name="action" value="ViewPublishedEventList"/>
</portlet:renderURL>
<portlet:renderURL var="viewWaitingEventsUrl">
	<portlet:param name="action" value="ViewWaitingEventList"/>
</portlet:renderURL>
<portlet:renderURL var="viewEventSearchFormUrl">
	<portlet:param name="action" value="ViewEventSearch!input"/>
</portlet:renderURL>
	
<div class="subfunctionarea">

	<c:if test="${activeEventSubNavItem == 'NewEvent'}"><span class="current"></c:if>
		<a href="<c:out value="${createEventUrl}"/>"><ww:property value="this.getLabel('labels.internal.event.addEvent')"/></a>
	<c:if test="${activeEventSubNavItem == 'NewEvent'}"></span></c:if> |  
		
	<c:if test="${activeEventSubNavItem == 'PublishedEvents'}"><span class="current"></c:if>
	   	<a href="<c:out value="${viewPublishedEventsUrl}"/>"><ww:property value="this.getLabel('labels.internal.applicationPublishedEvents')"/></a>
	<c:if test="${activeEventSubNavItem == 'PublishedEvents'}"></span></c:if> |
	
	<c:if test="${activeEventSubNavItem == 'WaitingEvents'}"><span class="current"></c:if>
	   	<a href="<c:out value="${viewWaitingEventsUrl}"/>"><ww:property value="this.getLabel('labels.internal.applicationWaitingEvents')"/></a>
	<c:if test="${activeEventSubNavItem == 'WaitingEvents'}"></span></c:if> |

	<c:if test="${activeEventSubNavItem == 'MyWorkingEvents'}"><span class="current"></c:if>
	   	<a href="<c:out value="${viewMyWorkingEventsUrl}"/>"><ww:property value="this.getLabel('labels.internal.applicationMyWorkingEvents')"/></a>
	<c:if test="${activeEventSubNavItem == 'MyWorkingEvents'}"></span></c:if> |

	<c:if test="${activeEventSubNavItem == 'EventSearch'}"><span class="current"></c:if>
		<a href="<c:out value="${viewEventSearchFormUrl}"/>"><ww:property value="this.getLabel('labels.internal.applicationSearchEvents')"/></a>
	<c:if test="${activeEventSubNavItem == 'EventSearch'}"></span></c:if>
	
</div>