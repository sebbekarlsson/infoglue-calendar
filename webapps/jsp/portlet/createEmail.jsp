<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<% System.err.println( "In createEmail" ); %>

<c:set var="activeNavItem" value="EntrySearch" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<%@ include file="functionMenu.jsp" %>

<script type="text/javascript">
	
	function toggleForms()
	{
		attachmentFormElement = document.getElementById("attachmentForm");
		emailFormElement = document.getElementById("emailForm");
		if(attachmentFormElement.style.display == "none")
		{
			attachmentFormElement.style.display = "block";
			emailFormElement.style.display = "none";
		}
		else
		{
			attachmentFormElement.style.display = "none";
			emailFormElement.style.display = "block";
		}
	}
	
</script>

<div id="emailForm" class="portlet_margin">

<h1><ww:property value="this.getLabel('labels.internal.soba.emailPersons')"/></h1>

<portlet:renderURL var="addAttachmentUrl">
	<calendar:evalParam name="action" value="ComposeEmail"/>
</portlet:renderURL>

<portlet:actionURL var="sendEmailUrl">
	<calendar:evalParam name="action" value="ComposeEmail"/>
</portlet:actionURL>
		
<form name="email" method="post" action="<c:out value="${sendEmailUrl}"/>">
	<input type="hidden" name="searchEventId" value="<ww:property value="searchEventId"/>">
	<input type="hidden" name="searchFirstName" value="<ww:property value="searchFirstName"/>">
	<input type="hidden" name="searchLastName" value="<ww:property value="searchLastName"/>">
	<input type="hidden" name="searchEmail" value="<ww:property value="searchEmail"/>">
	<input type="hidden" name="attachments" value="<ww:property value="attachments"/>">

	<ww:property value="this.getLabel('labels.internal.soba.emailIntro')"/>
	
	<calendar:textField label="labels.internal.soba.addresses" name="emailAddresses" value="emailAddresses" cssClass="longtextfield" mandatory="true"/>
	<calendar:textField label="labels.internal.soba.subject" name="subject" value="subject" cssClass="longtextfield" mandatory="true"/>
	<ww:if test="attachments != null && attachments.size > 0">
		<div class="fieldrow">
			<label for="attachmentSelect"><ww:property value="this.getLabel('labels.internal.soba.attachments')"/></label><br/>
			<select id="attachmentSelect" name="searchEventId" class="listBox">
				<ww:iterator value="attachments">
				<option value="<ww:property value="name"/>"/><ww:property value="name"/></option>
				</ww:iterator>
			</select>
		</div>
	</ww:if>

	<calendar:textAreaField label="labels.internal.soba.message" name="message" value="message" cssClass="smalltextarea" mandatory="true"/>

	<div style="height:10px"></div>
     
    <input type="button" class="button" onClick="javascript:toggleForms();" value="<ww:property value="this.getLabel('labels.internal.soba.addAttachment')"/>"/>
	<input type="submit" name="send"  class="button" value="<ww:property value="this.getLabel('labels.internal.soba.sendMessage')"/>"/>
	<input type="submit" name="cancel" class="button" value="<ww:property value="this.getLabel('labels.internal.applicationCancel')"/>"></a>
</form>
</div>

<div id="attachmentForm" class="portlet_margin" style="display: none;">
  <form name="attachment" method="post" action="<c:out value="${addAttachmentUrl}"/>" enctype="multipart/form-data">
	<input type="hidden" name="attachments" value="<ww:property value="attachments"/>">
	<input type="hidden" name="emailAddresses" value="<ww:property value="emailAddresses"/>">
	
	<ww:property value="this.getLabel('labels.internal.soba.attachmentIntro')"/>

	<div style="height:10px"></div>

    <input type="file" name="file1" class="button" value="<ww:property value="this.getLabel('labels.internal.soba.browse')"/>"/>
    <input type="submit" value="<ww:property value="this.getLabel('labels.internal.soba.addAttachment')"/>" class="button"/>
    <input type="button" onclick="javascript:toggleForms();" value="<ww:property value="this.getLabel('labels.internal.applicationCancel')"/>" class="button"/>
  </form>
</div>

</form>

<%@ include file="adminFooter.jsp" %>
