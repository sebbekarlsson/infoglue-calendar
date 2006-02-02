<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="calendar" prefix="calendar" %>

<portlet:defineObjects/>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="sv">

	<head>
		<title><ww:property value="this.getLabel('labels.internal.applicationTitle')"/></title>
		<meta http-equiv="content-type" content="text/html;charset=utf-8">
		<style type="text/css" media="screen">@import url(http://gu4.modul1.tripnet.se:8081/infoglueDeliverWorking/ViewPage.action?siteNodeId=101891&amp;languageId=100000&amp;contentId=-1);</style>

		<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/applications/jscalendar/calendar-system.css" title="system" />
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/calendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/lang/calendar-en.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/calendar-setup.js"></script>
		<style type="text/css">
			.errorMessage {
			    color: red;
			}
			
		</style>

		<script type="text/javascript">
		
			function linkEvent(calendarId)
			{
				document.getElementById("calendarId").value = calendarId;
				document.linkForm.submit();
			}
		
			function createEventFromCopy(action)
			{
				document.updateForm.action = action;
				document.updateForm.submit();
			} 

			function deleteResource(resourceId)
			{
				document.deleteResourceForm.resourceId.value = resourceId;
				document.deleteResourceForm.submit();
			} 
		
		</script>

	</head>

<body aonload="resize();">

<div class="calApp">

<div class="portlet">

<div class="head">
	<span class="left">
		<ww:property value="this.getLabel('labels.internal.applicationTitle')"/>
	</span>	
	<span class="right">	
		<ww:property value="this.getInfoGluePrincipal().firstName"/> <ww:property value="this.getInfoGluePrincipal().lastName"/> | <a href="<ww:property value="logoutUrl"/>">Logga ut</a>
	</span>
    <div class="clear"></div>
</div>
