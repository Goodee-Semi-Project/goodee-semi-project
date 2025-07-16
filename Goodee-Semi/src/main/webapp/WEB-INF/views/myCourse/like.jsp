<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>찜 목록</title>
	
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
				<th style="width: 30%">과정명</th>
				<th style="width: 20%">훈련사</th>
				<th style="width: 20%">수강 인원</th>
				<th style="width: 40%">목록 관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="like" items="${ likeList }">
				<tr style="height: 50px;">
					<td>${ like.courseData.title }</td>
					<td>${ like.courseData.name }</td>
					<td>${ like.courseData.capacity }</td>
					<td>
						<a href="<c:url value='/course/detail?no=${ like.courseNo }' />" class="btn btn-outline-secondary" style="padding: 5px 10px;">상세 보기</a>
						<button type="button" onclick="deleteLike(${ like.pickNo })" class="btn btn-danger" style="padding: 5px 10px;">찜 해제</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<script>
		function deleteLike(pickNo) {
			if (confirm("승인하시겠습니까?")) {
				const likeFlag = "DELETE";
				
				$.ajax({
					url : "/myCourse/like",
					type : "POST",
					data : {
						likeFlag : likeFlag,
						pickNo : pickNo
					},
					dataType : "JSON",
					success : function(data) {
						alert(data.resultMsg);
						
						if (data.resultCode == 200) {
							location.href = "<%= request.getContextPath() %>/myCourse/likeList";
						}
					},
					error : function() {
						alert("처리 중 오류가 발생했습니다.");
					}
				});
			}
		}
	</script>
</body>

</html>