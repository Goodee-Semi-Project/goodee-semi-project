<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보</title>

<script
  src="https://code.jquery.com/jquery-3.7.1.js"
  integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
  crossorigin="anonymous"></script>
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
		<form id="editDetail">
			<div>
				<span>${ myInfo.userName }</span>
			</div>
			<div>
				<span>${ myInfo.birDate }</span>
			</div>
			<div>
				<input type="text" placeholder="성별" value="${ myInfo.userGender }" name="userGender">
			</div>
			<div>
				<input type="text" placeholder="이메일" value="${ myInfo.email }" name="email">
			</div>
			<div>
				<input type="text" placeholder="전화번호" value="${ myInfo.phone }" name="phone">
			</div>
			<div>
				<input type="text" placeholder="주소" value="${ myInfo.address }" name="address">
			</div>
			<div>
				<input type="text" placeholder="상세 주소" value="${ myInfo.addressDetail }" name="addressDetail">
			</div>
			<button>변경 저장</button>
		</form>
		
	</section>
	
	<section class="">
		<form id="editPw">
			<div>
				<input type="text" placeholder="현재 비밀번호">
			</div>
			<div>
				<input type="text" placeholder="새 비밀번호">
			</div>
			<div>
				<input type="text" placeholder="새 비밀번호 확인">
			</div>
			<button>변경 저장</button>
		</form>
	</section>
	<a href="">회원 탈퇴</a>
</main>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">
	$('#editDetail').submit(function(e) {
		e.preventDefault();
		
		const form = document.querySelector('#editDetail');
		const formData = new FormData(form);
		
		if(confirm('변경하시겠습니까?') {
			$.ajax({
				url : '/myInfo/editDetail',
				type : 'post',
				data : formData,
				enctype : 'multipart/form-data',
				contentType : false,
				processData : false,
				cach : false,
				dataType : 'json',
				success : function(data) {
						alert(data.res_msg);
					if (data.res_code == 200) {
						location.href = "<%= request.getContentLength() %>/myInfo";
					}
					
				},
			});
		}
	});

</script>
</body>
</html>