<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	
	<!-- Daum Postcode API -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>

	<form id="registerForm">
		<input type="text" id="accountId" name="accountId" placeholder="아이디"><br>
		<input type="password" id="accountPw" name="accountPw" placeholder="비밀번호"><br>
		<input type="password" id="accountPwChk" placeholder="비밀번호 확인"><br><br>
		
		<label>프로필 사진: </label>
		<input type="file" name="profileImage"><br>
		<input type="text" id="accountName" name="accountName" placeholder="이름">
		<select id="accountGender" name="accountGender">
			<option value="0">선택</option>
			<option value="1">남</option>
			<option value="2">여</option>
		</select><br>
		<input type="text" id="accountBirth" name="accountBirth" placeholder="생년월일"><br>
		<input type="text" id="accountPhone" name="accountPhone" placeholder="전화번호"><br>
		<input type="text" id="accountEmail" name="accountEmail" placeholder="이메일"><br><br>
		
		<input type="text" id="postcode" name="postcode" placeholder="우편번호" readonly>
		<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
		<input type="text" id="roadAddress" name="roadAddress" placeholder="도로명주소" readonly>
		<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소"><br><br>
		
		<input type="submit" value="회원가입">
	</form>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<script>
    function execDaumPostcode() {
      new daum.Postcode({
        oncomplete: function(data) {
          document.getElementById('postcode').value = data.zonecode;
          document.getElementById("roadAddress").value = data.roadAddress;
        }
      }).open();
    }
	</script>
	
	<script>
	$(() => {
		$("#registerForm").submit((event) => {
			event.preventDefault();
			
			const accountId = $("#accountId").val();
			const accountPw = $("#accountPw").val();
			const accountPwChk = $("#accountPwChk").val();
			const accountName = $("#accountName").val();
			const accountGender = $("#accountGender").val();
			const accountBirth = $("#accountBirth").val();
			const accountPhone = $("#accountPhone").val();
			const accountEmail = $("#accountEmail").val();
			const postcode = $("#postcode").val();
			const address = $("#roadAddress").val();
			const addressDetail = $("#detailAddress").val();
			
			const idReg = /^[a-z0-9]{4,16}$/
			const pwReg = /^[a-zA-z0-9!@#$%^&]{8,20}$/
			const nameReg = /^[가-힣]{2,8}$/
			const birthReg = /^[0-9]{6}$/
			const phoneReg = /^010-[0-9]{4}-[0-9]{4}$/
			const emailReg = /^[a-zA-Z0-9_+&*-]+(?:.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+.)+[a-zA-Z]{2,7}$/
			
			if (!accountId) alert("아이디를 입력해주세요.");
			else if (!idReg.test(accountId)) alert("사용 불가능한 아이디입니다.");
			else if (!accountPw) alert("비밀번호를 입력해주세요.");
			else if (!pwReg.test(accountPw)) alert("사용 불가능한 비밀번호입니다.");
			else if (accountPw !== accountPwChk) alert("비밀번호가 일치하지 않습니다.");
			else if (!nameReg.test(accountName)) alert("이름을 정확히 입력해주세요.");
			else if (accountGender == 0) alert("성별을 선택해주세요.");
			else if (!birthReg.test(accountBirth)) alert("생일을 정확히 입력해주세요.");
			else if (!phoneReg.test(accountPhone)) alert("전화번호를 정확히 입력해주세요.");
			else if (!emailReg.test(accountEmail)) alert("이메일을 정확히 입력해주세요.");
			else if (postcode == "") alert("주소를 입력해주세요.");
			else if (addressDetail == "") alert("상세주소를 입력해주세요.");
			else {
				const formData = new FormData(document.getElementById("registerForm"));
				
				$.ajax({
					url : "/account/register",
					type : "POST",
					data : formData,
					enctype : "multipart/form-data",
					contentType : false,
					processData : false,
					cache : false,
					dataType : "JSON",
					success : function(data) {
						alert(data.resultMsg);
						
						if (data.resultCode == 200) {
							location.href = "<%= request.getContextPath() %>/";
						}
					},
					error : function() {
						alert("오류 발생!!");
					}
				});
			}
		});
	});
	</script>
</body>

</html>