<%@ page import="javax.portlet.PortletURL,
				 java.util.Map,
				 java.util.Iterator,
				 java.util.List"%>

<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>


<portlet:defineObjects/>

<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Calendar Administration</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendar.css" />
</head>

<body>

<div id="list">

	<div id="contentListHeader">
		Calendars
	</div>
		
	<div id="contentList">
		<ww:iterator value="administrationUCCBean.calendars" status="rowstatus">
			
			<ww:set name="calendarId" value="id" scope="page"/>
			<portlet:renderURL var="calendarUrl">
				<portlet:param name="action" value="ViewCalendar"/>
				<portlet:param name="calendarId" value="<%= pageContext.getAttribute("calendarId").toString() %>"/>
			</portlet:renderURL>

			<portlet:actionURL var="deleteCalendarUrl">
				<portlet:param name="action" value="DeleteCalendar"/>
				<portlet:param name="calendarId" value="<%= pageContext.getAttribute("calendarId").toString() %>"/>
			</portlet:actionURL>

		<p class="nobreak">
			<ww:if test="#rowstatus.odd == true">
		    	<span class="marked"><ww:property value="id"/>.<a href="<c:out value="${calendarUrl}"/>"><ww:property value="name"/></a> <a href="<c:out value="${calendarUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a><a href="<c:out value="${deleteCalendarUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.jpg" border="0"></a></span>
		    </ww:if>
		    <ww:else>
		    	<span><ww:property value="id"/>.<a href="<c:out value="${calendarUrl}"/>"><ww:property value="name"/></a> <a href="<c:out value="${calendarUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a><a href="<c:out value="${deleteCalendarUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.jpg" border="0"></a></span>
		    </ww:else>
		</p>
		</ww:iterator>
	</div>

	<div id="contentListFooter">
		
		<portlet:renderURL var="createCalendarUrl">
			<portlet:param name="action" value="CreateCalendar!input"/>
		</portlet:renderURL>
		
		<a href="<c:out value="${createCalendarUrl}"/>">Add Calendar</a>
	</div>
</div>

<div id="list">

	<div id="contentListHeader">
		Locations
	</div>

	<div id="contentList">
		<ww:iterator value="administrationUCCBean.locations" status="rowstatus">
		
			<ww:set name="locationId" value="id" scope="page"/>
			<portlet:renderURL var="locationUrl">
				<portlet:param name="action" value="ViewLocation"/>
				<portlet:param name="locationId" value="<%= pageContext.getAttribute("locationId").toString() %>"/>
			</portlet:renderURL>
			
			<portlet:actionURL var="deleteLocationUrl">
				<portlet:param name="action" value="DeleteLocation"/>
				<portlet:param name="locationId" value="<%= pageContext.getAttribute("locationId").toString() %>"/>
			</portlet:actionURL>
			
		<p class="nobreak">
			<ww:if test="#rowstatus.odd == true">
		    	<span class="marked"><ww:property value="id"/>.<a href="<c:out value="${locationUrl}"/>"><ww:property value="name"/></a> <a href="<c:out value="${locationUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a><a href="<c:out value="${deleteLocationUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.jpg" border="0"></a></span>
		    </ww:if>
		    <ww:else>
		    	<span><ww:property value="id"/>.<a href="<c:out value="${locationUrl}"/>"><ww:property value="name"/></a> <a href="<c:out value="${locationUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a><a href="<c:out value="${deleteLocationUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.jpg" border="0"></a></span>
		    </ww:else>
		</p>
		</ww:iterator>
	</div>

	<div id="contentListFooter">
		<portlet:renderURL var="createLocationUrl">
			<portlet:param name="action" value="CreateLocation!input"/>
		</portlet:renderURL>
		
		<a href="<c:out value="${createLocationUrl}"/>">Add Location</a>
	</div>
</div>

<div id="list">

	<div id="contentListHeader">
		Categories
	</div>

	<div id="contentList">
		<ww:iterator value="administrationUCCBean.categories" status="rowstatus">
			
			<ww:set name="categoryId" value="id" scope="page"/>
			<portlet:renderURL var="categoryUrl">
				<portlet:param name="action" value="ViewCategory"/>
				<portlet:param name="categoryId" value="<%= pageContext.getAttribute("categoryId").toString() %>"/>
			</portlet:renderURL>

			<portlet:actionURL var="deleteCategoryUrl">
				<portlet:param name="action" value="DeleteCategory"/>
				<portlet:param name="categoryId" value="<%= pageContext.getAttribute("categoryId").toString() %>"/>
			</portlet:actionURL>
			
		<p class="nobreak">
			<ww:if test="#rowstatus.odd == true">
		    	<span class="marked"><ww:property value="id"/>.<a href="<c:out value="${categoryUrl}"/>"><ww:property value="name"/></a> <a href="<c:out value="${categoryUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a><a href="<c:out value="${deleteCategoryUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.jpg" border="0"></a></span>
		    </ww:if>
		    <ww:else>
		    	<span><ww:property value="id"/>.<a href="<c:out value="${categoryUrl}"/>"><ww:property value="name"/></a> <a href="<c:out value="${categoryUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a><a href="<c:out value="${deleteCategoryUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.jpg" border="0"></a></span>
		    </ww:else>
		</p>
		</ww:iterator>
	</div>

	<div id="contentListFooter">
		<portlet:renderURL var="createCategoryUrl">
			<portlet:param name="action" value="CreateCategory!input"/>
		</portlet:renderURL>
		
		<a href="<c:out value="${createCategoryUrl}"/>">Add Category</a>
	</div>
</div>


</body>
</html>
