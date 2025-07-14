<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>비밀번호 찾기</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
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

	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
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
					alert(data.resultMsg);
				},
				error : function() {
					alert("인증번호 생성 도중 오류가 발생했습니다.");
				}
			});
		});
		
		$("#findPwSubmit").submit((event) => {
			event.preventDefault();
			
			const accountId = $("#accountId").val();
			const name = $("#name").val();
			const email = $("#email").val();
			const authCode = $("#auth").val();
			
			$.ajax({
				url : "/account/findPw",
				type : "POST",
				data : {
					accountId : accountId,
					name : name,
					email : email,
					authCode : authCode
				},
				dataType : "JSON",
				success : function(data) {
					alert(data.resultMsg);
					
					if (data.resultCode == 200) {
						location.href = "<%= request.getContextPath() %>/account/changePw";
					}
				},
				error : function() {
					alert("인증번호 확인 도중 오류가 발생했습니다.");
				}
			});
		});
	</script>
</body>

</html>