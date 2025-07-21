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
	
	<section class="page-search">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="advance-search nice-select-white">
						<form action="<c:url value='/review/list'/>" id="search" method="get">
							<div class="form-row align-items-center">
								<div class="form-group col-lg-2 col-md-6">
									<select class="w-100 form-control my-2 my-lg-0" name="category">
										<option value="reviewTitle">선택</option>
										<option value="reviewTitle" <c:if test="${ paging.category eq 'reviewTitle' }">selected</c:if> >제목</option>
										<option value="courseTitle" <c:if test="${ paging.category eq 'courseTitle' }">selected</c:if> >훈련 코스</option>
										<option value="accountId" <c:if test="${ paging.category eq 'accountId' }">selected</c:if> >작성자</option>
									</select>
								</div>
								<div class="form-group col-xl-6 col-lg-3 col-md-6">
									<input type="text" class="form-control my-2 my-lg-0" id="keyword" name="keyword" placeholder="검색" value="${ paging.keyword }">
								</div>
								<div class="form-group col-xl-2 col-lg-3 col-md-6">
									<button class="btn btn-primary active w-100">검색</button>
								</div>
								<!-- 정렬 방법 -->
								<div class="form-group col-lg-2 col-md-6">
									<select class="w-100 form-control my-2 my-lg-0" name="order">
										<option value="dsc">정렬</option>
										<option value="dsc" <c:if test="${ paging.order eq 'dsc' }">selected</c:if> >최신순</option>
										<option value="asc" <c:if test="${ paging.order eq 'asc' }">selected</c:if> >오래된순</option>
									</select>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section>
		<div class="my-1 w-100 text-right">
			<a href="/review/write" class="btn btn-main-sm" >후기 작성</a>
		</div>
		<div>
			<table class="table table-hover text-center">
				<thead class="w-100">
					<tr class="w-100">
						<th class="w-5">글번호</th>
						<th class="w-50">제목</th>
						<th class="w-20">작성자</th>
						<th class="w-20">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="r" items="${ reviewList }">
						<tr>
							<td>${ r.reviewNo }</td>
							<td class="btn w-100" onclick="location.href='<c:url value="/review/detail?no=${ r.reviewNo }"/>'">${ r.reviewTitle }</td>
							<td>${ r.accountId }</td>
							<td>${ r.regDate.substring(0, 10) }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<c:if test="${ not empty reviewList }">
			<div class="pagination justify-content-center">
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