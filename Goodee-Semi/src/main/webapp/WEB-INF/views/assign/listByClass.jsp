<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>과제 관리</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
	

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>

	<h3 class="tab-title mb-4 text-center">내 과제</h3>
  <hr>
		<div class="container my-2" style="border: 1px solid black; overflow: hidden; padding: 0; display: flex;">
			<div class="col-4" style="padding: 0;">
			 <img style="width: 200px; height: 50px; object-fit: cover;" src="<c:url value='/filePath?no=${ course.thumbAttach.attachNo }' />" alt="img">
			</div>
			<div class="col-5" style="display: flex; align-items: center;">
				<span style="font-size: 18px;">${ course.title }</span>
			</div>
			<div class="col-3" style="display:flex; align-items:center;">
				<img class="rounded-circle" style="width: 40px; display: inline-block; border: 2px solid white; box-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);" src="<c:url value='/filePath?no=${ pet.petAttach.attachNo }' />" alt="img">
		   	<span class="ml-1" style="font-size: 15px;">${ pet.petName }</span>
			</div>
		</div>
		
		<c:choose>
			<c:when test="${ not empty assignList }">
				<table class="text-center" style="width: 100%">
					<thead>
						<tr style="height: 70px;">
							<th style="width: 10%">훈련 차수</th>
							<th style="width: 40%">과제명</th>
							<th style="width: 20%">제출 기한</th>
							<th style="width: 30%">제출 현황</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="assign" items="${ assignList }">
							<tr style="height: 50px;">
								<td>${ assign.schedStep }</td>
								<td><a href="<c:url value='/assign/detail?assignNo=${ assign.assignNo }' />">${ assign.assignTitle }</a></td>
								<td style="font-size: 12px;">${ assign.assignStart }<br> ~ ${ assign.assignEnd }</td>
								<td>
									<c:choose>
										<c:when test="${ not empty assign.assignSubmit }">
											<button type="button" class="btn btn-success disabled" style="padding: 5px 10px;">제출 완료</button>										
										</c:when>
										
										<c:otherwise>
											<button type="button" class="btn btn-outline-secondary disabled" style="padding: 5px 10px;">미제출</button>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:when>
			
			<c:otherwise>
				<div style="width: 90%; height: 150px; margin: 0 auto; display: flex; justify-content: center; align-items: center;">
					<h3>생성된 과제가 없습니다.</h3>
				</div>
			</c:otherwise>
		</c:choose>

	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>

</html>