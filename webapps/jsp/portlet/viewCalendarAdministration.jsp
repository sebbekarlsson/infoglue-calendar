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
		<h2>Welcome to InfoGlue Calendar</h2>
		<p>
			This is the administrative application. It will let you manage all aspects of the calendar/event system.
		</p>
		<p>
			To the left is a menu containing the different aspects of the system.
		</p>
	</div>
	<div id="footer">
		&copy; The InfoGlue Community 2005
	</div>
</div>
