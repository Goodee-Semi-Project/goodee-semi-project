<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>수강확인증</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
	

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>
	<h3 class="widget-header">
  	<%@ include file="/WEB-INF/views/include/courseInnerBar.jsp" %>
  </h3>
  
  <h3 class="tab-title mb-4 text-center">수강확인증 발급</h3>
  <c:forEach var="course" items="${ courseList }" varStatus="index">
		<div class="container my-2" style="border: 1px solid black; border-radius: 10px; overflow: hidden; padding: 0; display: flex;">
			<div class="col-4" style="padding: 0;">
			 <img style="width: 200px; height: 50px; object-fit: cover;" src="<c:url value='/filePath?no=${ course.thumbAttach.attachNo }' />" alt="img">
			</div>
			<div class="col-4" style="display: flex; align-items: center;">
				<span style="font-size: 18px;">${ course.title }</span>
			</div>
			<div class="col-4" style="display: flex; justify-content: flex-end; align-items: center;">
				<button type="button" class="btn btn-outline-secondary" style="height: 30px; padding: 2px 5px;">다운로드</button>
			</div>
		</div>
	</c:forEach>

	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>

</html>