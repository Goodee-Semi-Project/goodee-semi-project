<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보</title>
	
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<%@ include file="/WEB-INF/views/include/myPageSideBar.jsp" %>
	
	<!-- 모달 창 -->
	<div class="modal fade" id="deleteAccountModal" tabindex="-1" role="dialog">
	  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 700px;">
	    <div class="modal-content">
	      <div class="modal-header border-bottom-0">
	        <button type="button" class="close" data-dismiss="modal">
	          <span>&times;</span>
	        </button>
	      </div>
	      <div class="modal-body text-center">
	        <h3 class="tab-title mb-2">회원 탈퇴</h3>
	        <p>
	        	<span>탈퇴 전 확인해주세요</span>
	        </p>
	        <ul>
	        	<li>등록한 반려견의 정보는 모두 삭제됩니다.</li>
	        	<li>회원 탈퇴 후 같은 아이디로 재가입할 수 없습니다.</li>
	        	<li>작성한 글은 자동으로 삭제되지 않으며, 탈퇴 이후 수정 및 삭제가 불가능합니다.</li>
	        	<li>온라인으로 수료증 및 수강확인증 발급이 불가능하며,<br>추가 발급을 원하시는 경우 훈련소로 직접 방문해야 합니다.</li>
	        </ul>
	        
	        <input class="form-control mt-4 mb-2" style="width: 60%; margin: 0 auto;" type="password" id="checkPw" placeholder="탈퇴하시려면 사용중인 비밀번호를 입력해주세요.">
	      </div>
	      <div class="modal-footer border-top-0 mb-3 mx-5 justify-content-center">
	        <button type="button" id="dropOut" class="btn btn-danger" style="padding: 5px 10px;">탈퇴</button>
	        <button type="button" class="btn btn-outline-secondary" style="padding: 5px 10px;" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 모달 창 종료 -->
	
	
	<section style="position: relative;">
		<div>
			<form id="editDetail" method="post">
				<fieldset class="p-4">
				
					<div style="display: flex; align-items: center; width: 100%;">
						<c:choose>
							<c:when test="${ not empty attach }">
								<img width="150" height="150" style="padding: 5px; margin: 0 20px 20px 0; border: 1px solid #ced4da;" id="preview" alt="profile-img" src="<c:url value='/filePath?no=${ attach.attachNo }'/>">
							</c:when>
							<c:otherwise>
								<!-- NOTE: 공통 사용 이미지로 -->
								<img width="150" height="150" style="padding: 5px; margin: 0 20px 20px 0; border: 1px solid #ced4da;" id="preview" alt="profile-img" src="<c:url value='/static/images/user/profile.png'/>"/>
							</c:otherwise>
						</c:choose>
				
						<label for="attach" class="btn btn-outline-secondary text-primary px-2 py-1 mx-2" style="padding: 2px 5px; margin: 0 5px 0 0;">
					  	<span style="width: 100px; font-size: 12px; font-weight: 500;">수정</span>
						</label>
						<button type="button" class="btn btn-outline-danger text-danger px-2 py-1 mx-2" style="padding: 2px 5px;" onclick="removeImg(${ accountDetail.accountNo })"><span style="width: 100px; font-size: 12px; font-weight: 500;">삭제</span></button>
						<input type="file" id="attach" name="attach" onchange="readURL(this)" style="opacity: 0; width: 0%;">
					</div>
					
					<div class="mb-2" style="width: 50%; display: flex; align-items: center;">
			      <input class="form-control" style="width: 48%;" type="text" value="${ accountDetail.name }" readonly>
			      <div style="margin-left: 30px;">
			        <label for="gender" style="margin: 0 20px 0 0;">성별</label>
				      <select id="gender" name="gender">
								<c:choose>
									<c:when test="${ accountDetail.gender eq 'M'.charAt(0) }">
										<option value="M" selected>남</option>
										<option value="F">여</option>
									</c:when>
									<c:otherwise>
										<option value="M">남</option>
										<option value="F" selected>여</option>
									</c:otherwise>
								</c:choose>
							</select>
			      </div>             
			    </div>
			    
			    <div class="mb-1" style="width: 50%; display: flex; justify-content: space-between; align-items: center;">
			      <input class="form-control" style="width: 48%;" type="text" value="${ accountDetail.birth.substring(0, 2) }년 ${ accountDetail.birth.substring(2, 4) }월 ${ accountDetail.birth.substring(4, 6) }일" readonly>
			      <input class="form-control ml-2" style="width: 48%;" type="text" id="phone" name="phone" value="${ accountDetail.phone }" placeholder="전화번호" required>
			    </div>
			    <input class="form-control mb-3" style="width: 50%;" type="email" id="email" name="email" value="${ accountDetail.email }" placeholder="이메일" required>
			    
			    <div class="mb-2" style="width: 50%; display: flex; align-items: center;">
			      <input class="form-control" style="width: 40%;" type="text" id="postNum" name="postNum" value="${ accountDetail.postNum }" placeholder="우편번호" readonly>
			      <button type="button" class="btn btn-outline-secondary text-primary px-2 py-1 mx-2" style="font-weight: 500;" id="findPost">주소 변경</button>
			    </div>
			    <input class="form-control mb-2" style="width: 50%;" type="text" id="address" name="address" value="${ accountDetail.address }" placeholder="주소" readonly>
			    <input class="form-control mb-2" style="width: 50%;" type="text" id="addressDetail" name="addressDetail" value="${ accountDetail.addressDetail }" placeholder="상세주소">
				
					<button type="submit" class="btn btn-primary mt-3" >회원정보 변경</button>
				</fieldset>
			</form>
			
			<button type="button" onclick="openDeleteAccountModal()" class="btn btn-danger px-2 py-1" style="padding: 2px 5px; margin-left: 24px;">회원 탈퇴</button>	
		</div>
		
		<div style="width: 250px; position: absolute; top: 30%; right: 5%;">
			<form id="editPw">
				<h3 class="mb-4">비밀번호 변경</h3>
				<input class="form-control mb-3" type="password" id="currentPw" placeholder="현재 비밀번호" required>
				<input class="form-control mb-3" type="password" id="newPw" placeholder="새 비밀번호" required>
	      <input class="form-control mb-3" type="password" id="newPwCheck" placeholder="새 비밀번호 확인" required>
	      <button type="submit" class="btn btn-primary mt-3" >비밀번호 변경</button>
			</form>
		</div>
	</section>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">
	function openDeleteAccountModal() {
		$("#deleteAccountModal").modal("show");
	}

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

	function removeImg(accountNo) {
		Swal.fire({
			text: "프로필 사진을 삭제하시겠습니까?",
			icon: "warning",
			showCancelButton: true,
			confirmButtonColor: "#3085d6",
			cancelButtonColor: "#d33",
			confirmButtonText: "삭제",
			cancelButtonText: "취소"
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					url : '/myInfo/removeImg',
					type : 'post',
					data : {
						accountNo : accountNo
					},
					dataType : 'json',
					success : function(data) {
						if (data.res_code == 200) {
							Swal.fire({
								icon: "success",
								text: data.res_msg,
								confirmButtonText: "확인"
							}).then((result) => {
								if (result.isConfirmed) {
									location.href = "<%= request.getContextPath() %>/myInfo";						    
								}
							});
						} else {
							Swal.fire({ icon: "error", text: data.res_msg});
						}
					}
				});
			}
		});
	}

	$('#editPw').submit(function(e) {
		e.preventDefault();
		
		const currentPw = $('#currentPw').val().trim();
		const newPw = $('#newPw').val().trim();
		const newPwCheck = $('#newPwCheck').val().trim();
		const pwReg = /^[a-zA-z0-9!@#$%^&]{8,20}$/;
		
		if (!currentPw || !newPw || !newPwCheck) {
			Swal.fire({ icon: "error", text: "비밀번호를 입력하세요."});
		} else if (!pwReg.test(currentPw) || !pwReg.test(newPw) || !pwReg.test(newPwCheck)) {
			Swal.fire({ icon: "error", text: "비밀번호는 영문, 숫자 특수문자를 포함한 8~20자 형식입니다."});
		} else if (newPw !== newPwCheck) {
			Swal.fire({ icon: "error", text: "비밀번호 확인이 맞지 않습니다."});
		} else {
			Swal.fire({
				text: "비밀번호를 변경 하시겠습니까?",
				icon: "question",
				showCancelButton: true,
				confirmButtonColor: "#3085d6",
				cancelButtonColor: "#d33",
				confirmButtonText: "변경",
				cancelButtonText: "취소"
			}).then((result) => {
				if (result.isConfirmed) {
					$.ajax({
						url : '/myInfo/editPw',
						type : 'post',
						data : {
							currentPw : currentPw,
							newPw : newPw,
							newPwCheck : newPwCheck
						},
						dataType : 'json',
						success : function(data) {
							if (data.res_code == 200) {
								Swal.fire({
									icon: "success",
									text: data.res_msg,
									confirmButtonText: "확인"
								}).then((result) => {
									if (result.isConfirmed) {
										location.href = "<%= request.getContextPath() %>/myInfo";						    
									}
								});
							} else {
								Swal.fire({ icon: "error", text: data.res_msg});
							}
						},
						error : function(data) {
							Swal.fire({ icon: "error", text: "비밀번호 변경 중 오류가 발생했습니다."});
						}
					});
				}
			});
		}
	});


	$('#findPost').click(function() {
		new daum.Postcode({
			oncomplete: function(data) {
				$('#postNum').val(data.zonecode);
				$('#address').val(data.address);
			}
		}).open();
	});
	
	
	
	$('#editDetail').submit(function(e) {
		e.preventDefault();
		
		const form = document.querySelector('#editDetail');
		const formData = new FormData(form);
		
		const gender = formData.get('gender');
		const email = formData.get('email');
		const phone = formData.get('phone');
		const postNum = formData.get('postNum');
		const address = formData.get('address');
		const addressDetail = formData.get('addressDetail');
		// SJ: 이미지 파일만 등록할 수 있음
		const attachName = formData.get('attach').name;
		const attachExtIdx = attachName.lastIndexOf('.') + 1;
		const attachExt = attachName.slice(attachExtIdx).toLowerCase();
		const imgExt = ['', 'png', 'jpg', 'jpeg', 'webp', 'gif']
		
		const emailReg = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
		const phoneReg = /^\d{3}-\d{3,4}-\d{4}$/;
		
		/* if (!(gender === 'M' || gender === 'F')) {
			alert('성별은 M 또는 F로 입력해주세요');
		} */
		
		if (!gender) {
			Swal.fire({ icon: "error", text: "성별을 선택해주세요."});
		} else if (!email) {
			Swal.fire({ icon: "error", text: "이메일을 입력해주세요."});
		} else if (!phone) {
			Swal.fire({ icon: "error", text: "전화번호를 입력해주세요."});
		}
		else if (!emailReg.test(email)) {
			Swal.fire({ icon: "error", text: "잘못된 이메일 형식입니다."});
		} else if (!phoneReg.test(phone)) {
			Swal.fire({ icon: "error", text: "잘못된 전화번호 형식입니다."});
		} else if (!address) {
			Swal.fire({ icon: "error", text: "주소를 입력해주세요."});
		} else if (!addressDetail) {
			Swal.fire({ icon: "error", text: "상세 주소를 입력해주세요."});
		} else if(!imgExt.includes(attachExt)){
			Swal.fire({ icon: "error", text: "이미지 파일만 첨부할 수 있습니다."});
		} else {
			Swal.fire({
				text: "회원 정보를 변경하시겠습니까?",
				icon: "question",
				showCancelButton: true,
				confirmButtonColor: "#3085d6",
				cancelButtonColor: "#d33",
				confirmButtonText: "변경",
				cancelButtonText: "취소"
			}).then((result) => {
				if (result.isConfirmed) {
					$.ajax({
						url : '/myInfo/editDetail',
						type : 'post',
						data : formData,
						enctype : 'multipart/form-data',
						contentType : false,
						processData : false,
						cache : false,
						dataType : 'json',
						success : function(data) {
							if (data.res_code == 200) {
								Swal.fire({
									icon: "success",
									text: data.res_msg,
									confirmButtonText: "확인"
								}).then((result) => {
									if (result.isConfirmed) {
										location.href = "<%= request.getContextPath() %>/myInfo";						    
									}
								});
							} else {
								Swal.fire({ icon: "error", text: data.res_msg});
							}
						},
						error : function(data) {
							Swal.fire({ icon: "error", text: "회원정보 변경 중 오류가 발생했습니다."});
						}
					});
				}
			});
		}
	});
	
	$('#dropOut').on("click", function(e) {
		e.preventDefault();
		
		const checkPw = $('#checkPw').val().trim();
		
		if(!checkPw) {
			Swal.fire({ icon: "error", text: "비밀번호를 입력해주세요."});
		} else {
			Swal.fire({
				text: "탈퇴하시겠습니까?",
				icon: "warning",
				showCancelButton: true,
				confirmButtonColor: "#3085d6",
				cancelButtonColor: "#d33",
				confirmButtonText: "탈퇴",
				cancelButtonText: "취소"
			}).then((result) => {
				if (result.isConfirmed) {
					$.ajax({
						url : '/myInfo/inactive',
						type : 'post',
						data : {
							checkPw : checkPw
						},
						dataType : 'json',
						success : function(data) {
							if (data.res_code == 200) {
								Swal.fire({
									icon: "success",
									text: data.res_msg,
									confirmButtonText: "확인"
								}).then((result) => {
									if (result.isConfirmed) {
										location.href="<%= request.getContextPath() %>/home";						    
									}
								});
							} else {
								Swal.fire({ icon: "error", text: data.res_msg});
							}
						},
						error : function(data) {
							Swal.fire({ icon: "error", text: "회원탈퇴 처리 중 오류가 발생했습니다."});
						}
					});
				}
			});
		}
	});

</script>
</body>
</html>