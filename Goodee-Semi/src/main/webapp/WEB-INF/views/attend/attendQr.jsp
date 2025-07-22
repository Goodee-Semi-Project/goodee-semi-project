<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QR코드</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>

	<div class="container">
		<div style="display: flex; justify-content: center; align-items: center; height: 100vh">
			 <img src="<c:url value='/qr/generate?schedNo=${ sched.schedNo }'/>" style="width : 400px; height : 400px;" alt="QR 코드">
		 </div>
	 </div>
	 
<!-- 	 <script> -->
// 	 	const schedNo = '${sched.schedNo}';
// 	 	const stop = setInterval(function() {
// 	 		$.ajax({
// 	 			url : "/attend/check",
// 	 			type : "get",
// 	 			data : { schedNo : schedNo },
// 	 		dataType : "json",
// 	 		success : function(data) {
// 	 			if(data.attend === true) {
// 	 				clearInterval(stop);
// 	 				alert("출석이 확인되었습니다")
<%-- 	 				location.href="<%= request.getContextPath() %>/attend/detail?petNo=${sched.petNo}&courseNo=${sched.courseNo}"; --%>
// 	 			}
// 	 		},
// 	 		});
// 	 	}, 3000);
<!-- 	 </script> -->
</body>
</html>