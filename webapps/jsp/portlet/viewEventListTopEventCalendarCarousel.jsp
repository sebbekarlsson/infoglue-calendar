<!--eri-no-index-->
<%@ taglib uri="webwork" prefix="ww"%>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@ taglib uri="calendar" prefix="calendar"%>

<portlet:defineObjects />

<ww:set name="languageCode" value="this.getLanguageCode()" />
<ww:if test="#languageCode == 'en'">
	<ww:set name="dateFormat" value="'M/d/yyyy'" />
	<ww:set name="timeFormat" value="'h:mm aaa'" />
</ww:if>
<ww:else>
	<ww:set name="dateFormat" value="'yyyy-MM-dd'" />
	<ww:set name="timeFormat" value="'HH:mm'" />
</ww:else>
	
<div class="caroufredsel_wrap">
	<ul id="GUCarouselItems">
		<ww:iterator value="topEvents" status="rowstatus">
		<li>
			<ww:set name="topEvent" value="top" />
			<ww:if test="#attr.eventDetailUrl.indexOf('?') > -1">
				<c:set var="delim" value="&" />
			</ww:if>
			<ww:else>
				<c:set var="delim" value="?" />
			</ww:else>
			<ww:set name="puffImage" value="this.getResourceUrl(top.event, 'DetaljBild')"/>
			
			<ww:if test="#puffImage != null">
				<div class="GUCarouselItemAssetContainer">
					<img src="<ww:property value="#puffImage"/>"/>
				</div>
			</ww:if>
			
			<span class="smallfont">
				<ww:iterator value="top.event.owningCalendar.eventType.categoryAttributes">
					<ww:if test="top.name == 'Evenemangstyp' || top.name == 'Eventtyp'">
						<ww:set name="selectedCategories" value="this.getEventCategories('#topEvent.event', top)"/>
						<ww:iterator value="#selectedCategories" status="rowstatus"><ww:property value="top.getLocalizedName(#languageCode, 'sv')"/><ww:if test="!#rowstatus.last">,</ww:if></ww:iterator>
					</ww:if>
		   		</ww:iterator></span>
		   		<br/>
				<h2><a href="<ww:property value="#attr.eventDetailUrl"/><c:out value="${delim}"/>eventId=<ww:property value="top.event.id"/>" title="<ww:property value="#topEvent.title"/>"><ww:property value="#topEvent.name" /></a></h2>
				<span class="smallfont">
					<ww:property value="this.formatDate(top.event.startDateTime.getTime(), 'EEEE d MMM ')" /> kl
					<ww:property value="this.formatDate(top.event.startDateTime.getTime(), 'HH')" />-<ww:property value="this.formatDate(top.event.endDateTime.getTime(), 'HH')" />
				</span>
			</li>
		</ww:iterator>
	</ul>
</div>
<!--/eri-no-index-->