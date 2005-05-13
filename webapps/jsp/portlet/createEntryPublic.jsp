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
<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/applications/jscalendar/calendar-system.css" title="system" />

<div id="inputForm">
	
	<div id="contentListHeader">
		<%= resourceBundle.getString("labels.public.entry.newEntryHeader") %>
	</div>

	<div id="contentList">

		<portlet:actionURL var="createEntryActionUrl">
			<portlet:param name="action" value="CreateEntry!public"/>
		</portlet:actionURL>

		<form name="inputForm" method="POST" action="<c:out value="${createEntryActionUrl}"/>">
			<input type="hidden" name="eventId" value="<ww:property value="eventId"/>">
			<p>
				<%= resourceBundle.getString("labels.public.entry.firstNameLabel") %> <input type="textfield" class="normalInput" name="firstName" value="">
			</p>
			<p>
			<%= resourceBundle.getString("labels.public.entry.lastNameLabel") %> <input type="textfield" class="normalInput" name="lastName" value="">
			</p>
			<p>
			<%= resourceBundle.getString("labels.public.entry.emailLabel") %> <input type="textfield" class="normalInput" name="email" value="">
			</p>
			<input type="submit" value="<%= resourceBundle.getString("labels.public.entry.submitLabel") %>">
		</form>
	</div>

</div>
