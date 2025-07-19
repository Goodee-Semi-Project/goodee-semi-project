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
	
	<section class="login py-5 border-top-1">
	  <div class="container">
	    <div class="row justify-content-center">
	      <div class="col-lg-5 col-md-8 align-item-center">
	        <div class="border border">
	          <h3 class="bg-gray p-4">FIND MY PASSWORD</h3>
	          <form id="findPwSubmit">
			        <fieldset class="p-4">
			        <input class="form-control mb-2" type="text" id="accountId" placeholder="아이디" required>
			          <input class="form-control mb-2" type="text" id="name" placeholder="이름" required>
			          <input class="form-control mb-2" type="email" id="email" placeholder="이메일" required>
			          <div style="display: flex; justify-content: flex-end;"><a href="<c:url value='/account/findId' />"><span style="font-size: 14px; color: #848484;">또는 아이디 찾기</span></a></div>
			          
			          <div class="mt-5" style="display: flex; align-items: center;">
			          	<input class="form-control" type="text" id="auth" placeholder="인증번호 입력" style="width: 70%;" required>
			          	<button type="button" class="btn btn-outline-secondary" id="startAuth" style="padding: 10px 20px; margin-left: 30px;">인증</button>
			          </div>
			          
			          <div id="afterSendCode" class="mt-2 ml-2" style="opacity: 0;">
			          	<p>인증번호가 전송되었습니다.</p>
			          </div>
			              
			          <div style="width: 100%; text-align: center;">
				          <button type="submit" class="btn btn-primary font-weight-bold mt-4 mb-3" style="display: block; width: 100%;">비밀번호 찾기</button>
				          <a href="<c:url value='/account/login' />"><span style="font-size: 14px; color: #848484;">로그인하기</span></a>
			          </div>
			        </fieldset>
			      </form>
	        </div>
	      </div>
	    </div>
	  </div>
	</section>

	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<script>
		$("#startAuth").on("click", (event) => {
			const accountId = $("#accountId").val();
			const name = $("#name").val();
			const email = $("#email").val();
			
			if (!accountId) alert("아이디를 입력해주세요.");
			else if (!name) alert("이름을 입력해주세요.");
			else if (!email) alert("이메일을 입력해주세요.");
			else {
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
						$("#afterSendCode").css("opacity", "1");
					},
					error : function() {
						alert("인증번호 생성 도중 오류가 발생했습니다.");
					}
				});
			}
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