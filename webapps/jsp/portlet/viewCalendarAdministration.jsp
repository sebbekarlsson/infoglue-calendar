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
	<title>Calendar Administration</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendar.css" />
</head>

<body>

<div id="list">

	<div id="contentListHeader">
		Calendars sss
	</div>
	
	<%=renderResponse.encodeURL(renderRequest.getContextPath() + "/images/no.gif")%>
	<%	
		PortletURL url = renderResponse.createActionURL();
		url.setParameter("action", "ViewCalendar");
        url.setParameter("calendarId", "1");

		PortletURL url2 = renderResponse.createRenderURL();
		url2.setParameter("action", "ViewCalendar");
        url2.setParameter("calendarId", "1");
    %>    
    <%=url%>
    <%=url2%>
	<a href="<%=url%>">Test</a>
	<a href="<%=url2%>">Test2</a>
	
	<div id="contentList">
		<ww:iterator value="administrationUCCBean.calendars" status="rowstatus">
		<p>
			<ww:if test="#rowstatus.odd == true">
		    	<span class="marked"><ww:property value="id"/>.<a href="ViewCalendar.action?calendarId=<ww:property value="id"/>"><ww:property value="name"/></a> : <a href="ViewCalendar.action?calendarId=<ww:property value="id"/>">Edit</a> : <a href="DeleteCalendar.action?calendarId=<ww:property value="id"/>">Delete</a></span>
		    </ww:if>
		    <ww:else>
		    	<span><ww:property value="id"/>.<a href="ViewCalendar.action?calendarId=<ww:property value="id"/>"><ww:property value="name"/></a> : <a href="ViewCalendar.action?calendarId=<ww:property value="id"/>">Edit</a> : <a href="DeleteCalendar.action?calendarId=<ww:property value="id"/>">Delete</a></span>
		    </ww:else>
		</p>
		</ww:iterator>
	</div>

	<div id="contentListFooter">
		<a href="CreateCalendar!input.action">Add Calendar</a>
	</div>
</div>

<div id="list">

	<div id="contentListHeader">
		Locations
	</div>

	<div id="contentList">
		<ww:iterator value="administrationUCCBean.locations" status="rowstatus">
		<p>
			<ww:if test="#rowstatus.odd == true">
		    	<span class="marked"><ww:property value="id"/>.<ww:property value="name"/> : <a href="ViewLocation.action?locationId=<ww:property value="id"/>">Edit</a> : <a href="DeleteLocation.action?locationId=<ww:property value="id"/>">Delete</a></span>
		    </ww:if>
		    <ww:else>
		    	<span><ww:property value="id"/>.<ww:property value="name"/> : <a href="ViewLocation.action?locationId=<ww:property value="id"/>">Edit</a> : <a href="DeleteLocation.action?locationId=<ww:property value="id"/>">Delete</a></span>
		    </ww:else>
		</p>
		</ww:iterator>
	</div>

	<div id="contentListFooter">
		<a href="CreateLocation!input.action">Add Location</a>
	</div>
</div>

<div id="list">

	<div id="contentListHeader">
		Categories
	</div>

	<div id="contentList">
		<ww:iterator value="administrationUCCBean.categories" status="rowstatus">
		<p>
			<ww:if test="#rowstatus.odd == true">
		    	<span class="marked"><ww:property value="id"/>.<ww:property value="name"/> : <a href="ViewCategory.action?categoryId=<ww:property value="id"/>">Edit</a> : <a href="DeleteCategory.action?categoryId=<ww:property value="id"/>">Delete</a></span>
		    </ww:if>
		    <ww:else>
		    	<span><ww:property value="id"/>.<ww:property value="name"/> : <a href="ViewCategory.action?categoryId=<ww:property value="id"/>">Edit</a> : <a href="DeleteCategory.action?categoryId=<ww:property value="id"/>">Delete</a></span>
		    </ww:else>
		</p>
		</ww:iterator>
	</div>

	<div id="contentListFooter">
		<a href="CreateCategory!input.action">Add Category</a>
	</div>
</div>


</body>
</html>
