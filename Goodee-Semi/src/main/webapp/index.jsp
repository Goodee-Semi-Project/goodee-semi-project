<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<title>안녕하세요! ○○훈련소 입니다.</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<section class="hero-area bg-1 text-left overly">
	<!-- Container Start -->
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<!-- Header Contetnt -->
				<div class="content-block">
					<h1>고객과 반려견이<br>더 가까워질 수 있도록.</h1>
					<p>더 안전한 훈련, 더 정확한 행동 교정,<br>고객과 훈련사의 1:1 맞춤 관리 시스템으로<br>반려견과 함께하는 더 나은 삶을 위해 노력합니다.</p>
				</div>
				<!-- Advance Search -->
				<%@ include file="/WEB-INF/views/include/search.jsp" %>
			</div>
		</div>
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
		    						<h4 class="card-title"><a href="/course/detail?no=${ course.courseNo }">${ course.title }</a></h4>
		    						<p class="card-text">${ course.subTitle }</p>
		    						<div class="product-ratings">
								    	<ul class="list-inline">
								    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
								    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
								    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
								    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
								    		<li class="list-inline-item"><i class="fa fa-star"></i></li>
								    	</ul>
		    						</div>
									</div>
								</div>
							</div>
						</div>
						
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	</section>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<c:if test="${ empty requestScope.courseList }">
		<script>
			$(() => {
				location.href="<%= request.getContextPath() %>/home";
			});
		</script>
	</c:if>
</body>

</html>