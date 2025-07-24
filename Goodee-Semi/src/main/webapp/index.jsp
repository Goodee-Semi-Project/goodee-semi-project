<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<title>## 고객과 반려견이 더 가까워지는 곳! 멍스터클래스 ##</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<section class="hero-area bg-1 text-left overly" style="position: relative;">
	<!-- Container Start -->
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<!-- Header Contetnt -->
				<div class="content-block">
					<h1 style="color: #0062CC; text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;">고객과 반려견이<br>더 가까워질 수 있도록.</h1>
					<p style="color: rgb(0, 0, 0, 0.7);">더 안전한 훈련, 더 정확한 행동 교정,<br>고객과 훈련사의 1:1 맞춤 관리 시스템으로<br>반려견과 함께하는 더 나은 삶을 위해 노력합니다.</p>
				</div>
				<!-- Advance Search -->
				<%@ include file="/WEB-INF/views/include/search.jsp" %>
			</div>
		</div>
	</div>
	
	<div id="homeDog1" style="position: absolute; top: 35%; right: 30%; border-radius: 10px; overflow: hidden; z-index: 10; transform: rotate(-20deg); opacity: 0; transition: 0.5s;">
		<img width="200" height="200" src="/static/images/home/homeDog1.jpg" style="border: 7px solid white;" alt="dog" />
	</div>
	
	<div id="homeDog2" style="position: absolute; top: 15%; right: 25%; border-radius: 10px; overflow: hidden; z-index: 11; opacity: 0; transition: 0.5s;">
		<img width="200" height="200" src="/static/images/home/homeDog2.jpg" style="border: 7px solid white;" alt="dog" />
	</div>
	
	<div id="homeDog3" style="position: absolute; top: 35%; right: 20%; border-radius: 10px; overflow: hidden; z-index: 12; transform: rotate(20deg); opacity: 0; transition: 0.5s;">
		<img width="200" height="200" src="/static/images/home/homeDog3.jpg" style="border: 7px solid white;" alt="dog" />
	</div>
	<!-- Container End -->
	</section>

	<section class="popular-deals section bg-gray">
	<div class="container">
		<div class="row">
			<div class="col-12">
				<div class="section-title">
					<h2>교육과정</h2>
				</div>
			</div>
		</div>
		<div class="row">
			<!-- offer 01 -->
			<div class="col-12">
				<c:choose>
					<c:when test="${ not empty courseList }">
						<div class="trending-ads-slide">
							<c:forEach var="course" items="${ courseList }" varStatus="index">
								
								<div class="col-4" style="max-width : 100%;">
									<div class="product-item bg-light">
										<div class="card">
											<div class="thumb-content">
												<a href="/course/detail?no=${ course.courseNo }">
													<img class="card-img-top img-fluid" src="<c:url value='/filePath?no=${ course.thumbAttach.attachNo }' />" alt="img">
												</a>
											</div>
											<div class="card-body">
				    						<h4 class="card-title"><a href="<c:url value='/course/detail?no=${ course.courseNo }' />">${ course.title }</a></h4>
				    						<p class="card-text">${ course.subTitle }</p>
				    						<div class="container" style="padding: 0; display: flex; justify-content: space-between;">
				    							<div style="margin: auto 0;">
				    								<p style="margin: 0;">수강중인 반려견: ${ course.petInCourseCount } / ${ course.capacity }</p>
				    							</div>
				    							<c:choose>
					    							<c:when test="${ course.petInCourseCount ge course.capacity }">
					    								<div>
					    									<button type="button" class="btn btn-secondary" style="padding: 5px 10px;" disabled>수강 불가</button>
					    								</div>
					    							</c:when>
					    							
					    							<c:otherwise>
					    								<div>
					    									<a href="<c:url value='/course/detail?no=${ course.courseNo }' />" class="btn btn-success" style="padding: 5px 10px;">수강 가능</a>
					    								</div>
					    							</c:otherwise>
					    						</c:choose>
				    						</div>
											</div>
										</div>
									</div>
								</div>
								
							</c:forEach>
						</div>
					</c:when>
					
					<c:otherwise>
						<c:if test="${ not empty requestScope.afterSearch }">
							<div style="height: 450px; display: flex; justify-content: center; align-items: center;">
								<h3 style="text-align: center">검색 결과가 없습니다.</h3>						
							</div>
						</c:if>
					</c:otherwise>
				</c:choose>
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
	
	<c:if test="${ empty requestScope.afterSearch }">
		<script>
			$(() => {
				location.href="<%= request.getContextPath() %>/home";
			});
		</script>
	</c:if>
</body>

</html>