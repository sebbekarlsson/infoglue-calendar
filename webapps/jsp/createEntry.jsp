<%@ taglib uri="webwork" prefix="ww" %>


<html>
<head>
</head>
<body>

<div id="inputForm">
	
	<div id="contentListHeader">
		Create new entry
	</div>

	<div id="contentList">
		<form name="inputForm" method="POST" action="CreateEntry.action">
			<input type="hidden" name="eventId" value="<ww:property value="eventId"/>">
			firstName: <input type="textfield" name="firstName" value="">
			lastName: <input type="textfield" name="lastName" value="">
			email: <input type="textfield" name="email" value="">
			<input type="submit">
		</form>
	</div>

</div>

</body>
</html>
