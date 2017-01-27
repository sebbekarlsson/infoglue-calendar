<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Home" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="portlet_margin">
	<h1><%= request.getParameter("confirmTitle") %></h1>
    <p><%= request.getParameter("confirmMessage") %></p>
    <input onclick="document.location.href='<%= java.net.URLDecoder.decode(request.getParameter("okUrl"), "utf-8") %>';" type="submit" value="<ww:property value="this.getLabel('labels.internal.applicationDelete')"/>" title="Radera 'postens namn'"/>
	<input onclick="document.location.href='<%= java.net.URLDecoder.decode(request.getParameter("cancelUrl"), "utf-8") %>';" type="submit" value="<ww:property value="this.getLabel('labels.internal.applicationCancel')"/>" title="<ww:property value="this.getLabel('labels.internal.applicationCancel')"/> 'postens namn'"/>
</div>

<%@ include file="adminFooter.jsp" %>
