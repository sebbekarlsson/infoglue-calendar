<%@page import="org.infoglue.calendar.entities.Event"%>
<%@page import="java.util.List"%>
<%@ include file="externalBindingHeader.jsp" %>
	<c:set var="isIncluded" value="true"/>
	<%@ include file="viewExternalBindingEventSearchForm.jsp" %>
	<c:remove var="isIncluded"/>

	<div class="portlet_margin">
		<h1>
			<ww:property value="this.getLabel('labels.internal.event.searchResult')"/>
	    </h1>
	</div>
	<div class="columnlabelarea">
		<div class="columnMedium"><p><ww:property value="this.getLabel('labels.internal.event.name')"/></p></div>
		<div class="columnDate"><p><ww:property value="this.getLabel('labels.internal.event.startDate')"/></p></div>
		<div class="clear"></div>
	</div>

	<ww:set name="eventList" value="events" scope="page"/>

	<c:set var="eventsItems" value="${eventList}"/>
	<%
		@SuppressWarnings("unchecked")
		List<Event> events = (List<Event>)pageContext.getAttribute("eventsItems");
		if (events.size() > 100)
		{
			pageContext.setAttribute("truncated", true);
			pageContext.setAttribute("eventsItems", events.subList(0, 100));
		}
	%>

	<ww:iterator value="#attr.eventsItems" status="rowstatus">

		<ww:set name="eventId" value="id" scope="page"/>
		<ww:set name="event" value="top"/>
		<ww:set name="eventVersion" value="this.getMasterEventVersion('#event')"/>
		<ww:set name="eventVersion" value="this.getMasterEventVersion('#event')" scope="page"/>

		<ww:set name="eventName" value="name" scope="page"/>

		<c:set var="searchActionEvents"></c:set>

		<ww:if test="#rowstatus.odd == true"><c:set var="rowClass" value="oddrow"/></ww:if>
	    <ww:else><c:set var="rowClass" value="evenrow"/></ww:else>

		<div class="<c:out value="${rowClass}"/>" onclick="mark(<c:out value="${eventId}" />, '<ww:property value="#eventVersion.name"/>')" ondblclick="add(<c:out value="${eventId}" />, '<ww:property value="#eventVersion.name"/>')">
		   	<div class="columnMedium" >
		   		<p class="portletHeadline"><ww:property value="#event.versions.size"/></p>
		   	</div>
		   	<div class="columnMedium" >
		   		<p class="portletHeadline"><ww:property value="#eventVersion.name"/></p>
		   	</div>
		   	<div class="columnDate">
		   		<p><ww:property value="this.formatDate(startDateTime.time, 'yyyy-MM-dd')"/>&nbsp;</p>
		   	</div>
		   	<div class="clear"></div>
		</div>
	</ww:iterator>
	
	<c:if test="${truncated eq true}">
		<div class="portlet_margin">
			<p><ww:property value="this.getLabel('labels.internal.event.externalSearchTruncate')"/></p>
		</div>
	</c:if>

	<script type="text/javascript">
	<!--
	var selectedObject = {};
	function mark(entityId, path)
	{
		parent.markQualifyer(entityId, path);
	}
	function add(entityId, path)
	{
		parent.addQualifyer(entityId, path);
	}
	//-->
	</script>
<%@ include file="externalBindingFooter.jsp" %>