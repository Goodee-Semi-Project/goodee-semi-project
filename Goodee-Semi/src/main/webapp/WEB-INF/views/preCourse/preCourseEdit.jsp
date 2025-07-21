<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>

<main>
	<h1>사전 학습 수정</h1>
	
	<form id="edit" method="post">
		<input type="text" name="preNo" value="${ preCourse.preNo }" hidden>
		<div>
			<select name="courseNo">
				<c:forEach var="c" items="${ courseList }">
					<option value="${ c.courseNo }" <c:if test="${ c.courseNo eq preCourse.courseNo }">selected</c:if> >${ c.title }</option>
				</c:forEach>
			</select>
		</div>
		<div>
			<label for="title">[제목] </label>
			<input type="text" name="title" value="${ preCourse.preTitle }">
		</div>
		<div>
			<label for="attach">[학습영상] </label>
			<input type="file" name="attach">
			<input type="text" name="videoLen" value="${ preCourse.videoLen }" readonly>
		</div>
	
		<!-- SJ: 퀴즈 추가 -->
		<input type="text" name="size" value="${ list.size() }" hidden>
		<c:forEach var="i" begin="0" end="${ list.size() - 1 }">
			<input type="text" name="test${ i }No" value="${ list[i].testNo }" hidden>
			<input type="text" name="answer${ i }" value="${ list[i].testAnswer }" hidden>
			<input type="text" name="content${ i }" value="${ list[i].testContent }">
			<br>
			<label>
				<input type="radio" name="quiz${ i }" value="one" <c:if test="${ list[i].testAnswer eq 'one' }">checked</c:if> >
				<input type="text" name="one${ i }" value="${ list[i].one }">
			</label>
			<label>
				<input type="radio" name="quiz${ i }" value="two" <c:if test="${ list[i].testAnswer eq 'two' }">checked</c:if> >
				<input type="text" name="two${ i }" value="${ list[i].two }">
			</label>
			<label>
				<input type="radio" name="quiz${ i }" value="three" <c:if test="${ list[i].testAnswer eq 'three' }">checked</c:if> >
				<input type="text" name="three${ i }" value="${ list[i].three }">
			</label>
			<label>
				<input type="radio" name="quiz${ i }" value="four" <c:if test="${ list[i].testAnswer eq 'four' }">checked</c:if> >
				<input type="text" name="four${ i }" value="${ list[i].four }">
			</label>
			<br>
		</c:forEach>
		
		<button>수정</button>
	</form>

</main>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">
	$('#edit').submit(function(e) {
		e.preventDefault();
		
		const form = document.querySelector('#edit');
		const formData = new FormData(form);
		
		const courseNo = formData.get('courseNo');
		const title = formData.get('title');
		const preNo = formData.get('preNo');
		
		// TODO: 첨부파일 등록 확인하기
		if (!courseNo) {
			alert('교육과정을 선택해주세요.');
		} else if (!title) {
			alert('제목을 입력해주세요.');
		} else {
			if (confirm('사전 교육을 수정 하시겠습니까?')) {
				$.ajax({
					url : '/preCourse/edit',
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
							location.href = "<%= request.getContextPath() %>/preCourse/detail?preNo=" + preNo;
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