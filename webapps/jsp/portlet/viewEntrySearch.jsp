<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<c:set var="activeNavItem" value="EntrySearch" scope="page"/>

<%@ include file="adminHeader.jsp" %>

<script type="text/javascript">
	
	function toggleSearchForm()
	{
		searchFormElement = document.getElementById("searchForm");
		emailFormElement = document.getElementById("emailForm");
		hitListElement = document.getElementById("hitlist");
		if(searchFormElement.style.display == "none")
		{
			searchFormElement.style.display = "block";
			hitListElement.style.display = "none";
			emailFormElement.style.display = "none";
		}
		else
		{
			searchFormElement.style.display = "none";
			hitListElement.style.display = "block";
			emailFormElement.style.display = "none";
		}
	}

	function toggleEmailForm()
	{
		emailFormElement = document.getElementById("emailForm");
		hitListElement = document.getElementById("hitlist");
		searchFormElement = document.getElementById("searchForm");
		if(emailFormElement.style.display == "none")
		{
			emailFormElement.style.display = "block";
			searchFormElement.style.display = "none";
			hitListElement.style.display = "none";
		}
		else
		{
			emailFormElement.style.display = "none";
			searchFormElement.style.display = "none";
			hitListElement.style.display = "block";
		}
	}
	
</script>

<%@ include file="functionMenu.jsp" %>

<div id="searchForm" class="portlet_margin" style="display: <ww:if test="entries == null">block</ww:if><ww:else>none</ww:else>;">

	<h1><ww:property value="this.getLabel('labels.internal.soba.searchIntro')"/></h1>

	<portlet:renderURL var="searchEntryActionUrl">
		<portlet:param name="action" value="ViewEntrySearch"/>
	</portlet:renderURL>
			
	<form method="post" action="<c:out value="${searchEntryActionUrl}"/>">
	
	<div class="fieldrow">
		<label for="searchEventId"><ww:property value="this.getLabel('labels.internal.soba.events')"/></label><br>
		<select id="searchEventId" name="searchEventId" multiple="true" class="listBox">
			<option value=""/><ww:property value="this.getLabel('labels.internal.soba.anyEvent')"/></option>
			<option value=""/>--------------------</option>
			<ww:iterator value="eventList">
			<option value="<ww:property value="id"/>"/><ww:property value="name"/></option>
			</ww:iterator>
		</select>
	</div>
	
	<calendar:textField label="labels.internal.soba.firstName" name="'searchFirstName'" value="firstName" cssClass="longtextfield"/>
	<calendar:textField label="labels.internal.soba.lastName" name="'searchLastName'" value="lastName" cssClass="longtextfield"/>
	<calendar:textField label="labels.internal.soba.email" name="'searchEmail'" value="email" cssClass="longtextfield"/>

	<ww:iterator value="categoryAttributes" status="rowstatus">
		<ww:set name="categoryAttribute" value="top" scope="page"/>
		<ww:set name="categoryAttributeIndex" value="#rowstatus.index" scope="page"/>
		<input type="hidden" name="categoryAttributeId_<ww:property value="#rowstatus.index"/>" value="<ww:property value="top.id"/>"/>
		<c:set var="categoryAttributeName" value="categoryAttribute_${categoryAttribute.id}_categoryId"/>
		<calendar:selectField label="top.name" name="${categoryAttributeName}" multiple="true" value="top.category.children" selectedValues="getCategoryAttributeValues(top.id)" cssClass="listBox" required="false"/>
	</ww:iterator>

	<calendar:checkboxField label="labels.internal.soba.searchANDOR" name="'andSearch'" valueMap="this.getAndSearch()" selectedValues="false"/>

	<div style="height:10px"></div>
	
	<input type="submit" value="<ww:property value="this.getLabel('labels.internal.soba.searchButton')"/>" class="button"/>
	<input type="button" class="button" onclick="toggleSearchForm();" value="<ww:property value="this.getLabel('labels.internal.applicationCancel')"/>"></a>
	</form>
</div>

<div id="emailForm" class="portlet_margin" style="display: none;">

<h1><ww:property value="this.getLabel('labels.internal.soba.emailPersons')"/></h1>

<portlet:actionURL var="emailActionUrl">
	<portlet:param name="action" value="EmailEntries"/>
</portlet:actionURL>
		
<form name="email" method="post" action="<c:out value="${emailActionUrl}"/>">
	<input type="hidden" name="searchEventId" value="<ww:property value="searchEventId"/>">
	<input type="hidden" name="searchFirstName" value="<ww:property value="searchFirstName"/>">
	<input type="hidden" name="searchLastName" value="<ww:property value="searchLastName"/>">
	<input type="hidden" name="searchEmail" value="<ww:property value="searchEmail"/>">

	<ww:property value="this.getLabel('labels.internal.soba.emailIntro')"/>
	
	<calendar:textField label="labels.internal.soba.addresses" name="'emailAddresses'" value="emailAddresses" cssClass="longtextfield" required="true"/>
	<calendar:textField label="labels.internal.soba.subject" name="'subject'" value="subject" cssClass="longtextfield" required="true"/>
	<calendar:textAreaField label="labels.internal.soba.message" name="message" value="message" cssClass="smalltextarea" required="true"/>

	<div style="height:10px"></div>

	<input type="submit" value="<ww:property value="this.getLabel('labels.internal.soba.sendMessage')"/>" class="button"/>
	<input type="button" class="button" onclick="toggleEmailForm();" value="<ww:property value="this.getLabel('labels.internal.applicationCancel')"/>"></a>

</form>
</div>

<!-- ********************* -->
<!-- ******  HITS ******** -->
<!-- ********************* -->
<ww:if test="entries != null">
	<div id="hitlist" style="display: <ww:if test="entries == null">none</ww:if><ww:else>block</ww:else>;">
	
	<div class="portlet_margin">
		<h1><ww:property value="this.getLabel('labels.internal.soba.hitListStart')"/> <ww:property value="entries.size()"/> <ww:property value="this.getLabel('labels.internal.soba.hitListEnd')"/></h1>
	</div>
	
	<portlet:renderURL var="createEntryRenderURL">
		<portlet:param name="action" value="CreateEntry!input"/>
		<portlet:param name="eventId" value="1"/>
	</portlet:renderURL>
	
	<div class="subfunctionarea">
	<span class="left">
		<a href="javascript:toggleSearchForm();"><ww:property value="this.getLabel('labels.internal.soba.newSearch')"/></a>
		<ww:if test="entries != null && entries.size() > 0"> | <a href="javascript:toggleEmailForm();"><ww:property value="this.getLabel('labels.internal.soba.emailPersons')"/></a></ww:if>
	</span>	
	<span class="right"></span>	
	<div class="clear"></div>
	</div>
	
	<div class="columnlabelarea">
		<div class="columnShort"><p><ww:property value="this.getLabel('labels.internal.soba.idColumnHeader')"/></p></div>
		<div class="columnMedium"><p><ww:property value="this.getLabel('labels.internal.soba.nameColumnHeader')"/></p></div>
		<div class="columnMedium"><p><ww:property value="this.getLabel('labels.internal.soba.eventColumnHeader')"/></p></div>
		<div class="clear"></div>
	</div>
	
	<ww:iterator value="entries" status="rowstatus">
		<ww:set name="entryId" value="id" scope="page"/>
		<ww:set name="name" value="name" scope="page"/>
		<ww:if test="searchEventId != null">
			<ww:set name="searchEventId" value="searchEventId" scope="page"/>
		</ww:if>
		<ww:if test="searchFirstName != null">
			<ww:set name="searchFirstName" value="searchFirstName" scope="page"/>
		</ww:if>
		<ww:if test="searchLastName != null">
			<ww:set name="searchLastName" value="searchLastName" scope="page"/>
		</ww:if>
		<ww:if test="searchEmail != null">
			<ww:set name="searchEmail" value="searchEmail" scope="page"/>
		</ww:if>
		<ww:if test="onlyFutureEvents != null">
			<ww:set name="onlyFutureEvents" value="onlyFutureEvents" scope="page"/>
		</ww:if>
		<portlet:renderURL var="viewEntryRenderURL">
			<portlet:param name="action" value="ViewEntry"/>
			<c:if test="${entryId != null}">
				<portlet:param name="entryId" value="<%= pageContext.getAttribute("entryId").toString() %>"/>
			</c:if>
			<c:if test="${searchEventId != null}">
				<portlet:param name="searchEventId" value="<%= pageContext.getAttribute("searchEventId").toString() %>"/>
			</c:if>		
		</portlet:renderURL>
	
		<portlet:actionURL var="deleteUrl">
			<portlet:param name="action" value="DeleteEntry"/>
			<c:if test="${entryId != null}">
				<portlet:param name="entryId" value="<%= pageContext.getAttribute("entryId").toString() %>"/>
			</c:if>
			<c:if test="${searchEventId != null}">
				<portlet:param name="searchEventId" value="<%= pageContext.getAttribute("searchEventId").toString() %>"/>
			</c:if>
			<c:if test="${searchFirstName != null}">
				<portlet:param name="searchFirstName" value="<%= pageContext.getAttribute("searchFirstName").toString() %>"/>
			</c:if>
			<c:if test="${searchLastName != null}">
				<portlet:param name="searchLastName" value="<%= pageContext.getAttribute("searchLastName").toString() %>"/>
			</c:if>
			<c:if test="${searchEmail != null}">
				<portlet:param name="searchEmail" value="<%= pageContext.getAttribute("searchEmail").toString() %>"/>
			</c:if>
			<c:if test="${onlyFutureEvents != null}">
				<portlet:param name="onlyFutureEvents" value="<%= pageContext.getAttribute("onlyFutureEvents").toString() %>"/>
			</c:if>			
		</portlet:actionURL>
	
		<portlet:actionURL var="viewListUrl">
			<portlet:param name="action" value="ViewEntrySearch"/>
			<c:if test="${searchEventId != null}">
				<portlet:param name="searchEventId" value="<%= pageContext.getAttribute("searchEventId").toString() %>"/>
			</c:if>
			<c:if test="${searchFirstName != null}">
				<portlet:param name="searchFirstName" value="<%= pageContext.getAttribute("searchFirstName").toString() %>"/>
			</c:if>
			<c:if test="${searchLastName != null}">
				<portlet:param name="searchLastName" value="<%= pageContext.getAttribute("searchLastName").toString() %>"/>
			</c:if>
			<c:if test="${searchEmail != null}">
				<portlet:param name="searchEmail" value="<%= pageContext.getAttribute("searchEmail").toString() %>"/>
			</c:if>
			<c:if test="${onlyFutureEvents != null}">
				<portlet:param name="onlyFutureEvents" value="<%= pageContext.getAttribute("onlyFutureEvents").toString() %>"/>
			</c:if>
		</portlet:actionURL>
	
		<portlet:renderURL var="confirmUrl">
			<portlet:param name="action" value="Confirm"/>
			<portlet:param name="confirmTitle" value="Radera - bekräfta"/>
			<calendar:evalParam name="confirmMessage" value="Är du säker på att du vill radera &quot;${name}&quot;"/>
			<portlet:param name="okUrl" value="<%= java.net.URLEncoder.encode(pageContext.getAttribute("deleteUrl").toString(), "utf-8") %>"/>
			<portlet:param name="cancelUrl" value="<%= java.net.URLEncoder.encode(pageContext.getAttribute("viewListUrl").toString(), "utf-8") %>"/>
		</portlet:renderURL>
	
		<ww:if test="#rowstatus.odd == true">
	    	<div class="oddrow">
	    </ww:if>
	    <ww:else>
			<div class="evenrow">
	    </ww:else>
	
		   	<div class="columnShort">
		   		<p class="portletHeadline"><a href="<c:out value="${viewEntryRenderURL}"/>" title="Redigera '<ww:property value="firstName"/>'"><ww:property value="#rowstatus.count"/></a></p>
		   	</div>
		   	<div class="columnMedium">
		   		<p class="portletHeadline"><a href="<c:out value="${viewEntryRenderURL}"/>" title="Redigera '<ww:property value="firstName"/>'"><ww:property value="firstName"/> <ww:property value="lastName"/></a></p>
		   	</div>
		   	<div class="columnMedium">
		   		<p><ww:property value="top.event.name"/></p>
		   	</div>
		   	<div class="columnEnd">
		   		<a href="<c:out value="${confirmUrl}"/>" title="Radera '<ww:property value="firstName"/>'" class="delete"></a>
		   	   	<a href="<c:out value="${viewEntryRenderURL}"/>" title="Redigera '<ww:property value="firstName"/>'" class="edit"></a>
		   	</div>
		   	<div class="clear"></div>
		</div>
	
	</ww:iterator>
</ww:if>

<%--

<ww:if test="entries == null || entries.size() == 0">
	<div class="oddrow">
		<div class="columnLong"><p class="portletHeadline"><ww:property value="this.getLabel('labels.internal.applicationNoItemsFound')"/></a></p></div>
       	<div class="columnMedium"></div>
       	<div class="columnEnd"></div>
       	<div class="clear"></div>
    </div>
</ww:if>
--%>

<%@ include file="adminFooter.jsp" %>