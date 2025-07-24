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
	
	<section class="login py-5 border-top-1">
	  <div class="container">
	    <div class="row justify-content-center">
	      <div class="col-lg-5 col-md-8 align-item-center">
	        <div class="border border">
	          <h3 class="bg-gray p-4">REGISTER</h3>
	          <form id="registerForm">
	            <fieldset class="p-4">
	              <input class="form-control mb-2" type="text" id="accountId" name="accountId" placeholder="아이디" onchange="idCheck()">
	              <p class="ml-2 mb-2" id="idCheck" style="height: 25px;"></p>
	              <input class="form-control mb-2" type="password" id="accountPw" name="accountPw" placeholder="비밀번호" onchange="pwCheck()">
	              <p class="ml-2 mb-2" id="pwCheck" style="height: 25px;"></p>
	              <input class="form-control mb-2" type="password" id="accountPwChk" placeholder="비밀번호 확인" onchange="pwCheckResult()">
	              <p class="ml-2 mb-5" id="pwCheckResult" style="height: 25px;"></p>
	              
	              <div style="display: flex; align-items: center; width: 100%;">
	             		<img width="150" height="150" style="padding: 5px; margin: 0 20px 20px 0; border: 1px solid #ced4da;" id="preview" />
	             		<label for="profileImage" class="btn btn-outline-secondary" style="padding: 2px 5px;">
	             			<span style="width: 100px; font-size: 12px;">프로필 사진 선택</span>
	             		</label>
									<input type="file" id="profileImage" name="profileImage" onchange="readURL(this)" style="opacity: 0; width: 0%;">
	              </div>
	              
	              <div class="mb-2" style="display: flex; justify-content: space-between; align-items: center;">
	              	<input class="form-control" style="width: 40%;" type="text" id="accountName" name="accountName" placeholder="이름">
	              	<div style="margin-right: 50px;">
	              		<label for="accountGender" style="margin: 0 20px 0 0;">성별</label>
		              	<select id="accountGender" name="accountGender">
											<option value="0">선택</option>
											<option value="1">남</option>
											<option value="2">여</option>
										</select>
	              	</div>             
	              </div>
	              <input class="form-control mb-2" type="email" id="accountEmail" name="accountEmail" placeholder="이메일">
	              <div class="mb-5" style="display: flex; justify-content: space-between; align-items: center;">
	              	<input class="form-control" style="width: 48%;" type="text" id="accountBirth" name="accountBirth" placeholder="생년월일 (6자리)">
	              	<input class="form-control" style="width: 48%;" type="text" id="accountPhone" name="accountPhone" placeholder="전화번호 (- 포함)">
	              </div>
	              
	              <div class="mb-2" style="display: flex; align-items: center;">
	              	<input class="form-control" style="width: 40%;" type="text" id="postcode" name="postcode" placeholder="우편번호" readonly>
	              	<button type="button" class="btn btn-outline-secondary" style="padding: 2px 5px; font-size: 12px; margin-left: 20px;" onclick="execDaumPostcode()">우편번호 찾기</button>
	              </div>
	              <input class="form-control mb-2" type="text" id="roadAddress" name="roadAddress" placeholder="주소" readonly>
	              <input class="form-control mb-2" type="text" id="detailAddress" name="detailAddress" placeholder="상세주소">
	              <div class="loggedin-forgot my-3" style="align-items: center;">
	                <input type="checkbox" id="registering" value="registering" style="vertical-align: -2px;">
	                <label for="registering"><a class="text-primary" href="#">개인정보 수집 및 이용약관</a>에 동의합니다.</label>
	              </div>
	              <button type="submit" class="btn btn-primary font-weight-bold mt-3" style="width: 100%;">회원가입</button>
	            </fieldset>
	          </form>
	        </div>
	      </div>
	    </div>
	  </div>
	</section>

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
		function readURL(input) {
		  if (input.files && input.files[0]) {
		    const reader = new FileReader();
		    
		    reader.onload = function(event) {
		      document.getElementById('preview').src = event.target.result;
		    };
		    
		    reader.readAsDataURL(input.files[0]);
		  } else {
		    document.getElementById('preview').src = "";
		  }
		}
		
		function idCheck() {
			const accountId = $("#accountId").val();
			const idReg = /^[a-z0-9]{4,16}$/
			
			if (!idReg.test(accountId)) {
				$("#accountId").css("border-color", "red");
				$("#idCheck").css("color", "red");
				$("#idCheck").text("사용할 수 없는 아이디입니다.");
				return;
			}
			
			$.ajax({
				url : "/account/idCheck",
				type : "POST",
				data : {
					accountId : accountId
				},
				dataType : "JSON",
				success : function(data) {
					if (data.resultCode == 500) {
						$("#accountId").css("border-color", "red");
						$("#idCheck").css("color", "red");
						$("#idCheck").text(data.resultMsg);
					} else {
						$("#accountId").css("border-color", "rgb(16, 185, 129)");
						$("#idCheck").css("color", "rgb(16, 185, 129)");
						$("#idCheck").text(data.resultMsg);
					}
				},
				error : function() {
					Swal.fire({ icon: "error", text: "아이디를 확인하는 중 오류가 발생했습니다."});
				}
			});
			
		}
		
		function pwCheck() {
			const accountPw = $("#accountPw").val();
			const pwReg = /^[a-zA-z0-9!@#$%^&]{8,20}$/
			
			if (!pwReg.test(accountPw)) {
				$("#accountPw").css("border-color", "red");
				$("#pwCheck").css("color", "red");
				$("#pwCheck").text("사용할 수 없는 비밀번호입니다.");
			} else {
				$("#accountPw").css("border-color", "rgb(16, 185, 129)");
				$("#pwCheck").css("color", "rgb(16, 185, 129)");
				$("#pwCheck").text("사용 가능한 비밀번호입니다.");
			}
		}
		
		function pwCheckResult() {
			const accountPw = $("#accountPw").val();
			const accountPwChk = $("#accountPwChk").val();
			
			if (accountPw !== accountPwChk) {
				$("#accountPwChk").css("border-color", "red");
				$("#pwCheckResult").css("color", "red");
				$("#pwCheckResult").text("비밀번호가 일치하지 않습니다.");
			} else {
				$("#accountPwChk").css("border-color", "rgb(16, 185, 129)");
				$("#pwCheckResult").css("color", "rgb(16, 185, 129)");
				$("#pwCheckResult").text("비밀번호가 일치합니다.");
			}
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
			const registering = $("#registering").is(":checked");
			
			const idReg = /^[a-z0-9]{4,16}$/
			const pwReg = /^[a-zA-z0-9!@#$%^&]{8,20}$/
			const nameReg = /^[가-힣]{2,8}$/
			const birthReg = /^[0-9]{6}$/
			const phoneReg = /^010-[0-9]{4}-[0-9]{4}$/
			const emailReg = /^[a-zA-Z0-9_+&*-]+(?:.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+.)+[a-zA-Z]{2,7}$/
			
			if (!accountId) Swal.fire({ icon: "error", text: "아이디를 입력해주세요."});
			else if (!idReg.test(accountId)) Swal.fire({ icon: "error", text: "사용 불가능한 아이디입니다."});
			else if (!accountPw) Swal.fire({ icon: "error", text: "비밀번호를 입력해주세요."});
			else if (!pwReg.test(accountPw)) Swal.fire({ icon: "error", text: "사용 불가능한 비밀번호입니다."});
			else if (accountPw !== accountPwChk) Swal.fire({ icon: "error", text: "비밀번호가 일치하지 않습니다."});
			else if (!nameReg.test(accountName)) Swal.fire({ icon: "error", text: "이름을 정확히 입력해주세요."});
			else if (accountGender == 0) Swal.fire({ icon: "error", text: "성별을 선택해주세요."});
			else if (!birthReg.test(accountBirth)) Swal.fire({ icon: "error", text: "생일을 정확히 입력해주세요."});
			else if (!phoneReg.test(accountPhone)) Swal.fire({ icon: "error", text: "전화번호를 정확히 입력해주세요."});
			else if (!emailReg.test(accountEmail)) Swal.fire({ icon: "error", text: "이메일을 정확히 입력해주세요."});
			else if (postcode == "") Swal.fire({ icon: "error", text: "주소를 입력해주세요."});
			else if (addressDetail == "") Swal.fire({ icon: "error", text: "상세주소를 입력해주세요."});
			else if (!registering) Swal.fire({ icon: "error", text: "개인정보 수집 및 이용약관에 동의해주세요."});
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
						if (data.resultCode != 200) {
							Swal.fire({ icon: "error", text: data.resultMsg});
						}
						
						if (data.resultCode == 200) {
							Swal.fire({
								icon: "success",
								text: data.resultMsg,
								confirmButtonText: "확인"
							}).then((result) => {
								if (result.isConfirmed) {
									location.href = "<%= request.getContextPath() %>/";								    
								}
							});
						}
					},
					error : function() {
						Swal.fire({ icon: "error", text: "회원가입 중 오류가 발생했습니다."});
					}
				});
			}
		});
	});
	</script>
</body>

</html>