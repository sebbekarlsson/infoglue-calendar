<%@ taglib uri="webwork" prefix="ww" %>


<html>
<head>
</head>
<body>

<div id="inputForm">
	
	<div id="contentListHeader">
		Update category <ww:property value="category.name"/>
	</div>

	<div id="contentList">
		<form name="inputForm" method="POST" action="UpdateCategory.action">
		<input type="hidden" name="categoryId" value="<ww:property value="category.id"/>">
			name: <input type="textfield" name="name" value="<ww:property value="category.name"/>">
			description: <input type="textfield" name="description" value="<ww:property value="category.description"/>">
			<input type="submit">
		</form>
	</div>

</div>

</body>
</html>
