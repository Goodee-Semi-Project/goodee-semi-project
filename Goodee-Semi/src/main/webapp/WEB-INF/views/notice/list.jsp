<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>공지사항</title>

	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	
	<style type="text/css">
		div.widget.text-center.user-dashboard-profile > p {
			color: #888;
			font-size: 14px;
    		font-weight: 400;
    		font-family: "Muli", sans-serif;
		}
		
		div.widget.text-center.user-dashboard-profile > h5 {
			margin-top: 10px;
		}
		
		div.widget text-center user-dashboard-profile > h5 > a {
			color: #333 !important;
		}
	</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<%@ include file="/WEB-INF/views/notice/noticeHeader.jsp" %>

	<section class="blog section">
		<div class="container">
			<div class="row">
				<div class="col-lg-9">
					<c:choose>
						<c:when test="${ not empty noticeList }">
							<c:forEach var="notice" items="${ noticeList }">
								<article>
									<div class="image">
										<c:choose>
											<c:when test="${ not empty notice.noticeAttach }">
												<img class="img-fluid" src="<c:url value='/filePath?no=${ notice.noticeAttach.attachNo }' />" style="width: 100%; height: 300px; object-fit: cover;" alt="notice">
											</c:when>
											
											<c:otherwise>
												<img class="img-fluid" src="/static/images/notice/notice_default.jpg" alt="notice_default">									
											</c:otherwise>
										</c:choose>
									</div>
									<h3>
									<c:if test="${notice.nailUp eq 'Y'}">
										<span style="color: crimson;">📌</span>
									</c:if>
									${ notice.noticeTitle }</h3>
									<ul class="list-inline">
										<li class="list-inline-item">by ${ notice.writer }</li>
										<li class="list-inline-item">${ notice.regDate }</li>
									</ul>
									<p>${ notice.noticeContent }</p>
									<a href="<c:url value='/noticeDetail?no=${notice.noticeNo}'/>" class="btn btn-transparent" style="padding: 10px 20px;">상세 보기</a>
								</article>
							</c:forEach>
						</c:when>
						
						<c:otherwise>
							<div style="height: 500px; display: flex; justify-content: center; align-items: center;">
								<h3>작성된 공지가 없습니다.</h3>
							</div>
						</c:otherwise>
					</c:choose>
	
					<!-- Pagination -->
					<c:if test="${ not empty noticeList }">
					  <div class="pagination justify-content-center">
					    <ul class="pagination">
					
					      <c:if test="${paging.prev}">
					        <li class="page-item">
					          <a class="page-link"
					             href="<c:url value='/notice/list?nowPage=${paging.pageBarStart - 1}&keyword=${param.keyword}'/>">&laquo;</a>
					        </li>
					      </c:if>
					
					      <c:forEach var="i" begin="${paging.pageBarStart}" end="${paging.pageBarEnd}">
					        <li class="page-item ${i == paging.nowPage ? 'active' : ''}">
					          <a class="page-link"
					             href="<c:url value='/notice/list?nowPage=${i}&keyword=${param.keyword}'/>">${i}</a>
					        </li>
					      </c:forEach>
					
					      <c:if test="${paging.next}">
					        <li class="page-item">
					          <a class="page-link"
					             href="<c:url value='/notice/list?nowPage=${paging.pageBarEnd + 1}&keyword=${param.keyword}'/>">&raquo;</a>
					        </li>
					      </c:if>
					
					    </ul>
					  </div>
					</c:if>					
				</div>
				<div class="col-lg-3">
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
						
						<div class="widget text-center user-dashboard-profile">
							<c:choose>
								<c:when test="${ sessionScope.loginAccount.author eq 1 }">
									<c:choose>
										<c:when test="${ not empty sessionScope.loginAccount.profileAttach }">
											<div class="profile-thumb">
												<img class="rounded-circle img-fluid" src="<c:url value='/filePath?no=${ sessionScope.loginAccount.profileAttach.attachNo }' />" alt="profile">
											</div>
										</c:when>
										<c:otherwise>
												<div class="profile-thumb">												
													<img class="rounded-circle img-fluid" src="<c:url value='/static/images/user/profile.png' />" alt="profile">
												</div>
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
											<div class="profile-thumb">
												<img class="rounded-circle img-fluid" src="<c:url value='/filePath?no=${ sessionScope.loginAccount.profileAttach.attachNo }' />" alt="profile">
											</div>
										</c:when>
										<c:otherwise>
											<div class="profile-thumb">
												<img class="rounded-circle img-fluid" src="<c:url value='/static/images/user/profile.png' />" alt="profile">
											</div>
										</c:otherwise>
									</c:choose>
									<h5><a href="<c:url value='/myInfo' />" style="color: #333 !important">${ sessionScope.loginAccount.name } 님</a></h4>
									<p class="member-time"> <c:choose><c:when test="${ sessionScope.loginAccount.author eq 1 }">훈련사</c:when><c:when test="${ sessionScope.loginAccount.author eq 2 }">회원</c:when><c:otherwise>게스트</c:otherwise></c:choose> | 가입일: ${ fn:split(sessionScope.loginAccount.reg_date, " ")[0] }</p>
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
<script>
		$(() => {
			setTimeout(() => {
				$("#homeDog1").css("opacity", "1");
			}, 1000);
			
			setTimeout(() => {
				$("#homeDog2").css("opacity", "1");
			}, 2000);
			
			setTimeout(() => {
				$("#homeDog3").css("opacity", "1");
			}, 3000);
		})
	</script>
</body>
</html>