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


<portlet:defineObjects/>

<ww:set name="languageCode" value="languageCode" scope="page"/>
<% 
	Locale locale = new Locale(pageContext.getAttribute("languageCode").toString());
	ResourceBundle resourceBundle = ResourceBundleHelper.getResourceBundle("infoglueCalendar", locale);
%>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calendar.css" />

<div id="container">
	<div id="top"><h1>Calendar application administration</h1></div>

	<div id="leftnav">
		<portlet:renderURL var="viewCalendarListUrl">
			<portlet:param name="action" value="ViewCalendarList"/>
		</portlet:renderURL>
		<portlet:renderURL var="viewLocationListUrl">
			<portlet:param name="action" value="ViewLocationList"/>
		</portlet:renderURL>
		<portlet:renderURL var="viewCategoryListUrl">
			<portlet:param name="action" value="ViewCategoryList"/>
		</portlet:renderURL>

		<ul>
	    	<li><a href="<c:out value="${viewCalendarListUrl}"/>">Administer calendars</a></li>
	    	<li><a href="<c:out value="${viewLocationListUrl}"/>">Administer locations</a></li>
			<li><a href="<c:out value="${viewCategoryListUrl}"/>">Administer categories</a></li>
		</ul>
	</div>

	<div id="content">
		<h2>Categories</h2>

		<ww:iterator value="categories" status="rowstatus">
		
			<ww:set name="categoryId" value="id" scope="page"/>
			<portlet:renderURL var="categoryUrl">
				<portlet:param name="action" value="ViewCategory"/>
				<portlet:param name="categoryId" value="<%= pageContext.getAttribute("categoryId").toString() %>"/>
			</portlet:renderURL>
			
			<portlet:actionURL var="deleteCategoryUrl">
				<portlet:param name="action" value="DeleteCategory"/>
				<portlet:param name="categoryId" value="<%= pageContext.getAttribute("categoryId").toString() %>"/>
			</portlet:actionURL>
			
		<p class="nobreak">
			<ww:if test="#rowstatus.odd == true">
		    	<span class="marked"><ww:property value="id"/>. <a href="<c:out value="${categoryUrl}"/>"><ww:property value="name"/></a> 
		    	<a href="<c:out value="${categoryUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a>
		    	<a href="<c:out value="${deleteCategoryUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a></span>
		    </ww:if>
		    <ww:else>
		    	<span><ww:property value="id"/>. <a href="<c:out value="${categoryUrl}"/>"><ww:property value="name"/></a> 
		    	<a href="<c:out value="${categoryUrl}"/>"><img src="<%=request.getContextPath()%>/images/edit.jpg" border="0"></a>
		    	<a href="<c:out value="${deleteCategoryUrl}"/>"><img src="<%=request.getContextPath()%>/images/delete.gif" border="0"></a></span>
		    </ww:else>
		</p>
		</ww:iterator>

		<portlet:renderURL var="createCategoryUrl">
			<portlet:param name="action" value="CreateCategory!input"/>
		</portlet:renderURL>
		
		<a href="<c:out value="${createCategoryUrl}"/>">Add Category</a>
	</div>
	<div id="footer">
		&copy; The InfoGlue Community 2005
	</div>
</div>