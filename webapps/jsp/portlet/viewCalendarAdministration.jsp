<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Home" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.applicationSubHeader')"/></div>

<%@ include file="functionMenu.jsp" %>

<p>
<ww:property value="this.getLabel('labels.internal.applicationIntroduction')"/>
</p>
<portlet:renderURL var="createEventUrl">
	<portlet:param name="action" value="ViewCalendarList!choose"/>
</portlet:renderURL>

<a href="<c:out value="${createEventUrl}"/>">Skapa nytt event</a>

<%@ include file="adminFooter.jsp" %>
