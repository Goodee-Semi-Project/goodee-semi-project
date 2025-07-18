<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>

<main>
	<c:forEach var="t" items="${ list }">
		<p>${ t.testContent }</p>
		<label>
			<input type="radio" name="quiz">
			${ t.one }
		</label>
		<label>
			<input type="radio" name="quiz">
			${ t.two }
		</label>
		<label>
			<input type="radio" name="quiz">
			${ t.three }
		</label>
		<label>
			<input type="radio" name="quiz">
			${ t.four }
		</label>
	
	</c:forEach>
	
</main>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>