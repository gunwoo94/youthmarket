<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>



<style type="text/css">
	.header {
		display: flex;
		flex-direction: row;
		justify-content: space-around;
		width: 100%;
		height: 110px;
	}
	
	.menu {
		display: flex;
		flex-direction: row;
		/* justify-content: space-around; */
		width: 100%;
		height: 50px;
	}
	
	.menu2 {
		display: flex;
		flex-direction: column;
		width: 100%;
		height: 150px;
	}

	.column {
		display: flex;
		flex-direction: column;
	}
	
	.footer {
		display: flex;
		flex-direction: row;
		width: 100%;
		margin-top:70px;
	}

	.body {
		margin-top: 150px;
		width: 100%;
	}

</style>


</head>
<body style="overflow-y: scroll; overflow-x: hidden; align-content: center;">
	<div>
		<div class=header>
			<tiles:insertAttribute name="header"></tiles:insertAttribute>
		</div>
		<div class=body>
			<tiles:insertAttribute name="body"></tiles:insertAttribute>
		</div> 
		<div class=footer>
			<tiles:insertAttribute name="footer"></tiles:insertAttribute>
		</div>
		<div class=sidebar>
			<tiles:insertAttribute name="sidebar"></tiles:insertAttribute>
		</div>
		
	</div>
</body>
</html>