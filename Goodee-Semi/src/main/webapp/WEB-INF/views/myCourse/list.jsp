<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>내 교육과정</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
	

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<%@ include file="/WEB-INF/views/include/courseInnerBar.jsp" %>
	
	<c:if test="${ sessionScope.loginAccount.author eq 1 }">
		<a href="<c:url value='/myCourse/create' />">새 교육과정 생성</a>	
	</c:if>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>

</html>