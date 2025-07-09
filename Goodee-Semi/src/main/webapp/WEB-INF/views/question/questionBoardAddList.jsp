<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="addQnaList">
		<input type="hidden" name="boardWriter" value="${loginAccount.accountNo}">
		<label for="title">제목</label>
		<input type="text" name="title" id="title" placeholder="제목 입력">
		<textarea rows="40" cols="70"></textarea>
	</form>
	
	<a href="<c:url value='/qnaBoard/list'/>">목록</a>
</body>
</html>