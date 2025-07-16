<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA질문 게시판</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp"%>
	
	<div>
		<h1>QnA 게시판</h1>
	</div>
	<hr>
	<a href="<c:url value='/qnaBoard/questionAdd'/>">질문 등록</a>
	<div>
		<form action="<c:url value='/qnaBoard/list'/>" method="get">
			<select name="searchBy">
				<option value="1" ${question.searchBy == 1 ? 'selected' : ''}>제목</option>
				<option value="2" ${question.searchBy == 2 ? 'selected' : ''}>제목+내용</option>
				<option value="3" ${question.searchBy == 3 ? 'selected' : ''}>작성자</option>
			</select>
			<label for="keyword"></label>
			<input type="text" name="keyword" id="keyword" value="${question.keyword}">
			<input type="submit" value="검색">
			<select name="orderBy">
				<option value="0" ${question.orderBy == 0 ? 'selected' : ''}>정렬</option>
				<option value="1" ${question.orderBy == 1 ? 'selected' : ''}>최근 날짜순</option>
				<option value="2" ${question.orderBy == 2 ? 'selected' : ''}>오래된 날짜순</option>
			</select>
		</form>
	</div>
	
	<table class="text-center" style="width: 100%">
		<tbody>
			<tr style="height: 70px;">
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>등록날짜</th>
			</tr>
			<c:forEach var="q" items="${questionList}">
				<tr>
					<td>${q.questNo}</td>
					<td><a href="<c:url value='/qnaBoard/detail?no=${q.questNo}'/>">${q.questTitle}</a></td>
					<td>${q.accountId}</td>
					<td>${q.questReg}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<c:if test="${not empty questionList}">
		<div>
			<c:if test="${question.prev}">
				<a href="<c:url value='/qnaBoard/list?nowPage=${question.pageBarStart - 1}&keyword=${question.keyword}&searchBy=${question.searchBy}&orderBy=${question.orderBy}'/>">
				&laquo;
				</a>
			</c:if>
			<c:forEach var="i" begin="${question.pageBarStart}" end="${question.pageBarEnd}">
				<a href="<c:url value='/qnaBoard/list?nowPage=${i}&keyword=${question.keyword}&searchBy=${question.searchBy}&orderBy=${question.orderBy}'/>">
					${i}
				</a>			
			</c:forEach>
			<c:if test="${question.next}">
				<a href="<c:url value='/qnaBoard/list?nowPage=${question.pageBarEnd + 1 }&keyword=${question.keyword}&searchBy=${question.searchBy}&orderBy=${question.orderBy}'/>">
					&raquo;
				</a>
			</c:if>
		</div>
	</c:if>
	
	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>