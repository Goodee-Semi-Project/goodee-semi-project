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
	
	<div class="container">
		<div class="row">
			<div class="col-12">
				<c:choose>
					<c:when test="${ not empty courseList }">
						<c:forEach var="course" items="${ courseList }" varStatus="index">
							<div class="col-4" style="display: inline-block; max-width: 32%;">
								<div class="product-item bg-light">
										<div class="card">
											<div class="thumb-content" style="position: relative;">
												<a href="/course/detail?no=${ course.courseNo }">
													<img class="card-img-top img-fluid" src="<c:url value='/filePath?no=${ course.thumbAttach.attachNo }' />" style="width: 100%; height: 180px; object-fit: cover;" alt="img">
												</a>
												<c:if test="${ course.classData.classProg eq 100 }">
													<button type="button" class="btn btn-warning disabled" style="position: absolute; padding: 2px 5px; top: 5%; right: 5%; border: 1px solid white; border-radius: 20px; opacity: 1;"><span style="color: white; font-size: 12px; font-weight: 700; margin: 0;">수료</span></button>
												</c:if>
											</div>
											<div class="card-body" style="padding: 10px;">
				    						<h4 class="card-title"><a href="/course/detail?no=${ course.courseNo }">${ course.title }</a></h4>
				    						<c:if test="${ sessionScope.loginAccount.author eq 1 }">
				    							<p>수강중인 반려견: ${ course.petInCourseCount }</p>
				    							<div style="text-align: right;">
				    								<a href="<c:url value='/myCourse/update?no=${ course.courseNo }' />" class="btn btn-outline-secondary" style="padding: 2px 5px;">수정</a>
				    							</div>
												</c:if>
												
												<c:if test="${ sessionScope.loginAccount.author eq 2 }">
													<div>
														<img class="rounded-circle" style="width: 40px; height: 40px; object-fit: cover; display: inline-block; border: 2px solid white; box-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);" src="<c:url value='/filePath?no=${ course.myPetInCourse.attachNo }' />" alt="img">
				    								<span style="font-size: 15px;">${ course.myPetInCourse.petName }</span>
													</div>
													<div>
														<p class="my-1" style="font-size: 15px;">현재 진도: ${ course.classData.classProg }%</p>
														<ul class="progress_bar_wrap" style="list-style: none; display: table; width: 100%; height: 20px; background-color: #bcbaba; border-radius: 3px; margin-bottom: 5px; padding: 0;">
															<c:set var="percent" value="${ course.classData.classProg }" />
															<li style="width: ${ percent }%; display: table-cell; background-color: lime; border: 1px solid lime; border-radius: 3px;"></li>
															<li style="background-color: #bcbaba; border: 0; border-left: 0; border-radius: 0 3px 3px 0;"></li>
														</ul>
													</div>
												</c:if>
											</div>
										</div>
									</div>
							</div>
						</c:forEach>
					</c:when>
					
					<c:otherwise>
						<div style="width: 100%; height: 300px; display: flex; justify-content: center; align-items: center;">
							<h3>등록된 교육과정이 없습니다.</h3>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	
	<c:if test="${ sessionScope.loginAccount.author eq 1 }">
		<div style="display: flex; justify-content: center;">
			<a href="<c:url value='/myCourse/create' />" class="btn btn-success btn-sm" style="padding: 5px 10px;">새 교육과정 생성</a><br>		
		</div>
	</c:if>
	
	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<script>
		$("#listSideLink").css("color", "#5672F9");
	</script>
</body>

</html>