<%@ taglib uri="webwork" prefix="ww" %>


<html>
<head>
</head>
<body>

<div id="calendars">
	<div id="header">
		Calendars
	</div>
	<div id="contentList">
		<ww:iterator value="administrationUCCBean.calendars" status="rowstatus">
		<p>
			<ww:if test="#rowstatus.odd == true">
		    	<span class="marked"><ww:property value="id"/>.<ww:property value="name"/></span>
		    </ww:if>
		    <ww:else>
		    	<span><ww:property value="name"/></span>
		    </ww:else>
		</p>
		</ww:iterator>
	</div>
</div>

</body>
</html>
