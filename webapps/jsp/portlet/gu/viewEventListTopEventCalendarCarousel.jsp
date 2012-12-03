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
<ww:set name="foundMedia" value="false"/>
<ww:set name="topEventsSize" value="topEvents.size()" scope="page"/>
<div class="caroufredsel_wrap">
	<ul id="GUCalendarCarouselItems" class="GUCarouselItems">
		<ww:iterator value="topEvents" status="rowstatus">
		<li>
			<ww:set name="topEvent" value="top"/>
			<ww:set name="mediaUrl" value="this.getAttributeValue(top.attributes, 'mediaUrl')"/>
			<ww:set name="netConnectionUrl" value="this.getAttributeValue(top.attributes, 'netConnectionUrl')"/>
			<ww:if test="#attr.eventDetailUrl.indexOf('?') > -1">
				<c:set var="delim" value="&" />
			</ww:if>
			<ww:else>
				<c:set var="delim" value="?" />
			</ww:else>
			<ww:set name="puffImage" value="this.getResourceUrl(top.event, 'DetaljBild')"/>	
			<ww:if test="supplementingImages.containsKey(top.event.id)">
				<div class="GUCarouselItemAssetContainer">
					<img src="<ww:property value="supplementingImages.get(top.event.id)"/>" alt=""/> 
				</div>
				<ww:set name="foundMedia" value="true"/>
			</ww:if> 
			<ww:if test="#mediaUrl != null && #mediaUrl != '' && !#foundMedia">
				<div id="movie_<ww:property value="top.event.id"/>" class="GUCarouselItemAssetContainer">
					<noscript>
						<div class="videoNoscript">
							<ww:property value="this.getLabel('labels.public.event.noscriptVideo')"/>
						</div>
					</noscript>
				</div>
				<ww:if test="#attr.ajaxServiceUrl.indexOf('?') > -1">
					<c:set var="delimAjax" value="&" />
				</ww:if>
				<ww:else>
					<c:set var="delimAjax" value="?" />
				</ww:else>
				<script type="text/javascript">
					<!--
					$("#movie_<ww:property value='top.event.id'/>").load("<ww:property value="#attr.ajaxServiceUrl"/><c:out value="${delimAjax}" escapeXml="false"/>mediaUrl=<ww:property value="#mediaUrl"/>&netConnectionUrl=<ww:property value="#netConnectionUrl"/>&width=220");
					 -->
				</script>
				<ww:set name="foundMedia" value="true"/>
			</ww:if>
			<ww:if test="#puffImage != null  && !#foundMedia">
				<div class="GUCarouselItemAssetContainer">
					<img src="<ww:property value="#puffImage"/>" alt=""/>
				</div>
			</ww:if>
			<%-- clean up --%>
			<ww:set name="foundMedia" value="false"/>
			
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
					<ww:property value="this.formatDate(top.event.startDateTime.getTime(), 'EEEE d MMM ')" /><ww:property value="this.getLabel('labels.public.event.klockLabel')"/>
					<ww:property value="this.formatDate(top.event.startDateTime.getTime(), 'HH')" />-<ww:property value="this.formatDate(top.event.endDateTime.getTime(), 'HH')" />
				</span>
			</li>
		</ww:iterator>
		<%
			Integer topEventsSize = (Integer)pageContext.getAttribute("topEventsSize");
			int addNumberOfItems = 3 - topEventsSize % 3;
			for(int i = 0; i < addNumberOfItems; i++){
				out.print("<li>&nbsp;</li>");
			}
		%>
	</ul>
</div>
<!--/eri-no-index-->