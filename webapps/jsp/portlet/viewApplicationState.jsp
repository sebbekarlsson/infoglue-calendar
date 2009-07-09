<%@ taglib uri="webwork" prefix="ww" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="calendar" prefix="calendar" %>

<portlet:defineObjects/>

<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "DTD/xhtml1-strict.dtd">

<html>
<head>
	<title>Calendar status page</title>
	
	<style>
	<!--
		.header 
		{
			font-family : Verdana;
			font-size 	: 16pt;
			font-weight : bold;
		}
		.label
		{
			font-family	:Verdana;
			font-size	:10pt;
			font-weight : bold;
		}
		.text 
		{
			font-family	:Verdana;
			font-size	:10pt;
		}
		.texttrue 
		{
			font-family	:Verdana;
			font-size	:10pt;
		}
		.textfalse 
		{
			font-family	:Verdana;
			font-size	:10pt;
			color  		:red;
		}
		.fullymarginalized 
		{
			margin-left	: 50;
			margin-right: 50;
			margin-top	: 10%;
		}
	-->
	</style>

</head>

<body>

 
<portlet:actionURL var="updateModelActionUrl">
	<portlet:param name="action" value="ViewApplicationState!upgradeModel"/>
</portlet:actionURL>

<center>

<table class="fullymarginalized" border="0" cellpadding="2" cellspacing="0">
  <tr>
    <td colspan="4" class="header">Calendar Status (<ww:property value="serverName"/>)</td>
  </tr>
  <tr>
    <td colspan="4"><hr/></td>
  </tr>
  <tr>
    <td colspan="4" class="header">Maintainence actions</td>
  </tr>
  <tr>
    <td colspan="4"><a href="<c:out value="${updateModelActionUrl}"/>">Upgrade model</a></td>
  </tr>
   <tr>
    <td colspan="4"><hr/></td>
  </tr>
  
<%--
  <tr>
    <td class="label" bgcolor="gray">InfoGlue cache name</td>
    <td class="label" bgcolor="gray">Cached items</td>
    <td class="label" bgcolor="gray">Statistics</td>
    <td class="label" bgcolor="gray">Actions</td>
  </tr>
  #foreach($cacheName in $caches.keySet())
  <tr>
    <td class="text" valign="top">$cacheName</td>
    <td class="text" valign="top">#if($caches.get($cacheName).class.name == "com.opensymphony.oscache.general.GeneralCacheAdministrator") Unkown #else $caches.get($cacheName).size() #end</td>
    <td class="text" valign="top">
    	#if($caches.get($cacheName).class.name == "com.opensymphony.oscache.general.GeneralCacheAdministrator") 
    		#set($cacheEntryEventListener =	$eventListeners.get("${cacheName}_cacheEntryEventListener"))
    		#set($cacheMapAccessEventListener =	$eventListeners.get("${cacheName}_cacheMapAccessEventListener"))
    		 
    		$cacheEntryEventListener.toString()
	        <br/>
	        $cacheMapAccessEventListener.toString()
    	#else 
    		$caches.get($cacheName).size() 
    	#end
    </td>
    <td class="text" valign="top"><a href="ViewApplicationState!clearCache.action?cacheName=$cacheName">Clear</a></td>
  </tr>
  #end
  <tr>
    <td colspan="4" class="text"><a href="ViewApplicationState!clearCaches.action">Clear All</a> | <a href="ViewApplicationState!reCache.action">Recache sitenodes</a></td>
  </tr>
  <tr>
    <td colspan="4"><hr/></td>
  </tr>
--%>  
  	<portlet:actionURL var="clearCachesViewStateActionUrl">
		<portlet:param name="action" value="ViewApplicationState!clearCaches"/>
	</portlet:actionURL>
  
  	<tr>
    	<td colspan="4" class="text"><a href="<c:out value="${clearCachesViewStateActionUrl}"/>">Clear All</a></td>
  	</tr>
  	<tr>
    	<td colspan="4"><hr/></td>
  	</tr>
  	<tr>
    	<td class="label" bgcolor="gray" colspan="4">Log settings</td>
  	</tr>
  
	<portlet:actionURL var="updateStateActionUrl">
		<portlet:param name="action" value="UpdateApplicationState"/>
	</portlet:actionURL>
  
  <tr>
    <td colspan="4" class="text" align="left">
    	<form action="<c:out value="${updateStateActionUrl}"/>" method="POST"> 
	    	ClassName:
	    	<input type="textfield" name="className">
	    	Log level:
	    	<select name="logLevel">
	    		<option value="debug">Debug</option>
	    		<option value="info">Information</option>
	    		<option value="warn">Warning</option>
	    		<option value="error">Error</option>
	    	</select>
	    	<input type="submit" value="Submit"/>
	    </form>
    </td>
  </tr>

</table>
</center>

</body>

</html>
