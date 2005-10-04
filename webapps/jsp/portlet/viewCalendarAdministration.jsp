<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Home" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.applicationTitle')"/> - <ww:property value="this.getLabel('labels.internal.applicationHeader')"/></div>

<%@ include file="functionMenu.jsp" %>

<portlet:renderURL var="createEventUrl">
	<portlet:param name="action" value="ViewCalendarList!choose"/>
</portlet:renderURL>

<div class="portlet_margin">
<h1><ww:property value="this.getLabel('labels.internal.applicationSubHeader')"/></h1>
<p>
	<ww:property value="this.getLabel('labels.internal.applicationIntroduction')"/>
</p>
<p><a href="<c:out value="${createEventUrl}"/>"><ww:property value="this.getLabel('labels.internal.event.addEvent')"/></a></p>
</div>

<%@ include file="adminFooter.jsp" %>
