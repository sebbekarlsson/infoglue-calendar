<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="calendar" prefix="calendar" %>

<c:set var="activeNavItem" value="Events" scope="page"/>
<c:set var="activeEventSubNavItem" value="EventSearch" scope="page"/>

<portlet:defineObjects/>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html;charset=utf-8">
		<ww:if test="CSSUrl != null">
			<style type="text/css" media="screen">@import url(<ww:property value="CSSUrl"/>);</style>
		</ww:if>
		<ww:else>
			<style type="text/css" media="screen">@import url(/infoglueCalendar/css/calendarPortlet.css);</style>
		</ww:else>

		<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/applications/jscalendar/skins/aqua/theme.css" title="aqua" />
		<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/applications/jscalendar/calendar-system.css" title="system" />

		<script type="text/javascript" src="<%=request.getContextPath()%>/script/dom-drag.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/script/infoglueCalendar.js"></script>

		<script type="text/javascript">
			function includeScript(url)
			{
			  document.write('<script type="text/javascript" src="' + url + '"></scr' + 'ipt>'); 
			}
		</script>

		<script type="text/javascript">
			//alert("Calendar:" + typeof(Calendar));
			if(typeof(Calendar) == 'undefined')
			{
				//alert("No calendar found - let's include it..");
				includeScript("<%=request.getContextPath()%>/applications/jscalendar/calendar.js");
				includeScript("<%=request.getContextPath()%>/applications/jscalendar/lang/calendar-en.js");
				includeScript("<%=request.getContextPath()%>/applications/jscalendar/calendar-setup.js");
			}
		</script>
	</head>
	<body>
