<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<%@ include file="/WEB-INF/views/notice/noticeHeader.jsp" %>

	<section class="blog section">
		<div class="container">
			<div class="row">
				<div class="col-lg-8">
					<c:forEach var="notice" items="${ noticeList }">
						<!-- Article -->
						<article>
							<!-- Post Image -->
							<div class="image">
								<c:choose>
									<c:when test="${ not empty notice.noticeAttach }">
										<img class="img-fluid" src="<c:url value='/filePath?no=${ notice.noticeAttach.attachNo }' />" alt="notice">
									</c:when>
									
									<c:otherwise>
										<img class="img-fluid" src="/static/images/notice/notice_default.jpg" alt="notice_default">									
									</c:otherwise>
								</c:choose>
							</div>
							<!-- Post Title -->
							<h3>${ notice.noticeTitle }</h3>
							<ul class="list-inline">
								<li class="list-inline-item">by ${ notice.writer }</li>
								<li class="list-inline-item">${ notice.regDate }</li>
							</ul>
							<!-- Post Description -->
							<p>${ notice.noticeContent }</p>
							<!-- Read more button -->
							<a href="<c:url value='/noticeDetail?no=${notice.noticeNo}'/>" class="btn btn-transparent" style="padding: 10px 20px;">상세 보기</a>
						</article>
					</c:forEach>
	
					<!-- Pagination -->
					<c:if test="${ not empty noticeList }">
						<div style="text-align: center;">
							<c:if test="${paging.prev }">
								<a href="<c:url value='/notice/list?nowPage=${paging.pageBarStart-1 }&keyword=${param.keyword }'/>" class="btn btn-outline-secondary" style="padding: 2px 5px;">
									&laquo;
								</a>
							</c:if>
							<c:forEach var="i" begin="${paging.pageBarStart }" end="${paging.pageBarEnd }">
								<a href="<c:url value='/notice/list?nowPage=${i }&keyword=${param.keyword }'/>" class="btn btn-outline-secondary" style="padding: 2px 5px;">
									${i }
								</a>
							</c:forEach>
							<c:if test="${paging.next }">
								<a href="<c:url value='/notice/list?nowPage=${paging.pageBarEnd+1 }&keyword=${param.keyword }'/>" class="btn btn-outline-secondary" style="padding: 2px 5px;">
									&raquo;
								</a>
							</c:if>			
						</div>
					</c:if>
					
				</div>
				<div class="col-lg-4">
					<div class="sidebar">
						<!-- Search Widget -->
						<div class="widget search p-0">
							<div class="input-group">
								<form action="/notice/list" method="get" style="width: 100%; display: flex;">
	  							<input type="text" class="form-control" id="expire" name="keyword" placeholder="제목 또는 작성자 검색" value="${param.keyword}">
	  							<button type="submit" class="input-group-addon"><i class="fa fa-search px-3"></i></button>
								</form>
						  </div>
						</div>
						
						<div class="widget user text-center">
							<c:choose>
								<c:when test="${ sessionScope.loginAccount.author eq 1 }">
									<c:choose>
										<c:when test="${ not empty sessionScope.loginAccount.profileAttach }">
											<img class="rounded-circle img-fluid mb-5 px-5" src="<c:url value='/filePath?no=${ sessionScope.loginAccount.profileAttach.attachNo }' />" alt="profile">
										</c:when>
										<c:otherwise>
												<img class="rounded-circle img-fluid mb-5 px-5" src="<c:url value='/static/images/user/profile.png' />" alt="profile">
										</c:otherwise>
									</c:choose>
									<h4><a href="<c:url value='/myInfo' />">${ sessionScope.loginAccount.name } 님</a></h4>
									<div class="d-grid gap-2">
											<a href="<c:url value='/notice/write' />" class="btn btn-success col-12 mt-4">공지사항 등록</a>
										</div>
								</c:when>
								
								<c:when test="${ sessionScope.loginAccount.author eq 2 }">
									<c:choose>
										<c:when test="${ not empty sessionScope.loginAccount.profileAttach }">
											<img class="rounded-circle img-fluid mb-5 px-5" src="<c:url value='/filePath?no=${ sessionScope.loginAccount.profileAttach.attachNo }' />" alt="profile">
										</c:when>
										<c:otherwise>
											<img class="rounded-circle img-fluid mb-5 px-5" src="<c:url value='/static/images/user/profile.png' />" alt="profile">
										</c:otherwise>
									</c:choose>
									<h4><a href="<c:url value='/myInfo' />">${ sessionScope.loginAccount.name } 님</a></h4>
									<p class="member-time">가입일: ${ sessionScope.loginAccount.reg_date }</p>
								</c:when>
								
								<c:otherwise>
									<div class="d-grid gap-2">
										<a href="<c:url value='/account/login' />" class="btn btn-light btn-outline-dark col-12 px-5 my-1">로그인</a>
										<a href="<c:url value='/account/register' />" class="btn btn-success col-12 px-5 my-1">회원가입</a>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</section>






	

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>