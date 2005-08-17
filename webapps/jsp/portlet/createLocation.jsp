<%@ include file="adminHeader.jsp" %>
	
	<div id="contentListHeader">
		<ww:property value="this.getLabel('labels.internal.location.createNewLocation')"/>
	</div>

	<div id="contentList">
		<portlet:actionURL var="createLocationActionUrl">
			<portlet:param name="action" value="CreateLocation"/>
		</portlet:actionURL>
		
		<form name="inputForm" method="POST" action="<c:out value="${createLocationActionUrl}"/>">
		<p>
			<calendar:textField label="labels.internal.location.name" name="name" value="location.name" cssClass="normalInput"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.location.description" name="description" value="location.description" cssClass="normalInput"/>
		</p>
		<p>
			<input type="submit" value="<ww:property value="this.getLabel('labels.internal.location.createButton')"/>">
		</p>
		</form>
	</div>

<%@ include file="adminFooter.jsp" %>
