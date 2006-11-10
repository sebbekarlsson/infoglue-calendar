<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="Languages" scope="page"/>

<%@ include file="adminHeader.jsp" %>
<%@ include file="functionMenu.jsp" %>

<portlet:renderURL var="createLanguageUrl">
	<portlet:param name="action" value="CreateLanguage!input"/>
</portlet:renderURL>

<div class="subfunctionarea">
<span class="left"></span>	
<span class="right">
	<a href="<c:out value="${createLanguageUrl}"/>" title="Skapa ny post"><ww:property value="this.getLabel('labels.internal.language.addLanguage')"/></a>
</span>	
<div class="clear"></div>
</div>

<div class="columnlabelarea">
	<div class="columnLong"><p><ww:property value="this.getLabel('labels.internal.language.name')"/></p></div>
	<div class="columnMedium"><p><ww:property value="this.getLabel('labels.internal.language.isoCode')"/></p></div>
	<div class="clear"></div>
</div>

<ww:iterator value="languages" status="rowstatus">

	<ww:set name="languageId" value="id" scope="page"/>
	<ww:set name="name" value="name" scope="page"/>
	<portlet:renderURL var="languageUrl">
		<portlet:param name="action" value="ViewLanguage"/>
		<portlet:param name="languageId" value="<%= pageContext.getAttribute("languageId").toString() %>"/>
	</portlet:renderURL>
	
	<portlet:actionURL var="deleteLanguageUrl">
		<portlet:param name="action" value="DeleteLanguage"/>
		<portlet:param name="languageId" value="<%= pageContext.getAttribute("languageId").toString() %>"/>
	</portlet:actionURL>

	<portlet:renderURL var="viewLanguageListUrl">
		<portlet:param name="action" value="ViewLanguageList"/>
	</portlet:renderURL>

	<portlet:renderURL var="confirmUrl">
		<portlet:param name="action" value="Confirm"/>
		<portlet:param name="confirmTitle" value="Radera - bekräfta"/>
		<calendar:evalParam name="confirmMessage" value="Är du säker på att du vill radera &quot;${name}&quot;"/>
		<portlet:param name="okUrl" value="<%= java.net.URLEncoder.encode(pageContext.getAttribute("deleteLanguageUrl").toString(), "utf-8") %>"/>
		<portlet:param name="cancelUrl" value="<%= java.net.URLEncoder.encode(pageContext.getAttribute("viewLanguageListUrl").toString(), "utf-8") %>"/>
	</portlet:renderURL>

	<ww:if test="#rowstatus.odd == true">
    	<div class="oddrow">
    </ww:if>
    <ww:else>
		<div class="evenrow">
    </ww:else>

       	<div class="columnLong">
       		<p class="portletHeadline"><a href="<c:out value="${languageUrl}"/>" title="Redigera '<ww:property value="name"/>'"><ww:property value="name"/></a></p>
       	</div>
       	<div class="columnMedium">
       		<p><ww:property value="isoCode"/></p>
       	</div>
       	<div class="columnEnd">
       		<a href="<c:out value="${confirmUrl}"/>" title="Radera '<ww:property value="name"/>'" class="delete"></a>
       	   	<a href="<c:out value="${languageUrl}"/>" title="Redigera '<ww:property value="name"/>'" class="edit"></a>
       	</div>
       	<div class="clear"></div>
    </div>

</ww:iterator>

<ww:if test="languages == null || languages.size() == 0">
	<div class="oddrow">
		<div class="columnLong"><p class="portletHeadline"><ww:property value="this.getLabel('labels.internal.applicationNoItemsFound')"/></a></p></div>
       	<div class="columnMedium"></div>
       	<div class="columnEnd"></div>
       	<div class="clear"></div>
    </div>
</ww:if>

<%@ include file="adminFooter.jsp" %>
