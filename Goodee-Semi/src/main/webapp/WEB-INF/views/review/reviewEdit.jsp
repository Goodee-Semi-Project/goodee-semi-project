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
	<h2>후기 수정</h2>
	<form id="edit" method="post">
		<!-- 후기 번호 히든으로 -->
		<input type="text" id="reviewNo" name="reviewNo" value="${ review.reviewNo }" hidden>
		<div>
			<div class="m-1">
				<label class="mr-2" for="classNo">[목록] </label>
				<select class="w-75 rounded" name="classNo">
					<option value="-1">선택</option>
					<c:forEach var="c" items="${ list }">
						<option value="${ c.classNo }" <c:if test="${ c.classNo eq review.classNo }">selected</c:if> >${ c.petName } - ${ c.courseTitle }</option>
					</c:forEach>
				</select>
			</div>
			<div class="m-1">
				<label class="	mr-2" for="title">[제목] </label>
				<input type="text" class="w-75 form-control rounded d-inline-block" id="title" name="title" value="${ review.reviewTitle }">
			</div>
		</div>
		<div class="d-flex justify-content-between">
			<p my-1>[작성자] ${ review.accountId }</p>
			<c:choose>
				<c:when test="${ review.regDate eq review.modDate }">
					<p my-1 id="date">[작성일] ${ review.regDate }</p>
				</c:when>
				<c:otherwise>
					<p my-1>[수정일] ${ review.modDate }</p>
				</c:otherwise>
			</c:choose>
		</div>
		<c:if test="${ not empty attach }">
			<img class="img-fluid w-100 m-2" src="<c:url value='/filePath?no=${ attach.attachNo }'/>">
		</c:if>
		<div>
			<textarea class="border w-100 rounded p-3 overflow-hidden" id="content" name="content" spellcheck="false" style="height: 300px; resize: none;">${ review.reviewContent }</textarea>
		</div>
		<div class="d-flex justify-content-end">
			<!-- SJ: 우선은 첨부파일은 1개 -->
			<div class="position-relative mx-2" style="width: 100px;">
				<img alt="미리보기" class="position-absolute w-100" id="preview"/>
			</div>
			<label class="btn btn-info px-2 py-1 d-inline" for="attach">이미지 변경</label>
			<input type="file" class="d-none" id="attach" name="attach" onchange="readURL(this);">
		</div>
		<div class="d-flex justify-content-between mt-5">
			<a class="btn btn-primary px-2 py-1" href="javascript:history.back();">뒤로가기</a>
			<button class="btn btn-success px-2 py-1">수정하기</button>
		</div>
	</form>
</main>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">
	function readURL(input) {
		if (input.files && input.files[0]) {
			let reader = new FileReader();
			reader.onload = function(e) {
				document.querySelector('#preview').src = e.target.result;
			};
			reader.readAsDataURL(input.files[0]);
		} else {
			document.querySelector('#preview').src = "";
		}
	}

	const $textarea = document.querySelector('#content');
	
	$textarea.oninput = (event) => {
		const $target = event.target;
	
		$target.style.height = '302px';
		$target.style.height = $target.scrollHeight + 'px';
	};
	
	$('#edit').submit(function(e) {
		e.preventDefault();

		const form = document.querySelector('#edit');
		const formData = new FormData(form);
		
		const title = formData.get('title');
		const content = formData.get('content');
		const classNo = formData.get('classNo');
		// SJ: 이미지 파일만 등록할 수 있음
		const attachName = formData.get('attach').name;
		const attachExtIdx = attachName.lastIndexOf('.') + 1;
		const attachExt = attachName.slice(attachExtIdx).toLowerCase();
		const imgExt = ['', 'png', 'jpg', 'jpeg', 'webp', 'gif']
		
		const reviewNo = formData.get('reviewNo');
		
		if (!title) {
			Swal.fire({ icon: "error", text: "제목을 입력해주세요."});
		} else if (!content) {
			Swal.fire({ icon: "error", text: "내용을 입력해주세요."});
		} else if (!classNo || classNo == -1) {
			Swal.fire({ icon: "error", text: "교육과정을 선택해주세요."});
		} else if(!imgExt.includes(attachExt)){
			Swal.fire({ icon: "error", text: "이미지 파일만 첨부할 수 있습니다."});
		} else {
			Swal.fire({
				text: "후기를 수정하시겠습니까?",
				icon: "question",
				showCancelButton: true,
				confirmButtonColor: "#3085d6",
				cancelButtonColor: "#d33",
				confirmButtonText: "수정",
				cancelButtonText: "취소"
			}).then((result) => {
				if (result.isConfirmed) {
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
							if (data.res_code == 200) {
								Swal.fire({
									icon: "success",
									text: data.res_msg,
									confirmButtonText: "확인"
								}).then((result) => {
									if (result.isConfirmed) {
										location.href = "<%= request.getContextPath() %>/review/detail?no=" + reviewNo;				    
									}
								});
							} else {
								Swal.fire({ icon: "error", text: data.res_msg});
							}
						},
						error : function(data) {
							Swal.fire({ icon: "error", text: "후기 수정 중 오류가 발생했습니다."});
						}
					});
				}
			});
		}
	});

</script>
</body>
</html>