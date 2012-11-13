<%@page import="org.infoglue.calendar.entities.Event"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="calendar" prefix="calendar" %>
<c:set var="activeNavItem" value="Events" scope="page"/>
<c:set var="activeEventSubNavItem" value="EventSearch" scope="page"/>
<portlet:defineObjects/>
<!DOCTYPE html>
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

		<style type="text/css">
			.fieldrow input {font-size:100%;}
			.column_name {width:75%;}
			.column_date {width:25%;}
			.selected, .selected:hover {background-color:darkgrey;}
		</style>

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
		<div class="portlet_margin">
			<h1><ww:property value="this.getLabel('labels.internal.event.searchIntro')"/></h1>

			<portlet:renderURL var="searchEntryActionUrl">
				<portlet:param name="action" value="ViewEventSearch!externalBindingSearch" />
			</portlet:renderURL>

			<form name="register" method="post" action="<c:out value="${searchEntryActionUrl}"/>">
				<calendar:textField label="labels.internal.event.name" name="'name'" value="name" cssClass="longtextfield"/>

				<span class="errorMessage"><ww:property value="#fieldErrors.startDateTime"/></span>
				<div class="fieldrow">
					<label id="startDateTimeLabel">
						<ww:property value="this.getLabel('labels.internal.event.searchStartDate')"/><br />
						<input id="startDateTime" readonly="readonly" name="startDateTime" value="<ww:property value="startDateTime"/>" class="datefield" type="textfield">
						<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_startDateTime" style="border: 0px solid black; cursor: pointer;" title="Date selector">
					</label>
					<input name="startTime" value="<ww:property value="startTime"/>" class="hourfield" type="hidden">
				</div>

				<span class="errorMessage"><ww:property value="#fieldErrors.endDateTime"/></span>
				<div class="fieldrow">
					<label id="endDateTimeLabel">
						<ww:property value="this.getLabel('labels.internal.event.searchEndDate')"/><br />
						<input id="endDateTime" readonly="readonly" name="endDateTime" value="<ww:property value="endDateTime"/>" class="datefield" type="textfield">
						<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_endDateTime" style="border: 0px solid black; cursor: pointer;" title="Date selector">
					</label>
					<input name="endTime" value="<ww:property value="endTime"/>" class="hourfield" type="hidden">
				</div>

				<calendar:selectField label="labels.internal.calendar.eventType" name="'categoryId'" headerItem="Filtrera på evenemangstyp" multiple="true" value="categoriesList" selectedValue="categoryId" cssClass="listBox"/>

				<calendar:selectField label="labels.internal.event.owningCalendar" name="'calendarId'" headerItem="Filtrera på huvudkalender" multiple="true" value="calendarList" selectedValue="calendarId" cssClass="listBox"/>
			<div style="height:10px"></div>
			<input type="submit" value="<ww:property value="this.getLabel('labels.internal.soba.searchButton')"/>" class="button"/>
			</form>
		</div>

		<script type="text/javascript">
		    Calendar.setup({
		        inputField     :    "startDateTime",     // id of the input field
		        ifFormat       :    "%Y-%m-%d",      // format of the input field
		        button         :    "startDateTimeLabel",  // trigger for the calendar (button ID)
		        align          :    "BR",           // alignment (defaults to "Bl")
		        singleClick    :    true,
		        cache          :    true,
		        firstDay  	   : 	1
		    });
		</script>

		<script type="text/javascript">
		    Calendar.setup({
		        inputField     :    "endDateTime",     // id of the input field
		        ifFormat       :    "%Y-%m-%d",      // format of the input field
		        button         :    "endDateTimeLabel",  // trigger for the calendar (button ID)
		        align          :    "BR",           // alignment (defaults to "Bl")
		        singleClick    :    true,
		        cache          :    true,
		        firstDay  	   : 	1
		    });
		</script>

		<ww:set name="eventList" value="events" scope="page"/>
		<%
			@SuppressWarnings("unchecked")
			List<Event> events = (List<Event>)pageContext.getAttribute("eventList");

			if (events == null)
			{
				pageContext.setAttribute("showResult", false);
			}
			else
			{
				if (events.size() > 100)
				{
					pageContext.setAttribute("truncated", true);
					pageContext.setAttribute("eventsItems", events.subList(0, 100));
					pageContext.setAttribute("resultListSize", 100);
				}
				else
				{
					pageContext.setAttribute("resultListSize", events.size());
				}
			}
		%>

		<c:if test="${showResult ne false}">
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

			<c:choose>
				<c:when test="${resultListSize eq 0}">
					<div class="portlet_margin">
						<p><ww:property value="this.getLabel('labels.internal.event.externalSearchNoResult')"/></p>
					</div>
				</c:when>
				<c:otherwise>
					<ww:iterator value="events" status="rowstatus">
						<ww:set name="eventId" value="id" scope="page"/>
						<ww:set name="event" value="top"/>
						<ww:set name="eventVersion" value="this.getMasterEventVersion('#event')"/>
						<ww:set name="eventVersion" value="this.getMasterEventVersion('#event')" scope="page"/>

						<ww:set name="eventName" value="name" scope="page"/>

						<c:set var="searchActionEvents"></c:set>

						<ww:if test="#rowstatus.odd == true"><c:set var="rowClass" value="oddrow"/></ww:if>
					    <ww:else><c:set var="rowClass" value="evenrow"/></ww:else>

						<div class="<c:out value="${rowClass}"/>" onclick="mark(this, <c:out value="${eventId}" />, '<ww:property value="#eventVersion.name"/>')" ondblclick="add(<c:out value="${eventId}" />, '<ww:property value="#eventVersion.name"/>')">
						   	<div class="column_name" >
						   		<p class="portletHeadline">
						   			<ww:property value="#eventVersion.name"/>
						   			(<ww:iterator value="#event.versions" status="rowstatus"><ww:property value="top.language.isoCode"/><ww:if test="!#rowstatus.last">,&nbsp;</ww:if></ww:iterator>)
						   		</p>
						   	</div>
						   	<div class="column_date">
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
					function addClass( classname, element ) {
					    var cn = element.className;
					    if( cn.indexOf( classname ) != -1 ) {
					    	return;
					    }
					    if( cn != '' ) {
					    	classname = ' '+classname;
					    }
					    element.className = cn+classname;
					}

					function removeClass( classname, element ) {
					    var cn = element.className;
					    var rxp = new RegExp( "\\s?\\b"+classname+"\\b", "g" );
					    cn = cn.replace( rxp, '' );
					    element.className = cn;
					}

					var selectedObject = {};
					var selectedElement;
					function mark(element, entityId, path)
					{
						if (selectedElement)
						{
							removeClass("selected", selectedElement);
						}
						selectedElement = element;
						addClass("selected", selectedElement);
						parent.markQualifyer(entityId, path);
					}
					function add(entityId, path)
					{
						if (selectedElement)
						{
							removeClass( "selected", selectedElement );
							selectedElement = null;
						}
						parent.addQualifyer(entityId, path);
					}
					//-->
					</script>
				</c:otherwise>
			</c:choose>
		</c:if>
	</body>
</html>