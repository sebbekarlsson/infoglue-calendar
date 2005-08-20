<%@ include file="adminHeader.jsp" %>
	
	<div id="contentListHeader">
		<ww:property value="this.getLabel('labels.internal.category.updateCategory')"/> <ww:property value="category.name"/>
	</div>

	<div id="contentList">
		<portlet:actionURL var="updateCategoryActionUrl">
			<portlet:param name="action" value="UpdateCategory"/>
		</portlet:actionURL>
		
		<form name="inputForm" method="POST" action="<c:out value="${updateCategoryActionUrl}"/>">
			<input type="hidden" name="categoryId" value="<ww:property value="category.id"/>">

			<p>
				<calendar:textField label="labels.internal.category.name" name="name" value="category.name" cssClass="normalInput"/>
			</p>
			<p>
				<calendar:textField label="labels.internal.category.description" name="description" value="category.description" cssClass="normalInput"/>
			</p>
			<p>
				<input type="submit" value="<ww:property value="this.getLabel('labels.internal.category.updateButton')"/>" class="calendarButton">
			</p>
		</form>
	</div>

<%@ include file="adminFooter.jsp" %>