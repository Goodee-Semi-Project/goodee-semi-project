<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp"%>
	<%@ include file="/WEB-INF/views/include/courseInnerBar.jsp" %>
	
	<div>
		<h1>타이틀</h1>
	</div>
	
	<c:forEach>
		<div>
			<div>
				<div>
					<img alt="" src="">
				</div>
				<div>
					<span>반려견이름</span>
					<span>(회원이름**)</span>
				</div>
				<div>
					<span>@세</span>
					<span>/</span>
					<span>성별</span>
				</div>
				<div>
					품종
				</div>
			</div>
			<div>
				<button type="button" onclick="">일정</button>
				<button type="button" onclick="">과제</button>
				<button type="button" id="btn_kick_out">추방</button>
			</div>
		</div>
	</c:forEach>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	
	<script>
	
	
	
	
	
	
	
	
	
	</script>
</body>
</html>