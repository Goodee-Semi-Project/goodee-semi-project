<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 게시판</title>

<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/myPageSideBar.jsp" %>

<main>
	<h1>참여 후기</h1>

	<form id="search" method="get">
		<select id="category">
			<option>제목</option>
			<option>훈련 코스</option>
			<option>훈련사</option>
		</select>
		<input type="text" id="keyword" name="keyword" placeholder="검색" value="${ paging.keyword }">
		<button>검색</button>
	</form>

	<section>
		<div>
			<select>
				<option></option>
				<option></option>
			</select>
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
							<td>${ r.reviewDate }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<c:if test="${ not empty reviewList }">
			<div>
				<c:if test="${ paging.prev }">
					<a href="<c:url value='/review/list?nowPage=${ paging.pageBarStart - 1 }&keyword=${ paging.keyword }'/>">
						&laquo;
					</a>
				</c:if>
				<c:forEach var="i" begin="${ paging.pageBarStart }" end="${ paging.pageBarEnd }">
					<a href="<c:url value='/review/list?nowPage=${ i }&keyword=${ paging.keyword }'/>">${ i }</a>
				</c:forEach>
				<c:if test="${ paging.next }">
					<a href="<c:url value='/review/list?nowPage=${ paging.pageBarEnd + 1 }&keyword=${ paging.keyword }'/>">
						&raquo;
					</a>
				</c:if>
				
			</div>
		</c:if>
	</section>
	
</main>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">
	<%-- $('#search').submit(function(e) {
		e.preventDefault();
		
		const keyword = $('keyword').val();
		$.ajax({
			url : '/review/list',
			type : 'get',
			data : {
				keyword : keyword
			},
			dataType : 'json',
			success : function(data) {
				console.log(data.res_msg);
				if (data.res_code == 200) {
					location.href="<%= request.getContextPath() %>/review/list?nowPage=1&keyword=${ paging.keyword }"
				}
			},
			error : function(data) {
				alert('요청 실패');
			}
			
		});
	}); --%>
</script>
</body>
</html>