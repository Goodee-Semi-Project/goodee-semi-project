<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>수강신청</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
	

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>
	<h3 class="widget-header">
  	<%@ include file="/WEB-INF/views/include/courseInnerBar.jsp" %>
  </h3>
	
	<table class="text-center" style="width: 100%">
		<thead>
			<tr style="height: 70px;">
				<th style="width: 10%">신청번호</th>
				<th style="width: 30%">신청과정</th>
				<th style="width: 20%">반려견</th>
				<th style="width: 10%">반려인</th>
				<th style="width: 30%">신청관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="enroll" items="${ myEnrollList }">
				<tr style="height: 50px;">
					<td>${ enroll.enrollNo }</td>
					<td>${ enroll.courseData.title }</td>
					<td>${ enroll.petData.petName }<br>(${ enroll.petData.petBreed } / ${ enroll.petData.petAge }살)</td>
					<td>${ enroll.accountData.name }</td>
					<td>
						<c:if test="${ sessionScope.loginAccount.author eq 1 }">
							<c:choose>
								<c:when test="${ enroll.courseData.petInCourseCount ge enroll.courseData.capacity }">
									<button type="button" class="btn btn-success disabled" onclick="alert('정원이 초과되었습니다.')" style="padding: 5px 10px;">승인</button>
								</c:when>
								
								<c:otherwise>
									<button type="button" onclick="enrollYes(${ enroll.enrollNo })" class="btn btn-success" style="padding: 5px 10px;">승인</button>								
								</c:otherwise>
							</c:choose>
							<button type="button" onclick="enrollSorry(${ enroll.enrollNo })" class="btn btn-danger" style="padding: 5px 10px;">취소</button>
						</c:if>
						
						<c:if test="${ sessionScope.loginAccount.author eq 2 }">
							<c:choose>
								<c:when test="${ enroll.enrollStatus == 89 }">
									신청이 승인되었습니다.
								</c:when>
								
								<c:when test="${ enroll.enrollStatus == 78 }">
									신청이 취소되었습니다.
								</c:when>
								
								<c:otherwise>
									<button type="button" onclick="enrollCancel(${ enroll.enrollNo })" class="btn btn-outline-secondary" style="padding: 5px 10px;">신청 취소</button>								
								</c:otherwise>
							</c:choose>
							
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	
	
	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<script>
		function enrollYes(enrollNo) {
			Swal.fire({
				text: "승인하시겠습니까?",
				icon: "question",
				showCancelButton: true,
				confirmButtonColor: "#3085d6",
				cancelButtonColor: "#d33",
				confirmButtonText: "승인",
				cancelButtonText: "취소"
			}).then((result) => {
				if (result.isConfirmed) {
					const enrollFlag = "UPDATE";
					const status = "Y";
					
					$.ajax({
						url : "/myCourse/enroll",
						type : "POST",
						data : {
							enrollFlag : enrollFlag,
							enrollNo : enrollNo,
							status : status
						},
						dataType : "JSON",
						success : function(data) {
							if (data.resultCode == 200) {
								Swal.fire({
									icon: "success",
									text: data.resultMsg,
									confirmButtonText: "확인"
								}).then((result) => {
									if (result.isConfirmed) {
										location.href = "<%= request.getContextPath() %>/myCourse/enrollList";							    
									}
								});
							} else {
								Swal.fire({ icon: "error", text: data.resultMsg});
							}
						},
						error : function() {
							Swal.fire({ icon: "error", text: "승인 중 오류가 발생했습니다."});
						}
					});
				}
			});
		}
		
		function enrollSorry(enrollNo) {
			Swal.fire({
				text: "거부하시겠습니까?",
				icon: "warning",
				showCancelButton: true,
				confirmButtonColor: "#3085d6",
				cancelButtonColor: "#d33",
				confirmButtonText: "거부",
				cancelButtonText: "취소"
			}).then((result) => {
				if (result.isConfirmed) {
					const enrollFlag = "UPDATE";
					const status = "N";
					
					$.ajax({
						url : "/myCourse/enroll",
						type : "POST",
						data : {
							enrollFlag : enrollFlag,
							enrollNo : enrollNo,
							status : status
						},
						dataType : "JSON",
						success : function(data) {
							if (data.resultCode == 200) {
								Swal.fire({
									icon: "success",
									text: data.resultMsg,
									confirmButtonText: "확인"
								}).then((result) => {
									if (result.isConfirmed) {
										location.href = "<%= request.getContextPath() %>/myCourse/enrollList";							    
									}
								});
							} else {
								Swal.fire({ icon: "error", text: data.resultMsg});
							}
						},
						error : function() {
							Swal.fire({ icon: "error", text: "거부 중 오류가 발생했습니다."});
						}
					});
				}
			});
		}
		
		function enrollCancel(enrollNo) {
			Swal.fire({
				text: "신청을 취소하시겠습니까?",
				icon: "warning",
				showCancelButton: true,
				confirmButtonColor: "#3085d6",
				cancelButtonColor: "#d33",
				confirmButtonText: "확인",
				cancelButtonText: "취소"
			}).then((result) => {
				if (result.isConfirmed) {
					const enrollFlag = "DELETE";
					
					$.ajax({
						url : "/myCourse/enroll",
						type : "POST",
						data : {
							enrollFlag : enrollFlag,
							enrollNo : enrollNo,
						},
						dataType : "JSON",
						success : function(data) {
							if (data.resultCode == 200) {
								Swal.fire({
									icon: "success",
									text: data.resultMsg,
									confirmButtonText: "확인"
								}).then((result) => {
									if (result.isConfirmed) {
										location.href = "<%= request.getContextPath() %>/myCourse/enrollList";							    
									}
								});
							} else {
								Swal.fire({ icon: "error", text: data.resultMsg});
							}
						},
						error : function() {
							Swal.fire({ icon: "error", text: "취소 중 오류가 발생했습니다."});
						}
					});
				}
			});
		}
	</script>
</body>

</html>