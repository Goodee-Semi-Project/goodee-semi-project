<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문 게시판</title>
<script src="<c:url value='/resources/jquery-3.7.1.js'/>"></script> 
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp"%>
	
	<h1>질문 게시판</h1>
	<hr>
	<div>
		<form action="<c:url value='/qnaBoard/searchList'/>" method="get">
			<select name="">
				<option value="">제목</option>
				<option value="">제목 + 내용</option>
				<option value="">아이디</option>
			</select>
			<label for="keywords"></label>
			<input type="text" name="keyword" id="keyword" placeholder="검색어를 입력해 주세요.">
			<input type="button" name="btn_search_keyword" value="검색">
			<select>
				<option value="">최근 날짜순</option>
				<option value="">오래된 날짜순</option>
				<option value=""></option>
				<option value=""></option>
			</select>
		</form>
	</div>
	
	
	
	
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>