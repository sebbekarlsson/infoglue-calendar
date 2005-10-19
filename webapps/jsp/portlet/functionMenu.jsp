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

<portlet:renderURL var="viewSettingsUrl">
	<portlet:param name="action" value="ViewSettings"/>
</portlet:renderURL>
	
<div class="functionarea">
  <span class="left">	
	<ww:if test="infoGlueRemoteUser != 'eventPublisher'">
	
		<a href="<c:out value="${viewEventsUrl}"/>" <c:if test="${activeNavItem == 'Events'}">class="current"</c:if>><ww:property value="this.getLabel('labels.internal.applicationHome')"/></a> |
		<a href="<c:out value="${viewEntrySearchUrl}"/>" <c:if test="${activeNavItem == 'EntrySearch'}">class="current"</c:if>><ww:property value="this.getLabel('labels.internal.applicationSearchEntries')"/></a>
	
	</ww:if>
  </span>	
	
  <span class="right">	
	
	<!--User: <ww:property value="infoGlueRemoteUserRoles"/>-->
	
	<calendar:hasRole id="calendarAdministrator" roleName="CalendarAdministrator"/>
	<calendar:hasRole id="calendarOwner" roleName="CalendarOwner"/>
	<calendar:hasRole id="administrators" roleName="administrators"/>
	<calendar:hasRole id="eventPublisher" roleName="EventPublisher"/>
	
	<ww:if test="infoGlueRemoteUser != 'eventPublisher'">
	
		<!--
		<a href="<c:out value="${viewWaitingEventsUrl}"/>" <c:if test="${activeNavItem == 'WaitingEvents'}">class="current"</c:if>><ww:property value="this.getLabel('labels.internal.applicationWaitingEvents')"/></a> |
		<a href="<c:out value="${viewEventSearchFormUrl}"/>" <c:if test="${activeNavItem == 'EventSearch'}">class="current"</c:if>><ww:property value="this.getLabel('labels.internal.applicationSearchEvents')"/></a> |
		<b><ww:property value="this.getLabel('labels.internal.applicationAdministrate')"/></b> 
		-->
		
		<a href="<c:out value="${viewCalendarListUrl}"/>" <c:if test="${activeNavItem == 'Calendars'}">class="current"</c:if>><ww:property value="this.getLabel('labels.internal.applicationAdministerCalendars')"/></a> |

		<c:if test="${calendarAdministrator == true}">
			<a href="<c:out value="${viewCategoryUrl}"/>" <c:if test="${activeNavItem == 'Categories'}">class="current"</c:if>><ww:property value="this.getLabel('labels.internal.applicationAdministerCategories')"/></a> |
			<a href="<c:out value="${viewEventTypeListUrl}"/>" <c:if test="${activeNavItem == 'EventTypes'}">class="current"</c:if>><ww:property value="this.getLabel('labels.internal.applicationAdministerEventTypes')"/></a> |
			<!--
			<a href="<c:out value="${viewSettingsUrl}"/>" <c:if test="${activeNavItem == 'Settings'}">class="current"</c:if>><ww:property value="this.getLabel('labels.internal.applicationAdministerSettings')"/></a> |
			-->
		</c:if>
			
		<a href="<c:out value="${viewLocationListUrl}"/>" <c:if test="${activeNavItem == 'Locations'}">class="current"</c:if>><ww:property value="this.getLabel('labels.internal.applicationAdministerLocations')"/></a>
	</ww:if>
  </span>
  <div class="clear"></div>
</div>	