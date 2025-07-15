<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 게시판</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/myPageSideBar.jsp" %>

<main>
	<h1>참여 후기</h1>

	<form action="<c:url value='/review/list'/>" id="search" method="get">
		<div>
		</div>
		<select name="category">
			<option value="reviewTitle">선택</option>
			<option value="reviewTitle">제목</option>
			<option value="courseTitle">훈련 코스</option>
			<option value="accountId">작성자</option>
		</select>
		<input type="text" id="keyword" name="keyword" placeholder="검색" value="${ paging.keyword }">
		<button>검색</button>
		<!-- 정렬 방법 -->
		<select name="order">
			<option value="asc">정렬</option>
			<option value="asc">오름차순</option>
			<option value="dsc">내림차순</option>
		</select>
	</form>

	<section>
		<div>
			<a href="/review/write">후기 작성</a>
		</div>
		<div>
			<table>
				<thead>
					<tr>
						<th>글번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="r" items="${ reviewList }">
						<tr>
							<td>${ r.reviewNo }</td>
							<td onclick="location.href='<c:url value="/review/detail?no=${ r.reviewNo }"/>'">${ r.reviewTitle }</td>
							<td>${ r.accountId }</td>
							<td>${ r.regDate }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<c:if test="${ not empty reviewList }">
			<div>
				<c:if test="${ paging.prev }">
					<a href="<c:url value='/review/list?nowPage=${ paging.pageBarStart - 1 }&category=${ paging.category }&keyword=${ paging.keyword }&order=${ paging.order }'/>">
						&laquo;
					</a>
				</c:if>
				<c:forEach var="i" begin="${ paging.pageBarStart }" end="${ paging.pageBarEnd }">
					<a href="<c:url value='/review/list?nowPage=${ i }&category=${ paging.category }&keyword=${ paging.keyword }&order=${ paging.order }'/>">${ i }</a>
				</c:forEach>
				<c:if test="${ paging.next }">
					<a href="<c:url value='/review/list?nowPage=${ paging.pageBarEnd + 1 }&category=${ paging.category }&keyword=${ paging.keyword }&order=${ paging.order }'/>">
						&raquo;
					</a>
				</c:if>
				
			</div>
		</c:if>
	</section>
	
</main>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>