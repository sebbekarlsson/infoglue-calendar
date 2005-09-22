<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="calendar" prefix="calendar" %>

<portlet:defineObjects/>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendar.css" />
<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/applications/jscalendar/calendar-system.css" title="system" />

<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/calendar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/lang/calendar-en.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/calendar-setup.js"></script>
<style type="text/css">
	.errorMessage {
	    color: red;
	}
</style>

<div id="container">
	<div id="top"><h1><ww:property value="this.getLabel('labels.internal.applicationHeader')"/></h1></div>

	<div id="leftnav">
		<portlet:renderURL var="viewCalendarListUrl">
			<portlet:param name="action" value="ViewCalendarList"/>
		</portlet:renderURL>
		<portlet:renderURL var="viewLocationListUrl">
			<portlet:param name="action" value="ViewLocationList"/>
		</portlet:renderURL>
		<portlet:renderURL var="viewCategoryListUrl">
			<portlet:param name="action" value="ViewCategoryList"/>
		</portlet:renderURL>
		<portlet:renderURL var="viewEventTypeListUrl">
			<portlet:param name="action" value="ViewEventTypeList"/>
		</portlet:renderURL>

		<ul>
	    	<li><a href="<c:out value="${viewCalendarListUrl}"/>"><ww:property value="this.getLabel('labels.internal.applicationAdministerCalendars')"/></a></li>
	    	<li><a href="<c:out value="${viewLocationListUrl}"/>"><ww:property value="this.getLabel('labels.internal.applicationAdministerLocations')"/></a></li>
			<li><a href="<c:out value="${viewCategoryListUrl}"/>"><ww:property value="this.getLabel('labels.internal.applicationAdministerCategories')"/></a></li>
			<li><a href="<c:out value="${viewEventTypeListUrl}"/>"><ww:property value="this.getLabel('labels.internal.applicationAdministerEventTypes')"/></a></li>
		</ul>
	</div>

	<div id="content">
