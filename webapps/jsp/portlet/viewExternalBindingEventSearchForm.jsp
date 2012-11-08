<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<c:if test="${isIncluded ne 'true'}">
<%@ include file="externalBindingHeader.jsp" %>
</c:if>
		<div class="portlet_margin">
			<h1><ww:property value="this.getLabel('labels.internal.event.searchIntro')"/></h1>

			<portlet:renderURL var="searchEntryActionUrl">
				<portlet:param name="action" value="ViewEventSearch!externalBindingSearch" />
			</portlet:renderURL>

			<form name="register" method="post" action="<c:out value="${searchEntryActionUrl}"/>">

				<calendar:textField label="labels.internal.event.name" name="'name'" value="name" cssClass="longtextfield"/>

				<span class="errorMessage"><ww:property value="#fieldErrors.startDateTime"/></span>
				<div class="fieldrow">
					<label for="startDateTime"><ww:property value="this.getLabel('labels.internal.event.searchStartDate')"/></label><br />
					<input id="startDateTime" name="startDateTime" value="<ww:property value="startDateTime"/>" class="datefield" type="textfield">
					<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_startDateTime" style="border: 0px solid black; cursor: pointer;" title="Date selector">
					<input name="startTime" value="<ww:property value="startTime"/>" class="hourfield" type="textfield">					
				</div>

				<span class="errorMessage"><ww:property value="#fieldErrors.endDateTime"/></span>
				<div class="fieldrow">
					<label for="endDateTime"><ww:property value="this.getLabel('labels.internal.event.searchEndDate')"/></label><br />
					<input id="endDateTime" name="endDateTime" value="<ww:property value="endDateTime"/>" class="datefield" type="textfield">
					<img src="<%=request.getContextPath()%>/images/calendar.gif" id="trigger_endDateTime" style="border: 0px solid black; cursor: pointer;" title="Date selector">
					<input name="endTime" value="<ww:property value="endTime"/>" class="hourfield" type="textfield">					
				</div>

				<calendar:selectField label="labels.internal.calendar.eventType" name="'categoryId'" headerItem="Filtrera på evenemangstyp" multiple="true" value="categoriesList" selectedValue="categoryId" cssClass="listBox"/>

				<calendar:selectField label="labels.internal.event.owningCalendar" name="'calendarId'" headerItem="Filtrera på huvudkalender" multiple="true" value="calendarList" selectedValue="calendarId" cssClass="listBox"/>
			<div style="height:10px"></div>
			<input type="submit" value="<ww:property value="this.getLabel('labels.internal.soba.searchButton')"/>" class="button"/>
			</form>
		</div>
		
		<script type="text/javascript">
		    Calendar.setup({
		        inputField     :    "startDateTime",     // id of the input field
		        ifFormat       :    "%Y-%m-%d",      // format of the input field
		        button         :    "trigger_startDateTime",  // trigger for the calendar (button ID)
		        align          :    "BR",           // alignment (defaults to "Bl")
		        singleClick    :    true,
		        cache          :    true,
		        firstDay  	   : 	1    
		    });
		</script>
		
		<script type="text/javascript">
		    Calendar.setup({
		        inputField     :    "endDateTime",     // id of the input field
		        ifFormat       :    "%Y-%m-%d",      // format of the input field
		        button         :    "trigger_endDateTime",  // trigger for the calendar (button ID)
		        align          :    "BR",           // alignment (defaults to "Bl")
		        singleClick    :    true,
		        cache          :    true,
		        firstDay  	   : 	1    
		    });
		</script>
<c:if test="${isIncluded ne 'true'}">
<%@ include file="externalBindingFooter.jsp" %>
</c:if>