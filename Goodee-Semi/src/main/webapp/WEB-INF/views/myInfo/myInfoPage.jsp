<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보</title>
	
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/myPageSideBar.jsp" %>

<main>
	<section class="">
		<h1>회원 정보</h1>
		<h2></h2>
	</section>
	
	<section class="">
		<form id="editDetail" method="post">
			<div>
				<span>${ accountDetail.name }</span>
			</div>
			<div>
				<!-- TODO: 출생년 앞자리 -->
				<c:if test="${ accountDetail.birth.substring(0, 2) } le "></c:if>
				<span>${ accountDetail.birth.substring(0, 2) }년 ${ accountDetail.birth.substring(2, 4) }월 ${ accountDetail.birth.substring(4, 6) }일</span>
			</div>
			<div>
				<input type="text" placeholder="성별" value="${ accountDetail.gender }" name="gender" id="gender">
			</div>
			<div>
				<input type="text" placeholder="이메일" value="${ accountDetail.email }" name="email" id="email">
			</div>
			<div>
				<input type="text" placeholder="전화번호" value="${ accountDetail.phone }" name="phone" id="phone">
			</div>
			<div>
				<input type="text" placeholder="우편번호" value="${ accountDetail.postNum }" name="postNum" id="postNum" readonly="readonly">
				<button id="findPost" type="button">우편번호 찾기</button>
			</div>
			<div>
				<input type="text" placeholder="주소" value="${ accountDetail.address }" name="address" id="address" readonly="readonly">
			</div>
			<div>
				<input type="text" placeholder="상세 주소" value="${ accountDetail.addressDetail }" name="addressDetail" id="addressDetail">
			</div>
			<button>변경 저장</button>
		</form>
		
	</section>
	
	<section class="">
		<form id="editPw">
			<div>
				<input type="password" placeholder="현재 비밀번호" id="currentPw">
			</div>
			<div>
				<input type="password" placeholder="새 비밀번호" id="newPw">
			</div>
			<div>
				<input type="password" placeholder="새 비밀번호 확인" id="newPwCheck">
			</div>
			<button>변경 저장</button>
		</form>
	</section>
	<a href="/myInfo/inactive">회원 탈퇴</a>
</main>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">

	$('#editPw').submit(function(e) {
		e.preventDefault();
		
		const currentPw = $('#currentPw').val();
		const newPw = $('#newPw').val();
		const newPwCheck = $('#newPwCheck').val();
		const pwReg = /^[a-zA-z0-9!@#$%^&]{8,20}$/;
		
		if (!currentPw || !newPw || !newPwCheck) {
			alert('비밀번호를 입력하세요.');
		} else if (!pwReg.test(currentPw) || !pwReg.test(newPw) || !pwReg.test(newPwCheck)) {
			alert('비밀번호는 영문, 숫자 특수문자를 포함한 8~20자 형식입니다.')
		} else if (newPw !== newPwCheck) {
			alert('비밀번호 확인이 맞지 않습니다.')
		} else {
			if (confirm('비밀번호를 변경 하시겠습니까?')) {
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
						alert(data.res_msg);
						if (data.res_code == 200) {
							location.href = "<%= request.getContextPath() %>/myInfo";
						}
					},
					error : function(data) {
						alert('비밀번호 변경 요청 실패');
					}
				});
			}
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
		
		const gender = $('#gender').val().toUpperCase();
		const email = $('#email').val();
		const phone = $('#phone').val();
		const postNum = $('#postNum').val();
		const address = $('#address').val();
		const addressDetail = $('#addressDetail').val();
		
		const emailReg = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
		const phoneReg = /^\d{3}-\d{3,4}-\d{4}$/;
		
		if (!(gender === 'M' || gender === 'F')) {
			alert('성별은 M 또는 F로 입력해주세요');
		} else if (!emailReg.test(email)) {
			alert('잘못된 이메일 형식입니다.');
		} else if (!phoneReg.test(phone)) {
			alert('잘못된 전화번호 형식입니다.');
		} else if (!address) {
			alert('주소를 입력해주세요.');
		} else if (!addressDetail) {
			alert('상세 주소를 입력해주세요.');
		} else {
			if(confirm('회원 정보를 변경하시겠습니까?')) {
				$.ajax({
					url : '/myInfo/editDetail',
					type : 'post',
					data : {
						gender : gender,
						email : email,
						phone : phone,
						postNum : postNum,
						address : address,
						addressDetail : addressDetail
					},
					dataType : 'json',
					success : function(data) {
							alert(data.res_msg);
						if (data.res_code == 200) {
							location.href = "<%= request.getContextPath() %>/myInfo";
						}
					},
					error : function(data) {
						alert('요청 실패');
					}
				});
			}
		}
	});

</script>
</body>
</html>