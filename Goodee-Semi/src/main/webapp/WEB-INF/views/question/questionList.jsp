<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문 게시판</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" 
integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
 crossorigin="anonymous">
 </script>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp"%>
	
	<h1>질문 게시판</h1>
	<hr>
	<div>
		<form action="<c:url value='/qnaBoard/searchList'/>" method="get">
			<select name="searchBy">
				<option value="1">제목</option>
				<option value="2">제목+내용</option>
				<option value="3">아이디</option>
			</select>
			<label for="keyword_input"></label>
			<input type="text" name="keyword_input" id="keyword_input" placeholder="검색어를 입력해 주세요.">
			<input type="submit" name="btn_search" value="검색">
			<select name="orderBy">
				<option value="1">정렬</option>
				<option value="2">최근 날짜순</option>
				<option value="3">오래된 날짜순</option>
			</select>
		</form>
	</div>
	
	<c:forEach var="q" items="${questionList }">
		<span>${q.questNo }</span>
		<a href="<c:url value='/question/list/detail'/>">${q.questTitle}</a>
		<span>${q.userId }</span>
		<span>${q.questReg }</span>
		<hr>
	</c:forEach>
	
	
	
	
	
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>