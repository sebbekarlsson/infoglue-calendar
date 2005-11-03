<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="calendar" prefix="calendar" %>

<portlet:defineObjects/>

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
		<ww:set name="eventId" value="id" scope="page"/>
		<portlet:renderURL var="eventDetailUrl">
			<portlet:param name="action" value="ViewEvent!publicGU"/>
			<portlet:param name="eventId" value="<%= pageContext.getAttribute("eventId").toString() %>"/>
		</portlet:renderURL>
	                     
		<!-- Record Start -->
		<div class="record">
			<span class="categoryLabelSmall">
				<ww:iterator value="top.owningCalendar.eventType.categoryAttributes" status="rowstatus">
					<ww:if test="top.name == 'Evenemangstyp' || top.name == 'Eventtyp'">
						<ww:set name="selectedCategories" value="this.getEventCategories('#event', top)"/>
						<ww:iterator value="#selectedCategories">
							<ww:property value="top.name"/>
						</ww:iterator>
					</ww:if>
		   		</ww:iterator>
			</span>
			<h3><a href="<ww:property value="#attr.detailUrl"/><c:out value="${delim}"/>eventId=<ww:property value="top.id"/>"><ww:property value="name"/></a></h3>
	
			<p><span class="calFactLabel">Tid:</span> <ww:property value="this.formatDate(top.startDateTime.getTime(), 'yyyy-MM-dd')"/> kl <ww:property value="this.formatDate(top.startDateTime.getTime(), 'HH.mm')"/><br /></p>
	        <ww:set name="puffImage" value="this.getResourceUrl(event, 'PuffBild')"/>
			<ww:if test="#puffImage != null">
			<img src="<ww:property value="#puffImage"/>" class="img_calendar_event"/>
			</ww:if>
			<p><ww:property value="shortDescription"/></p>
			<ww:if test="lecturer != null && lecturer != ''">
			<p><span class="calFactLabel">F&ouml;rel&auml;sare:</span> <ww:property value="lecturer"/></p>
			</ww:if>
		</div>
		<!-- Record End -->
	</ww:iterator>
	
</div>
<!-- Calendar End -->  

<!--
	<p><strong>Sida 2 av 2</strong>&nbsp;</p>                       
<div class="prev_next">

<a href="#" class="number">START</a>
<a href="#" class="number">&laquo;</a>
<a href="#" class="number">1</a>
<span class="number">2</span>
<a href="#" class="number">3</a>
<a href="#" class="number">4</a>
<a href="#" class="number">5</a>
<a href="#" class="number">6</a>
<a href="#" class="number">7</a>

<a href="#" class="number">8</a>
<a href="#" class="number">9</a>
<a href="#" class="number">10</a>
<a href="#" class="number">&raquo;</a>
</div>
-->
