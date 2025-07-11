<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 수정</title>

<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/myPageSideBar.jsp" %>

<main>
	<h1>후기 작성</h1>
	<form id="write" method="post">
		<div>
			<label for="class">수료 목록</label>
			<select id="class">
				<option></option>
			</select>
			<label for="title">제목</label>
			<input type="text" id="title" name="title">
		</div>
		<div></div>
		<div>
			<textarea rows="30" cols="100" id="content" name="content" spellcheck="false" style="resize: none;"></textarea>
		</div>
		<div>
			<!-- 우선은 첨부파일은 1개 -->
			<input type="file" id="attach" name="attach">
			
		</div>
		<div>
			<a href="">목록</a>
			<button>등록하기</button>
		</div>
	</form>
</main>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">
	$('#write').submit(function(e) {
		e.preventDefault();

		const form = document.querySelector('#write');
		const formData = new FormData(form);
		
		const title = formData.get('title');
		const content = formData.get('content');
		
		if (!title) {
			alert('제목을 입력해주세요!');
		} else if (!content) {
			alert('내용을 입력해주세요!');
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