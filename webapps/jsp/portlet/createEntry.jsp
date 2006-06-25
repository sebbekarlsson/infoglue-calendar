<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Calendars" scope="page"/>

<%@ include file="adminHeader.jsp" %>
<%@ include file="functionMenu.jsp" %>

<div class="portlet_margin">

	<portlet:actionURL var="createEntryActionUrl">
		<portlet:param name="action" value="CreateEntry"/>
	</portlet:actionURL>

	<form name="inputForm" method="POST" action="<c:out value="${createEntryActionUrl}"/>">
		<input type="hidden" name="eventId" value="<ww:property value="eventId"/>">
	
		<calendar:textField label="labels.internal.entry.firstName" name="firstName" value="entry.firstName" mandatory="true" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.lastName" name="lastName" value="entry.lastName" mandatory="true" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.email" name="email" value="entry.email" mandatory="true" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.organisation" name="organisation" value="entry.organisation" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.address" name="address" value="entry.address" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.zipcode" name="zipcode" value="entry.zipcode" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.city" name="city" value="entry.city" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.phone" name="phone" value="entry.phone" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.fax" name="fax" value="entry.fax" cssClass="longtextfield"/>
		<calendar:textAreaField label="labels.internal.entry.message" name="message" value="entry.message" cssClass="smalltextarea"/>

		<c:set var="count" value="0"/>
		<ww:iterator value="attributes" status="rowstatus">
			<ww:set name="attribute" value="top" scope="page"/>
			<ww:set name="title" value="top.getContentTypeAttribute('title').getContentTypeAttributeParameterValue().getLocalizedValue('label', '$!currentContentTypeEditorViewLanguageCode')" scope="page"/>
			<ww:set name="attributeName" value="this.concat('attribute_', top.name)"/>

			<input type="hidden" name="attributeName_<c:out value="${count}"/>" value="attribute_<ww:property value="top.name"/>"/>
			<calendar:textField label="${title}" name="#attributeName" value="" cssClass="longtextfield"/>
		
			<ww:set name="count" value="${count + 1)"/>
		</ww:iterator>
		

		<div style="height:10px"></div>
		<input type="submit" value="<ww:property value="this.getLabel('labels.internal.entry.createButton')"/>" class="button">
		<input type="button" onclick="history.back();" value="<ww:property value="this.getLabel('labels.internal.applicationCancel')"/>" class="button">
	</form>

</div>

<%@ include file="adminFooter.jsp" %>

