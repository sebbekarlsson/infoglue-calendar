<%@ page import="javax.portlet.PortletURL,
				 java.util.Map,
				 java.util.Iterator,
				 java.util.List"%>

<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<portlet:defineObjects/>

<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Entry Search</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
</head>

<body>

<div id="searchForm" style="display: <ww:if test="entries == null">block</ww:if><ww:else>none</ww:else>;">

<h1>Sök anmälan</h1>
<hr/>

<portlet:renderURL var="searchEntryActionUrl">
	<portlet:param name="action" value="ViewEntrySearch"/>
</portlet:renderURL>
		
<form name="register" method="post" action="<c:out value="${searchEntryActionUrl}"/>">
<h4>Sök efter anmälningar</h4>

<div class="descriptionsmall">
	Events:
    <select name="eventId" class="smallInput">
		<ww:iterator value="eventList">
		<option value="<ww:property value="id"/>"/><ww:property value="name"/></option>
		</ww:iterator>
    </select>
</div>

<div class="descriptionbig">
		<p>
		Förnamn:
		<input type="text" size="40" name="firstName" id="firstName" class="smallInput" value="<ww:property value="firstName"/>" />
		</p>
		<p>
		Efternamn:
		<input type="text" size="40" name="lastName" id="lastName" class="smallInput" value="<ww:property value="lastName"/>" />		
		</p>
		<p>
		Email: 
		<input type="text" size="40" name="email" id="email" class="smallInput" value="<ww:property value="email"/>" />		
		</p>
</div>
<div class="descriptionsmall">
	<div class="category">
		Categories:
	</div>		
	<div class="category">
	<ww:iterator value="categoryList">
		<input type="checkbox" name="categoryId" value="<ww:property value="id"/>"/><ww:property value="name"/>
	</ww:iterator>
	</div>
</div>
<div style="height:10px"></div>
<div class="descriptionsmall">
	<div class="location">
		Locations:
	</div>		
	<div class="locations">
	<ww:iterator value="locationList">
		<input type="checkbox" name="locationId" value="<ww:property value="id"/>"/><ww:property value="name"/>
	</ww:iterator>
	</div>
</div>
<div style="height:10px"></div>
<input type="submit" value="Sök"/>
</div>

<div id="hitlist" style="display: <ww:if test="entries == null">none</ww:if><ww:else>block</ww:else>;">
<h1>Sök anmälan</h1>

<hr/>

<h4>Träfflista</h4>

<table border="0" width="100%">
<tr>
<th>ID</th>
<th>Name</th>
<th>Actions</th>
</tr>

<ww:iterator value="entries">
<tr>
	<td><ww:property value="id"/></td>
	<td><a href="<c:out value="${viewEntryRenderURL}"/>"><ww:property value="firstName"/> <ww:property value="lastName"/></a></td>
	<td>
		<ww:set name="entryId" value="id" scope="page"/>
		<portlet:renderURL var="viewEntryRenderURL">
			<portlet:param name="action" value="ViewEntry"/>
			<portlet:param name="entryId" value="<%= pageContext.getAttribute("entryId").toString() %>"/>
		</portlet:renderURL>

		<portlet:actionURL var="deleteEntryUrl">
			<portlet:param name="action" value="DeleteEntry"/>
			<portlet:param name="entryId" value="<%= pageContext.getAttribute("entryId").toString() %>"/>
		</portlet:actionURL>
		
		<a href="<c:out value="${viewEntryRenderURL}"/>">Ändra</a>
		<a href="<c:out value="${deleteEntryUrl}"/>">Ta bort</a>
	</td>		
</tr>
</ww:iterator>

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

</body>
</html>
