<%@ include file="adminHeader.jsp" %>
	
	<div id="contentListHeader">
		<ww:property value="this.getLabel('labels.internal.category.createNewCategory')"/>
	</div>

	<div id="contentList">
		<portlet:actionURL var="createCategoryActionUrl">
			<portlet:param name="action" value="CreateCategory"/>
		</portlet:actionURL>
		
		<form name="inputForm" method="POST" action="<c:out value="${createCategoryActionUrl}"/>">
		
		<p>
			<calendar:textField label="labels.internal.category.name" name="name" value="category.name" cssClass="normalInput"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.category.description" name="description" value="category.description" cssClass="normalInput"/>
		</p>
		<p>
			<input type="submit" value="<ww:property value="this.getLabel('labels.internal.category.createButton')"/>">
		</p>
		</form>
	</div>

<%@ include file="adminFooter.jsp" %>
