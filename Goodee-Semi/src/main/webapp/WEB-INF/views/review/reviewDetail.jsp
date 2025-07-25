<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 조회</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/myPageSideBar.jsp" %>

<main>
	<div>
		<input type="text" id="reviewNo" value="${ review.reviewNo }" hidden>
		<h2 id="title" name="title">[후기] ${ review.reviewTitle }</h2>
		<ul class="list-inline d-flex flex-wrap justify-content-between">
			<li class="list-inline-item">[코스명] ${ review.courseTitle }</li>
			<c:choose>
				<c:when test="${ review.regDate eq review.modDate }">
					<li class="list-inline-item" id="date">[작성일] ${ review.regDate }</li>
				</c:when>
				<c:otherwise>
					<li class="list-inline-item" id="date">[수정일] ${ review.modDate }</li>
				</c:otherwise>
			</c:choose>
			<li class="list-inline-item w-100">[작성자] ${ review.accountId }</li>
		</ul>
	</div>
	<div>
		<c:if test="${ not empty attach }">
			<img class="img-fluid w-100 m-2" src="<c:url value='/filePath?no=${ attach.attachNo }'/>">
		</c:if>
		<p style="font-size: 20px">${ review.reviewContent }</p>
	</div>
	<div class="d-flex justify-content-between">
		<a class="btn btn-primary px-2 py-1" href="<c:url value='/review/list' />">목록</a>
		<div>
			<c:if test="${ review.accountId eq loginAccount.accountId }">
				<a class="btn btn-success px-2 py-1" href="<c:url value='/review/edit?reviewNo=${ review.reviewNo }' />">수정</a>
				<input type="button" class="btn btn-danger px-2 py-1" value="삭제" onclick="deleteReview()">
			</c:if>
		</div>
	</div>
</main>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">
	function deleteReview() {
		Swal.fire({
			text: "후기를 삭제하시겠습니까?",
			icon: "warning",
			showCancelButton: true,
			confirmButtonColor: "#3085d6",
			cancelButtonColor: "#d33",
			confirmButtonText: "삭제",
			cancelButtonText: "취소"
		}).then((result) => {
			if (result.isConfirmed) {
				const reviewNo = $('#reviewNo').val();
				const accountId = $('#accountId').val();
				
				$.ajax({
					url : '/review/detail',
					type : 'post',
					data : {
						reviewNo : reviewNo,
						accountId : accountId
					},
					dataType : 'json',
					success : function(data){
						if (data.res_code == 200) {
							Swal.fire({
								icon: "success",
								text: data.res_msg,
								confirmButtonText: "확인"
							}).then((result) => {
								if (result.isConfirmed) {
									location.href="<%= request.getContextPath() %>/review/list";					    
								}
							});
						} else {
							Swal.fire({ icon: "error", text: data.res_msg});
						}
					},
					error : function(data) {
						Swal.fire({ icon: "error", text: "후기 삭제 중 오류가 발생했습니다."});
					},
				});
			}
		});
	}
</script>
</body>
</html>