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
	<h2>사전 학습 수정</h2>
	
	<form id="edit" method="post">
		<input type="text" id="preNo" name="preNo" value="${ preCourse.preNo }" hidden>
		<div class="m-1">
			<label class="mr-2" for="courseNo">[목록] </label>
			<select class="w-75	 rounded" name="courseNo">
				<c:forEach var="c" items="${ courseList }">
					<option value="${ c.courseNo }" <c:if test="${ c.courseNo eq preCourse.courseNo }">selected</c:if> >${ c.title }</option>
				</c:forEach>
			</select>
		</div>
		<div class="m-1">
			<label class="mr-2" for="title">[제목] </label>
			<input type="text" class="w-75 form-control rounded d-inline-block" name="title" value="${ preCourse.preTitle }">
		</div>
		<div class="d-flex justify-content-between">
			<div class="w-75 m-1">
				<label class="mr-2" for="attach">[영상] </label>
				<input type="file" class="border rounded" name="attach">
			</div>
			<input type="text" class="w-25 rounded" name="videoLen" value="${ preCourse.videoLen }" readonly>
		</div>
	
		<!-- SJ: 퀴즈 추가 -->
		<div>
			<button type="button" class="btn btn-info px-2 py-1 my-1" onclick="addTest()">퀴즈 추가</button>
		</div>
		<input type="text" id="count" name="size" value="${ list.size() }" hidden>
		<div class="mt-1" id="testPart">
			<c:if test="${ not empty list }">
				<c:forEach var="i" begin="0" end="${ list.size() - 1 }">
					<div id="test${ i }">
						<input type="text" id="test${ i }No" name="test${ i }No" value="${ list[i].testNo }" hidden>
						<input type="text" name="answer${ i }" value="${ list[i].testAnswer }" hidden>
						<textarea class="border w-100 rounded p-3 overflow-hidden" name="content${ i }" id="content${ i }" oninput="contentInput(${ i })" spellcheck="false" style="resize: none;">${ list[i].testContent }</textarea>

						<div class="d-flex flex-row">
							<div class="d-flex flex-wrap w-75">
								<div class="my-1 mr-1 flex-grow-1">
									<input type="radio" name="quiz${ i }" value="one" <c:if test="${ list[i].testAnswer eq 'one' }">checked</c:if> >
									<input type="text" class="mx-1" name="one${ i }" value="${ list[i].one }">
								</div>
								<div class="my-1 mr-1 flex-grow-1">
									<input type="radio" name="quiz${ i }" value="two" <c:if test="${ list[i].testAnswer eq 'two' }">checked</c:if> >
									<input type="text" class="mx-1" name="two${ i }" value="${ list[i].two }">
								</div>
								<div class="my-1 mr-1 flex-grow-1">
									<input type="radio" name="quiz${ i }" value="three" <c:if test="${ list[i].testAnswer eq 'three' }">checked</c:if> >
									<input type="text" class="mx-1" name="three${ i }" value="${ list[i].three }">
								</div>
								<div class="my-1 mr-1 flex-grow-1">
									<input type="radio" name="quiz${ i }" value="four" <c:if test="${ list[i].testAnswer eq 'four' }">checked</c:if> >
									<input type="text" class="mx-1" name="four${ i }" value="${ list[i].four }">
								</div>
							</div>
							<div class="w-25 text-right">
								<button type="button" class="btn btn-danger px-2 py-1" onclick="remove(${ i })">퀴즈 삭제</button>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:if>
		</div>
		
		<div class="d-flex justify-content-end">
			<button class="btn btn-success px-2 py-1 mr-1">수정하기</button>
		</div>
	</form>

</main>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">
	function contentInput(num) {
		const $target = document.querySelector('#content' + num);
	
		$target.style.height = '202px';
		$target.style.height = $target.scrollHeight + 'px';
	};

	let i = document.querySelector('#count').value;
	function addTest() {
		html =`<%@ include file="/WEB-INF/views/preCourse/preTest.jsp" %>`;
		document.querySelector('#testPart').innerHTML += html;
		document.querySelector('#count').value = ++i;
	}
	
	function remove(num) {
		if (confirm('퀴즈를 삭제합니다. 퀴즈 삭제는 즉시 반영됩니다.')) {
			
			const testNo = $('#test' + num + 'No').val();
			
			$.ajax({
				url : '/preTest/delete',
				type : 'post',
				data : {
					testNo : testNo
				},
				dataType : 'json',
				success : function(data) {
					alert(data.res_msg);
					if (data.res_code == 200) {
						location.href="<%= request.getContextPath() %>/preCourse/edit?no=" + $('#preNo').val();
					}
				},
				error : function(data) {
					alert('요청 실패');
				},
			});
			
			document.querySelector('#test' + num).remove();
		}
	}

	$('#edit').submit(function(e) {
		e.preventDefault();
		
		const form = document.querySelector('#edit');
		const formData = new FormData(form);
		
		const courseNo = formData.get('courseNo');
		const title = formData.get('title');
		const preNo = formData.get('preNo');
		const attachName = formData.get('attach').name;
		
		for (let j = 0; j < i; j++) {
			if (!formData.get('content' + j)) {
				alert('테스트 내용을 입력해주세요.');
				return;
			} else if (!formData.get('one' + j) || !formData.get('two' + j)
					|| !formData.get('three' + j) || !formData.get('four' + j)) {
				alert('선택지 내용을 입력해주세요.');
				return;
			} else if (!formData.get('quiz' + j)) {
				alert('정답을 골라주세요');
				return;
			}
		}
		
		const attachExtIdx = attachName.lastIndexOf('.') + 1;
		const attachExt = attachName.slice(attachExtIdx).toLowerCase();
		const vidExt = ['', 'mp4', 'mov', 'avi', 'wmv', 'mkv', 'webm'];
		
		// TODO: 첨부파일 등록 확인하기
		if (!courseNo) {
			alert('교육과정을 선택해주세요.');
		} else if (!title) {
			alert('제목을 입력해주세요.');
		} else if(!vidExt.includes(attachExt)){
			alert('동영상 파일만 첨부할 수 있습니다!')
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