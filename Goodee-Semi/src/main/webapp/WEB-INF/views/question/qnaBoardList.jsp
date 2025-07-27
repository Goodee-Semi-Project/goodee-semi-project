<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA질문 게시판</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>

<style>
	.btn_question_add {
		padding: 5px 10px;
    	border-radius: 4px;
    	background-color: #5672f9;
    	color: white;
    	text-align: center;
    	text-decoration: none;
    	display: inline-block;
    	margin: 5px 0;
	}
	
	.btn_question_add:hover {
		color: white;
	}
	
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp"%>
	
	<div>
		<h1 class="text-center">질문 게시판</h1>
	</div>
	
	<section class="page-search">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="advance-search nice-select-white">
						<form action="<c:url value='/qnaBoard/list'/>" method="get">
							<div class="form-row align-items-center">
								<div class="form-group col-lg-2 col-md-6">
									<select class="w-100 form-control my-2 my-lg-0" name="searchBy" >
										<option value="1" ${ question.searchBy == 1 ? 'selected' : '' }>제목</option>
										<option value="2" ${ question.searchBy == 2 ? 'selected' : '' }>제목+내용</option>
										<option value="3" ${ question.searchBy == 3 ? 'selected' : '' }>작성자</option>
									</select>
								</div>
								<div class="form-group col-xl-6 col-lg-3 col-md-6">
									<input type="text" class="form-control my-2 my-lg-0" name="keyword" 
									placeholder="검색어를 입력하세요." value="${ question.keyword }">
								</div>
								<div class="form-group col-xl-2 col-lg-3 col-md-6">
									<button type="submit" class="btn btn-primary active w-100">검색</button>
								</div>
								<div class="form-group col-lg-2 col-md-6">
									<select class="w-100 form-control my-2 my-lg-0" name="orderBy">
										<option value="0" ${ question.orderBy == 0 ? 'selected' : '' }>정렬</option>
										<option value="1" ${ question.orderBy == 1 ? 'selected' : '' }>최근 날짜</option>
										<option value="2" ${ question.orderBy == 2 ? 'selected' : '' }>오래된 날짜</option>
									</select>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<c:if test="${loginAccount.author eq 2}">
		<div style="display : flex; justify-content : end;">
			<a href="<c:url value='/qnaBoard/questionAdd'/>" class="btn_question_add">
			   질문 등록
			</a>
		</div>
	</c:if>
	
	<section>
		<table class="text-center" style="table-layout: fixed; width: 100%;">
			<tbody>
				<tr style="height: 40px; border-bottom: 2px solid #999;">
					<th>글번호</th>
					<th style="width: 350px;">제목</th>
					<th>작성자</th>
					<th>등록날짜</th>
				</tr>
				<c:forEach var="q" items="${ questionList }">
					<tr style="height: 35px; border-bottom: 1px solid #ddd;">
						<td>${ q.questNo }</td>
						<td><a href="<c:url value='/qnaBoard/detail?no=${ q.questNo }'/>" style="display: block; width: 100%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${ q.questTitle }</a></td>
						<td>${ q.accountId }</td>
						<td>${ q.questReg }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</section>
	
	<c:if test="${ not empty questionList }">
		<div class="pagination justify-content-center" style="margin-top : 20px;">
			<ul class="pagination">
				<c:if test="${ question.prev }">
					<li class="page-item">
						<a class="page-link" href="<c:url value='/qnaBoard/list?nowPage=${ question.pageBarStart - 1 }&keyword=${ question.keyword }&searchBy=${ question.searchBy }&orderBy=${ question.orderBy }'/>">
							&laquo;
						</a>
					</li>
				</c:if>
				<c:forEach var="i" begin="${ question.pageBarStart }" end="${ question.pageBarEnd }">
					<li class="page-item <c:if test='${ i eq question.nowPage }'>active</c:if>">
						<a class="page-link" href="<c:url value='/qnaBoard/list?nowPage=${ i }&keyword=${ question.keyword }&searchBy=${ question.searchBy }&orderBy=${ question.orderBy }'/>">${ i }</a>
					</li>
				</c:forEach>
				<c:if test="${ question.next }">
					<li class="page-item">
						<a class="page-link" href="<c:url value='/qnaBoard/list?nowPage=${ question.pageBarEnd + 1 }&keyword=${ question.keyword }&searchBy=${ uestion.searchBy }&orderBy=${ question.orderBy }'/>">
							&raquo;
						</a>
					</li>
				</c:if>
			</ul>
		</div>
	</c:if>
	<c:if test="${ empty questionList }">
		<div class="text-center d-flex" style="width: 100%; height: 360px; justify-content: center; align-items: center;">
			<span class="h2">조회된 게시글이 없습니다</span>
		</div>
	</c:if>
	
	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>