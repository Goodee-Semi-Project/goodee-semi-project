<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리</title>

<%@ include file="/WEB-INF/views/include/head.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp"%>
	<%@ include file="/WEB-INF/views/include/courseInnerBar.jsp"%>

	<div>
		<h1>수강 인원 관리</h2>
	</div>

	<c:forEach var="c" items="${courseList}">
		<div style="padding : 30px">
			<div style="display : flex; justify-content : space-between;">
				<div style="display : flex; align-items : center;">
					<c:if test="${c.thumbAttach ne null}">
						<img src="<c:url value='/filePath?no=${c.thumbAttach.attachNo}'/>" alt="${c.title}" 
						style="width : 200px; height : 150px">
					</c:if>
					<h2>${c.title}</h2>
				</div>
				<div>
					<div style="margin-top : 45px;">
						<a href="<c:url value='/myCourse/MemberDetail?courseNo=${c.courseNo }'/>">상세보기</a>
						<div>수강 인원</div>
						<span>${c.currentEnrollment}</span>/<span>${c.capacity}</span>
					</div>
				</div>
			</div>
		</div>
		<hr>
	</c:forEach>

	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>