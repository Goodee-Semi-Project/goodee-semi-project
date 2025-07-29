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
	
	<section class="login py-5 border-top-1">
	  <div class="container">
	    <div class="row justify-content-center">
	      <div class="col-lg-5 col-md-8 align-item-center">
	        <div class="border border">
	          <h3 class="bg-gray p-4">FIND MY ID</h3>
	          <div id="beforeFindId">
	          	<form id="findIdSubmit">
			          <fieldset class="p-4">
			            <input class="form-control mb-2" type="text" id="name" placeholder="이름" required>
			            <input class="form-control mb-2" type="email" id="email" placeholder="이메일" required>
			            <div style="display: flex; justify-content: flex-end;"><a href="<c:url value='/account/findPw' />"><span style="font-size: 14px; color: #848484;">또는 비밀번호 찾기</span></a></div>
			              
			            <div style="width: 100%; text-align: center;">
				            <button type="submit" class="btn btn-primary font-weight-bold mt-5 mb-3" style="display: block; width: 100%;">아이디 찾기</button>
				            <a href="<c:url value='/account/login' />"><span style="font-size: 14px; color: #848484;">로그인하기</span></a>	              
			            </div>
			          </fieldset>
			        </form>
	         	</div>
	         	
	         	<div id="afterFindId" style="display: none;">
	         		<fieldset class="p-4">
	         			<p style="width: 100%; font-size: 18px; text-align: center;">회원님이 가입 시 등록한 아이디는<br><span id="foundMyId" style="font-size: 20px; font-weight: 700; color: black;">test</span> 입니다.</p>
	         			<a href="<c:url value='/account/login' />" class="btn btn-primary font-weight-bold mt-5 mb-2" style="display: block; width: 100%;">로그인하기</a>
	         			<a href="<c:url value='/account/findPw' />" class="btn btn-outline-secondary font-weight-bold mb-3" style="display: block; width: 100%;">비밀번호 찾기</a>
	         		</fieldset>
	         	</div>
	        </div>
	      </div>
	    </div>
	  </div>
	</section>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<script>
		$(() => {
			$("#findIdSubmit").submit((event) => {
				event.preventDefault();
				
				const name = $("#name").val();
				const email = $("#email").val();
				
				if (!name) Swal.fire({ icon: "error", text: "이름을 입력해주세요."});
				else if (!email) Swal.fire({ icon: "error", text: "이메일을 입력해주세요."});
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
								$("#foundMyId").text(data.accountId);
								$("#beforeFindId").css("display", "none");
								$("#afterFindId").css("display", "block");
							} else if (data.resultCode == 500) {
								Swal.fire({ icon: "error", text: "입력하신 정보와 일치하는 아이디가 없습니다."});
							}
						},
						error : function() {
							Swal.fire({ icon: "error", text: "아이디 찾기 중 오류가 발생했습니다."});
						}
					});
				}
			});
		});
	</script>
</body>

</html>