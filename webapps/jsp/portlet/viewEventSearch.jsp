<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="EventSearch" scope="page"/>

<%@ include file="adminHeader.jsp" %>
<%@ include file="functionMenu.jsp" %>

<div class="portlet_margin">
	<h1><ww:property value="this.getLabel('labels.internal.event.searchResult')"/></h1>
</div>

<div class="columnlabelarea">
	<div class="columnMedium"><p><ww:property value="this.getLabel('labels.internal.event.name')"/></p></div>
	<div class="columnMedium"><p><ww:property value="this.getLabel('labels.internal.event.description')"/></p></div>
	<div class="columnShort"><p><ww:property value="this.getLabel('labels.internal.event.owningCalendar')"/></p></div>
	<div class="columnShort"><p><ww:property value="this.getLabel('labels.internal.event.state')"/></p></div>
	<div class="columnDate"><p><ww:property value="this.getLabel('labels.internal.event.startDate')"/></p></div>
	<div class="clear"></div>
</div>

<portlet:renderURL var="viewListUrl">
	<portlet:param name="action" value="ViewEventSearch"/>
	<c:if test="${searchEventId != null}">
		<ww:iterator value="searchEventId">
			<ww:if test="top != null">
				<ww:set name="currentSearchEventId" value="top" scope="page"/>
				<portlet:param name="searchEventId" value="<%= pageContext.getAttribute("currentSearchEventId").toString() %>"/>
			</ww:if>
		</ww:iterator>
	</c:if>
	<c:if test="${searchFirstName != null}">
		<portlet:param name="searchFirstName" value="<%= pageContext.getAttribute("searchFirstName").toString() %>"/>
	</c:if>
	<c:if test="${searchLastName != null}">
		<portlet:param name="searchLastName" value="<%= pageContext.getAttribute("searchLastName").toString() %>"/>
	</c:if>
	<c:if test="${searchEmail != null}">
		<portlet:param name="searchEmail" value="<%= pageContext.getAttribute("searchEmail").toString() %>"/>
	</c:if>
</portlet:renderURL>

<script type="text/javascript">
	function submitDelete(okUrl, confirmMessage)
	{
		//alert("okUrl:" + okUrl);
		document.confirmForm.okUrl.value = okUrl;
		document.confirmForm.confirmMessage.value = confirmMessage;
		document.confirmForm.submit();
	}
</script>
<form name="confirmForm" action="<c:out value="${confirmUrl}"/>" method="post">
	<input type="hidden" name="confirmTitle" value="Radera - bekräfta"/>
	<input type="hidden" name="confirmMessage" value="Fixa detta"/>
	<input type="hidden" name="okUrl" value=""/>
	<input type="hidden" name="cancelUrl" value="<c:out value="${viewListUrl}"/>"/>	
</form>

<ww:iterator value="events" status="rowstatus">

	<ww:set name="eventId" value="id" scope="page"/>
	<ww:set name="event" value="top"/>
	<ww:set name="eventVersion" value="this.getMasterEventVersion('#event')"/>
	<ww:set name="eventVersion" value="this.getMasterEventVersion('#event')" scope="page"/>
	
	<ww:set name="name" value="name" scope="page"/>
	<portlet:renderURL var="eventUrl">
		<portlet:param name="action" value="ViewEvent"/>
		<portlet:param name="eventId" value="<%= pageContext.getAttribute("eventId").toString() %>"/>
	</portlet:renderURL>
	
	<portlet:actionURL var="deleteUrl">
		<portlet:param name="action" value="DeleteEvent"/>
		<portlet:param name="eventId" value="<%= pageContext.getAttribute("eventId").toString() %>"/>
	</portlet:actionURL>
		
	<ww:if test="#rowstatus.odd == true">
    	<div class="oddrow">
    </ww:if>
    <ww:else>
		<div class="evenrow">
    </ww:else>

	   	<div class="columnMedium">
	   		<p class="portletHeadline"><a href="<c:out value="${eventUrl}"/>" title="Visa '<ww:property value="#eventVersion.name"/>'"><ww:property value="#eventVersion.name"/></a></p>
	   	</div>
	   	<div class="columnMedium">
	   		<p><ww:property value="#eventVersion.shortDescription"/>&nbsp;</p>
	   	</div>
	   	<div class="columnShort">
	   		<p><ww:property value="owningCalendar.name"/>&nbsp;</p>
	   	</div>
	   	<div class="columnShort">
	   		<p><ww:property value="this.getState(stateId)"/>&nbsp;</p>
	   	</div>
	   	<div class="columnDate">
	   		<p><ww:property value="this.formatDate(startDateTime.time, 'yyyy-MM-dd')"/>&nbsp;</p>
	   	</div>
	   	<div class="columnEnd">
		   	<ww:if test="this.getIsEventOwner(top)">
		   		<a href="javascript:submitDelete('<c:out value="${deleteUrl}"/>', 'Är du säker på att du vill radera &quot;<ww:property value="#eventVersion.name"/>&quot;');" title="Radera '<ww:property value="#eventVersion.name"/>'" class="delete"></a>
		   	</ww:if>
	   	   	<a href="<c:out value="${eventUrl}"/>" title="Redigera '<ww:property value="#eventVersion.name"/>'" class="edit"></a>
	   	</div>
	   	<div class="clear"></div>
	</div>
</ww:iterator>

<ww:if test="events == null || events.size() == 0">
	<div class="oddrow">
		<div class="columnLong"><p class="portletHeadline"><ww:property value="this.getLabel('labels.internal.applicationNoItemsFound')"/></a></p></div>
       	<div class="columnMedium"></div>
       	<div class="columnEnd"></div>
       	<div class="clear"></div>
    </div>
</ww:if>

<%@ include file="adminFooter.jsp" %>