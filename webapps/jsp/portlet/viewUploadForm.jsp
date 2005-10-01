<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.event.attachFile')"/></div>

<%@ include file="functionMenu.jsp" %>

<portlet:actionURL var="createResourceUploadActionUrl">
	<portlet:param name="action" value="CreateResource"/>
</portlet:actionURL>
	
<form enctype="multipart/form-data" name="inputForm" method="POST" action="<c:out value="${createResourceUploadActionUrl}"/>">
	<input type="hidden" name="eventId" value="<ww:property value="event.id"/>"/>
		
	<p>
		<ww:property value="this.getLabel('labels.internal.event.assetKey')"/><br>
		<select name="assetKey" class="textValue">
			<ww:iterator value="assetKeys">
      			<option value="<ww:property value='top'/>"><ww:property value="top"/></option>
      		</ww:iterator>
		</select>
	</p>
	<p>
		<ww:property value="this.getLabel('labels.internal.event.fileToAttach')"/><br>
		<input type="file" name="file" id="file" class="button"/>
	</p>
	<p>
		<input type="submit" value="<ww:property value="this.getLabel('labels.internal.event.updateButton')"/>" class="button">
	</p>
</form>

<%@ include file="adminFooter.jsp" %>
