<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="EventSearch" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.event.searchEvents')"/></div>

<%@ include file="functionMenu.jsp" %>

<div id="searchForm" class="marginalizedDiv" style="display: <ww:if test="entries == null">block</ww:if><ww:else>none</ww:else>;">

<portlet:renderURL var="searchEntryActionUrl">
	<portlet:param name="action" value="ViewEventSearch"/>
</portlet:renderURL>
		
<form name="register" method="post" action="<c:out value="${searchEntryActionUrl}"/>">
<p>
	<span class="subheadline"><ww:property value="this.getLabel('labels.internal.event.searchIntro')"/></span>
</p>

<div class="descriptionbig">
	<p>
		<calendar:textField label="labels.internal.event.name" name="name" value="name" cssClass="normalInput"/>
	</p>
	<p>
		<calendar:textField label="labels.internal.event.organizerName" name="organizerName" value="organizerName" cssClass="normalInput"/>
	</p>
	<p>
		<calendar:textField label="labels.internal.event.lecturer" name="lecturer" value="lecturer" cssClass="normalInput"/>
	</p>
	<p>
		<calendar:textField label="labels.internal.event.customLocation" name="customLocation" value="customLocation" cssClass="normalInput"/>
	</p>
	<p>
		<calendar:textField label="labels.internal.event.contactName" name="contactName" value="contactName" cssClass="normalInput"/>
	</p>
	<!--
	<p>
		<calendar:textField label="labels.internal.event.contactEmail" name="contactEmail" value="contactEmail" cssClass="normalInput"/>
	</p>
	<p>
		<calendar:textField label="labels.internal.event.contactPhone" name="contactPhone" value="contactPhone" cssClass="normalInput"/>
	</p>
	<p>
		<calendar:textField label="labels.internal.event.price" name="price" value="price" cssClass="normalInput"/>
	</p>
	<p>
		<calendar:textField label="labels.internal.event.maximumParticipants" name="maximumParticipants" value="maximumParticipants" cssClass="normalInput"/>
	</p>
	-->
	<p>
		<table border="0" cellspacing="0">
		<tr>
			<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.startDate')"/></span></td> 
			<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.startTime')"/></span></td> 
		</tr>
		<tr>
			<td width="20%" nowrap>
				<input type="textfield" id="startDateTime" name="startDateTime" value="<ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/>" class="dateInput">
				<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_startDateTime" style="cursor: pointer; border: 0px solid black;" title="Date selector" />
			</td>				
			<td>
				<input type="textfield" name="startTime" value="<ww:property value="this.formatDate(event.startDateTime.time, 'HH')"/>" class="hourInput">
			</td>				
		</tr>
		</table>
	</p>    
	<p>
		<table border="0">
		<tr>
			<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.endDate')"/></span></td> 
			<td><span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.event.endTime')"/></span></td> 
		</tr>
		<tr>
			<td width="20%" nowrap>
				<input type="textfield" id="endDateTime" name="endDateTime" value="<ww:property value="this.formatDate(event.endDateTime.time, 'yyyy-MM-dd')"/>" class="dateInput">
				<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_endDateTime" style="cursor: pointer; border: 0px solid black;" title="Date selector" />
			</td>				
			<td>
      			<input type="textfield" name="endTime" value="<ww:property value="this.formatDate(event.endDateTime.time, 'HH')"/>" class="hourInput">
			</td>				
		</tr>
		</table>				
	</p>

</div>

<div style="height:10px"></div>
<input type="submit" value="<ww:property value="this.getLabel('labels.internal.soba.searchButton')"/>" class="calendarButton"/>
</form>
</div>


<div id="emailForm" class="marginalizedDiv" style="display: none;">

<span class="headline"><ww:property value="this.getLabel('labels.internal.soba.emailPersons')"/></span>
<hr/>

<portlet:actionURL var="emailActionUrl">
	<portlet:param name="action" value="EmailEntries"/>
</portlet:actionURL>
		
<form name="email" method="post" action="<c:out value="${emailActionUrl}"/>">
	<input type="hidden" name="searchEventId" value="<ww:property value="searchEventId"/>">
	<input type="hidden" name="searchFirstName" value="<ww:property value="searchFirstName"/>">
	<input type="hidden" name="searchLastName" value="<ww:property value="searchLastName"/>">
	<input type="hidden" name="searchEmail" value="<ww:property value="searchEmail"/>">

<p>
<span class="subheadline"><ww:property value="this.getLabel('labels.internal.soba.emailIntro')"/></span>
</p>

<div class="descriptionsmall">
	<span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.soba.addresses')"/></span><br>
    <input type="textfield" name="emailAddresses" class="normalInput" value="<ww:property value="emailAddresses"/>">
</div>

<div class="descriptionsmall">
	<span class="calendarLabel"><ww:property value="this.getLabel('labels.internal.soba.subject')"/></span><br>
    <input type="textfield" name="subject" class="normalInput" value="<ww:property value="subject"/>">
</div>

<div class="descriptionbig">
	<p>
	<ww:property value="this.getLabel('labels.internal.soba.message')"/><br>
	<textarea name="message"></textarea>
	</p>
</div>
<div style="height:10px"></div>
<input type="submit" value="<ww:property value="this.getLabel('labels.internal.soba.sendMessage')"/>" class="calendarButton"/>
</form>
<hr/>
</div>


<div id="hitlist" class="marginalizedDiv" style="display: <ww:if test="entries == null">none</ww:if><ww:else>block</ww:else>;">
<span class="headline"><ww:property value="this.getLabel('labels.internal.soba.searchEntries')"/></span>

<hr/>

<p>
	<span class="subheadline"><ww:property value="this.getLabel('labels.internal.soba.hitList')"/></span>
</p>

<table border="0" width="100%" cellpadding="2" cellspacing="0">
<tr>
<th><ww:property value="this.getLabel('labels.internal.soba.idColumnHeader')"/></th>
<th><ww:property value="this.getLabel('labels.internal.soba.nameColumnHeader')"/></th>
<th><ww:property value="this.getLabel('labels.internal.soba.actionColumnHeader')"/></th>
</tr>

<ww:iterator value="entries">
	<ww:set name="entryId" value="id" scope="page"/>
	<ww:set name="searchEventId" value="searchEventId" scope="page"/>
	<ww:set name="searchFirstName" value="searchFirstName" scope="page"/>
	<ww:set name="searchLastName" value="searchLastName" scope="page"/>
	<ww:set name="searchEmail" value="searchEmail" scope="page"/>
	<portlet:renderURL var="viewEntryRenderURL">
		<portlet:param name="action" value="ViewEntry"/>
		<portlet:param name="entryId" value="<%= pageContext.getAttribute("entryId").toString() %>"/>
		<portlet:param name="searchEventId" value="<%= pageContext.getAttribute("searchEventId").toString() %>"/>
	</portlet:renderURL>

	<portlet:actionURL var="deleteEntryUrl">
		<portlet:param name="action" value="DeleteEntry"/>
		<portlet:param name="entryId" value="<%= pageContext.getAttribute("entryId").toString() %>"/>
		<portlet:param name="searchEventId" value="<%= pageContext.getAttribute("searchEventId").toString() %>"/>
		<portlet:param name="searchFirstName" value="<%= pageContext.getAttribute("searchFirstName").toString() %>"/>
		<portlet:param name="searchLastName" value="<%= pageContext.getAttribute("searchLastName").toString() %>"/>
		<portlet:param name="searchEmail" value="<%= pageContext.getAttribute("searchEmail").toString() %>"/>
	</portlet:actionURL>

<tr>
	<td><ww:property value="id"/></td>
	<td><a href="<c:out value="${viewEntryRenderURL}"/>"><ww:property value="firstName"/> <ww:property value="lastName"/></a></td>
	<td>
		
		<a href="<c:out value="${viewEntryRenderURL}"/>"><ww:property value="this.getLabel('labels.internal.soba.edit')"/></a>
		<a href="<c:out value="${deleteEntryUrl}"/>"><ww:property value="this.getLabel('labels.internal.soba.delete')"/></a>
	</td>		
</tr>
</ww:iterator>

<ww:if test="entries == null || entries.size() == 0">
<tr>
	<td colspan="3"><ww:property value="this.getLabel('labels.internal.soba.noHits')"/></td>
</tr>
</ww:if>
</table>

<portlet:renderURL var="createEntryRenderURL">
	<portlet:param name="action" value="CreateEntry!input"/>
	<portlet:param name="eventId" value="1"/>
</portlet:renderURL>

	<div style="height:10px"></div>
	<a href="javascript:toggleSearchForm();"><ww:property value="this.getLabel('labels.internal.soba.newSearch')"/></a>
	<ww:if test="entries != null"><a href="javascript:toggleEmailForm();"><ww:property value="this.getLabel('labels.internal.soba.emailPersons')"/></a></ww:if>
<hr/>
</div>

<script type="text/javascript">
    Calendar.setup({
        inputField     :    "startDateTime",     // id of the input field
        ifFormat       :    "%Y-%m-%d",      // format of the input field
        button         :    "trigger_startDateTime",  // trigger for the calendar (button ID)
        align          :    "Tl",           // alignment (defaults to "Bl")
        singleClick    :    true
    });
</script>

<script type="text/javascript">
    Calendar.setup({
        inputField     :    "endDateTime",     // id of the input field
        ifFormat       :    "%Y-%m-%d",      // format of the input field
        button         :    "trigger_endDateTime",  // trigger for the calendar (button ID)
        align          :    "Tl",           // alignment (defaults to "Bl")
        singleClick    :    true
    });
</script>

<%@ include file="adminFooter.jsp" %>