<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>과제 관리</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
	

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>
	
	<h3 class="tab-title mb-4 text-center">과제 관리</h3>
  <c:forEach var="course" items="${ courseList }" varStatus="index">
  	<hr>
		<div class="container my-2" style="border: 1px solid black; overflow: hidden; padding: 0; display: flex;">
			<div class="col-4" style="padding: 0;">
			 <img style="width: 200px; height: 50px; object-fit: cover;" src="<c:url value='/filePath?no=${ course.thumbAttach.attachNo }' />" alt="img">
			</div>
			<div class="col-5" style="display: flex; align-items: center;">
				<span style="font-size: 18px;">${ course.title }</span>
			</div>
			<div class="col-3" style="display:flex; align-items:center;">
		   	<span class="ml-1" style="font-size: 15px;">수강중인 반려견: ${ course.petInCourseCount }</span>
			</div>
		</div>
		
		<c:choose>
			<c:when test="${ not empty course.petList }">
				<div class="container" style="width: 90%;">
					<div class="row">
						<c:forEach var="pet" items="${ course.petList }" >
							<div class="col-4" style="height: 80px; display: flex; align-items: center;" onclick="getAssignList('${ course.courseNo }', '${ pet.petNo }')">		
								<img class="rounded-circle" style="width: 60px; display: inline-block; margin-right: 10px; border: 2px solid white; box-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);" src="<c:url value='/filePath?no=${ pet.petAttach.attachNo }' />" alt="img">
								<span class="ml-1" style="font-size: 16px;">${ pet.petName }<br>(${ pet.accountName } 님)</span>
							</div>
						</c:forEach>
					</div>
				</div>
			</c:when>
			
			<c:otherwise>
				<div style="width: 90%; height: 150px; margin: 0 auto; display: flex; justify-content: center; align-items: center;">
					<h3>수강중인 반려견이 없습니다.</h3>
				</div>
			</c:otherwise>
		</c:choose>
	</c:forEach>

	<div class="mt-4" style="display: flex; justify-content: center; align-items: center;">
		<a href="<c:url value='/assign/create' />" class="btn btn-success" style="padding: 5px 10px;">새 과제 생성</a>
	</div>
	
	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<script>
		function getAssignList(courseNo, petNo) {
			$.ajax({
				url : "/assign/management",
				type : "POST",
				data : {
					courseNo : courseNo,
					petNo : petNo
				},
				dataType : "JSON",
				success : function(data) {
					
				},
				error : function() {
					alert("페이지 이동 중 오류가 발생했습니다.");
				}
			});
		}
	</script>
</body>

</html>