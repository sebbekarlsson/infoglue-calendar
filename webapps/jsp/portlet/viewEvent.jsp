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
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="calendar" prefix="calendar" %>

<portlet:defineObjects/>

<ww:set name="languageCode" value="languageCode" scope="page"/>
<% 
	Locale locale = new Locale(pageContext.getAttribute("languageCode").toString());
	ResourceBundle resourceBundle = ResourceBundleHelper.getResourceBundle("infoglueCalendar", locale);
%>

<ww:set name="event" value="event" scope="page"/>
<ww:set name="eventId" value="event.id" scope="page"/>
<ww:set name="calendarId" value="calendarId" scope="page"/>
<ww:set name="mode" value="mode" scope="page"/>


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

	function createEventFromCopy(action)
	{
		document.updateForm.action = action;
		document.updateForm.submit();
	} 
</script>

<div id="inputDiv">
	
	<portlet:actionURL var="deleteEventUrl">
		<portlet:param name="action" value="DeleteEvent"/>
	</portlet:actionURL>

	<portlet:renderURL var="publishEventUrl">
		<portlet:param name="action" value="ViewEvent"/>
		<portlet:param name="eventId" value="{eventId}"/>
	</portlet:renderURL>

	<%
	Object requestObject = request.getAttribute("javax.portlet.request");
	javax.portlet.PortletRequest renderRequestIG = (javax.portlet.PortletRequest)requestObject;
	String hostName = (String)renderRequestIG.getProperty("host");
	%>		

	<form name="deleteLinkForm" method="POST" action="<c:out value="${deleteEventUrl}"/>">
		<input type="hidden" name="eventId" value="<ww:property value="event.id"/>"/>
		<input type="hidden" name="calendarId" value="<ww:property value="calendarId"/>"/>
		<input type="hidden" name="mode" value="<ww:property value="mode"/>"/>
		<input type="hidden" name="startDateTime" value="<ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/>">
		<input type="hidden" name="endDateTime" value="<ww:property value="this.formatDate(event.endDateTime.time, 'yyyy-MM-dd')"/>">
	</form>		
	
	<div id="contentListHeader">
		 <ww:property value="event.name"/> <a href="javascript:document.deleteLinkForm.submit();">Delete</a>
	</div>

	<div id="contentList" style="display: block;">
	
		<portlet:actionURL var="updateEventActionUrl">
			<portlet:param name="action" value="UpdateEvent"/>
		</portlet:actionURL>
		
		<form name="updateForm" method="POST" action="<c:out value="${updateEventActionUrl}"/>">
			<input type="hidden" name="eventId" value="<ww:property value="event.id"/>"/>
			<input type="hidden" name="calendarId" value="<ww:property value="event.calendar.id"/>"/>
			<input type="hidden" name="mode" value="<ww:property value="mode"/>"/>
			<input type="hidden" name="publishEventUrl" value="http://<%=hostName%><c:out value="${publishEventUrl}"/>"/>
						
			<p>
				<span class="label"><%= resourceBundle.getString("labels.internal.event.nameLabel") %></span><span class="alert"><ww:property value="nameErrorMessage"/></span><br>
				<input type="textfield" name="name" value="<ww:property value="event.name"/>" class="normalInput">
			</p>
			<p>
				<span class="label"><%= resourceBundle.getString("labels.internal.event.descriptionLabel") %></span><span class="alert"><ww:property value="descriptionErrorMessage"/></span><br> 
				<input type="textfield" name="description" value="<ww:property value="event.description"/>" class="normalInput">
			</p>
			<p>
				<table border="0" cellspacing="0">
				<tr>
					<td><span class="label"><%= resourceBundle.getString("labels.internal.event.startDateTimeLabel") %></span></td> 
					<td><span class="label">Starttid:</span></td> 
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
					<td><span class="label"><%= resourceBundle.getString("labels.internal.event.endDateTimeLabel") %></span></td> 
					<td><span class="label">Sluttid:</span></td> 
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
			<!-- NEW -->
			<p>
				<span class="label"><%= resourceBundle.getString("labels.internal.event.isInternalLabel") %></span><span class="alert"><ww:property value="isInternalErrorMessage"/></span> 
				<input type="checkbox" name="isInternal" value="true" <c:if test="${event.isInternal == true}">checked="1"</c:if> >
			</p>
			<p>
				<span class="label"><%= resourceBundle.getString("labels.internal.event.isOrganizedByGULabel") %></span><span class="alert"><ww:property value="isOrganizedByGUErrorMessage"/></span> 
				<input type="checkbox" name="isOrganizedByGU" value="true" <c:if test="${event.isOrganizedByGU == true}">checked="1"</c:if> >
			</p>
			<p>
				<span class="label"><%= resourceBundle.getString("labels.internal.event.organizerNameLabel") %></span><span class="alert"><ww:property value="organizerNameErrorMessage"/></span><br> 
				<input type="textfield" name="organizerName" value="<ww:property value="event.organizerName"/>" class="normalInput">
			</p>
			<p>
				<span class="label"><%= resourceBundle.getString("labels.internal.event.lecturerLabel") %></span><span class="alert"><ww:property value="lecturerErrorMessage"/></span><br> 
				<input type="textfield" name="lecturer" value="<ww:property value="event.lecturer"/>" class="normalInput">
			</p>

			<p>
				<span class="label"><%= resourceBundle.getString("labels.internal.event.customLocationLabel") %></span><span class="alert"><ww:property value="customLocationErrorMessage"/></span><br> 
				<input type="textfield" name="customLocation" value="<ww:property value="event.customLocation"/>" class="normalInput">
			</p>
			<p>
				<span class="label"><%= resourceBundle.getString("labels.internal.event.shortDescriptionLabel") %></span><span class="alert"><ww:property value="shortDescriptionErrorMessage"/></span><br> 
				<input type="textfield" name="shortDescription" value="<ww:property value="event.shortDescription"/>" class="normalInput">
			</p>
			<p>
				<span class="label"><%= resourceBundle.getString("labels.internal.event.longDescriptionLabel") %></span><span class="alert"><ww:property value="longDescriptionErrorMessage"/></span><br> 
				<input type="textfield" name="longDescription" value="<ww:property value="event.longDescription"/>" class="normalInput">
			</p>
			<p>
				<span class="label"><%= resourceBundle.getString("labels.internal.event.eventUrlLabel") %></span><span class="alert"><ww:property value="eventUrlErrorMessage"/></span><br> 
				<input type="textfield" name="eventUrl" value="<ww:property value="event.eventUrl"/>" class="normalInput">
			</p>
			<p>
				<span class="label"><%= resourceBundle.getString("labels.internal.event.contactEmailLabel") %></span><span class="alert"><ww:property value="contactEmailErrorMessage"/></span><br> 
				<input type="textfield" name="contactEmail" value="<ww:property value="event.contactEmail"/>" class="normalInput">
			</p>
			<p>
				<span class="label"><%= resourceBundle.getString("labels.internal.event.contactPhoneLabel") %></span><span class="alert"><ww:property value="contactPhoneErrorMessage"/></span><br> 
				<input type="textfield" name="contactPhone" value="<ww:property value="event.contactPhone"/>" class="normalInput">
			</p>
			<p>
				<span class="label"><%= resourceBundle.getString("labels.internal.event.contactNameLabel") %></span><span class="alert"><ww:property value="contactNameErrorMessage"/></span><br> 
				<input type="textfield" name="contactName" value="<ww:property value="event.contactName"/>" class="normalInput">
			</p>

			<p>
				<span class="label"><%= resourceBundle.getString("labels.internal.event.priceLabel") %></span><span class="alert"><ww:property value="priceErrorMessage"/></span><br> 
				<input type="textfield" name="price" value="<ww:property value="event.price"/>" class="normalInput">
			</p>
			<p>
				<span class="label"><%= resourceBundle.getString("labels.internal.event.maxumumParticipantsLabel") %></span><span class="alert"><ww:property value="maxumumParticipantsErrorMessage"/></span><br> 
				<input type="textfield" name="maxumumParticipants" value="<ww:property value="event.maxumumParticipants"/>" class="normalInput">
			</p>

			<p>
				<table border="0">
				<tr>
					<td><span class="label"><%= resourceBundle.getString("labels.internal.event.lastRegistrationDateTimeLabel") %></span></td> 
					<td><span class="label">Sluttid:</span></td> 
				</tr>
				<tr>
					<td width="20%" nowrap>
						<input type="textfield" id="lastRegistrationDateTime" name="lastRegistrationDateTime" value="<ww:property value="this.formatDate(event.lastRegistrationDateTime.time, 'yyyy-MM-dd')"/>" class="dateInput">
						<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_lastRegistrationDateTime" style="cursor: pointer; border: 0px solid black;" title="Date selector" />
					</td>				
					<td>
		      			<input type="textfield" name="lastRegistrationTime" value="<ww:property value="this.formatDate(event.lastRegistrationDateTime.time, 'HH')"/>" class="hourInput">
					</td>				
				</tr>
				</table>				
			</p>

			<!-- END NEW -->
			
       		<p>
	      		<span class="label">Plats (Håll ner Ctrl för att välja flera):</span><span class="alert"><ww:property value="locationErrorMessage"/></span><br>
				<select name="locationId" multiple="true" class="listBox">
      				<ww:iterator value="selectedLocations">
		      			<option value="<ww:property value='top.id'/>" selected="1"><ww:property value="top.name"/></option>
		      		</ww:iterator>
		      		<option value="">-------------------</option>
		      		<ww:iterator value="remainingLocations">
		      			<option value="<ww:property value='top.id'/>"><ww:property value="top.name"/></option>
		      		</ww:iterator>		      		
				</select>
  			</p>
			<p>
	      		<span class="label">Kategori (Håll ner Ctrl för att välja flera):</span><span class="alert"><ww:property value="categoryErrorMessage"/></span><br>
				<select name="categoryId" multiple="true" class="listBox">
					<ww:iterator value="selectedCategories">
		      			<option value="<ww:property value='top.id'/>" selected="1"><ww:property value="top.name"/></option>
		      		</ww:iterator>
		      		<option value="">-------------------</option>
		      		<ww:iterator value="remainingCategories">
		      			<option value="<ww:property value='top.id'/>"><ww:property value="top.name"/></option>
		      		</ww:iterator>		      		
	      		</select>
	       	</p>
	       	<p>  		
      			<span class="label">Deltagare (Håll ner Ctrl för att välja flera):</span><span class="alert"><ww:property value="principalsErrorMessage"/></span><br>
	      		<select size="10" name="participantUserName" multiple="true" class="listBox">
	      			<ww:iterator value="participatingPrincipals">
		      			<option value="<ww:property value='top.name'/>" selected="1"><ww:property value="top.firstName"/> <ww:property value="top.lastName"/></option>
		      		</ww:iterator>
		      		<option value="">-------------------</option>
		      		<ww:iterator value="infogluePrincipals">
		      			<option value="<ww:property value='top.name'/>"><ww:property value="top.firstName"/> <ww:property value="top.lastName"/></option>
		      		</ww:iterator>
	      		</select>
      		</p>
			<p>
				<span class="label">Attached files:</span><br>
				<ww:iterator value="event.resources">
				
					<ww:set name="resourceId" value="top.id" scope="page"/>
					<calendar:resourceUrl id="url" resourceId="${resourceId}"/>
			
					<portlet:actionURL var="deleteResourceUrl">
						<calendar:evalParam name="action" value="DeleteResource"/>
						<calendar:evalParam name="resourceId" value="${resourceId}"/>
						<calendar:evalParam name="eventId" value="${eventId}"/>
						<calendar:evalParam name="calendarId" value="${calendarId}"/>
						<calendar:evalParam name="mode" value="${mode}"/>
					</portlet:actionURL>
						
					<a href="<c:out value="${url}"/>"><ww:property value='assetKey'/></a>&nbsp;<a href="<c:out value="${deleteResourceUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a><br>     			
	      		</ww:iterator>
	      		<br/>
	      		<a href="javascript:showUploadForm();">Add resource</a>
			</p>
			<p>
				<br>
				<ww:set name="eventId" value="eventId" scope="page"/>
				<portlet:renderURL var="createEntryRenderURL">
					<calendar:evalParam name="action" value="CreateEntry!input"/>
					<calendar:evalParam name="eventId" value="${eventId}"/>
					<calendar:evalParam name="calendarId" value="${calendarId}"/>
					<calendar:evalParam name="mode" value="${mode}"/>
				</portlet:renderURL>
				<a href="<c:out value="${createEntryRenderURL}"/>">Sign up for this event</a>
			</p>
			<p>
				<input type="submit" value="Update">

				<ww:if test="event.isPublished == false">
					<portlet:actionURL var="publishEventActionUrl">
						<calendar:evalParam name="action" value="UpdateEvent!publishEvent"/>
						<calendar:evalParam name="eventId" value="${eventId}"/>
						<calendar:evalParam name="calendarId" value="${calendarId}"/>
						<calendar:evalParam name="mode" value="${mode}"/>
					</portlet:actionURL>
					<a href="<c:out value="${publishEventActionUrl}"/>"><input type="button" value="Publish event"/></a>
				</ww:if>

				<portlet:actionURL var="createEventAsCopyActionUrl">
					<calendar:evalParam name="action" value="CreateEvent!copy"/>
				</portlet:actionURL>
				<a href="javascript:createEventFromCopy('<c:out value="${createEventAsCopyActionUrl}"/>')"><input type="button" value="Create new event"/></a>
			</p>
		</form>
	</div>
	
	<portlet:actionURL var="createResourceUploadActionUrl">
		<portlet:param name="action" value="CreateResource"/>
	</portlet:actionURL>
	
	<div id="upload" style="display: none;">
		
		<form enctype="multipart/form-data" name="inputForm" method="POST" action="<c:out value="${createResourceUploadActionUrl}"/>">
			<input type="hidden" name="eventId" value="<ww:property value="event.id"/>"/>
			<input type="hidden" name="calendarId" value="<ww:property value="calendarId"/>"/>
			<input type="hidden" name="mode" value="<ww:property value="mode"/>"/>
			<input type="hidden" name="startDateTime" value="<ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/>"/>
			<input type="hidden" name="endDateTime" value="<ww:property value="this.formatDate(event.startDateTime.time, 'yyyy-MM-dd')"/>"/>
			
			<p>
				Attachment key:<br>
				<!--<input type="textfield" name="assetKey" class="normalInput">-->
				<select name="assetKey" class="normalInput">
					<ww:iterator value="assetKeys">
		      			<option value="<ww:property value='top'/>"><ww:property value="top"/></option>
		      		</ww:iterator>
				</select>
			</p>
			<p>
				Attach file:<br>
				<input type="file" name="file" id="file"/>
			</p>
			<p>
				<input type="submit" value="Update">
			</p>
			</form>
	
	</div>
	

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

<script type="text/javascript">
    Calendar.setup({
        inputField     :    "lastRegistrationDateTime",     // id of the input field
        ifFormat       :    "%Y-%m-%d",      // format of the input field
        button         :    "trigger_lastRegistrationDateTime",  // trigger for the calendar (button ID)
        align          :    "Tl",           // alignment (defaults to "Bl")
        singleClick    :    true
    });
</script>
