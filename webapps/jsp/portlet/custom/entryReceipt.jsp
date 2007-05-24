<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="calendar" prefix="calendar" %>

<portlet:defineObjects/>

<ww:if test="#attr.detailUrl.indexOf('?') > -1">
	<c:set var="delim" value="&"/>
</ww:if>
<ww:else>
	<c:set var="delim" value="?"/>
</ww:else>

<!-- Anm&auml;lan - kvitto -->			  
<H1>Anm&auml;lan - kvitto</H1>

<div class="contaktform_receipt">
	<h2>F&ouml;ljande person är nu anmäld till:</h2>
	<h3>"<ww:property value="event.name"/>"</h3>
	<h3>Boknings ID:</h3>
	<p><ww:property value="entry.id"/></p>
	<h3>Namn:</h3>
	<p><ww:property value="entry.firstName"/> <ww:property value="entry.lastName"/></p>
	<h3>E-post:</h3>
	<p><ww:property value="entry.email"/></p>
	<p>En bekr&auml;ftelse på anm&auml;lan &auml;r skickad till <ww:property value="entry.email"/></p>
	<p>Välkommen!</p>
	<p><a href="<ww:property value="#attr.detailUrl"/><c:out value="${delim}"/>eventId=<ww:property value="eventId"/>" title="L&auml;nk till info om evenemanget">&laquo; Tillbaka till evenemangets informationssida</a></p>	
</div>
<!-- Anm&auml;lan - kvitto Slut --> 