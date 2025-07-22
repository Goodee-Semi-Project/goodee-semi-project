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
	
	<script defer src="<c:url value='/static/js/schedule_trainer_byPet.js'/>"></script>
	
	<style>
        /* FullCalendar 일정 스타일 커스터마이징 */
        
        /* 점(dot) 제거 */
        .fc-daygrid-event-dot {
            display: none;
        }
        
        /* 일정 배경색 및 기본 스타일 설정 */
        .fc-event {
            background-color: skyBlue; /* 기본 파란색 */
            border-radius: 4px;
        }
        
        /* 일정 텍스트 색상 */
/*         .fc-event-title div {
            color: white;
        } */
        
        /* 호버 효과 */
        .fc-event:hover {
            background-color: lihgtGray;
        }
        
        /* 선택된 일정 스타일 */
        .fc-event-selected {
            background-color: #1e4a72;
        }
    </style>
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
			
			<input type="hidden" id="data-pet-no" value="${petNo }">
			<input type="hidden" id="data-course-no" value="${courseNo }">
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