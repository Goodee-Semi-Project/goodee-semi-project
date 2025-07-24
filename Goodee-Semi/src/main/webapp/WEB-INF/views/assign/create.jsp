<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>과제 생성</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
	

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>
		
	<div class="container">
	  <div class="row justify-content-center">
	    <div class="align-item-center" style="width: 100%;">
	      <h3 class="tab-title" style="text-align: center; font-size: 32px;">새 과제 생성</h3>
	      <form id="createAssignForm">
	      	<c:if test="${ sessionScope.loginAccount.author eq 1 }">
	      		<input type="hidden" id="trainer" name="trainer" value="${ sessionScope.loginAccount.accountNo }">
	      		<c:if test="${ not empty savedAssign }">
	      			<input type="hidden" id="savedAssignNo" name="savedAssignNo" value="${ savedAssign.assignNo }" />
	      		</c:if>
	      		
	      		<fieldset class="p-4">
	      			<div style="display: flex; justify-content: center; align-items: center;">
	      				<select id="selectCourse" name="selectCourse" class="selectCourse">
		      				<option value="" selected>-- 교육과정 --</option>
		      				<c:forEach var="course" items="${ courseList }">
		      					<option value="${ course.courseNo }">${ course.title }</option>
		      				</c:forEach>
		      			</select>
	      			</div>
	      			
	      			<div class="mt-2 mb-4" style="width: 90%; margin: 0 auto; display: flex; justify-content: space-between;">
	      				<div style="width: 45%;">
	      					<select id="selectPet" name="selectPet" class="selectPet">
	      						<option value="" selected>-- 반려견 --</option>
	      					</select>
	      				</div>
	      				
	      				<div style="width: 45%;">
	      					<select id="selectSchedule" name="selectSchedule" class="selectSchedule">
	      						<option value="" selected>-- 훈련 회차 --</option>
	      					</select>
	      				</div>
	      			</div>
	      			
	      			<input class="form-control mb-3" type="text" id="assignTitle" name="assignTitle" <c:if test="${ not empty savedAssign and not empty savedAssign.assignTitle }">value="${ savedAssign.assignTitle }"</c:if> placeholder="과제 제목" style="width: 90%; height: 42px; margin: 0 auto;" required>
	      			
	      			<div class="mt-2 mb-4" style="width: 90%; margin: 0 auto; display: flex; justify-content: space-between;">
	      				<div style="width: 45%;">
	      					<label>과제 시작일: </label>
	      					<input class="form-control" type="datetime-local" id="assignStart" name="assignStart" <c:if test="${ not empty savedAssign and not empty savedAssign.assignStart }">value="${ savedAssign.assignStart }"</c:if> style="width: 100%; height: 42px; margin: 0 auto;">
	      				</div>
	      				
	      				<div style="width: 45%;">
	      					<label>과제 마감일: </label>
	      					<input class="form-control" type="datetime-local" id="assignEnd" name="assignEnd" <c:if test="${ not empty savedAssign and not empty savedAssign.assignEnd }">value="${ savedAssign.assignEnd }"</c:if> style="width: 100%; height: 42px; margin: 0 auto;">
	      				</div>
	      			</div>
	      			
	      			<textarea class="form-control" id="assignContent" name="assignContent" placeholder="내용을 입력하세요." style="width: 90%; height: 400px; margin: 0 auto; resize: none;"><c:if test="${ not empty savedAssign and not empty savedAssign.assignContent }">${ savedAssign.assignContent }</c:if></textarea>
	      			
	      			<div class="mt-3 mb-3" style="display: flex; justify-content: center; align-items: center;">
	      				<div style="width: 45%;">
	             		<img width="150" height="150" <c:if test="${ not empty savedAssign and not empty savedAssign.assignAttach }">src="<c:url value='/filePath?no=${ savedAssign.assignAttach.attachNo }' />"</c:if> style="padding: 5px; margin-right: 10px; border: 1px solid #ced4da; object-fit: contain;" id="preview" />
	             		<label for="assignImage" class="btn btn-outline-secondary" style="padding: 2px 5px;">
	             			<span style="width: 100px; font-size: 12px;">이미지 선택</span>
	             		</label>
									<input type="file" id="assignImage" name="assignImage" onchange="readURL(this)" style="opacity: 0; width: 0%;">
	            	</div>
	      			</div>

	          	<div class="mt-5" style="display: flex; justify-content: center;">
	          		<button type="button" id="saveAssignForm" class="btn btn-success font-weight-bold" style="padding: 10px 20px; margin-right: 20px;">임시저장</button>
	          		<button type="button" id="submitAssignForm" class="btn btn-primary font-weight-bold" style="padding: 10px 20px; margin-right: 20px;">등록</button>
	          		<button type="button" class="btn btn-outline-secondary font-weight-bold" style="padding: 10px 20px;" onclick="history.back()">취소</button>
	          	</div>
	        	</fieldset>
	      	</c:if>
	      </form>
	    </div>
	  </div>
	</div>
		
	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<script>
		$(".selectCourse.nice-select").css({
			width : "90%"
		});
		
		$(".selectPet.nice-select").css({
			width : "100%"
		});
		
		$(".selectSchedule.nice-select").css({
			width : "100%"
		});
		
		function readURL(input) {
			if (input.files && input.files[0]) {
			  const reader = new FileReader();
			    
			  reader.onload = function(event) {
			    document.getElementById('preview').src = event.target.result;
			  };
			    
			  reader.readAsDataURL(input.files[0]);
			} else {
			  document.getElementById('preview').src = "";
			}
		}
		
		$(() => {
			$("#selectCourse").on("change", (event) => {
				const courseNo = $("#selectCourse").val();
				const flag = "pet";
				
				if (courseNo != "") {
					$.ajax({
						url : "/assign/create",
						type : "POST",
						data : {
							flag : flag,
							courseNo : courseNo
						},
						dataType: "JSON",
						success : function(data) {
							const petList = data.petList;
							
							$("select#selectPet option").remove();
							
							$("#selectPet").append(new Option("-- 반려견 --", ""));
							petList.forEach((pet) => {
								$("#selectPet").append(new Option(pet.petName, pet.petNo));
							});
							
							$("#selectPet").niceSelect("update");
							$(".selectPet.nice-select").css("width", "100%");
						},
						error : function() {
							Swal.fire({ icon: "error", text: "목록 조회 중 오류가 발생했습니다."});
						}
					});
				}
				
			});
			
			$("#selectPet").on("change", (event) => {
				const courseNo = $("#selectCourse").val();
				const petNo = $("#selectPet").val();
				const flag = "schedule";
				
				if (courseNo != "" && petNo != "") {
					$.ajax({
						url : "/assign/create",
						type : "POST",
						data : {
							flag : flag,
							courseNo : courseNo,
							petNo : petNo
						},
						dataType: "JSON",
						success : function(data) {
							const scheduleList = data.scheduleList;
							
							$("select#selectSchedule option").remove();
							
							$("#selectSchedule").append(new Option("-- 훈련 회차 --", ""));
							scheduleList.forEach((schedule) => {
								$("#selectSchedule").append(new Option(schedule.schedDate, schedule.schedNo));
							});
							
							$("#selectSchedule").niceSelect("update");
							$(".selectSchedule.nice-select").css("width", "100%");
						},
						error : function() {
							Swal.fire({ icon: "error", text: "목록 조회 중 오류가 발생했습니다."});
						}
					});
				}
				
			});
			
			$("#saveAssignForm").on("click", (event) => {
				event.preventDefault();
				
				Swal.fire({
					text: "과제를 임시저장 하시겠습니까?",
					icon: "question",
					showCancelButton: true,
					confirmButtonColor: "#3085d6",
					cancelButtonColor: "#d33",
					confirmButtonText: "저장",
					cancelButtonText: "취소"
				}).then((result) => {
					if (result.isConfirmed) {
						const formData = new FormData(document.getElementById("createAssignForm"));
						formData.append("flag", "save");
						
						$.ajax({
							url : "/assign/create",
							type : "POST",
							data : formData,
							enctype : "multipart/form-data",
							contentType : false,
							processData : false,
							cache : false,
							dataType : "JSON",
							success : function(data) {
								if (data.resultCode == 200) {
									Swal.fire({
										icon: "success",
										text: data.resultMsg,
										confirmButtonText: "확인"
									}).then((result) => {
										if (result.isConfirmed) {
											location.href = "<%= request.getContextPath() %>/assign/management";							    
										}
									});
								} else {
									Swal.fire({ icon: "error", text: data.resultMsg});
								}
							},
							error : function() {
								Swal.fire({ icon: "error", text: "임시저장 중 오류가 발생했습니다."});
							}
						});
					}
				});
			});
			
			$("#submitAssignForm").on("click", (event) => {
				event.preventDefault();
				
				Swal.fire({
					text: "과제를 생성하시겠습니까?",
					icon: "question",
					showCancelButton: true,
					confirmButtonColor: "#3085d6",
					cancelButtonColor: "#d33",
					confirmButtonText: "생성",
					cancelButtonText: "취소"
				}).then((result) => {
					if (result.isConfirmed) {
						const formData = new FormData(document.getElementById("createAssignForm"));
						formData.append("flag", "submit");
						
						$.ajax({
							url : "/assign/create",
							type : "POST",
							data : formData,
							enctype : "multipart/form-data",
							contentType : false,
							processData : false,
							cache : false,
							dataType : "JSON",
							success : function(data) {
								if (data.resultCode == 200) {
									Swal.fire({
										icon: "success",
										text: data.resultMsg,
										confirmButtonText: "확인"
									}).then((result) => {
										if (result.isConfirmed) {
											location.href = "<%= request.getContextPath() %>/assign/management";							    
										}
									});
								} else {
									Swal.fire({ icon: "error", text: data.resultMsg});
								}
							},
							error : function() {
								Swal.fire({ icon: "error", text: "과제 생성 중 오류가 발생했습니다."});
							}
						});
					}
				});
			});
		});
	</script>
</body>

</html>