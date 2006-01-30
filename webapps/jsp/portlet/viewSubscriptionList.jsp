<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Calendars" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<div class="head"><ww:property value="this.getLabel('labels.internal.applicationTitle')"/><!--  - <ww:property value="this.getLabel('labels.internal.location.subHeader')"/>--></div>

<%@ include file="functionMenu.jsp" %>

<div class="subfunctionarea">
<span class="left"></span>	
<span class="right">
	<a href="<c:out value="${viewSubscriptionsUrl}"/>" title="Skapa ny post"><ww:property value="this.getLabel('labels.internal.calendar.viewSubscriptions')"/></a>
</span>	
<div class="clear"></div>
</div>

<div class="columnlabelarea">
	<div class="columnLong"><p><ww:property value="this.getLabel('labels.internal.subscribers')"/></p></div>
	<div class="clear"></div>
</div>

<ww:iterator value="subscribers" status="rowstatus">

	<ww:set name="subscriptionId" value="top.id" scope="page"/>
	<ww:set name="name" value="top.email" scope="page"/>
	
	<portlet:actionURL var="deleteUrl">
		<portlet:param name="action" value="DeleteEventSubscription"/>
		<portlet:param name="subscriptionId" value="<%= pageContext.getAttribute("subscriptionId").toString() %>"/>
	</portlet:actionURL>
	
	<portlet:renderURL var="viewListUrl">
		<portlet:param name="action" value="ViewEventSubscriptionList"/>
	</portlet:renderURL>

	<portlet:renderURL var="confirmUrl">
		<portlet:param name="action" value="Confirm"/>
		<portlet:param name="confirmTitle" value="Radera - bekräfta"/>
		<calendar:evalParam name="confirmMessage" value="Är du säker på att du vill ta bort prenumerationen på kalendern &quot;${name}&quot;"/>
		<portlet:param name="okUrl" value="<%= java.net.URLEncoder.encode(pageContext.getAttribute("deleteUrl").toString(), "utf-8") %>"/>
		<portlet:param name="cancelUrl" value="<%= java.net.URLEncoder.encode(pageContext.getAttribute("viewListUrl").toString(), "utf-8") %>"/>
	</portlet:renderURL>
	
	<ww:if test="#rowstatus.odd == true">
    	<div class="oddrow">
    </ww:if>
    <ww:else>
		<div class="evenrow">
    </ww:else>

       	<div class="columnLong">
       		<p class="portletHeadline"><ww:property value="top.email"/></p>
       	</div>
       	<div class="columnEnd">
       		<a href="<c:out value="${confirmUrl}"/>" title="Radera '<ww:property value="top.email"/>'" class="delete"></a>
       	</div>
       	<div class="clear"></div>
    </div>
		
</ww:iterator>

<ww:if test="subscribers == null || subscribers.size() == 0">
	<div class="oddrow">
		<div class="columnLong"><p class="portletHeadline"><ww:property value="this.getLabel('labels.internal.applicationNoItemsFound')"/></a></p></div>
       	<div class="columnMedium"></div>
       	<div class="columnEnd"></div>
       	<div class="clear"></div>
    </div>
</ww:if>

<%@ include file="adminFooter.jsp" %>
