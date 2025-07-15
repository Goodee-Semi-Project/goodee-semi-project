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
		<input type="text" hidden id="reviewNo" value="${ review.reviewNo }">
		<label for="title">[후기]</label>
		<span id="title" name="title">${ review.reviewTitle }</span>
		<c:choose>
			<c:when test="${ review.regDate eq review.modDate }">
				<span id="date">작성일: ${ review.regDate }</span>
			</c:when>
			<c:otherwise>
				<span>수정일: ${ review.modDate }</span>
			</c:otherwise>
		</c:choose>
	</div>
	<div id="accountId">${ review.accountId }</div>
	<div>
		<c:if test="${ not empty attach }">
			<img src="<c:url value='/filePath?no=${ attach.attachNo }'/>">
		</c:if>
		<textarea rows="30" cols="100" id="content" name="content" spellcheck="false" style="resize: none;" readonly>
			${ review.reviewContent }
		</textarea>
	</div>
	<div>
		<a href="<c:url value='/review/list' />">목록</a>
		<c:if test="${ review.accountId eq loginAccount.accountId }">
			<a href="<c:url value='/review/edit?reviewNo=${ review.reviewNo }' />">수정</a>
			<input type="button" value="삭제" onclick="deleteReview()">
		</c:if>
	</div>
</main>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">
	function deleteReview() {
		if (confirm('정말 삭제하시겠습니까?')) {
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
					alert(data.res_msg);
					if (data.res_code == 200) {
						location.href="<%= request.getContextPath() %>/review/list";
					}
				},
				error : function(data) {
					alert('요청 실패');
				},
			});
		}
	}
</script>
</body>
</html>