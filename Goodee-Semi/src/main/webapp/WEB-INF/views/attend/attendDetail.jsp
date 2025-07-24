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

	
	<div class="container my-2" style="width: 80%; height: 50px; border: 1px solid black; border-radius: 10px; overflow: hidden; padding: 0; display: flex;">
		<div class="col-12" style="display: flex; justify-content: center; align-items: center;">
			<span style="font-size: 20px; font-weight: 700;">${courseTitle}</span>
		</div>
	</div>
	
	<c:if test="${ empty scheduleList }">
		<div class="text-center">
			<h2>조회된 출석 기록이 없습니다</h2>
		</div>
	</c:if>
	
	<section>
		<table class="text-center" style="width: 100%">
			<tbody>
				<c:if test="${ not empty scheduleList }">
					<c:choose>
						<c:when test="${ loginAccount.author eq 1 }">
							<tr style="height: 50px">
								<th style="width: 10%">회차</th>
								<th style="width: 15%">이미지</th>
								<th style="width: 20%">반려견 이름</th>
								<th style="width: 20%">교육일</th>
								<th style="width: 10%">출석여부</th>
								<th style="width: 20%">체크</th>
							</tr>
						</c:when>					
						<c:when test="${ loginAccount.author eq 2 }">
							<tr style="height: 50px">
								<th style="width: 10%">회차</th>
								<th style="width: 15%">이미지</th>
								<th style="width: 20%">반려견 이름</th>
								<th style="width: 20%">교육일</th>
								<th style="width: 25%">교육시간</th>
								<th style="width: 10%">출석여부</th>
							</tr>
						</c:when>					
					</c:choose>
					<c:forEach var="sc" items="${ scheduleList }" varStatus="vs">
						<tr style="height: 80px;">
							<td style="width: 10%">${ sc.schedStep }회차</td>
							<td style="width: 15%">
								<c:if test="${ not empty petAttach.attachNo }">
									<img src="<c:url value='/filePath?no=${ petAttach.attachNo }'/>" alt="${ sc.courseTitle }" style="width : 70px; height : 70px; border-radius : 50%">
								</c:if>
							</td>
							<td style="width: 20%">${ sc.petName }</td>
							<td style="width: 20%">${ sc.schedDate }</td>
							<c:if test="${ loginAccount.author eq 2 }">	
								<td style="width: 25%">
									${ startEndList[vs.index] }																	
								</td>
							</c:if>
							<c:choose>
								<c:when test="${ sc.schedAttend eq 89 }">
									<td style="width: 10%">출석</td>
								</c:when>
								<c:when test="${ sc.schedAttend eq 78 }">
									<td style="width: 10%">결석</td>
								</c:when>
								<c:otherwise>
									<td style="width: 10%">결석</td>
								</c:otherwise>
							</c:choose>
							<c:if test="${ loginAccount.author eq 1 }">	
								<td style="width: 20%">
									<button type="button" onclick="openUpdateAttendModal('${ sc.schedAttend }', ${ sc.petNo }, ${ sc.courseNo }, ${ sc.schedNo })"class="btn btn-outline-secondary"  style="padding: 5px 10px;" >수정</button>
									<button type="button" onclick="moveToAttendQr(${ sc.schedNo }, ${ sc.petNo }, ${ sc.courseNo })"class="btn btn-outline-secondary" style="padding: 5px 10px; background-color: #1D1F20; color: white;" ${sc.schedAttend eq '89' ? "disabled" : ""}>QR생성</button>
								</td>
							</c:if>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
	</section>
	
<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>

	<div class="modal fade" id="updateAttend" tabindex="-1" role="dialog" aria-labelledby="printModal" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header border-bottom-0">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body text-center" id="modal_text"></div>
				<input type="hidden" id="modal_pet_no">
				<input type="hidden" id="modal_course_no">
				<input type="hidden" id="modal_sched_no">
				<input type="hidden" id="modal_didAttend">
				<div class="modal-footer border-top-0 mb-3 mx-5 justify-content-center">
					<button type="button" id="btn_modal_change_attend_confirm" class="btn btn-success">확인</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>

	<script>
		function moveToAttendQr(schedNo, petNo, courseNo) {
			location.href="<%=request.getContextPath()%>/qr/qrCode?schedNo=" + schedNo + "&petNo=" + petNo + "&courseNo=" + courseNo;
		}
		
		function openUpdateAttendModal(didAttend, petNo, courseNo, schedNo) {
			let msg;
			if(didAttend == 'Y') {
				msg = "결석으로 변경하시겠습니까?"
			} else{
				msg = "출석으로 변경하겠습니까?"
			}	
			$("#modal_text").text(msg);
			$("#modal_didAttend").val(didAttend);
			$("#modal_pet_no").val(petNo);
			$("#modal_course_no").val(courseNo);
			$("#modal_sched_no").val(schedNo);
			$("#updateAttend").modal("show");
		}
		
		$("#btn_modal_change_attend_confirm").click(function(){
			const petNo = $("#modal_pet_no").val();
			const courseNo = $("#modal_course_no").val();
			const schedNo = $("#modal_sched_no").val();
			const didAttend = $("#modal_didAttend").val();
			
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
					if (data.res_code == 200) {
						Swal.fire({
							icon: "success",
							text: data.res_msg,
							confirmButtonText: "확인"
						}).then((result) => {
							if (result.isConfirmed) {
								location.href="<%=request.getContextPath()%>/attend/detail?petNo="+petNo+"&courseNo="+courseNo;							    
							}
						});
					} else {
						Swal.fire({ icon: "error", text: data.res_msg});
					}

				}
			});
		})
	</script>
</body>
</html>