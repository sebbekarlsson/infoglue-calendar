<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="calendar" prefix="calendar" %>

<portlet:defineObjects/>

<ww:iterator value="events" status="rowstatus">

<ww:if test="#rowstatus.count <= numberOfItems">

	<div class="newspadding">
		<a href="<ww:property value="#attr.detailUrl"/>&eventId=<ww:property value="top.id"/>" class="Headline"><ww:property value="name"/></a><br />
		<span class="newsdate"><ww:property value="this.formatDate(top.startDateTime.getTime(), 'dd MMM')"/> kl <ww:property value="this.formatDate(top.startDateTime.getTime(), 'HH.mm')"/>
		[<ww:property value="top.calendar.name"/>]
		</span>
	</div>

</ww:if>

</ww:iterator>
