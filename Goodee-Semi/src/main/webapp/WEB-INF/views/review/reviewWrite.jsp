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
	<h2>후기 작성</h2>
	<form id="write" method="post">
		<div>
			<div class="m-1">
				<label class="mr-2" for="classNo">목록</label>
				<select class="w-50 rounded" name="classNo">
					<option value="-1">선택</option>
					<!-- SJ: 수강 진도 확인 하기 -->
					<c:forEach var="c" items="${ list }">
						<option value="${ c.classNo }">${ c.petName } - ${ c.courseTitle }</option>
					</c:forEach>
				</select>
			</div>
			<div class="m-1">
				<label class="mr-2" for="title">제목</label>
				<input class="w-75 form-control rounded d-inline-block" type="text" name="title">
			</div>
		</div>
		<div>
			<textarea class="border w-100 rounded p-3 overflow-hidden" id="content" name="content" spellcheck="false" style="resize: none;"></textarea>
		</div>
		<div>
			<div class="d-flex justify-content-end">
				<!-- SJ: 우선은 첨부파일은 1개 -->
				<label class="btn btn-info px-2 py-1" for="attach">이미지 첨부</label>
				<input type="file" class="d-none" name="attach">
			</div>
		</div>
		<div>
			<div class="d-flex justify-content-between">
				<a class="btn btn-primary px-2 py-1" href="<c:url value='/review/list' />">목록</a>
				<button class="btn btn-success px-2 py-1">등록하기</button>
			</div>
		</div>
	</form>
</main>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">
	const $textarea = document.querySelector('#content');
	
	$textarea.oninput = (event) => {
		const $target = event.target;
	
		$target.style.height = '202px';
		$target.style.height = $target.scrollHeight + 'px';
	};

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