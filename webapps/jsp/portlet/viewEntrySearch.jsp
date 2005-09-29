<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="EntrySearch" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendar.css" />
<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/applications/jscalendar/calendar-system.css" title="system" />

<script type="text/javascript">
	
	function toggleSearchForm()
	{
		searchFormElement = document.getElementById("searchForm");
		emailFormElement = document.getElementById("emailForm");
		hitListElement = document.getElementById("hitlist");
		if(searchFormElement.style.display == "none")
		{
			searchFormElement.style.display = "block";
			hitListElement.style.display = "none";
			emailFormElement.style.display = "none";
		}
		else
		{
			searchFormElement.style.display = "none";
			hitListElement.style.display = "block";
			emailFormElement.style.display = "none";
		}
	}

	function toggleEmailForm()
	{
		emailFormElement = document.getElementById("emailForm");
		hitListElement = document.getElementById("hitlist");
		searchFormElement = document.getElementById("searchForm");
		if(emailFormElement.style.display == "none")
		{
			emailFormElement.style.display = "block";
			searchFormElement.style.display = "none";
			hitListElement.style.display = "none";
		}
		else
		{
			emailFormElement.style.display = "none";
			searchFormElement.style.display = "none";
			hitListElement.style.display = "block";
		}
	}
	
</script>

<div id="searchForm" class="marginalizedDiv" style="display: <ww:if test="entries == null">block</ww:if><ww:else>none</ww:else>;">

<span class="headline"><ww:property value="this.getLabel('labels.internal.soba.searchEntries')"/></span>

<portlet:renderURL var="searchEntryActionUrl">
	<portlet:param name="action" value="ViewEntrySearch"/>
</portlet:renderURL>
		
<form name="register" method="post" action="<c:out value="${searchEntryActionUrl}"/>">
<p>
<span class="subheadline"><ww:property value="this.getLabel('labels.internal.soba.searchIntro')"/></span>
</p>

<div class="descriptionsmall">

	<span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.soba.events')"/></span>
    <select name="searchEventId" class="smallInput">
		<option value=""/><ww:property value="this.getLabel('labels.internal.soba.anyEvent')"/></option>
		<option value=""/>--------------------</option>
		<ww:iterator value="eventList">
		<option value="<ww:property value="id"/>"/><ww:property value="name"/></option>
		</ww:iterator>
    </select>
</div>

<div class="descriptionbig">
	<p>
	<span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.soba.firstName')"/></span>
	<input type="text" size="40" name="searchFirstName" id="searchFirstName" class="smallInput" value="<ww:property value="firstName"/>" />
	</p>
	<p>
	<span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.soba.lastName')"/></span>
	<input type="text" size="40" name="searchLastName" id="searchLastName" class="smallInput" value="<ww:property value="lastName"/>" />		
	</p>
	<p>
	<span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.soba.email')"/></span>
	<input type="text" size="40" name="searchEmail" id="searchEmail" class="smallInput" value="<ww:property value="email"/>" />		
	</p>
</div>
<div class="descriptionsmall">
	<div class="calendarLabel">
		<ww:property value="this.getLabel('labels.internal.soba.categories')"/>
	</div>		
	<div class="category">
	<%--	
	
		<ww:iterator value="event.calendar.eventType.categoryAttributes" status="rowstatus">
		<p>
			<ww:set name="categoryAttribute" value="top" scope="page"/>
			<ww:set name="categoryAttributeIndex" value="#rowstatus.index" scope="page"/>
			<ww:set name="selectedCategories" value="this.getEventCategories(top)"/>
			<c:set var="categoryAttributeName" value="categoryAttribute_${categoryAttribute.id}_categoryId"/>
			<input type="hidden" name="categoryAttributeId_<ww:property value="#rowstatus.index"/>" value="<ww:property value="top.id"/>"/>
			<calendar:selectField label="categoryAttribute.name" name="${categoryAttributeName}" multiple="true" value="top.category.children" selectedValueList="#selectedCategories" cssClass="listBox"/>
   		</p>
		</ww:iterator>
	<ww:iterator value="categoryList">
		<input type="checkbox" name="categoryId" value="<ww:property value="id"/>"/><ww:property value="name"/>
	</ww:iterator>
	--%>
	</div>
</div>
<div style="height:10px"></div>
<div class="descriptionsmall">
	<div class="calendarLabel">
		<ww:property value="this.getLabel('labels.internal.soba.locations')"/>
	</div>		
	<div class="locations">
	<ww:iterator value="locationList">
		<input type="checkbox" name="locationId" value="<ww:property value="id"/>"/><ww:property value="name"/>
	</ww:iterator>
	</div>
</div>
<div style="height:10px"></div>
<input type="submit" value="<ww:property value="this.getLabel('labels.internal.soba.searchButton')"/>" class="calendarButton"/>
</form>
<hr/>
</div>


<div id="emailForm" class="marginalizedDiv" style="display: none;">

<span class="headline"><ww:property value="this.getLabel('labels.internal.soba.emailPersons')"/></span>
<hr/>

<portlet:actionURL var="emailActionUrl">
	<portlet:param name="action" value="EmailEntries"/>
</portlet:actionURL>
		
<form name="email" method="post" action="<c:out value="${emailActionUrl}"/>">
	<input type="hidden" name="searchEventId" value="<ww:property value="searchEventId"/>">
	<input type="hidden" name="searchFirstName" value="<ww:property value="searchFirstName"/>">
	<input type="hidden" name="searchLastName" value="<ww:property value="searchLastName"/>">
	<input type="hidden" name="searchEmail" value="<ww:property value="searchEmail"/>">

<p>
<span class="subheadline"><ww:property value="this.getLabel('labels.internal.soba.emailIntro')"/></span>
</p>

<div class="descriptionsmall">
	<span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.soba.addresses')"/></span><br>
    <input type="textfield" name="emailAddresses" class="normalInput" value="<ww:property value="emailAddresses"/>">
</div>

<div class="descriptionsmall">
	<span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.soba.subject')"/></span><br>
    <input type="textfield" name="subject" class="normalInput" value="<ww:property value="subject"/>">
</div>

<div class="descriptionbig">
	<p>
	<ww:property value="this.getLabel('labels.internal.soba.message')"/><br>
	<textarea name="message"></textarea>
	</p>
</div>
<div style="height:10px"></div>
<input type="submit" value="<ww:property value="this.getLabel('labels.internal.soba.sendMessage')"/>" class="calendarButton"/>
</form>
</div>


<div id="hitlist" class="marginalizedDiv" style="display: <ww:if test="entries == null">none</ww:if><ww:else>block</ww:else>;">
<span class="headline"><ww:property value="this.getLabel('labels.internal.soba.searchEntries')"/></span>

<p>
	<span class="subheadline"><ww:property value="this.getLabel('labels.internal.soba.hitList')"/></span>
</p>

<table border="0" width="100%" cellpadding="2" cellspacing="0">
<tr>
<th><ww:property value="this.getLabel('labels.internal.soba.idColumnHeader')"/></th>
<th><ww:property value="this.getLabel('labels.internal.soba.nameColumnHeader')"/></th>
<th><ww:property value="this.getLabel('labels.internal.soba.actionColumnHeader')"/></th>
</tr>

<ww:iterator value="entries">
	<ww:set name="entryId" value="id" scope="page"/>
	<ww:set name="searchEventId" value="searchEventId" scope="page"/>
	<ww:set name="searchFirstName" value="searchFirstName" scope="page"/>
	<ww:set name="searchLastName" value="searchLastName" scope="page"/>
	<ww:set name="searchEmail" value="searchEmail" scope="page"/>
	<portlet:renderURL var="viewEntryRenderURL">
		<portlet:param name="action" value="ViewEntry"/>
		<portlet:param name="entryId" value="<%= pageContext.getAttribute("entryId").toString() %>"/>
		<portlet:param name="searchEventId" value="<%= pageContext.getAttribute("searchEventId").toString() %>"/>
	</portlet:renderURL>

	<portlet:actionURL var="deleteEntryUrl">
		<portlet:param name="action" value="DeleteEntry"/>
		<portlet:param name="entryId" value="<%= pageContext.getAttribute("entryId").toString() %>"/>
		<portlet:param name="searchEventId" value="<%= pageContext.getAttribute("searchEventId").toString() %>"/>
		<portlet:param name="searchFirstName" value="<%= pageContext.getAttribute("searchFirstName").toString() %>"/>
		<portlet:param name="searchLastName" value="<%= pageContext.getAttribute("searchLastName").toString() %>"/>
		<portlet:param name="searchEmail" value="<%= pageContext.getAttribute("searchEmail").toString() %>"/>
	</portlet:actionURL>

<tr>
	<td><ww:property value="id"/></td>
	<td><a href="<c:out value="${viewEntryRenderURL}"/>"><ww:property value="firstName"/> <ww:property value="lastName"/></a></td>
	<td>
		
		<a href="<c:out value="${viewEntryRenderURL}"/>"><ww:property value="this.getLabel('labels.internal.soba.edit')"/></a>
		<a href="<c:out value="${deleteEntryUrl}"/>"><ww:property value="this.getLabel('labels.internal.soba.delete')"/></a>
	</td>		
</tr>
</ww:iterator>

<ww:if test="entries == null || entries.size() == 0">
<tr>
	<td colspan="3"><ww:property value="this.getLabel('labels.internal.soba.noHits')"/></td>
</tr>
</ww:if>
</table>

<portlet:renderURL var="createEntryRenderURL">
	<portlet:param name="action" value="CreateEntry!input"/>
	<portlet:param name="eventId" value="1"/>
</portlet:renderURL>

	<div style="height:10px"></div>
	<a href="javascript:toggleSearchForm();"><ww:property value="this.getLabel('labels.internal.soba.newSearch')"/></a>
	<ww:if test="entries != null"><a href="javascript:toggleEmailForm();"><ww:property value="this.getLabel('labels.internal.soba.emailPersons')"/></a></ww:if>
</div>

<%@ include file="adminFooter.jsp" %>