<%@ taglib uri="webwork" prefix="ww" %>


<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Entry Search</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="css/calendar.css" />
	<link rel="stylesheet" type="text/css" media="all" href="applications/jscalendar/calendar-system.css" title="system" />
</head>

<body>

<h1>Sök anmälan</h1>
<hr/>

<form name="register" method="post" action="ViewEntrySearch.action">
<h4>Sök efter anmälningar</h4>

<div style="clear:both;"></div>
<div class="descriptionbig">
	<div style="width:20%; float:left;">
		<label for="event" class="reglabel">Event:</label> 
		<label for="firstName" class="reglabel">Förnamn:</label>
		<label for="lastName" class="reglabel">Efternamn:</label> 
		<label for="email" class="reglabel">Email:</label> 
	</div>	
	<div style="float:left;">
		<input type="text" size="40" name="event" id="event" class="normalInput" value="" />
		<input type="text" size="40" name="firstName" id="firstName" class="normalInput" value="<ww:property value="firstName"/>" />
		<input type="text" size="40" name="lastName" id="lastName" class="normalInput" value="<ww:property value="lastName"/>" />		
		<input type="text" size="40" name="email" id="email" class="normalInput" value="<ww:property value="email"/>" />		
	</div>
</div>
<div class="descriptionsmall">
	<div class="category">
		Categories:<div style="height:10px"></div>
	</div>		
	<ww:iterator value="categoryList">
	<div class="category">
		<input type="checkbox" name="categoryId" value="<ww:property value="id"/>"/><ww:property value="name"/>
	</div>
	</ww:iterator>
</div>
<div class="descriptionsmall">
	<div class="location">
		Locations:<div style="height:10px"></div>
	</div>		
	<ww:iterator value="locationList">
	<div class="locations">
		<input type="checkbox" name="locationId" value="<ww:property value="id"/>"/><ww:property value="name"/>
	</div>
	</ww:iterator>
</div>
<div style="clear:left"></div>
<input type="submit" value="Sök"/>


<div style="clear:both"></div>
<hr/>

<h4>Träfflista</h4>
<div style="clear:both;"></div>
<ww:iterator value="entries">
<div style="width:100%;">
	<div class="hitlist"><ww:property value="id"/></div>
	<div class="hitlist"><ww:property value="firstName"/></div>
	<div class="hitlist"><ww:property value="lastName"/></div>
	<a>Ändra</a>
	<a>Ta bort</a>	
</div>
</ww:iterator>
<div style="clear:both"></div>
<div style="height:10px"></div>
	<a>Lägg till</a>
	<div style="clear:both"></div>
</form>
<hr/>
</body>
</html>
