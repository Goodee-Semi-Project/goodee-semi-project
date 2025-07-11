<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>아이디 찾기</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>

	<form id="findIdSubmit">
		<input type="text" id="name" placeholder="이름">
		<input type="text" id="email" placeholder="이메일">
		<input type="submit" value="아이디 찾기">
	</form>
	
	<a href="<c:url value='/account/findPw' />">또는 비밀번호 찾기</a>
	<a href="<c:url value='/account/login' />">로그인하기</a>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<script>
		$(() => {
			$("#findIdSubmit").submit((event) => {
				event.preventDefault();
				
				const name = $("#name").val();
				const email = $("#email").val();
				
				if (!name) alert("이름을 입력해주세요.");
				else if (!email) alert("이메일을 입력해주세요.");
				else {
					$.ajax({
						url : "/account/findId",
						type : "POST",
						data : {
							name : name,
							email : email
						},
						dataType : "JSON",
						success : function(data) {
							if (data.resultCode == 200) {
								alert(data.accountId); // TODO 결과를 화면에 출력하기
							}
						},
						error : function() {
							alert("아이디 찾기 중 오류가 발생했습니다.");
						}
					});
				}
			});
		});
	</script>
</body>

</html>