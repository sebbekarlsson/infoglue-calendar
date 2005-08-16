<%@ page import="javax.portlet.PortletURL,
				 java.util.Map,
				 java.util.Iterator,
				 java.util.List,
				 java.util.Locale,
				 java.util.ResourceBundle,
				 org.infoglue.common.util.ResourceBundleHelper"%>

<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>


<portlet:defineObjects/>

<ww:set name="languageCode" value="languageCode" scope="page"/>
<% 
	Locale locale = new Locale(pageContext.getAttribute("languageCode").toString());
	ResourceBundle resourceBundle = ResourceBundleHelper.getResourceBundle("infoglueCalendar", locale);
%>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendar.css" />

<div id="container">
	<div id="top"><h1>Calendar application administration</h1></div>

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

		<ul>
	    	<li><a href="<c:out value="${viewCalendarListUrl}"/>">Administer calendars</a></li>
	    	<li><a href="<c:out value="${viewLocationListUrl}"/>">Administer locations</a></li>
			<li><a href="<c:out value="${viewCategoryListUrl}"/>">Administer categories</a></li>
		</ul>
	</div>

	<div id="content">
		<h2>Calendars</h2>

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

		<p class="nobreak">
			<ww:if test="#rowstatus.odd == true">
		    	<span class="marked"><ww:property value="id"/>. <a href="<c:out value="${calendarUrl}"/>"><ww:property value="name"/></a> 
		    	<a href="<c:out value="${calendarUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a>
		    	<a href="<c:out value="${deleteCalendarUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a></span>
		    </ww:if>
		    <ww:else>
		    	<span><ww:property value="id"/>. <a href="<c:out value="${calendarUrl}"/>"><ww:property value="name"/></a> 
		    	<a href="<c:out value="${calendarUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a>
		    	<a href="<c:out value="${deleteCalendarUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a></span>
		    </ww:else>
		</p>
		</ww:iterator>

		<portlet:renderURL var="createCalendarUrl">
			<portlet:param name="action" value="CreateCalendar!input"/>
		</portlet:renderURL>
		
		<a href="<c:out value="${createCalendarUrl}"/>">Add Calendar</a>
	</div>
	<div id="footer">
		&copy; The InfoGlue Community 2005
	</div>
</div>

