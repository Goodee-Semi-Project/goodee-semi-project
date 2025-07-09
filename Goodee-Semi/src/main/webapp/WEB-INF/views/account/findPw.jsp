<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>비밀번호 찾기</title>
	
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<form id="findPwSubmit">
		<input type="text" id="accountId" placeholder="아이디"><br>
		<input type="text" id="name" placeholder="이름"><br>
		<input type="text" id="email" placeholder="이메일"><br><br>
		
		<input type="number" id="auth" placeholder="인증번호 입력">
		<button type="button" id="startAuth">인증</button>
		<input type="submit" value="비밀번호 찾기">
	</form>

	<script>
		$("#startAuth").on("click", (event) => {
			const accountId = $("#accountId").val();
			const name = $("#name").val();
			const email = $("#email").val();
			
			$.ajax({
				url : "/account/findPw",
				type : "POST",
				data : {
					accountId : accountId,
					name : name,
					email : email
				},
				dataType : "JSON",
				success : function(data) {
					
				},
				error : function() {
					alert("인증번호 생성 도중 오류가 발생했습니다.");
				}
			});
		});
	</script>
</body>

</html>