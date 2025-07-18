<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 작성</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/myPageSideBar.jsp" %>

<main>
	<h1>후기 작성</h1>
	<form id="write" method="post">
		<div>
			<label for="classNo">수료 목록</label>
			<select name="classNo">
				<option value="-1">선택</option>
				<!-- SJ: 수강 진도 확인 하기 -->
				<c:forEach var="c" items="${ list }">
					<option value="${ c.classNo }">${ c.petName } - ${ c.courseTitle }</option>
				</c:forEach>
			</select>
			<label for="title">제목</label>
			<input type="text" name="title">
		</div>
		<div></div>
		<div>
			<textarea rows="30" cols="100" name="content" spellcheck="false" style="resize: none;"></textarea>
		</div>
		<div>
			<!-- SJ: 우선은 첨부파일은 1개 -->
			<input type="file" name="attach">
			
		</div>
		<div>
			<a href="<c:url value='/review/list' />">목록</a>
			<button>등록하기</button>
		</div>
	</form>
</main>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">
	$('#write').submit(function(e) {
		e.preventDefault();
		

		const form = document.querySelector('#write');
		const formData = new FormData(form);
		
		const title = formData.get('title');
		const content = formData.get('content');
		const classNo = formData.get('classNo');
		// SJ: 이미지 파일만 등록할 수 있음
		const attachName = formData.get('attach').name;
		const attachExtIdx = attachName.lastIndexOf('.') + 1;
		const attachExt = attachName.slice(attachExtIdx).toLowerCase();
		const imgExt = ['', 'png', 'jpg', 'jpeg', 'webp', 'gif']
		
		if (!title) {
			alert('제목을 입력해주세요!');
		} else if (!content) {
			alert('내용을 입력해주세요!');
		} else if (!classNo || classNo == -1) {
			alert('해당 과정을 선택해주세요');
		} else if(!imgExt.includes(attachExt)){
			alert('이미지 파일만 첨부할 수 있습니다!')
		} else {
			$.ajax({
				url : '/review/write',
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
						location.href = "<%= request.getContextPath() %>/review/list";
					}
				},
				error : function(data) {
					alert('요청 실패');
				}
			});
		}
		
	});

</script>
</body>
</html>