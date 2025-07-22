<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출석 현황</title>

<style>
	.list-margin td{
		margin : 10px
	}
</style>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<%@ include file="/WEB-INF/views/include/myPageSideBar.jsp"%>

	<c:forEach var="c" varStatus="status" items="${ courseList }">
		<table class="mb-4" style="width: 100%;">
			<tbody>
				<tr class="text-center course-header" style="cursor: pointer;" onclick="toggleCourse(${status.index})">
					<td colspan="4" style="height: 100px; box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.1); border-radius: 10px;">
						<div style="display: flex; align-items: center;">
							<div>
								<c:choose>
									<c:when test="${ not empty c.thumbAttach }">
										<img src="<c:url value='/filePath?no=${ c.thumbAttach.attachNo }'/>" alt="${ c.title }" style="width: 200px; height: 120px; object-fit: cover; border-radius: 10px 0 0 10px;">
									</c:when>
									<c:otherwise>
										<img src="<c:url value='/static/images/user/pet_profile.png'/>" alt="${ c.title }" style="width: 200px; height: 120px; object-fit: cover; border-radius: 10px 0 0 10px;">
									</c:otherwise>
								</c:choose>
							</div>
							<div class="h3 px-4 w-100">${ c.title }</div>
						</div>
					</td>
				</tr>

				<!-- 반려견 리스트 행 -->
				<c:forEach var="p" items="${ c.petList }">
					<tr class="text-center course-body course-${ status.index }" style="display: none; height: 95px;">
						<td style="width: 25%">
							<c:if test="${not empty p.attachNo}">
								<img src="<c:url value='/filePath?no=${ p.attachNo }'/>" style="width: 80px; height: 80px; border-radius: 50%;">
							</c:if></td>
						<td style="width: 25%">${ p.petName }(${ p.petBreed })<br>${ p.petAge }세 / ${ p.petGender }</td>
						<td style="width: 20%">${ p.accountName }</td>
						<td style="width: 30%">
							<button type="button" class="btn btn-dark" style="padding: 5px 10px;" onclick="goToDetail(${ p.petNo }, ${ c.courseNo })">출석 현황</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:forEach>


	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>

	<script>
		function goToDetail(petNo, courseNo) {
			location.href="<%= request.getContextPath() %>/attend/detail?petNo=" + petNo + "&courseNo=" + courseNo
		}
		
		function toggleCourse(index) {
			const targetRows = document.querySelectorAll('.course-' + index);
			const isVisible = targetRows.length > 0 && targetRows[0].style.display === 'table-row';
			
			// 모든 리스트 닫기
			document.querySelectorAll('.course-body').forEach(row => row.style.display = 'none');
			
			// 열려있지 않다면 해당 리스트 열기
			if (!isVisible) {
			  targetRows.forEach(row => row.style.display = 'table-row');
			}
		}
	</script>
</body>
</html>