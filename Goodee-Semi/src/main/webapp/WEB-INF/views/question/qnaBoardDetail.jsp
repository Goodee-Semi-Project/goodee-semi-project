<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 게시글 조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" 
integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
 crossorigin="anonymous">
 </script>
</head>
<body>
	<div style="display:flex; justify-content: between">
		<span>[QnA]</span>
		<h2>${question.questTitle}</h2>
		<span>${question.questReg}</span>
	</div>	
	<div>${question.questContent}</div>
	<input type="button" onclick='location.href="<c:url value='/qnaBoard/list'/>"' value="목록">
	
	
	<input type="button" onclick='location.href="<c:url value='/qnaBoard/list'/>"' value="수정">			
	<input type="button" onclick='location.href="<c:url value='/qnaBoard/list'/>"' value="삭제">	
	<!-- 게시글의 등록자와 현재 게시글 조회한 유저가 동일한 인물인지 확인하는 로직 추가할것 --> 
	<c:if test="${not empty loginAccount}">
		<c:if test="${loginAccount.accountNo eq question.accountNo}">
			<input type="button" onclick='location.href="<c:url value='/qnaBoard/list'/>"' value="수정">			
			<input type="button" onclick='location.href="<c:url value='/qnaBoard/list'/>"' value="삭제">			
		</c:if>
	</c:if>


</body>
</html>