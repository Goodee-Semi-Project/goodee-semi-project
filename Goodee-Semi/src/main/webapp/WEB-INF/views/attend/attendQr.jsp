<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QR코드</title>
</head>
<body>
	<div class="container">
		<div style="display: flex; justify-content: center; align-items: center; height: 100vh">
			 <img src="<c:url value='/qr/generate?schedNo=${schedNo}'/>"
			  style="width : 500px; height : 500px;" alt="QR 코드">
		 </div>
	 </div>
</body>
</html>