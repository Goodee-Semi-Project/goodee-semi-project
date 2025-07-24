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
<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>

<main>
	<h2>사전 학습 등록</h2>
	
	<form id="regist" method="post">
		<div class="m-1">
			<label class="mr-2" for="courseNo">[목록] </label>
			<select class="w-75 rounded" name="courseNo">
				<c:forEach var="c" items="${ courseList }">
					<option value="${ c.courseNo }">${ c.title }</option>
				</c:forEach>
			</select>
		</div>
		<div class="m-1">
			<label class="mr-2" for="title">[제목] </label>
			<input type="text" class="w-75 form-control rounded d-inline-block" name="title">
		</div>
		<div class="m-1">
			<label class="mr-2" for="attach">[영상] </label>
			<input type="file" class="w-75 border rounded" id="attach" name="attach">
		</div>
	
		<!-- SJ: 퀴즈 추가 -->
		<div>
			<button type="button" class="btn btn-info px-2 py-1 my-1" onclick="addTest()">퀴즈 추가</button>
		</div>
		<input type="text" id="count" name="count" value="0" hidden>
		<div class="mt-1" id="testPart"></div>
		
		<div class="d-flex justify-content-between mt-5">
			<a class="btn btn-primary px-2 py-1" href="javascript:history.back();">뒤로가기</a>
			<button class="btn btn-success px-2 py-1 mr-1">등록</button>
		</div>
	</form>
</main>
<%@ include file="/WEB-INF/views/include/loading.jsp" %>
<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">

	function contentInput(num) {
		const $target = document.querySelector('#content' + num);
	
		$target.style.height = '202px';
		$target.style.height = $target.scrollHeight + 'px';
	}

	const arr = [];
	function remove2(num) {
		$('#test' + num).remove();
		const idx = arr.indexOf(num);
		arr.splice(idx, 1);
	}

	let i = 0;
	function addTest() {
		document.querySelector('#count').value = ++i;
		html =`<%@ include file="/WEB-INF/views/preCourse/preTest.jsp" %>`;
		$('#testPart').append(html);
		arr.push(i);
	}

	$('#regist').submit(function(e) {
		e.preventDefault();
		
		const form = document.querySelector('#regist');
		const formData = new FormData(form);
		
		formData.append('arr', arr);
		
		const courseNo = formData.get('courseNo');
		const title = formData.get('title');
		const attachName = formData.get('attach').name;
		
		for (let j = 0; j < arr.length; j++) {
			if (!formData.get('content' + arr[j])) {
				Swal.fire({ icon: "error", text: "테스트 내용을 입력해주세요."});
				return;
			} else if (!formData.get('one' + arr[j]) || !formData.get('two' + arr[j])
					|| !formData.get('three' + arr[j]) || !formData.get('four' + arr[j])) {
				Swal.fire({ icon: "error", text: "선택지 내용을 입력해주세요."});
				return;
			} else if (!formData.get('quiz' + arr[j])) {
				Swal.fire({ icon: "error", text: "정답을 골라주세요."});
				return;
			}
		}
		
		const attachExtIdx = attachName.lastIndexOf('.') + 1;
		const attachExt = attachName.slice(attachExtIdx).toLowerCase();
		const vidExt = ['mp4', 'mov', 'avi', 'wmv', 'mkv', 'webm'];
		
		// TODO: 첨부파일 등록 확인하기
		if (!courseNo) {
			Swal.fire({ icon: "error", text: "교육과정을 선택해주세요."});
		} else if (!title) {
			Swal.fire({ icon: "error", text: "제목을 입력해주세요."});
		} else if (!attachName) {
			Swal.fire({ icon: "error", text: "학습 영상을 첨부해주세요."});
		} else if(!vidExt.includes(attachExt)){
			Swal.fire({ icon: "error", text: "동영상 파일만 첨부할 수 있습니다."});
		} else {
			Swal.fire({
				text: "사전 교육을 저장 하시겠습니까?",
				icon: "question",
				showCancelButton: true,
				confirmButtonColor: "#3085d6",
				cancelButtonColor: "#d33",
				confirmButtonText: "저장",
				cancelButtonText: "취소"
			}).then((result) => {
				if (result.isConfirmed) {
					$('#loading').addClass('d-block');
					
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
							if (data.res_code == 200) {
								Swal.fire({
									icon: "success",
									text: data.res_msg,
									confirmButtonText: "확인"
								}).then((result) => {
									if (result.isConfirmed) {
										location.href = "<%= request.getContextPath() %>/preCourse/list";				    
									}
								});
							} else {
								Swal.fire({ icon: "error", text: data.res_msg});
							}
						},
						error : function(data) {
							Swal.fire({ icon: "error", text: "저장 중 오류가 발생했습니다."});
						}
					});
				}
			});
		}
	});
</script>
</body>
</html>