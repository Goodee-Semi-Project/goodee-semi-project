<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>훈련과정 출석 현황</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<%@ include file="/WEB-INF/views/include/myPageSideBar.jsp"%>

	<section class="page-title">
		<div class="container">
			<div class="row">
				<div class="col-md-8 offset-md-2 text-center">
					<h3>훈련과정 출석 관리</h3>
				</div>
			</div>
		</div>
	</section>
	
	<section>
		<table>
			<tbody>
				<tr>
					<th>이미지</th>				
					<th>과정명</th>				
				</tr>
				<c:forEach var="c" items="${courseList}">
					<tr>
						<c:if test="${c.thumbAttach ne null}">
							<td>
								<img src="<c:url value='/filePath?no=${c.thumbAttach.attachNo}'/>" alt="${c.title}" 
								style="width : 200px; height : 150px">
							</td>
						</c:if>
						<td>${c.title}</td>
					</tr>
					<c:forEach var="p" items="${c.petList }">
						<tr style="height: 50px;">
							<td style="width: 25%">
								<c:if test="${not empty p.attachNo }">
									<img src="<c:url value='/filePath?no=${p.attachNo}'/>" alt="${c.title}" 
									style="width : 80px; height : 80px; border-radius : 50%">
								</c:if>
							</td>
							<td style="width: 25%">${ p.petName } (${ p.petBreed })<br>${ p.petAge }세 / ${ p.petGender }</td>
							<td style="width: 20%">${ p.accountName }</td>
							<td style="width: 30%">
								<button type="button" style="padding: 5px 10px;" onclick="goToDetail(${p.petNo})" class="btn btn-dark">출석 현황</button>
							</td>
						</tr>
					</c:forEach>
				</c:forEach>
			</tbody>
		</table>
	</section>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>

<script>
	function goToDetail(petNo) {
		location.href="<%= request.getContextPath()%>/attend/detail?no=" + petNo
	}
</script>
</body>
</html>