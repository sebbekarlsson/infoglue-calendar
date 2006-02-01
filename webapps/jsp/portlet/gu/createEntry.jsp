<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="calendar" prefix="calendar" %>

<portlet:defineObjects/>

<div class="calendar">

	<portlet:actionURL var="createEntryActionUrl">
		<portlet:param name="action" value="CreateEntry!publicGU"/>
	</portlet:actionURL>
	
	<form name="inputForm" method="POST" action="<c:out value="${createEntryActionUrl}"/>">
		<input type="hidden" name="eventId" value="<ww:property value="eventId"/>">
		<input type="hidden" name="returnAddress" value="<ww:property value="returnAddress"/>">
			
		<h1><ww:property value="this.getLabel('labels.internal.entry.createNewEntry')"/></h1>
		<h3>"<ww:property value="event.name"/>"</h3>
	
		<calendar:textField label="labels.internal.entry.firstName" name="firstName" value="entry.firstName" mandatory="true" labelCssClass="label" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.lastName" name="lastName" value="entry.lastName" mandatory="true" labelCssClass="label" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.email" name="email" value="entry.email" mandatory="true" labelCssClass="label" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.organisation" name="organisation" value="entry.organisation" labelCssClass="label" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.address" name="address" value="entry.address" labelCssClass="label" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.zipcode" name="zipcode" value="entry.zipcode" labelCssClass="label" cssClass="shorttextfield"/>
		<calendar:textField label="labels.internal.entry.city" name="city" value="entry.city" labelCssClass="label" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.phone" name="phone" value="entry.phone" labelCssClass="label" cssClass="shorttextfield"/>
		<calendar:textField label="labels.internal.entry.fax" name="fax" value="entry.fax" labelCssClass="label" cssClass="shorttextfield"/>
		<calendar:textAreaField label="labels.internal.entry.message" name="message" value="entry.message" labelCssClass="label" cssClass="fieldfullwidth"/>
		<br /><span class="fieldrow"><span class="redstar">*</span><label>obligatoriska f&auml;lt</label></span>  
		<br />
		<input id="submit" type="submit" value="<ww:property value="this.getLabel('labels.internal.entry.createButton')"/>" title="<ww:property value="this.getLabel('labels.internal.entry.createButton')"/>">
	</form>

</div>

