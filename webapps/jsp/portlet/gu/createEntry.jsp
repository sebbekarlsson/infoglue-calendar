<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="calendar" prefix="calendar" %>

<portlet:defineObjects/>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendarPublic.css" />

<div id="inputForm">
	
	<div id="contentListHeader">
		<ww:property value="this.getLabel('labels.internal.entry.createNewEntry')"/>
	</div>

	<div id="contentList">

		<portlet:actionURL var="createEntryActionUrl">
			<portlet:param name="action" value="CreateEntry!publicGU"/>
		</portlet:actionURL>

		<form name="inputForm" method="POST" action="<c:out value="${createEntryActionUrl}"/>">
		<input type="hidden" name="eventId" value="<ww:property value="eventId"/>">
		<p>	
			<calendar:textField label="labels.internal.entry.firstName" name="firstName" value="entry.firstName" cssClass="longtextfield"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.entry.lastName" name="lastName" value="entry.lastName" cssClass="longtextfield"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.entry.email" name="email" value="entry.email" cssClass="longtextfield"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.entry.organisation" name="organisation" value="entry.organisation" cssClass="longtextfield"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.entry.address" name="address" value="entry.address" cssClass="longtextfield"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.entry.zipcode" name="zipcode" value="entry.zipcode" cssClass="longtextfield"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.entry.city" name="city" value="entry.city" cssClass="longtextfield"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.entry.phone" name="phone" value="entry.phone" cssClass="longtextfield"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.entry.fax" name="fax" value="entry.fax" cssClass="longtextfield"/>
		</p>
		<p>
			<calendar:textAreaField label="labels.internal.entry.message" name="message" value="entry.message" cssClass="longtextfield"/>
		</p>
		<p>
			<input type="submit" value="<ww:property value="this.getLabel('labels.internal.entry.createButton')"/>" class="button">
		</p>
		</form>
	</div>

</div>
