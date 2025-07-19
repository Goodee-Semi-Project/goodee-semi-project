<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>비밀번호 재설정</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
	
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<section class="login py-5 border-top-1">
	  <div class="container">
	    <div class="row justify-content-center">
	      <div class="col-lg-5 col-md-8 align-item-center">
	        <div class="border border">
	          <h3 class="bg-gray p-4">FIND MY PASSWORD</h3>
	          <div id="beforeChangePw">
	          	<form id="changePwSubmit">
		            <fieldset class="p-4">
		            	<h3>본인인증이 완료되었습니다!</h3>
		            	<p>비밀번호를 재설정 해주세요.</p>
		              <input class="form-control mt-4 mb-2" type="password" id="accountPw" placeholder="변경할 비밀번호" required>
		              <input class="form-control mb-2" type="password" id="accountPwChk" placeholder="비밀번호 확인" required>
		              
		              <button type="submit" class="btn btn-primary font-weight-bold mt-3" style="width: 100%;">비밀번호 재설정</button>
		            </fieldset>
		          </form>
	          </div>
	          
	          <div id="afterChangePw" style="display: none;">
	          	<fieldset class="p-4">
		            <h3>비밀번호가 재설정 되었습니다.</h3>
		            <p>새로운 비밀번호로 로그인 해주세요.</p>
		              
		            <a href="<c:url value='/account/login' />" class="btn btn-primary font-weight-bold mt-5 mb-2" style="display: block; width: 100%;">로그인하기</a>
		          </fieldset>
	          </div>
	        </div>
	      </div>
	    </div>
	  </div>
	</section>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
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
						$("#beforeChangePw").css("display", "none");
						$("#afterChangePw").css("display", "block");
					},
					error : function() {
						alert("비밀번호 재설정 중 오류가 발생했습니다.");
					}
				});
			}
		});
	</script>

	
</body>

</html>