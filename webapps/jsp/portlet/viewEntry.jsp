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
		Update entry
	</div>

	<div id="contentList">

		<portlet:actionURL var="updateEntryActionUrl">
			<portlet:param name="action" value="UpdateEntry"/>
		</portlet:actionURL>

		<form name="inputForm" method="POST" action="<c:out value="${updateEntryActionUrl}"/>">
			<input type="hidden" name="entryId" value="<ww:property value="entryId"/>">
			First name: <input type="textfield" name="firstName" class="normalInput" value="<ww:property value="entry.firstName"/>"><br>
			Last name: <input type="textfield" name="lastName" class="normalInput" value="<ww:property value="entry.lastName"/>"><br>
			E-mail: <input type="textfield" name="email" class="normalInput" value="<ww:property value="entry.email"/>"><br>
			<br>
			<input type="submit" value="Save">
		</form>
	</div>

</div>
