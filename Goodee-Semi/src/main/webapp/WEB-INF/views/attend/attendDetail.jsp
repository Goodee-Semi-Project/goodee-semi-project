<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출석 상세</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<%@ include file="/WEB-INF/views/include/myPageSideBar.jsp"%>

	<section>
		<div>
			<div class="text-center">
				<div>출석 현황</div>
			</div>
		</div>
	</section>
	
	<section>
		<table class="text-center" style="width: 100%">
			<tbody>
				<c:forEach var="e" items="${eventList}">
					<tr style="height: 50px;">
						<td style="width: 10%">${e.schedStep}회차</td>
						<td style="width: 20%">
							<c:if test="${not empty petAttach.attachNo }">
								<img src="<c:url value='/filePath?no=${petAttach.attachNo}'/>" alt="${e.courseTitle}" 
								style="width : 80px; height : 80px; border-radius : 50%">
							</c:if>
						</td>
						<td style="width: 20%">${e.petName}</td>
						<td style="width: 15%">${e.schedDate}</td>
						<c:choose>
							<c:when test="${e.schedAttend eq 89}">
								<td style="width: 15%">출석</td>
							</c:when>
							<c:when test="${e.schedAttend eq 78}">
								<td style="width: 15%">결석</td>
							</c:when>
							<c:otherwise>
								<td style="width: 15%">알 수 없음</td>
							</c:otherwise>
						</c:choose>
						<td style="width: 20%">
							<button type="button" onclick="" style="padding: 5px 10px;" class="btn btn-outline-secondary">수정</button>
							<button type="button" onclick="delete(${e.schedNo})" style="padding: 5px 10px;" class="btn btn-outline-secondary">삭제</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</section>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>

	<script>
		function update() {
			
		}
	
		function delete(schedNo) {
			if(confirm("출석 기록을 삭제하시겠습니까?")) {
				$.ajax({
					url : "/attend/detailDelete",
					type : "post",
					data : {
						shcedNo : schedNo
					},
					dataType : "json",
					sucess : function(data) {
						if(data.res_code == 200) {
							alert(data.res_msg);
						}
						else if(data.res_code == 500) {
							alert(data.res_msg);
						}
						else {
							alert("오류가 발생했습니다!")
						}
					} 
					
				});
			}
		}	
	</script>
</body>
</html>