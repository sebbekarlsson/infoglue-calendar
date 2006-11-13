<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="calendar" prefix="calendar" %>

<portlet:defineObjects/>

<ww:set name="eventVersion" value="this.getEventVersion('#event')"/>
<ww:set name="eventVersion" value="this.getEventVersion('#event')" scope="page"/>


<!-- Calendar start -->
<div class="calendar"> 	
	<span class="categoryLabel">
		<ww:iterator value="event.owningCalendar.eventType.categoryAttributes">
			<ww:if test="top.name == 'Evenemangstyp' || top.name == 'Eventtyp'">
				<ww:set name="selectedCategories" value="this.getEventCategories(top)"/>
				<ww:iterator value="#selectedCategories" status="rowstatus">
					<ww:property value="top.name"/><ww:if test="!#rowstatus.last">, </ww:if>
				</ww:iterator>
			</ww:if>
   		</ww:iterator>
	</span> 	
	
	<H1><ww:property value="eventVersion.name"/></H1>

<!-- Detta skall ev vara med beroende på hur articelkomponenten ser ut
	<div class="recordLine">
	<span class="categoryLabelSmall">Öppen föreläsning</span> -->
	
	<ww:if test="eventVersion.decoratedShortDescription != null && eventVersion.decoratedShortDescription != ''">
		<h4><ww:property value="eventVersion.decoratedShortDescription"/></h4>
	</ww:if>
	
	<ww:if test="eventVersion.decoratedLongDescription != null && eventVersion.decoratedLongDescription != ''">
	<p>
	<ww:set name="puffImage" value="this.getResourceUrl(event, 'DetaljBild')"/>
	<ww:if test="#puffImage != null">
	<img src="<ww:property value="#puffImage"/>" class="img_left_letter"/>
	</ww:if>
	<ww:property value="eventVersion.decoratedLongDescription"/>
	</p>
	</ww:if>
	
	<div class="calFact" style="clear:both">
		<ww:if test="eventVersion.lecturer != null && eventVersion.lecturer != ''">
			<p><span class="calFactLabel">F&ouml;rel&auml;sare: </span><ww:property value="eventVersion.lecturer"/></p>
		</ww:if>
		<ww:set name="startDate" value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/>
		<ww:set name="endDate" value="this.formatDate(event.endDateTime.time, 'yyyy-MM-dd')"/>
		<ww:if test="#startDate != #endDate">
			<p><span class="calFactLabel">Datum & tid: </span><ww:property value="#startDate"/>
			<ww:if test="this.formatDate(event.startDateTime.time, 'HH:mm') != '12:34'">
		 	kl <ww:property value="this.formatDate(event.startDateTime.time, 'HH:mm')"/> till <ww:property value="#endDate"/> kl <ww:property value="this.formatDate(event.endDateTime.time, 'HH:mm')"/>
		 	</ww:if>
			</p>                             		
		</ww:if>
		<ww:else>
			<p><span class="calFactLabel">Datum: </span><ww:property value="#startDate"/></p>                             		
			<ww:if test="this.formatDate(event.startDateTime.time, 'HH:mm') != '12:34'">
		 	<p><span class="calFactLabel">Tid: </span><ww:property value="this.formatDate(event.startDateTime.time, 'HH:mm')"/> <ww:if test="this.formatDate(event.endDateTime.time, 'HH:mm') != '23:59'">- <ww:property value="this.formatDate(event.endDateTime.time, 'HH:mm')"/></ww:if></p>
		 	</ww:if>
		</ww:else>
		<p><span class="calFactLabel">Kategori: </span>
		<ww:iterator value="event.owningCalendar.eventType.categoryAttributes">
			<ww:if test="top.name == 'Ämnesområde' || top.name == 'Ämnesområden'">
				<ww:set name="selectedCategories" value="this.getEventCategories(top)"/>
				<ww:iterator value="#selectedCategories" status="rowstatus">
					<ww:property value="top.name"/><ww:if test="!#rowstatus.last">, </ww:if>
				</ww:iterator>
			</ww:if>
   		</ww:iterator>
   		</p>
   		
   		<ww:if test="eventVersion.organizerName != null && eventVersion.organizerName != ''">
   			<p><span class="calFactLabel">Arrang&ouml;r: </span><ww:property value="eventVersion.organizerName"/></p>
		</ww:if>
		
		<p><span class="calFactLabel">Plats: </span><br/>
			<ww:if test="eventVersion.alternativeLocation != null && eventVersion.alternativeLocation != ''">
				<ww:property value="eventVersion.alternativeLocation"/>		
			</ww:if>
			<ww:else>
  				<ww:iterator value="event.locations">
		      		<ww:set name="location" value="top"/>
	 				<ww:property value='#location.name'/><br/>		
	      		</ww:iterator>
			</ww:else>
			<ww:property value="eventVersion.customLocation"/>
		</p>
	
		<ww:if test="eventVersion.eventUrl != null && eventVersion.eventUrl != ''">
			<p><span class="calFactLabel">Evenemangsl&auml;nk: </span><a href="<ww:property value="eventVersion.eventUrl"/>">Läs mer om <ww:property value="eventVersion.name"/></a></p>
		</ww:if>
			
		<ww:if test="event.resources.size() > 0">
  			<p><span class="calFactLabel">Ytterligare information: </span><br/>
			<ww:iterator value="event.resources">
	  		  <ww:if test="top.assetKey == 'BifogadFil'">
				<ww:set name="resourceId" value="top.id" scope="page"/>
				<calendar:resourceUrl id="url" resourceId="${resourceId}"/>
				<ww:if test="fileName.indexOf('.pdf') > -1">
					<ww:set name="resourceClass" value="'pdficon'"/>
				</ww:if>
				<ww:if test="fileName.indexOf('.doc') > -1">
					<ww:set name="resourceClass" value="'wordicon'"/>
				</ww:if>
				<ww:if test="fileName.indexOf('.xls') > -1">
					<ww:set name="resourceClass" value="'excelicon'"/>
				</ww:if>
				<ww:if test="fileName.indexOf('.ppt') > -1">
					<ww:set name="resourceClass" value="'powerpointicon'"/>
				</ww:if>
				<a href="<c:out value="${url}"/>" target="_blank" class="<ww:property value="#resourceClass"/>"><ww:property value="shortendFileName"/></a><br/>
	  		  </ww:if>
	  		</ww:iterator>
	  		</p>
		</ww:if>

		<ww:if test="event.lastRegistrationDateTime != null">
   			<p><span class="calFactLabel">Sista anm&auml;lningsdag: </span><ww:property value="this.formatDate(event.lastRegistrationDateTime.time, 'yyyy-MM-dd')"/> kl. <ww:property value="this.formatDate(event.lastRegistrationDateTime.time, 'HH')"/>.</p>
		</ww:if>
		
		<ww:if test="eventVersion.price != null && eventVersion.price != ''">
	  		<p><span class="calFactLabel">Avgift:</span> <ww:property value="eventVersion.price"/> </p>
		</ww:if>
		<ww:else>
  			<p><span class="calFactLabel">Avgift:</span> Ingen avgift </p>		
		</ww:else>
		
		<ww:if test="event.contactEmail != null && event.contactEmail != ''">
			<ww:if test="eventVersion.contactName != null && eventVersion.contactName != ''">
				<p><span class="calFactLabel">Kontaktperson: </span><A href="mailto:<ww:property value="event.contactEmail"/>"><ww:property value="eventVersion.contactName"/></A></p>
			</ww:if>
			<ww:else>
				<p><span class="calFactLabel">Kontaktperson: </span><A href="mailto:<ww:property value="event.contactEmail"/>"><ww:property value="event.contactEmail"/></A></p>
			</ww:else>
		</ww:if>
		<ww:else>
			<ww:if test="event.contactName != null && event.contactName != ''">
				<p><span class="calFactLabel">Kontaktperson: </span><ww:property value="event.contactName"/></p>
			</ww:if>
		</ww:else>
		
		<ww:if test="event.contactPhone != null && event.contactPhone != ''">
			<p><span class="calFactLabel">Telefon: </span><ww:property value="event.contactPhone"/></p>
		</ww:if>
		
		<ww:set name="count" value="0"/>
		<ww:iterator value="attributes" status="rowstatus">
			<ww:set name="attribute" value="top" scope="page"/>
			<ww:set name="title" value="top.getContentTypeAttribute('title').getContentTypeAttributeParameterValue().getLocalizedValueByLanguageCode('label', currentContentTypeEditorViewLanguageCode)" scope="page"/>
			<ww:set name="attributeName" value="this.concat('attribute_', top.name)"/>
			<ww:set name="attributeValue" value="this.getAttributeValue(event.attributes, top.name)"/>
			<p>
				<calendar:textValue label="${title}" value="#attributeValue" labelCssClass="label"/>
			</p>
			<ww:set name="count" value="#count + 1"/>
		</ww:iterator>
		
		
		<ww:if test="event.maximumParticipants != null && event.maximumParticipants != 0">
			<p><span class="calFactLabel">Antal platser: </span><ww:property value="event.maximumParticipants"/> (Varav <ww:property value="event.entries.size()"/> är bokade)</p>
		</ww:if>

		<ww:if test="event.lastRegistrationDateTime != null">
			<p>	
			<ww:if test="event.lastRegistrationDateTime.time.time > now.time.time">
				<ww:if test="event.maximumParticipants == null || event.maximumParticipants > event.entries.size()">
					<ww:set name="eventId" value="eventId" scope="page"/>
					<portlet:renderURL var="createEntryRenderURL">
						<calendar:evalParam name="action" value="CreateEntry!inputPublicGU"/>
						<calendar:evalParam name="eventId" value="${eventId}"/>
					</portlet:renderURL>
					<a href="<c:out value="${createEntryRenderURL}"/>"><ww:property value="this.getLabel('labels.public.event.signUp')"/></a></span>
				</ww:if>
				<ww:else>
					<ww:property value="this.getLabel('labels.internal.event.signUpForThisOverbookedEvent')"/><br/>
					<ww:set name="eventId" value="eventId" scope="page"/>
					<portlet:renderURL var="createEntryRenderURL">
						<calendar:evalParam name="action" value="CreateEntry!inputPublicGU"/>
						<calendar:evalParam name="eventId" value="${eventId}"/>
					</portlet:renderURL>
					<a href="<c:out value="${createEntryRenderURL}"/>"><ww:property value="this.getLabel('labels.public.event.signUp')"/></a></span>
				</ww:else>
			</ww:if>
			<ww:else>
				<ww:property value="this.getLabel('labels.public.event.registrationExpired')"/>
			</ww:else>
			</p>
		</ww:if>
				
		<%--		
		<p><span class="calFactLabel">Anmälan:</span>
		<ww:if test="event.lastRegistrationDateTime.time.time > now.time.time">
			<ww:if test="event.maximumParticipants > event.entries.size()">
				<ww:set name="eventId" value="eventId" scope="page"/>
				<portlet:renderURL var="createEntryRenderURL">
					<calendar:evalParam name="action" value="CreateEntry!inputPublicGU"/>
					<calendar:evalParam name="eventId" value="${eventId}"/>
				</portlet:renderURL>
				<a href="<c:out value="${createEntryRenderURL}"/>"><ww:property value="this.getLabel('labels.public.event.signUp')"/></a></span>
			</ww:if>
			<ww:else>
					<ww:property value="this.getLabel('labels.public.maximumEntriesReached.title')"/>
			</ww:else>
		</ww:if>
		<ww:else>
			<ww:property value="this.getLabel('labels.public.event.registrationExpired')"/>
		</ww:else>
		</p>
		--%>
	</div>
<!-- </div> -->
</div>
<!-- Calendar End -->

