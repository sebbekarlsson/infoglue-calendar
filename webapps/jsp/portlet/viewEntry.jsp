<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Entry" scope="page"/>

<%@ include file="adminHeader.jsp" %>
<%@ include file="functionMenu.jsp" %>

<div class="portlet_margin">
	
	<portlet:actionURL var="updateEntryActionUrl">
		<portlet:param name="action" value="UpdateEntry"/>
	</portlet:actionURL>

	<form name="inputForm" method="POST" action="<c:out value="${updateEntryActionUrl}"/>">
		<input type="hidden" name="entryId" value="<ww:property value="entryId"/>">
		<input type="hidden" name="searchEventId" value="<ww:property value="searchEventId"/>">
		<input type="hidden" name="searchFirstName" value="<ww:property value="searchFirstName"/>">
		<input type="hidden" name="searchLastName" value="<ww:property value="searchLastName"/>">
		<input type="hidden" name="searchEmail" value="<ww:property value="searchEmail"/>">

		<calendar:textField label="labels.internal.entry.firstName" name="'firstName'" value="entry.firstName" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.lastName" name="'lastName'" value="entry.lastName" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.email" name="'email'" value="entry.email" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.organisation" name="'organisation'" value="entry.organisation" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.address" name="'address'" value="entry.address" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.zipcode" name="'zipcode'" value="entry.zipcode" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.city" name="'city'" value="entry.city" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.phone" name="'phone'" value="entry.phone" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.fax" name="'fax'" value="entry.fax" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.entry.message" name="'message'" value="entry.message" cssClass="smalltextarea"/>
		
		<ww:set name="count" value="0"/>
		<ww:iterator value="attributes" status="rowstatus">
			<ww:set name="attribute" value="top"/>
			<ww:if test="#errorEntry != null">
				<ww:set name="attributeValue" value="this.getAttributeValue(#errorEntry.attributes, top.name)"/>
			</ww:if>
			<ww:else>
				<ww:set name="attributeValue" value="this.getAttributeValue(entry.attributes, top.name)"/>
			</ww:else>
			<ww:set name="title" value="top.getContentTypeAttribute('title').getContentTypeAttributeParameterValue().getLocalizedValue('label', '$!currentContentTypeEditorViewLanguageCode')" scope="page"/>
			<ww:set name="attributeName" value="this.concat('attribute_', top.name)"/>

			<input type="hidden" name="attributeName_<ww:property value="#count"/>" value="attribute_<ww:property value="top.name"/>"/>
			
			<ww:if test="#attribute.inputType == 'textfield'">
				<calendar:textField label="${title}" name="#attributeName" value="#attributeValue" cssClass="longtextfield"/>
			</ww:if>		

			<ww:if test="#attribute.inputType == 'textarea'">
				<calendar:textAreaField label="${title}" name="#attributeName" value="#attributeValue" cssClass="smalltextarea"/>
			</ww:if>		

			<ww:if test="#attribute.inputType == 'select'">
				<calendar:selectField label="${title}" name="#attributeName" multiple="true" value="#attribute.contentTypeAttributeParameterValues" selectedValue="#attributeValue" cssClass="listBox"/>
			</ww:if>		

			<ww:if test="#attribute.inputType == 'radiobutton'">
				<calendar:radioButtonField label="${title}" name="#attributeName" mandatory="false" valueMap="#attribute.contentTypeAttributeParameterValuesAsMap" selectedValue="#attributeValue"/>
			</ww:if>		

			<ww:if test="#attribute.inputType == 'checkbox'">
				<calendar:checkboxField label="${title}" name="#attributeName" valueMap="#attribute.contentTypeAttributeParameterValuesAsMap" selectedValue="#attributeValue"/>
			</ww:if>		

			<ww:if test="#attribute.inputType == 'hidden'">
				<calendar:hiddenField name="#attributeName" value="#attributeValue"/>
			</ww:if>		
					
			<ww:set name="count" value="#count + 1"/>
		</ww:iterator>
		
		<div style="height:10px"></div>
		<input type="submit" value="<ww:property value="this.getLabel('labels.internal.entry.updateButton')"/>" class="button">
		<input type="button" onclick="history.back();" value="<ww:property value="this.getLabel('labels.internal.applicationCancel')"/>" class="button">
	</form>

</div>

<%@ include file="adminFooter.jsp" %>
