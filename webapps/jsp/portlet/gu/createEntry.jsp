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
		
		<calendar:textField label="labels.internal.entry.firstName" name="'firstName'" value="entry.firstName" mandatory="true" labelCssClass="label" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.lastName" name="'lastName'" value="entry.lastName" mandatory="true" labelCssClass="label" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.email" name="'email'" value="entry.email" mandatory="true" labelCssClass="label" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.organisation" name="'organisation'" value="entry.organisation" labelCssClass="label" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.address" name="'address'" value="entry.address" labelCssClass="label" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.zipcode" name="'zipcode'" value="entry.zipcode" labelCssClass="label" cssClass="shorttextfield"/>
		<calendar:textField label="labels.internal.entry.city" name="'city'" value="entry.city" labelCssClass="label" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.phone" name="'phone'" value="entry.phone" labelCssClass="label" cssClass="shorttextfield"/>
		<calendar:textField label="labels.internal.entry.fax" name="'fax'" value="entry.fax" labelCssClass="label" cssClass="shorttextfield"/>
		<calendar:textAreaField label="labels.internal.entry.message" name="message" value="entry.message" labelCssClass="label" cssClass="fieldfullwidth"/>
				
		<ww:set name="count" value="0"/>
		<ww:iterator value="attributes" status="rowstatus">
			<ww:set name="attribute" value="top"/>
			<ww:set name="title" value="top.getContentTypeAttribute('title').getContentTypeAttributeParameterValue().getLocalizedValue('label', '$!currentContentTypeEditorViewLanguageCode')" scope="page"/>
			<ww:set name="attributeName" value="this.concat('attribute_', top.name)"/>
			<ww:set name="attributeValue" value="this.getAttributeValue(#errorEntry.attributes, top.name)"/>

			<input type="hidden" name="attributeName_<ww:property value="#count"/>" value="attribute_<ww:property value="top.name"/>"/>
			
			<ww:if test="#attribute.inputType == 'textfield'">
				<calendar:textField label="${title}" name="#attributeName" value="#attributeValue" cssClass="longtextfield"/>
			</ww:if>		

			<ww:if test="#attribute.inputType == 'textarea'">
				<calendar:textAreaField label="${title}" name="#attributeName" value="#attributeValue" cssClass="smalltextarea"/>
			</ww:if>		

			<ww:if test="#attribute.inputType == 'select'">
				<calendar:selectField label="${title}" name="#attributeName" multiple="true" value="#attribute.contentTypeAttributeParameterValues" cssClass="listBox"/>
			</ww:if>		

			<ww:if test="#attribute.inputType == 'radiobutton'">
				<calendar:radioButtonField label="${title}" name="#attributeName" mandatory="false" valueMap="#attribute.contentTypeAttributeParameterValuesAsMap"/>
			</ww:if>		

			<ww:if test="#attribute.inputType == 'checkbox'">
				<calendar:checkboxField label="${title}" name="#attributeName" valueMap="#attribute.contentTypeAttributeParameterValuesAsMap"/>
			</ww:if>		

			<ww:if test="#attribute.inputType == 'hidden'">
				<calendar:hiddenField name="#attributeName" value="#attributeValue"/>
			</ww:if>		

			<ww:set name="count" value="#count + 1"/>
		</ww:iterator>
				
		<br /><span class="fieldrow"><span class="redstar">*</span><label>obligatoriska f&auml;lt</label></span>  
		<br />
		<input id="submit" type="submit" value="<ww:property value="this.getLabel('labels.internal.entry.createButton')"/>" title="<ww:property value="this.getLabel('labels.internal.entry.createButton')"/>">
	</form>

</div>

