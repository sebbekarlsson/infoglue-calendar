<%@ page import="javax.portlet.PortletURL,
				 java.util.Map,
				 java.util.Iterator,
				 java.util.List,
				 java.util.Locale,
				 java.util.ResourceBundle,
				 org.infoglue.common.util.ResourceBundleHelper"%>

<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>


<portlet:defineObjects/>

<ww:set name="languageCode" value="languageCode" scope="page"/>
<% 
	Locale locale = new Locale(pageContext.getAttribute("languageCode").toString());
	ResourceBundle resourceBundle = ResourceBundleHelper.getResourceBundle("infoglueCalendar", locale);
%>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendar.css" />
<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/applications/jscalendar/calendar-system.css" title="system" />

<script type="text/javascript">
	
	function toggleSearchForm()
	{
		searchFormElement = document.getElementById("searchForm");
		hitListElement = document.getElementById("hitlist");
		if(searchFormElement.style.display == "none")
		{
			searchFormElement.style.display = "block";
			hitListElement.style.display = "none";
		}
		else
		{
			searchFormElement.style.display = "none";
			hitListElement.style.display = "block";
		}
	}
	
</script>

<div id="searchForm" class="marginalizedDiv" style="display: <ww:if test="entries == null">block</ww:if><ww:else>none</ww:else>;">

<span class="headline">Sök anmälan</span>
<hr/>

<portlet:renderURL var="searchEntryActionUrl">
	<portlet:param name="action" value="ViewEntrySearch"/>
</portlet:renderURL>
		
<form name="register" method="post" action="<c:out value="${searchEntryActionUrl}"/>">
<p>
<span class="subheadline">Fyll i ett eller flera fält som du vill söka på</span>
</p>

<div class="descriptionsmall">
	<span class="label">Events:</span>
    <select name="eventId" class="smallInput">
		<ww:iterator value="eventList">
		<option value="<ww:property value="id"/>"/><ww:property value="name"/></option>
		</ww:iterator>
    </select>
</div>

<div class="descriptionbig">
	<p>
	<span class="label">Förnamn:</span>
	<input type="text" size="40" name="firstName" id="firstName" class="smallInput" value="<ww:property value="firstName"/>" />
	</p>
	<p>
	<span class="label">Efternamn:</span>
	<input type="text" size="40" name="lastName" id="lastName" class="smallInput" value="<ww:property value="lastName"/>" />		
	</p>
	<p>
	<span class="label">Email:</span>
	<input type="text" size="40" name="email" id="email" class="smallInput" value="<ww:property value="email"/>" />		
	</p>
</div>
<div class="descriptionsmall">
	<div class="label">
		Kategorier (kryssa i dom du vill filtrera på):
	</div>		
	<div class="category">
	<ww:iterator value="categoryList">
		<input type="checkbox" name="categoryId" value="<ww:property value="id"/>"/><ww:property value="name"/>
	</ww:iterator>
	</div>
</div>
<div style="height:10px"></div>
<div class="descriptionsmall">
	<div class="label">
		Platser (kryssa i dom du vill filtrera på):
	</div>		
	<div class="locations">
	<ww:iterator value="locationList">
		<input type="checkbox" name="locationId" value="<ww:property value="id"/>"/><ww:property value="name"/>
	</ww:iterator>
	</div>
</div>
<div style="height:10px"></div>
<input type="submit" value="Sök"/>
<hr/>
</div>

<div id="hitlist" class="marginalizedDiv" style="display: <ww:if test="entries == null">none</ww:if><ww:else>block</ww:else>;">
<span class="headline">Sök anmälan</span>

<hr/>

<p>
	<span class="subheadline">Träfflista</span>
</p>

<table border="0" width="100%" cellpadding="2" cellspacing="0">
<tr>
<th>ID</th>
<th>Namn</th>
<th>Actions</th>
</tr>

<ww:iterator value="entries">
	<ww:set name="entryId" value="id" scope="page"/>
	<portlet:renderURL var="viewEntryRenderURL">
		<portlet:param name="action" value="ViewEntry"/>
		<portlet:param name="entryId" value="<%= pageContext.getAttribute("entryId").toString() %>"/>
	</portlet:renderURL>

	<portlet:actionURL var="deleteEntryUrl">
		<portlet:param name="action" value="DeleteEntry"/>
		<portlet:param name="entryId" value="<%= pageContext.getAttribute("entryId").toString() %>"/>
	</portlet:actionURL>

<tr>
	<td><ww:property value="id"/></td>
	<td><a href="<c:out value="${viewEntryRenderURL}"/>"><ww:property value="firstName"/> <ww:property value="lastName"/></a></td>
	<td>
		
		<a href="<c:out value="${viewEntryRenderURL}"/>">Ändra</a>
		<a href="<c:out value="${deleteEntryUrl}"/>">Ta bort</a>
	</td>		
</tr>
</ww:iterator>

<ww:if test="entries == null || entries.size() == 0">
<tr>
	<td colspan="3">Inga poster hittades</td>
</tr>
</ww:if>
</table>

<portlet:renderURL var="createEntryRenderURL">
	<portlet:param name="action" value="CreateEntry!input"/>
	<portlet:param name="eventId" value="1"/>
</portlet:renderURL>

	<div style="height:10px"></div>
	<a href="javascript:toggleSearchForm('searchForm');">New search</a>
</form>
<hr/>
</div>
