<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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
				<h1>${scheduleList[0].courseTitle}</h1>
			</div>
		</div>
	</section>
	
	<section>
		<div>
			<div class="text-center">
				<h3>출석 현황</h3>
			</div>
		</div>
	</section>
	
	<section>
		<table class="text-center" style="width: 100%">
			<tbody>
				<c:if test="${not empty scheduleList}">
					<c:choose>
						<c:when test="${loginAccount.author eq 1}">
							<tr>
								<th style="width: 10%">회차</th>
								<th style="width: 15%">이미지</th>
								<th style="width: 20%">반려견 이름</th>
								<th style="width: 20%">교육일</th>
								<th style="width: 10%">출석여부</th>
								<th style="width: 20%">출결수정</th>
							</tr>
						</c:when>					
						<c:when test="${loginAccount.author eq 2}">
							<tr>
								<th style="width: 10%">회차</th>
								<th style="width: 15%">이미지</th>
								<th style="width: 20%">반려견 이름</th>
								<th style="width: 20%">교육일</th>
								<th style="width: 25%">교육시간</th>
								<th style="width: 10%">출석여부</th>
							</tr>
						</c:when>					
					</c:choose>
					<c:forEach var="sc" items="${scheduleList}" varStatus="vs">
						<tr style="height: 50px;">
							<td style="width: 10%">${sc.schedStep}회차</td>
							<td style="width: 15%">
								<c:if test="${not empty petAttach.attachNo }">
									<img src="<c:url value='/filePath?no=${petAttach.attachNo}'/>" alt="${sc.courseTitle}" 
									style="width : 70px; height : 70px; border-radius : 50%">
								</c:if>
							</td>
							<td style="width: 20%">${sc.petName}</td>
							<td style="width: 20%">${sc.schedDate}</td>
							<c:if test="${loginAccount.author eq 2}">	
								<td style="width: 25%">
									${startEndList[vs.index]}																	
								</td>
							</c:if>
							<c:choose>
								<c:when test="${sc.schedAttend eq 89}">
									<td style="width: 10%">출석</td>
								</c:when>
								<c:when test="${sc.schedAttend eq 78}">
									<td style="width: 10%">결석</td>
								</c:when>
								<c:otherwise>
									<td style="width: 10%">회차 정보 없음</td>
								</c:otherwise>
							</c:choose>
							<c:if test="${loginAccount.author eq 1}">	
								<td style="width: 20%">
									<button type="button" onclick="updateAttend('${sc.schedAttend}', ${sc.petNo}, ${sc.courseNo}, ${sc.schedNo})" 
									style="padding: 5px 10px;" class="btn btn-outline-secondary">수정</button>
									<button type="button" onclick="moveToAttendQr(${sc.schedNo})"class="btn btn-outline-secondary"
									style="padding: 5px 10px;" ${sc.schedAttend eq 89 ? "disabled" : ""}>QR생성</button>
								</td>
							</c:if>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
	</section>
	
	<c:if test="${empty scheduleList}">
		<section>
			<div class="text-center">
				<h2>조회된 출석 기록이 없습니다</h2>
			</div>
		</section>
	</c:if>
	
<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>

	<script>
	
		function moveToAttendQr(schedNo) {
			console.log("schedNo: " + schedNo);
			location.href="<%=request.getContextPath()%>/qr/qrCode?schedNo=" + schedNo
		}
	
		function updateAttend(didAttend, petNo, courseNo, schedNo) {
			let msg;
			if(didAttend == 'Y') {
				msg = "결석으로 바꾸시겠습니까?"
			} else{
				msg = "출석으로 바꾸시겠습니까?"
			}			
			if(confirm(msg)) {
				$.ajax({
					url : "/attend/detailUpdate",
					type : "post",
					data : {
						didAttend : didAttend,
						petNo : petNo,
						courseNo : courseNo,
						schedNo : schedNo,
						},
					dataType : "json",
					success : function(data) {
						if(data.res_code == 200) {
							alert(data.res_msg);
							location.href="<%=request.getContextPath()%>/attend/detail?petNo="+petNo+"&courseNo="+courseNo;
						} else if(data.res_code == 500) {
							alert(data.res_msg);
						}
					}
				});
			}
		}
	
		function deleteSchedule(schedNo, petNo, courseNo) {
			if(confirm("출석 기록을 삭제하시겠습니까?")) {
				$.ajax({
					url : "/attend/detailDelete",
					type : "post",
					data : {schedNo : schedNo},
					dataType : "json",
					success : function(data) {
						if(data.res_code == 200) {
							alert(data.res_msg);
							location.href="<%=request.getContextPath()%>/attend/detail?petNo="+petNo+"&courseNo="+courseNo;
						} else if(data.res_code == 500)	{
							alert(data.res_msg);
						} else alert("오류가 발생했습니다!");
					} 
				});
			}
		}	
	</script>
</body>
</html>