<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QR코드</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script src="/static/plugins/jquery/jquery.min.js"></script>
</head>
<body>

	<div class="container">
		<div style="display: flex; justify-content: center; align-items: center; height: 100vh">
			 <img src="<c:url value='/qr/generate?schedNo=${ sched.schedNo }&petNo=${ sched.petNo }&courseNo=${ sched.courseNo }'/>" style="width : 400px; height : 400px;" alt="QR 코드">
		 </div>
	 </div>
	 
	 <c:if test="${not empty sched.schedNo}">
		 <script>
		 	const schedNo = '${sched.schedNo}';
		 	const stop = setInterval(function() {
		 		console.log("attendQr.jsp : 3초마다 조회중");
		 		$.ajax({
		 			url : "/attend/check",
		 			type : "get",
		 			data : { schedNo : schedNo },
		 		dataType : "json",
		 		success : function(data) {
		 			if (data.attend === true) {
		 				clearInterval(stop);
		 				
						Swal.fire({
							icon: "success",
							text: "출석이 확인되었습니다.",
							confirmButtonText: "확인"
						}).then((result) => {
							if (result.isConfirmed) {
								location.href="<%= request.getContextPath() %>/attend/detail?petNo=${sched.petNo}&courseNo=${sched.courseNo}";						    
							}
						});
					}
		 		},
		 		});
		 	}, 3000);
		 	
		 	// 페이지 뒤로가기를 하거나 새로고침을 하면 Interval종료
			window.addEventListener("beforeunload", function () {
				console.log("interval :종료됨");
				clearInterval(stop);
			});
		 </script>
	 </c:if>

</body>
</html>