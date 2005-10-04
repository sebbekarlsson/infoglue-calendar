<portlet:renderURL var="viewCalendarAdministrationUrl">
	<portlet:param name="action" value="ViewCalendarAdministration"/>
</portlet:renderURL>
<portlet:renderURL var="viewEventsUrl">
	<portlet:param name="action" value="ViewWaitingEventList"/>
</portlet:renderURL>

<portlet:renderURL var="viewCalendarListUrl">
	<portlet:param name="action" value="ViewCalendarList"/>
</portlet:renderURL>
<portlet:renderURL var="viewLocationListUrl">
	<portlet:param name="action" value="ViewLocationList"/>
</portlet:renderURL>
<portlet:renderURL var="viewCategoryUrl">
	<portlet:param name="action" value="ViewCategory"/>
</portlet:renderURL>
<portlet:renderURL var="viewEventTypeListUrl">
	<portlet:param name="action" value="ViewEventTypeList"/>
</portlet:renderURL>
<portlet:renderURL var="viewMyWorkingEventsUrl">
	<portlet:param name="action" value="ViewMyWorkingEventList"/>
</portlet:renderURL>
<portlet:renderURL var="viewWaitingEventsUrl">
	<portlet:param name="action" value="ViewWaitingEventList"/>
</portlet:renderURL>
<portlet:renderURL var="viewEventSearchFormUrl">
	<portlet:param name="action" value="ViewEventSearch!input"/>
</portlet:renderURL>
<portlet:renderURL var="viewEntrySearchUrl">
	<portlet:param name="action" value="ViewEntrySearch!input"/>
</portlet:renderURL>
	
<div class="functionarea">
  <span class="left">	
	<c:if test="${activeNavItem == 'Events'}"><span class="current"></c:if>
		<a href="<c:out value="${viewEventsUrl}"/>"><ww:property value="this.getLabel('labels.internal.applicationHome')"/></a>
	<c:if test="${activeNavItem == 'Events'}"></span></c:if> |  
	
	<ww:if test="infoGlueRemoteUser != 'eventPublisher'">
	
		<c:if test="${activeNavItem == 'EntrySearch'}"><span class="current"></c:if>
			<a href="<c:out value="${viewEntrySearchUrl}"/>"><ww:property value="this.getLabel('labels.internal.applicationSearchEntries')"/></a>
		<c:if test="${activeNavItem == 'EntrySearch'}"></span></c:if>
	
	</ww:if>
  </span>	
	
  <span class="right">	
	
	<ww:if test="infoGlueRemoteUser != 'eventPublisher'">
		<!--
		<c:if test="${activeNavItem == 'WaitingEvents'}"><span class="current"></c:if>
			<a href="<c:out value="${viewWaitingEventsUrl}"/>"><ww:property value="this.getLabel('labels.internal.applicationWaitingEvents')"/></a>
		<c:if test="${activeNavItem == 'WaitingEvents'}"></span></c:if> |  
		
		<c:if test="${activeNavItem == 'EventSearch'}"><span class="current"></c:if>
			<a href="<c:out value="${viewEventSearchFormUrl}"/>"><ww:property value="this.getLabel('labels.internal.applicationSearchEvents')"/></a>
		<c:if test="${activeNavItem == 'EventSearch'}"></span></c:if> |  
		-->
				
		<b><ww:property value="this.getLabel('labels.internal.applicationAdministrate')"/></b> 
	
		<c:if test="${activeNavItem == 'Calendars'}"><span class="current"></c:if>
			<a href="<c:out value="${viewCalendarListUrl}"/>"><ww:property value="this.getLabel('labels.internal.applicationAdministerCalendars')"/></a>
		<c:if test="${activeNavItem == 'Calendars'}"></span></c:if> |  
		
		<c:if test="${activeNavItem == 'Categories'}"><span class="current"></c:if>
			<a href="<c:out value="${viewCategoryUrl}"/>"><ww:property value="this.getLabel('labels.internal.applicationAdministerCategories')"/></a>
		<c:if test="${activeNavItem == 'Categories'}"></span></c:if> |  
		
		<c:if test="${activeNavItem == 'EventTypes'}"><span class="current"></c:if>
			<a href="<c:out value="${viewEventTypeListUrl}"/>"><ww:property value="this.getLabel('labels.internal.applicationAdministerEventTypes')"/></a>
		<c:if test="${activeNavItem == 'EventTypes'}"></span></c:if> |  
		
		<c:if test="${activeNavItem == 'Locations'}"><span class="current"></c:if>
			<a href="<c:out value="${viewLocationListUrl}"/>"><ww:property value="this.getLabel('labels.internal.applicationAdministerLocations')"/></a>
		<c:if test="${activeNavItem == 'Locations'}"></span></c:if>

	</ww:if>
  </span>
  <div class="clear"></div>
</div>	