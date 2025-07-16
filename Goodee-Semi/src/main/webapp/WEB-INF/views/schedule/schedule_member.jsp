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
</head>
<body>
	<!-- header -->
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<!-- 중앙정렬용 container -->
	<div id="container">
		<aside>
			<div id="profile">
				<img src="https://picsum.photos/150" alt="프로필 이미지">
				<h4>${loginAccount.name } 님</h4>
				<div>
					<p>${authurName }</p>
					<p>${regDate } 가입</p>
				</div>
			</div>
			<%@ include file="/WEB-INF/views/include/myPageSideBar.jsp" %>
		</aside>
		
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
						<label for="courseName">교육과정명 <span>*</span></label>
						<select id="course-name" name="courseName" required>
							<option value="" disabled selected>교육과정명 선택</option>
						    <option value="기초교육">기초교육</option>
						    <option value="중급교육">중급교육</option>
						    <option value="고급교육">고급교육</option>
						    <option value="특별교육">특별교육</option>
						</select>
					</div>
					<div class="form-group">
						<label for="memberName">회원명 <span>*</span></label>
						<select id="member-name" name="memberName" required>
							<option value="" disabled selected>회원명 선택</option>
						    <option value="김철수">김철수</option>
						    <option value="이영희">이영희</option>
						    <option value="박민수">박민수</option>
						</select>
					</div>
					<div class="form-group">
						<label for="petName">반려견명 <span>*</span></label>
						<select id="pet-name" name="petName" required>
							<option value="" disabled selected>반려견명 선택</option>
						    <option value="멍멍이">멍멍이</option>
						    <option value="바둑이">바둑이</option>
						    <option value="뽀삐">뽀삐</option>	
						</select>
					</div>
					<div class="form-group">
						<label for="startTime">시작 시간 <span>*</span></label>
						<input type="time" id="start-time" name="startTime" required>
					</div>
					<div class="form-group">
						<label for="endTime">종료 시간 <span>*</span></label>
						<input type="time" id="end-time" name="endTime" required>
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