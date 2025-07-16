<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사전 학습 등록</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%-- <%@ include file="/WEB-INF/views/include/courseInnerBar.jsp" %> --%>
<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>

<main>
	<h1>사전 학습 등록</h1>
	
	<form id="regist" method="post">
		<div>
			<select name="courseNo">
				<c:forEach var="c" items="${ courseList }">
					<option value="${ c.courseNo }">${ c.title }</option>
				</c:forEach>
			</select>
		</div>
		<div>
			<label for="title">제목</label>
			<input type="text" name="title">
		</div>
		<div>
			<label for="attach">학습영상</label>
			<input type="file" name="attach">
		</div>
	
		<!-- SJ: 퀴즈 추가 -->
		
		<button>등록</button>
	</form>

</main>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">
	$('#regist').submit(function(e) {
		e.preventDefault();
		
		const form = document.querySelector('#regist');
		const formData = new FormData(form);
		
		const courseNo = formData.get('courseNo');
		const title = formData.get('title');
		const attach = formData.get('attach');
		
		
		// TODO: 첨부파일 등록 확인하기
		if (!courseNo) {
			alert('교육과정을 선택해주세요.');
		} else if (!title) {
			alert('제목을 입력해주세요.');
		} else {
			if (confirm('사전 교육을 저장 하시겠습니까?')) {
				$.ajax({
					url : '/preCourse/regist',
					type : 'post',
					data : formData,
					enctype : 'multipart/form-data',
					contentType : false,
					processData : false,
					cache : false,
					dataType : 'json',
					success : function(data) {
						alert(data.res_msg);
						if (data.res_code == 200) {
							location.href = "<%= request.getContextPath() %>/preCourse/manage";
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