<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="calendar" prefix="calendar" %>

<portlet:defineObjects/>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendarPublic.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/calendar.js"></script>

<%--
<H1><ww:property value="event.calendar.name"/></H1>
<div class="newspadding">
<h2><ww:property value="event.name"/></h2>
<p><span class="calender">F&ouml;rel&auml;sare:</span> <ww:property value="event.lecturer"/></p>
<p>
	<span class="calender">Datum:</span> 
	<ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/> : <ww:property value="this.formatDate(event.startDateTime.time, 'HH')"/>
	<ww:property value="this.getLabel('labels.public.event.until')"/> 
	<ww:property value="this.formatDate(event.endDateTime.time, 'yyyy-MM-dd')"/> : <ww:property value="this.formatDate(event.endDateTime.time, 'HH')"/>	
</p>                             
<p>
	<ww:property value="event.shortDescription"/>
</p>
</div>

<p><span class="calender">Kategori:</span> Ekonomi </p>
<p><span class="calender">Arrang&ouml;r:</span> Handelsh&ouml;gskolan</p>
<p><span class="calender">Plats:</span> <ww:property value="event.customLocation"/></p>

<p>
	<span class="calender">Adress:</span>
	<ww:iterator value="event.locations">
		<ww:set name="location" value="top"/>
 		<ww:property value='#location.name'/>
    </ww:iterator>
</p>
<p>
	<span class="calender">Inneh&aring;ll: </span>
	<ww:property value="event.longDescription"/>
</p>

<p><span class="calender">Evenemangsl&auml;nk:</span> <a href="<ww:property value="event.eventUrl"/>"><ww:property value="event.eventUrl"/></a></p>
<p><span class="calender">Ytterliggare information:</span> <A 
href="mailto:<ww:property value="event.contactEmail"/>"><ww:property value="event.contactEmail"/></A></p>
<p><span class="calender">Ytterliggare information:</span><a href="tom.html" target="_blank" class="pdficon">AugustiAkademin</a></p>
<p><span class="calender">Sista anm&auml;lniongsdag:</span> <ww:property value="this.formatDate(event.lastRegistrationDateTime.time, 'yyyy-MM-dd')"/> : <ww:property value="this.formatDate(event.lastRegistrationDateTime.time, 'HH')"/></p>
<p><span class="calender">Avgift:</span> <ww:property value="event.price"/></p>
--%>

<div class="marginalizedDiv" id="inputForm">
		
	<span class="headline"><ww:property value="event.name"/></span>
	<hr/>
	<div id="contentList" style="display: block;">
		<p>
			<span class="calendarLabel"><ww:property value="this.getLabel('labels.public.event.organizerName')"/></span><br> 
			<span class="calendarValue"><ww:property value="event.organizerName"/></span>
		</p>
		<p>
			<span class="calendarLabel"><ww:property value="this.getLabel('labels.public.event.lecturer')"/></span><br> 
			<span class="calendarValue"><ww:property value="event.lecturer"/></span>
		</p>
		<p>
			<span class="calendarLabel"><ww:property value="this.getLabel('labels.public.event.customLocation')"/></span><br> 
			<span class="calendarValue"><ww:property value="event.customLocation"/></span>
		</p>
		<p>
			<span class="calendarLabel"><ww:property value="this.getLabel('labels.public.event.shortDescription')"/></span><br> 
			<span class="calendarValue"><ww:property value="event.shortDescription"/></span>
		</p>
		<p>
			<span class="calendarLabel"><ww:property value="this.getLabel('labels.public.event.longDescription')"/></span><br> 
			<span class="calendarValue"><ww:property value="event.longDescription"/></span>
		</p>
		<p>
			<span class="calendarLabel"><ww:property value="this.getLabel('labels.public.event.eventUrl')"/></span><br> 
			<span class="calendarValue"><ww:property value="event.eventUrl"/></span>
		</p>
		<p>
			<span class="calendarLabel"><ww:property value="this.getLabel('labels.public.event.contactEmail')"/></span><br> 
			<span class="calendarValue"><ww:property value="event.contactEmail"/></span>
		</p>
		<p>
			<span class="calendarLabel"><ww:property value="this.getLabel('labels.public.event.contactPhone')"/></span><br> 
			<span class="calendarValue"><ww:property value="event.contactPhone"/></span>
		</p>
		<p>
			<span class="calendarLabel"><ww:property value="this.getLabel('labels.public.event.contactName')"/></span><br> 
			<span class="calendarValue"><ww:property value="event.contactName"/></span>
		</p>
		<p>
			<span class="calendarLabel"><ww:property value="this.getLabel('labels.public.event.price')"/></span><br> 
			<span class="calendarValue"><ww:property value="event.price"/></span>
		</p>
		<p>
			<span class="calendarLabel"><ww:property value="this.getLabel('labels.public.event.maximumParticipants')"/></span><br> 
			<span class="calendarValue"><ww:property value="event.maxumumParticipants"/></span>
		</p>
		<p>
			<span class="calendarLabel"><ww:property value="this.getLabel('labels.public.event.lastRegistrationDate')"/></span><br> 
			<span class="calendarValue"><ww:property value="this.formatDate(event.lastRegistrationDateTime.time, 'yyyy-MM-dd')"/> : <ww:property value="this.formatDate(event.lastRegistrationDateTime.time, 'HH')"/></span>
		</p>
		
		
		<p>
			<span class="calendarLabel"><ww:property value="this.getLabel('labels.public.event.dateTime')"/></span><br>
			<span class="calendarValue">
			<ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/> : <ww:property value="this.formatDate(event.startDateTime.time, 'HH')"/>
			<ww:property value="this.getLabel('labels.public.event.until')"/> 
			<ww:property value="this.formatDate(event.endDateTime.time, 'yyyy-MM-dd')"/> : <ww:property value="this.formatDate(event.endDateTime.time, 'HH')"/>
			</span>
		</p>    			
   		<p>
      		<span class="calendarLabel"><ww:property value="this.getLabel('labels.public.event.location')"/></span><br>
			<span class="calendarValue">
			<ww:iterator value="event.locations">
	      		<ww:set name="location" value="top"/>
 				<ww:property value='#location.name'/>
      		</ww:iterator>
      		</span>
  		</p>
		<p>
      		<span class="calendarLabel"><ww:property value="this.getLabel('labels.public.event.category')"/></span><br>
			<span class="calendarValue">
			<ww:iterator value="event.categories">
	      		<ww:set name="category" value="top"/>
 				<ww:property value='#category.name'/>
      		</ww:iterator>
       		</span>
       	</p>
		<p>  		
  			<span class="calendarLabel"><ww:property value="this.getLabel('labels.public.event.participants')"/></span><br>
      		<span class="calendarValue">
      		<ww:iterator value="infogluePrincipals">
      			<ww:property value="top.firstName"/> <ww:property value="top.lastName"/>,
      		</ww:iterator>
 			</span>
 		</p>
		<p>
			<span class="calendarLabel"><ww:property value="this.getLabel('labels.public.event.files')"/></span><br>
			<span class="calendarValue">
			<ww:iterator value="event.resources">
				<ww:set name="resourceId" value="top.id" scope="page"/>
				<calendar:resourceUrl id="url" resourceId="${resourceId}"/>
					
				<a href="<c:out value="${url}"/>"><ww:property value='assetKey'/></a><br>     			
      		</ww:iterator>
			</span>
		</p>
		<p>
			<ww:set name="eventId" value="eventId" scope="page"/>
			<portlet:renderURL var="createEntryRenderURL">
				<calendar:evalParam name="action" value="CreateEntry!inputPublicGU"/>
				<calendar:evalParam name="eventId" value="${eventId}"/>
				<calendar:evalParam name="calendarId" value="${calendarId}"/>
				<calendar:evalParam name="mode" value="${mode}"/>
			</portlet:renderURL>
			
			<span class="calendarValue"><a href="<c:out value="${createEntryRenderURL}"/>"><ww:property value="this.getLabel('labels.public.event.signUp')"/></a></span>
		</p>
		
		<calendar:vCalendarUrl id="vCalendarUrl" eventId="${eventId}"/>
		<a href="<c:out value="${vCalendarUrl}"/>"><img src="<%=request.getContextPath()%>/images/calendarIcon.jpg" border="0"> Add to my calendar (vCal)</a>
		<hr/>
	</div>		

</div>
