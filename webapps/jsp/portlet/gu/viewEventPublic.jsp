<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="calendar" prefix="calendar" %>

<portlet:defineObjects/>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendarPublic.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/applications/jscalendar/calendar.js"></script>

<div class="inputDiv">
		
	<h1><ww:property value="event.name"/></h1>
	<hr/>
	<div id="portlet_margin">
		<p>
			<calendar:textValue label="labels.public.event.organizerName" value="event.organizerName" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.public.event.lecturer" value="event.lecturer" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.public.event.customLocation" value="event.customLocation" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.public.event.shortDescription" value="event.shortDescription" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.public.event.longDescription" value="event.longDescription" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.public.event.eventUrl" value="event.eventUrl" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.public.event.contactEmail" value="event.contactEmail" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.public.event.contactPhone" value="event.contactPhone" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.public.event.contactName" value="event.contactName" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.public.event.price" value="event.price" labelCssClass="label"/>
		</p>
		<p>
			<calendar:textValue label="labels.public.event.maximumParticipants" value="event.maximumParticipants" labelCssClass="label"/>
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
