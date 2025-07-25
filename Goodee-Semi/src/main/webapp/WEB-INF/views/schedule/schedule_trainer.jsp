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
	
	<!-- FullCalendar 스타일 커스터마이징 -->
	<link href="<c:url value='/static/css/schedule_calendar.css'/>" rel="stylesheet">
	
	<style>
        /* 모달 스타일 커스터마이징 */
        
        /* 모달 창 */
        .modal-dialog {
        	width: 350px;
        }
        .modal-content {
        	padding: 10px;
        }
        
        /* 입력 요소 정렬 */
        .form-group {
        	display: flex;
        	flex-direction: column;
        }
        .modal-content .form-group:nth-child(n + 4) {
        	flex-direction: row;
        	align-items: center;
        }
        
        /* 라벨 스타일 */
        .form-group label {
        	width: 30%;
        	margin-bottom: 0;
        }
        .form-group label span {
        	color: red;
        }
        
        /* 입력 스타일 */
        .form-group .form-control,
        .form-group .nice-select {
        	width: 100%;
        }
        .modal-content .form-group:nth-child(n + 4) .form-control,
        .modal-content .form-group:nth-child(n + 4) .nice-select {
        	width: 70%;
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
	<div id="event-modal-box" class="modal" style="display: none; justify-content: center; align-items: center; position: fixed; z-index: 999; top: 0; background: rgba(0, 0, 0, 0.5); width: 100%; height: 100%;">
		<div id="event-modal" class="modal-dialog" style="background: white;">
			<div class="modal-content">
				<div class="modal-header">
					<h2 id="modal-title">일정 등록</h2>
				</div>
				<div class="modal-body">
					<form id="modal-form">
						<div class="form-group">
							<label for="courseTitle">교육과정명 <span>*</span></label>
							<select id="course-title" class="nice-select" name="courseTitle" required>
								<option value="" disabled selected>교육과정명 선택</option>
								<c:forEach var="course" items="${courseList }">
									<option value="${course.courseNo }">${course.courseTitle }</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<label for="accountName">회원명 <span>*</span></label>
							<select id="account-name" class="nice-select" name="accountName" required disabled>
								<option value="" disabled selected>회원명 선택</option>
							</select>
						</div>
						<div class="form-group">
							<label for="petName">반려견명 <span>*</span></label>
							<select id="pet-name" class="nice-select" name="petName" required disabled>
								<option value="" disabled selected>반려견명 선택</option>
							</select>
						</div>
						<div class="form-group">
							<label for="schedStep">차시 <span>*</span></label>
							<select id="sched-step" class="nice-select" name="schedStep" required disabled>
								<option value="" disabled selected>차시 선택</option>
							</select>
						</div>
						<div class="form-group">
							<label for="start">시작 시간 <span>*</span></label>
							<input type="time" class="form-control" id="start" name="start" required>
						</div>
						<div class="form-group">
							<label for="end">종료 시간 <span>*</span></label>
							<input type="time" class="form-control" id="end" name="end" required>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" id="btn-add-event" class="btn btn-primary">저장</button>
					<button type="button" id="btn-delete-event" class="btn btn-danger" style="display:none;">삭제</button>
					<button type="button" id="btn-cancel-event" class="btn btn-secondary">취소</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>