<%@ taglib uri="webwork" prefix="ww" %>


<html>
<head>
</head>
<body>

<div id="inputForm">
	
	<div id="contentListHeader">
		Create new category
	</div>

	<div id="contentList">
		<form name="inputForm" method="POST" action="CreateCategory.action">
			name: <input type="textfield" name="name" value="">
			description: <input type="textfield" name="description" value="">
			<input type="submit">
		</form>
	</div>

</div>

</body>
</html>
