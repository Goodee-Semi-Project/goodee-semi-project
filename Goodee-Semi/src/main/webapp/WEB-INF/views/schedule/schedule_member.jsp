<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일정표</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	
	<!-- Fullcalendar CDN -->
	<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.18/index.global.min.js"></script>
	
	<script defer src="<c:url value='/static/js/schedule_member.js'/>"></script>
	
	<!-- FullCalendar 스타일 커스터마이징 -->
	<link href="<c:url value='/static/css/schedule_calendar.css'/>" rel="stylesheet">
</head>
<body>
	<!-- header -->
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<!-- sideBar start -->
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>
	
	<!-- 중앙정렬용 container -->
	<div id="container">
		<section>
			<div id="title">
				<h3>일정표</h3>
			</div>
			<hr>

			<!-- 일정표 html을 여기에 추가 -->
			<div id='calendar-container'>
				<div id='calendar'></div>
			</div>
		</section>
	</div>
	
	<!-- sideBar end -->
	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	
	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>