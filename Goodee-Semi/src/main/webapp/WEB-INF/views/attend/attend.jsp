<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
					<h3>훈련과정 출석 현황</h3>
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
					<th>상세보기</th>	
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
						<td><a href="<c:url value='/attend/detail'/>">상세보기</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</section>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>