<%@ taglib uri="webwork" prefix="ww" %>


<html>
<head>
</head>
<body>

<div id="inputForm">
	
	<div id="contentListHeader">
		Update location <ww:property value="location.name"/>
	</div>

	<div id="contentList">
		<form name="inputForm" method="POST" action="UpdateLocation.action">
		<input type="hidden" name="locationId" value="<ww:property value="location.id"/>">
			name: <input type="textfield" name="name" value="<ww:property value="location.name"/>">
			description: <input type="textfield" name="description" value="<ww:property value="location.description"/>">
			<input type="submit">
		</form>
	</div>

</div>

</body>
</html>
