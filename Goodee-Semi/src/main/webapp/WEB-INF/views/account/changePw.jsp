<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>비밀번호 재설정</title>
	
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<form id="changePwSubmit">
		<input type="password" id="accountPw" placeholder="변경할 비밀번호">
		<input type="password" id="accountPwChk" placeholder="비밀번호 확인">
		<input type="submit" value="비밀번호 변경">
	</form>
	
	<script>
		$("#changePwSubmit").submit((event) => {
			event.preventDefault();
			
			const accountPw = $("#accountPw").val();
			const accountPwChk = $("#accountPwChk").val();
			
			const pwReg = /^[a-zA-z0-9!@#$%^&]{8,20}$/
			
			if (!accountPw) alert("비밀번호를 입력해주세요.");
			else if (!pwReg.test(accountPw)) alert("사용 불가능한 비밀번호입니다.");
			else if (accountPw !== accountPwChk) alert("비밀번호가 일치하지 않습니다.");
			else {
				$.ajax({
					url : "/account/changePw",
					type : "POST",
					data : {
						accountPw : accountPw
					},
					dataType : "JSON",
					success : function(data) {
						alert(data.resultMsg);
						
						if (data.resultCode == 200) {
							location.href = "<%= request.getContextPath() %>/account/login";
						}
					},
					error : function() {
						alert("비밀번호 재설정 중 오류가 발생했습니다.");
					}
				});
			}
		});
	</script>
<body>

</body>

</html>