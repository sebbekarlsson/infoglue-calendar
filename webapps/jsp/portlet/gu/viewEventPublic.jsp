<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="calendar" prefix="calendar" %>

<portlet:defineObjects/>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendarPublic.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/calendar.js"></script>

<div class="marginalizedDiv" id="inputForm">
		
	<span class="headline"><ww:property value="event.name"/></span>
	<hr/>
	<div id="contentList" style="display: block;">
		<p>
			<span class="label"><ww:property value="this.getLabel('labels.public.event.organizerName')"/></span><br> 
			<ww:property value="event.organizerName"/>
		</p>
		<p>
			<span class="label"><ww:property value="this.getLabel('labels.public.event.lecturer')"/></span><br> 
			<ww:property value="event.lecturer"/>
		</p>
		<p>
			<span class="label"><ww:property value="this.getLabel('labels.public.event.customLocation')"/></span><br> 
			<ww:property value="event.customLocation"/>
		</p>
		<p>
			<span class="label"><ww:property value="this.getLabel('labels.public.event.shortDescription')"/></span><br> 
			<ww:property value="event.shortDescription"/>
		</p>
		<p>
			<span class="label"><ww:property value="this.getLabel('labels.public.event.longDescription')"/></span><br> 
			<ww:property value="event.longDescription"/>
		</p>
		<p>
			<span class="label"><ww:property value="this.getLabel('labels.public.event.eventUrl')"/></span><br> 
			<ww:property value="event.eventUrl"/>
		</p>
		<p>
			<span class="label"><ww:property value="this.getLabel('labels.public.event.contactEmail')"/></span><br> 
			<ww:property value="event.contactEmail"/>
		</p>
		<p>
			<span class="label"><ww:property value="this.getLabel('labels.public.event.contactPhone')"/></span><br> 
			<ww:property value="event.contactPhone"/>
		</p>
		<p>
			<span class="label"><ww:property value="this.getLabel('labels.public.event.contactName')"/></span><br> 
			<ww:property value="event.contactName"/>
		</p>
		<p>
			<span class="label"><ww:property value="this.getLabel('labels.public.event.price')"/></span><br> 
			<ww:property value="event.price"/>
		</p>
		<p>
			<span class="label"><ww:property value="this.getLabel('labels.public.event.maximumParticipants')"/></span><br> 
			<ww:property value="event.maximumParticipants"/>
		</p>
		<p>
			<span class="label"><ww:property value="this.getLabel('labels.public.event.lastRegistrationDate')"/></span><br> 
			<ww:property value="this.formatDate(event.lastRegistrationDateTime.time, 'yyyy-MM-dd')"/> : <ww:property value="this.formatDate(event.lastRegistrationDateTime.time, 'HH')"/>
		</p>
		
		
		<p>
			<span class="label"><ww:property value="this.getLabel('labels.public.event.dateTime')"/></span><br>
			
			<ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/> : <ww:property value="this.formatDate(event.startDateTime.time, 'HH')"/>
			<ww:property value="this.getLabel('labels.public.event.until')"/> 
			<ww:property value="this.formatDate(event.endDateTime.time, 'yyyy-MM-dd')"/> : <ww:property value="this.formatDate(event.endDateTime.time, 'HH')"/>
			
		</p>    			
   		<p>
      		<span class="label"><ww:property value="this.getLabel('labels.public.event.location')"/></span><br>
			
			<ww:iterator value="event.locations">
	      		<ww:set name="location" value="top"/>
 				<ww:property value='#location.name'/>
      		</ww:iterator>
      		
  		</p>
		<p>
      		<span class="label"><ww:property value="this.getLabel('labels.public.event.category')"/></span><br>
			
			<ww:iterator value="event.categories">
	      		<ww:set name="category" value="top"/>
 				<ww:property value='#category.name'/>
      		</ww:iterator>
       	</p>
		<p>  		
  			<span class="label"><ww:property value="this.getLabel('labels.public.event.participants')"/></span><br>
      		
      		<ww:iterator value="event.participants">
      			<ww:property value="top.name"/>,
      		</ww:iterator>
 		</p>
 		<p>
 			<ww:set name="puffImage" value="this.getResourceUrl(event, 'DetaljBild')"/>
			<ww:if test="#puffImage != null">
				<img src="<ww:property value="#puffImage"/>"/>
			</ww:if> 		
 		</p>
		<p>
			<span class="label"><ww:property value="this.getLabel('labels.public.event.files')"/></span><br>
			
			<ww:iterator value="event.resources">
				<ww:set name="resourceId" value="top.id" scope="page"/>
				<calendar:resourceUrl id="url" resourceId="${resourceId}"/>
					
				<a href="<c:out value="${url}"/>"><ww:property value='assetKey'/></a><br>     			
      		</ww:iterator>

			<ww:if test="event.resources == null || event.resources.size() == 0">
				<ww:property value="this.getLabel('labels.internal.event.noAttachments')"/><br>
			</ww:if>
		</p>
		<ww:if test="event.lastRegistrationDateTime.time.time > now.time.time">
			<ww:if test="event.maximumParticipants > event.entries.size()">
				<p>
					<ww:set name="eventId" value="eventId" scope="page"/>
					<portlet:renderURL var="createEntryRenderURL">
						<calendar:evalParam name="action" value="CreateEntry!inputPublicGU"/>
						<calendar:evalParam name="eventId" value="${eventId}"/>
						<calendar:evalParam name="calendarId" value="${calendarId}"/>
						<calendar:evalParam name="mode" value="${mode}"/>
					</portlet:renderURL>
					
					<a href="<c:out value="${createEntryRenderURL}"/>"><ww:property value="this.getLabel('labels.public.event.signUp')"/></a></span>
				</p>
			</ww:if>
			<ww:else>
				<p>
					<ww:property value="this.getLabel('labels.public.maximumEntriesReached.title')"/>
				</p>
			</ww:else>
		</ww:if>
		<ww:else>
		<p>
			<ww:property value="this.getLabel('labels.public.event.registrationExpired')"/>
		</p>
		</ww:else>
		<%--
		<calendar:vCalendarUrl id="vCalendarUrl" eventId="${eventId}"/>
		<a href="<c:out value="${vCalendarUrl}"/>"><img src="<%=request.getContextPath()%>/images/calendarIcon.jpg" border="0"> Add to my calendar (vCal)</a>
		--%>
	</div>		

</div>
