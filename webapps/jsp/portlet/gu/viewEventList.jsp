<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="calendar" prefix="calendar" %>

<portlet:defineObjects/>

<ww:set name="languageCode" value="this.getLanguageCode()"/>

<H1>Kalendarium</H1>
<!-- Calendar start -->
<div class="calendar">   

	<ww:if test="#attr.detailUrl.indexOf('?') > -1">
		<c:set var="delim" value="&"/>
	</ww:if>
	<ww:else>
		<c:set var="delim" value="?"/>
	</ww:else>

	<ww:iterator value="events" status="rowstatus">
	
		<ww:set name="event" value="top"/>
		<ww:set name="eventVersion" value="this.getEventVersion('#event')"/>
		<ww:set name="eventVersion" value="this.getEventVersion('#event')" scope="page"/>
		<ww:set name="eventId" value="id" scope="page"/>
		<portlet:renderURL var="eventDetailUrl">
			<portlet:param name="action" value="ViewEvent!publicGU"/>
			<portlet:param name="eventId" value="<%= pageContext.getAttribute("eventId").toString() %>"/>
		</portlet:renderURL>
	        
	    <ww:iterator value="top.owningCalendar.eventType.categoryAttributes">
			<ww:if test="top.name == 'Evenemangstyp' || top.name == 'Eventtyp'">
				<ww:set name="selectedCategories" value="this.getEventCategories('#event', top)"/>
				<ww:iterator value="#selectedCategories" status="rowstatus">
					<ww:set name="visibleCategoryName" value="top.getLocalizedName(#languageCode, 'sv')"/>
				</ww:iterator>
			</ww:if>
   		</ww:iterator>
   		                 
		<!-- Record Start -->
		<div class="recordLine">
			<span class="categoryLabelSmall">
				<ww:iterator value="top.owningCalendar.eventType.categoryAttributes">
					<ww:if test="top.name == 'Evenemangstyp' || top.name == 'Eventtyp'">
						<ww:set name="selectedCategories" value="this.getEventCategories('#event', top)"/>
						<ww:iterator value="#selectedCategories" status="rowstatus">
							<ww:property value="top.getLocalizedName(#languageCode, 'sv')"/><ww:if test="!#rowstatus.last">, </ww:if>
						</ww:iterator>
					</ww:if>
		   		</ww:iterator>
			</span>
			<h3><a href="<ww:property value="#attr.detailUrl"/><c:out value="${delim}"/>eventId=<ww:property value="top.id"/>"><ww:property value="#eventVersion.name"/></a></h3>
	
			<p><span class="calFactLabel"><ww:property value="this.getLabel('labels.public.event.timeLabel')"/></span> <ww:property value="this.formatDate(top.startDateTime.getTime(), 'yyyy-MM-dd')"/> 
			<ww:if test="this.formatDate(top.startDateTime.time, 'HH:mm') != '12:34'">
			<ww:property value="this.getLabel('labels.public.event.klockLabel')"/> <ww:property value="this.formatDate(top.startDateTime.getTime(), 'HH.mm')"/>
			</ww:if>
			
			<ww:if test="#eventVersion.alternativeLocation != ''">
				<ww:property value="#eventVersion.alternativeLocation"/>
			</ww:if>
			<ww:else>
				<ww:iterator value="top.locations">
					<ww:property value="top.getLocalizedName('en','sv')"/>,
				</ww:iterator>
			</ww:else>
			- <ww:property value="#eventVersion.customLocation"/>
			
			<br /></p>
	        <ww:set name="puffImage" value="this.getResourceUrl(event, 'PuffBild')"/>
			<ww:if test="#puffImage != null">
			<img src="<ww:property value="#puffImage"/>" class="img_calendar_event"/>
			</ww:if>
			<p><ww:property value="#eventVersion.shortDescription"/></p>
			<ww:if test="#eventVersion.lecturer != null && #eventVersion.lecturer != ''">
			<p><span class="calFactLabel"><ww:property value="this.getLabel('labels.public.event.lecturerLabel')"/>:</span> <ww:property value="#eventVersion.lecturer"/></p>
			</ww:if>
		</div>
		<!-- Record End -->
	</ww:iterator>
	
	<ww:if test="events == null || events.size() == 0">
		<p>För tillfället finns inga aktuella kalenderhändelser inlagda i kategorin 
		<!--"<ww:property value="#visibleCategoryName"/>"-->
		</p>
	</ww:if>
	
</div>
<!-- Calendar End -->  
