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
	<h3 class="widget-header">
  	<%@ include file="/WEB-INF/views/include/courseInnerBar.jsp" %>
  </h3>

	<c:forEach var="c" items="${ courseList }">
		<div class="container my-2" style="height: 100px; border-radius: 10px; box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.2); overflow: hidden; padding: 0; display: flex;">
			<div class="col-3" style="padding: 0;">
			 <img style="width: 150px; height: 100px; object-fit: cover;" src="<c:url value='/filePath?no=${ c.thumbAttach.attachNo }'/>" alt="img">
			</div>
			<div class="col-4" style="display: flex; align-items: center;">
				<span style="font-size: 20px; font-weight: 700;">${ c.title }</span>
			</div>
			<div class="col-3" style="text-align: center; margin: auto;">
				<span style="font-size: 15px; font-weight: 700;">수강 인원</span>
				<br>
		   	<span style="font-size: 15px;">${c.currentEnrollment} / ${c.capacity}</span>
			</div>
			<div class="col-2" style="display: flex; justify-content: center; align-items: center;">
				<a href="<c:url value='/myCourse/memberDetail?courseNo=${c.courseNo }'/>" class="btn btn-outline-secondary" style="padding: 2px 5px;">상세보기</a>
			</div>
		</div>
	</c:forEach>
 
 	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>