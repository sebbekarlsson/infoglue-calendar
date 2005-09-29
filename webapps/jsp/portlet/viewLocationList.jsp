<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Locations" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.location.subHeader')"/></div>

<%@ include file="functionMenu.jsp" %>

<portlet:renderURL var="createLocationUrl">
	<portlet:param name="action" value="CreateLocation!input"/>
</portlet:renderURL>

<div class="subfunctionarea">
	<a href="<c:out value="${createLocationUrl}"/>" title="Skapa ny post"><ww:property value="this.getLabel('labels.internal.location.addLocation')"/></a>
</div>

<div class="columnlabelarea">
	<div class="columnLong"><p><ww:property value="this.getLabel('labels.internal.location.name')"/></p></div>
	<div class="columnMedium"><p><ww:property value="this.getLabel('labels.internal.location.description')"/></p></div>
	<div class="clear"></div>
</div>

<ww:iterator value="locations" status="rowstatus">

	<ww:set name="locationId" value="id" scope="page"/>
	<portlet:renderURL var="locationUrl">
		<portlet:param name="action" value="ViewLocation"/>
		<portlet:param name="locationId" value="<%= pageContext.getAttribute("locationId").toString() %>"/>
	</portlet:renderURL>
	
	<portlet:actionURL var="deleteLocationUrl">
		<portlet:param name="action" value="DeleteLocation"/>
		<portlet:param name="locationId" value="<%= pageContext.getAttribute("locationId").toString() %>"/>
	</portlet:actionURL>

	<ww:if test="#rowstatus.odd == true">
    	<div class="oddrow">
    </ww:if>
    <ww:else>
		<div class="evenrow">
    </ww:else>

       	<div class="columnLong">
       		<p class="portletHeadline"><a href="<c:out value="${locationUrl}"/>" title="Visa KalenderNamn"><ww:property value="name"/></a></p>
       	</div>
       	<div class="columnMedium">
       		<p>Anteckning</p>
       	</div>
       	<div class="columnEnd">
       		<a href="<c:out value="${deleteLocationUrl}"/>" title="Radera KalenderNamn" class="delete"></a>
       	   	<a href="<c:out value="${locationUrl}"/>" title="Redigera KalenderNamn" class="edit"></a>
       	</div>
       	<div class="clear"></div>
    </div>

</ww:iterator>

<%@ include file="adminFooter.jsp" %>
