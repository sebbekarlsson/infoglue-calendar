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
<%@ taglib uri="calendar" prefix="calendar" %>


<portlet:defineObjects/>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendar.css" />
<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/applications/jscalendar/calendar-system.css" title="system" />

<div id="inputForm">
	
	<div id="contentListHeader">
		<ww:property value="this.getLabel('labels.internal.entry.updateEntry')"/>
	</div>

	<div id="contentList">

		<portlet:actionURL var="updateEntryActionUrl">
			<portlet:param name="action" value="UpdateEntry"/>
		</portlet:actionURL>

		<form name="inputForm" method="POST" action="<c:out value="${updateEntryActionUrl}"/>">
			<input type="hidden" name="entryId" value="<ww:property value="entryId"/>">
			<input type="hidden" name="searchEventId" value="<ww:property value="searchEventId"/>">
			<input type="hidden" name="searchFirstName" value="<ww:property value="searchFirstName"/>">
			<input type="hidden" name="searchLastName" value="<ww:property value="searchLastName"/>">
			<input type="hidden" name="searchEmail" value="<ww:property value="searchEmail"/>">

			<p>
				<calendar:textField label="labels.internal.entry.firstName" name="firstName" value="entry.firstName" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.entry.lastName" name="lastName" value="entry.lastName" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.entry.email" name="email" value="entry.email" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.entry.organisation" name="organisation" value="entry.organisation" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.entry.address" name="address" value="entry.address" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.entry.zipcode" name="zipcode" value="entry.zipcode" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.entry.city" name="city" value="entry.city" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.entry.phone" name="phone" value="entry.phone" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.entry.fax" name="fax" value="entry.fax" cssClass="normalInput"/>
			</p>
			<p>
				<ww:property value="this.getLabel('labels.internal.entry.message')"/><br> 
				<textarea name="message" class="normalInput"><ww:property value="entry.message"/></textarea>
			</p>
			<input type="submit" value="<ww:property value="this.getLabel('labels.internal.entry.updateButton')"/>">
		</form>
	</div>

</div>
