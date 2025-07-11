<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 조회</title>

<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/myPageSideBar.jsp" %>

<main>
	<div>
		<label for="title">[후기]</label>
		<span id="title" name="title">${ review.reviewTitle }</span>
		<span id="date">${ review.reviewDate }</span>
	</div>
	<div>${ review.accountId }</div>
	<div>
		<textarea rows="30" cols="100" id="content" name="content" spellcheck="false" style="resize: none;" readonly>
			${ review.reviewContent }
		</textarea>
	</div>
	<div>
		<a href="<c:url value='/review/list' />">목록</a>
		<a href="">수정</a>
		<input type="button" value="삭제" onclick="">
	</div>
</main>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">

</script>
</body>
</html>