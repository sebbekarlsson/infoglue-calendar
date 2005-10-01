<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="EventTypes" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.eventType.updateEventType')"/>  <ww:property value="eventType.name"/></div>

<%@ include file="functionMenu.jsp" %>

<div>
	<portlet:actionURL var="updateEventTypeActionUrl">
		<portlet:param name="action" value="UpdateEventType"/>
	</portlet:actionURL>
	
	<form name="inputForm" method="POST" action="<c:out value="${updateEventTypeActionUrl}"/>">
		<input type="hidden" name="eventTypeId" value="<ww:property value="eventType.id"/>">
		
		<p>
			<calendar:textField label="labels.internal.category.name" name="name" value="eventType.name" cssClass="longtextfield"/>
		</p>
		<p>
			<calendar:textField label="labels.internal.category.description" name="description" value="eventType.description" cssClass="longtextfield"/>
		</p>
		<p>
			<input type="submit" value="<ww:property value="this.getLabel('labels.internal.eventType.updateButton')"/>" class="button">
		</p>
	</form>
</div>

<div id="contentListHeader">
	<ww:property value="this.getLabel('labels.internal.eventType.AvailableCategories')"/>
</div>

<div id="contentList">
	<ww:iterator value="eventType.categoryAttributes" status="rowstatus">
		
		<ww:set name="eventTypeCategoryAttributeId" value="id" scope="page"/>
		<ww:set name="eventTypeId" value="eventTypeId" scope="page"/>
		<portlet:renderURL var="attributeCategoryUrl">
			<portlet:param name="action" value="ViewEventTypeCategoryAttribute"/>
			<portlet:param name="eventTypeCategoryAttributeId" value="<%= pageContext.getAttribute("eventTypeCategoryAttributeId").toString() %>"/>
		</portlet:renderURL>
		
		<portlet:actionURL var="deleteAttributeCategoryUrl">
			<portlet:param name="action" value="DeleteEventTypeCategoryAttribute"/>
			<portlet:param name="eventTypeCategoryAttributeId" value="<%= pageContext.getAttribute("eventTypeCategoryAttributeId").toString() %>"/>
			<portlet:param name="eventTypeId" value="<%= pageContext.getAttribute("eventTypeId").toString() %>"/>
		</portlet:actionURL>
		
		<p class="nobreak">
			<ww:if test="#rowstatus.odd == true">
		    	<span class="marked"><ww:property value="id"/>. <a href="<c:out value="${attributeCategoryUrl}"/>"><ww:property value="name"/></a> 
		    	<a href="<c:out value="${attributeCategoryUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a>
		    	<a href="<c:out value="${deleteAttributeCategoryUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a></span>
		    </ww:if>
		    <ww:else>
		    	<span><ww:property value="id"/>. <a href="<c:out value="${attributeCategoryUrl}"/>"><ww:property value="name"/></a> 
		    	<a href="<c:out value="${attributeCategoryUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a>
		    	<a href="<c:out value="${deleteAttributeCategoryUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a></span>
		    </ww:else>
		</p>
	</ww:iterator>
	
	<portlet:renderURL var="createAttributeCategoryUrl">
		<portlet:param name="action" value="CreateEventTypeCategoryAttribute!input"/>
		<calendar:evalParam name="eventTypeId" value="${param.eventTypeId}"/>
	</portlet:renderURL>
	
	<a href="<c:out value="${createAttributeCategoryUrl}"/>"><ww:property value="this.getLabel('labels.internal.eventType.addAvailableCategory')"/></a>
			
</div>

<%@ include file="adminFooter.jsp" %>