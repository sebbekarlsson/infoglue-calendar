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
<%@ taglib uri="calendar" prefix="calendar" %>


<portlet:defineObjects/>

<ww:set name="languageCode" value="languageCode" scope="page"/>
<% 
	Locale locale = new Locale(pageContext.getAttribute("languageCode").toString());
	ResourceBundle resourceBundle = ResourceBundleHelper.getResourceBundle("infoglueCalendar", locale);
%>


<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendar.css" />
<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/applications/jscalendar/calendar-system.css" title="system" />

<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/calendar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/lang/calendar-en.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/calendar-setup.js"></script>

<script type="text/javascript">

	function showUploadForm()
	{
		document.getElementById("contentList").style.display = "none";
		document.getElementById("upload").style.display = "block";
	}

</script>

<div class="marginalizedDiv" id="inputForm">
		
	<span class="headline"><ww:property value="event.name"/></span>
	<hr/>
	<div id="contentList" style="display: block;">
		<p>
			<span class="label"><%= resourceBundle.getString("labels.public.event.descriptionLabel") %></span><br> 
			<ww:property value="event.description"/>
		</p>
		<p>
			<span class="label"><%= resourceBundle.getString("labels.public.event.dateTimeLabel") %></span><br>
			<ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/> : <ww:property value="this.formatDate(event.startDateTime.time, 'HH')"/>
			<%= resourceBundle.getString("labels.public.event.untilLabel") %> 
			<ww:property value="this.formatDate(event.endDateTime.time, 'yyyy-MM-dd')"/> : <ww:property value="this.formatDate(event.endDateTime.time, 'HH')"/>
		</p>    			
   		<p>
      		<span class="label"><%= resourceBundle.getString("labels.public.event.locationLabel") %></span><br>
			<ww:iterator value="event.locations">
	      		<ww:set name="location" value="top"/>
 				<ww:property value='#location.name'/>
      		</ww:iterator>
  		</p>
		<p>
      		<span class="label"><%= resourceBundle.getString("labels.public.event.categoryLabel") %></span><br>
			<ww:iterator value="event.categories">
	      		<ww:set name="category" value="top"/>
 				<ww:property value='#category.name'/>
      		</ww:iterator>
       	</p>
		<p>  		
  			<span class="label"><%= resourceBundle.getString("labels.public.event.participantsLabel") %></span><br>
      		<ww:iterator value="infogluePrincipals">
      			<ww:property value="top.firstName"/> <ww:property value="top.lastName"/>,
      		</ww:iterator>
 		</p>
		<p>
			<span class="label"><%= resourceBundle.getString("labels.public.event.filesLabel") %></span><br>
			<ww:iterator value="event.resources">
				<ww:set name="resourceId" value="top.id" scope="page"/>
				<calendar:resourceUrl id="url" resourceId="${resourceId}"/>
					
				<a href="<c:out value="${url}"/>"><ww:property value='assetKey'/></a><br>     			
      		</ww:iterator>
		</p>
		<p>
			<ww:set name="eventId" value="eventId" scope="page"/>
			<portlet:renderURL var="createEntryRenderURL">
				<portlet:param name="action" value="CreateEntry!inputPublic"/>
				<portlet:param name="eventId" value="<%= pageContext.getAttribute("eventId").toString() %>"/>
			</portlet:renderURL>
			
			<a href="<c:out value="${createEntryRenderURL}"/>"><%= resourceBundle.getString("labels.public.event.signUpLabel") %></a>
		</p>
		
		<calendar:vCalendarUrl id="vCalendarUrl" eventId="${eventId}"/>
		<a href="<c:out value="${vCalendarUrl}"/>"><img src="<%=request.getContextPath()%>/images/calendarIcon.jpg" border="0"> Add to my calendar (vCal)</a>
		<hr/>
	</div>		

</div>
