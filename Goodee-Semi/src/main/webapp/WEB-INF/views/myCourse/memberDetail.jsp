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
	
	
	<div class="container my-2" style="width: 80%; height: 50px; border: 1px solid black; border-radius: 10px; overflow: hidden; padding: 0; display: flex;">
		<div class="col-4" style="padding: 0;">
			<img style="width: 100%; object-fit: cover;" src="<c:url value='/filePath?no=${ course.thumbAttach.attachNo }'/>" alt="img">
		</div>
		<div class="col-8" style="display: flex; justify-content: center; align-items: center;">
			<span style="font-size: 20px; font-weight: 700;">${ course.title }</span>
		</div>
	</div>
	<table class="text-center" style="width: 100%">
		<thead>
			<tr style="height: 50px;">
				<th>프로필 이미지</th>
				<th>반려견</th>
				<th>회원</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="pet" items="${ petList }">
				<tr style="height: 80px;">
					<td style="width: 25%">
						<c:if test="${ not empty pet.attachNo }">
							<img src="<c:url value='/filePath?no=${pet.attachNo}'/>" class="rounded-circle" alt="${course.title}" style="width : 70px; height : 70px; border-radius : 50% border: 1px solid white; box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.2);" >
						</c:if>
					</td>
					<td style="width: 25%">${ pet.petName } (${ pet.petBreed })<br>${ pet.petAge }세 / ${ pet.petGender }</td>
					<td style="width: 20%">${ pet.accountName } 님</td>
					<td style="width: 30%">
						<button type="button" onclick="moveToSchedList(${pet.petNo}, ${course.courseNo})" style="padding: 5px 10px;" class="btn btn-outline-secondary">일정</button>
						<button type="button" onclick="moveToAssign(${pet.classNo})" style="padding: 5px 10px;" class="btn btn-outline-secondary">과제</button>
						<button type="button" onclick="openKickoutModal('${pet.accountName}',${pet.classNo},'${pet.petName}')" class="btn_kickout btn btn-danger" style="padding: 5px 10px;">추방</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	
	<div class="modal fade" id="kickoutModal" tabindex="-1" role="dialog" aria-labelledby="printModal" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header border-bottom-0">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body text-center" id="modal_text"></div>
	      <input type="hidden" id="modal_class_no">
	      <div class="modal-footer border-top-0 mb-3 mx-5 justify-content-center">
	        <button type="button" id="btn_modal_kickout_confirm" class="btn btn-success">확인</button>
	        <button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	<script>
	function moveToAssign(classNo) {
		location.href="<%=request.getContextPath()%>/assign/listByClass?classNo=" + classNo;
	}
			
	function moveToSchedList(petNo, courseNo) {
		location.href="<%=request.getContextPath()%>/schedule?petNo=" + petNo + "/&courseNo=" + courseNo;
	}
	
	function openKickoutModal(accountName, classNo, petName) {
		$("#modal_text").text("반려견 " + petName + "(회원 " + accountName + ")님을 과정에서 제외하시겠습니까?");
		$("#modal_class_no").val(classNo);
		$("#kickoutModal").modal("show");
	}

	$("#btn_modal_kickout_confirm").click(function(){
		const classNo = $("#modal_class_no").val();
		$.ajax({
			url : "/myCourse/memberKickout?no=" + classNo,
			type : "get",
			success : function(data) {
				if (data == 1) {
					Swal.fire({
						icon: "success",
						text: "제외 처리되었습니다.",
						confirmButtonText: "확인"
					}).then((result) => {
						if (result.isConfirmed) {
							location.href="<%= request.getContextPath()%>/myCourse/memberDetail?courseNo=${course.courseNo}";				    
						}
					});
				} else {
					Swal.fire({ icon: "error", text: "제외 중 오류가 발생했습니다."});
				}
			}
		})
	})
	
	</script>
</body>
</html>