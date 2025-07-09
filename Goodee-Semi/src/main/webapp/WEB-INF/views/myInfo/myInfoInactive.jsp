<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/myPageSideBar.jsp" %>

	<main>
		<span>
			탈퇴 전 확인해주세요 <br>
			
			이름: ${ accountDetail.name } <br>
			<c:if test="">
				<!-- 내 반려견 목록 -->
			</c:if>
			<br>
			
			탈퇴가 완료되면 등록 정보는 즉시 파기되며, <br>
			복구할 수 없습니다 <br>
			
			탈퇴를 원하시면 비밀번호를 입력하고 탈퇴를 진행해주세요
		</span>
	</main>
	<section>
		<form id="dropOut" method="post">
			<input type="text" id="checkPw" placeholder="비밀번호 입력">
			<button>회원 탈퇴</button>
		</form>
	</section>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">
	$('#dropOut').submit(function(e) {
		e.preventDefault();
		
		const checkPw = $('#checkPw').val();
		
		if(!accountPw) {
			alert('비밀 번호를 입력하세요.');
		} else {
			if (confirm('탈퇴하시겠습니까?')) {
				$.ajax({
					url : '/myInfo/inactive',
					type : 'post',
					data : {
						checkPw : checkPw
					},
					dataType : 'json',
					success : function(data) {
						alert(data.res_msg);
						if (data.res_code == 200) {
							location.href="<%= request.getContextPath() %>/";
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