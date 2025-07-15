<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사전 학습 상세</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>

	<main>
		<h1>사전학습 세부 정보</h1>
		<div>
			<span>교육과정</span>
			<span>${ preCourse.courseNo }</span>
		</div>
		<div>
			<span>제목</span>
			<span>${ preCourse.preTitle }</span>
		</div>
		<div>
			<span>학습영상</span>
			<span>${ preCourse.videoLen }</span>
		</div>
	
	</main>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>