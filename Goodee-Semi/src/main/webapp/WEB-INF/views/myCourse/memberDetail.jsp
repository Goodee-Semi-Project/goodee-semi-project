<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp"%>
	<h3 class="widget-header">
  	<%@ include file="/WEB-INF/views/include/courseInnerBar.jsp" %>
  	</h3>
	
	<table class="text-center" style="width: 100%">
		<thead>
			<tr style="height: 70px;">
				<th style="width: 100%; font-size: 40px;" colspan="5">${course.title}</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="pet" items="${petList}">
				<tr style="height: 50px;">
					<td style="width: 25%">
						<c:if test="${not empty pet.attachNo }">
							<img src="<c:url value='/filePath?no=${pet.attachNo}'/>" alt="${c.title}" 
							style="width : 80px; height : 80px; border-radius : 50%">
						</c:if>
					</td>
					<td style="width: 25%">${ pet.petName } (${ pet.petBreed })<br>${ pet.petAge }세 / ${ pet.petGender }</td>
					<td style="width: 20%">${ pet.accountName }</td>
					<td style="width: 30%">
						<button type="button" onclick="" style="padding: 5px 10px;" class="btn btn-outline-secondary">일정</button>
						<button type="button" onclick="" style="padding: 5px 10px;" class="btn btn-outline-secondary">과제</button>
						<button type="button" class="btn_kickout btn btn-danger" data-account-name="${pet.accountName}"
							data-class-no="${pet.classNo}"
							data-pet-name="${pet.petName}" style="padding: 5px 10px;">추방</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	
	<script>
	$(".btn_kickout").click(function(){
		const petName = $(this).data("pet-name");
		const accountName = $(this).data("account-name");
		const msg = "반려견 " + petName + "(회원 " + accountName + ")님을 과정에서 제외하시겠습니까?";

		if(confirm(msg)) {
			const classNo = $(this).data("class-no")
			$.ajax({
				url : "/myCourse/memberKickout?no=" + classNo,
				type : "get",
				success : function(data) {
					if(data == 1) {
						alert("제외 처리되었습니다!");
						location.href="<%= request.getContextPath()%>/myCourse/memberDetail?=${course.courseNo}"
					} else {
						alert("오류가 발생했습니다!")
					}
				}
			})
		}
	})
	
	
	</script>
</body>
</html>