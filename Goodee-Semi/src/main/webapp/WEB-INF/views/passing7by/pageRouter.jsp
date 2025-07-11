<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테스트 할 페이지들</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
	<a href="<c:url value='/myPet/list'/>">내 반려견</a>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>