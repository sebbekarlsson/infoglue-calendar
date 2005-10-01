<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="EventTypes" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.eventType.updateEventType')"/>  <ww:property value="eventType.name"/></div>

<%@ include file="functionMenu.jsp" %>

<div class="portlet_margin">

	<portlet:actionURL var="updateEventTypeActionUrl">
		<portlet:param name="action" value="UpdateEventType"/>
	</portlet:actionURL>
	
	<form name="inputForm" method="POST" action="<c:out value="${updateEventTypeActionUrl}"/>">
		<input type="hidden" name="eventTypeId" value="<ww:property value="eventType.id"/>">
		
		<calendar:textField label="labels.internal.category.name" name="name" value="eventType.name" cssClass="longtextfield"/>
		<calendar:textField label="labels.internal.category.description" name="description" value="eventType.description" cssClass="longtextfield"/>

		<div style="height:10px"></div>
	
		<input type="submit" value="<ww:property value="this.getLabel('labels.internal.eventType.updateButton')"/>" class="button">
	</form>
</div>


<portlet:renderURL var="createAttributeCategoryUrl">
	<portlet:param name="action" value="CreateEventTypeCategoryAttribute!input"/>
	<calendar:evalParam name="eventTypeId" value="${param.eventTypeId}"/>
</portlet:renderURL>

<div class="subfunctionarea">
	<a href="<c:out value="${createAttributeCategoryUrl}"/>" title="Skapa ny post"><ww:property value="this.getLabel('labels.internal.eventType.addAvailableCategory')"/></a>
</div>

<div class="columnlabelarea">
	<div class="columnLong"><p><ww:property value="this.getLabel('labels.internal.eventType.AvailableCategories')"/></p></div>
	<div class="columnMedium"><p></p></div>
	<div class="clear"></div>
</div>


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
	
	<ww:if test="#rowstatus.odd == true">
    	<div class="oddrow">
    </ww:if>
    <ww:else>
		<div class="evenrow">
    </ww:else>

       	<div class="columnLong">
       		<p class="portletHeadline"><a href="<c:out value="${attributeCategoryUrl}"/>" title="Visa kategori"><ww:property value="name"/></a></p>
       	</div>
       	<div class="columnMedium">
       		<p><ww:property value="description"/></p>
       	</div>
       	<div class="columnEnd">
       		<a href="<c:out value="${deleteAttributeCategoryUrl}"/>" title="Radera kategori" class="delete"></a>
       	   	<a href="<c:out value="${attributeCategoryUrl}"/>" title="Redigera kategori" class="edit"></a>
       	</div>
       	<div class="clear"></div>
    </div>
	
</ww:iterator>
	
<ww:if test="eventType.categoryAttributes == null || eventType.categoryAttributes.size() == 0">
	<div class="oddrow">
		<div class="columnLong"><p class="portletHeadline"><ww:property value="this.getLabel('labels.internal.applicationNoItemsFound')"/></a></p></div>
       	<div class="columnMedium"></div>
       	<div class="columnEnd"></div>
       	<div class="clear"></div>
    </div>
</ww:if>
	

<%@ include file="adminFooter.jsp" %>