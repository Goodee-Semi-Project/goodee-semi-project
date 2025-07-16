<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>내 교육과정</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
	

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>
	<h3 class="widget-header">
  	<%@ include file="/WEB-INF/views/include/courseInnerBar.jsp" %>
  </h3>
	
	<c:if test="${ sessionScope.loginAccount.author eq 1 }">
		<a href="<c:url value='/myCourse/create' />" class="btn btn-success btn-sm" style="padding: 5px 10px; margin-bottom: 20px;">새 교육과정 생성</a><br>
	</c:if>
	
	<div class="container">
		<div class="row">
			<div class="col-12">
			
				<c:forEach var="course" items="${ courseList }" varStatus="index">
					<div class="col-4" style="display: inline-block;">
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
	
	
	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>

</html>