<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 수정</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/myPageSideBar.jsp" %>

<main>
	<h1>후기 수정</h1>
	<form id="edit" method="post">
		<!-- 후기 번호 히든으로 -->
		<input type="text" id="reviewNo" name="reviewNo" value="${ review.reviewNo }" hidden>
		<div>
			<label for="class">수료 목록</label>
			<select id="class">
				<option></option>
			</select>
			<label for="title">제목</label>
			<input type="text" id="title" name="title" value="${ review.reviewTitle }">
		</div>
		<div>
			<span>${ review.accountId }</span>
			<c:choose>
				<c:when test="${ review.regDate eq review.modDate }">
					<span id="date">작성일: ${ review.regDate }</span>
				</c:when>
				<c:otherwise>
					<span>수정일: ${ review.modDate }</span>
				</c:otherwise>
			</c:choose>
		</div>
		<div>
			<textarea rows="30" cols="100" id="content" name="content" spellcheck="false" style="resize: none;">${ review.reviewContent }</textarea>
		</div>
		<div>
			<!-- 우선은 첨부파일은 1개 -->
			<input type="file" id="attach" name="attach">
			
		</div>
		<div>
			<a href="">목록</a>
			<button>수정하기</button>
		</div>
	</form>
</main>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">
	$('#edit').submit(function(e) {
		e.preventDefault();

		const form = document.querySelector('#edit');
		const formData = new FormData(form);
		
		/* const title = formData.get('title');
		const content = formData.get('content');
		const reviewNo = formData.get('reviewNo');
		console.log(reviewNo); */
		
		if (!title) {
			alert('제목을 입력해주세요!');
		} else if (!content) {
			alert('내용을 입력해주세요!');
		} else {
			$.ajax({
				url : '/review/edit',
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