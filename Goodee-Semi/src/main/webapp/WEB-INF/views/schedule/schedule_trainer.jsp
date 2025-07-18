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
	
	<script defer src="<c:url value='/static/js/schedule_trainer.js'/>"></script>
	
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
	
	<!-- modal -->
	<!-- 일정 등록/수정 모달 -->
	<div id="event-modal-box" style="display: none; justify-content: center; align-items: center; position: fixed; z-index: 9999; top: 0; background: rgba(0, 0, 0, 0.5); width: 100%; height: 100%;">
		<div id="event-modal" style="background: white;">
			<div class="modal-header">
				<h2 id="modal-title">일정 등록</h2>
			</div>
			<div class="modal-body">
				<form id="modal-form">
					<div class="form-group">
						<label for="courseTitle">교육과정명 <span>*</span></label>
						<select id="course-title" name="courseTitle" required>
							<option value="" disabled selected>교육과정명 선택</option>
							<c:forEach var="course" items="${courseList }">
								<option value="${course.courseNo }">${course.courseTitle }</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group">
						<label for="accountName">회원명 <span>*</span></label>
						<select id="account-name" name="accountName" required disabled>
							<option value="" disabled selected>회원명 선택</option>
						</select>
					</div>
					<div class="form-group">
						<label for="petName">반려견명 <span>*</span></label>
						<select id="pet-name" name="petName" required disabled>
							<option value="" disabled selected>반려견명 선택</option>
						</select>
					</div>
					<div class="form-group">
						<label for="start">시작 시간 <span>*</span></label>
						<input type="time" id="start" name="start" required>
					</div>
					<div class="form-group">
						<label for="end">종료 시간 <span>*</span></label>
						<input type="time" id="end" name="end" required>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" id="btn-add-event">저장</button>
				<button type="button" id="btn-delete-event" style="display:none;">삭제</button>
				<button type="button" id="btn-cancel-event">취소</button>
			</div>
		</div>
	</div>
</body>
</html>