<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>수료증</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	
	<style>
		@media print {
	    body * {
	        visibility: hidden;
	    }
	    
	    #printableArea, #printableArea * {
	        visibility: visible;
	    }
	    
	    #printableArea {
	        position: fixed;
	        left: 25%;
	        right: 25%;
	        top: 0;
	    }
		}
	</style>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>
	<h3 class="widget-header">
  	<%@ include file="/WEB-INF/views/include/courseInnerBar.jsp" %>
  </h3>
  
  <!-- 모달 창 -->
	<div class="modal fade" id="printModal" tabindex="-1" role="dialog" aria-labelledby="printModal" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 700px;">
	    <div class="modal-content">
	      <div class="modal-header border-bottom-0">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body text-center">
	        <h3 class="tab-title mb-2">수료증 발급</h3>
	        <p>다음의 이미지 형태로 출력됩니다.</p>
	        <div class="col-12" style="background-color: gray; padding: 0; display: flex; justify-content: center;">
	        	<div style="width: 80%; margin: 15px auto;">
	        		<div id="printableArea" style="border: 2px solid black;">
	        			<div style="position: relative;">
	        				<img src="/static/images/cert/cert_complete.png" style="width: 100%;" alt="cert_enroll">
	        				<div style="position: absolute; top: 35%; left: 20%;">
	        					<p id="printPetName" style="color: black; font-size: 16px; font-weight: 700; text-align: left;"></p>
	        				</div>
	        				<div style="position: absolute; top: 35%; right: 20%;">
	        					<p id="printMemberName" style="color: black; font-size: 16px; font-weight: 700; text-align: left;"></p>
	        				</div>
	        				<div style="position: absolute; left: 0; right: 0; top: 45%;">
	        					<p id="printBody" style="color: black; font-size: 18px;"></p>
	        				</div>
	        				<div style="position: absolute; bottom: 13%; left: 25%;">
	        					<p id="printGraduateNo" style="color: black; font-size: 15px;"></p>
	        				</div>
	        				<div style="position: absolute; bottom: 13%; right: 25%;">
	        					<p id="printTrainerName" style="color: black; font-size: 15px;"></p>
	        				</div>
	        				<div style="position: absolute; bottom: 20px; right: 15%;">
	        					<img src="/static/images/cert/sign.png" style="width: 100px; opacity: 0.5;" alt="sign">
	        				</div>
	        			</div>
	        		</div>
	        	</div>
	        </div>
	      </div>
	      <div class="modal-footer border-top-0 mb-3 mx-5 justify-content-center">
	        <button type="button" class="btn btn-primary" style="padding: 5px 10px;" onclick="printCert()">출력</button>
	        <button type="button" class="btn btn-outline-secondary" style="padding: 5px 10px;" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 모달 창 종료 -->
  
  <h3 class="tab-title mb-4 text-center">수료증 발급</h3>
  <c:forEach var="course" items="${ courseList }" varStatus="index">
		<div class="container my-2" style="border: 1px solid black; border-radius: 10px; overflow: hidden; padding: 0; display: flex;">
			<div class="col-4" style="padding: 0;">
			 <img style="width: 200px; height: 50px; object-fit: cover;" src="<c:url value='/filePath?no=${ course.thumbAttach.attachNo }' />" alt="img">
			</div>
			<div class="col-3" style="display: flex; align-items: center;">
				<span style="font-size: 18px;">${ course.title }</span>
			</div>
			<div class="col-2" style="display:flex; align-items:center;">
				<img class="rounded-circle" style="width: 40px; display: inline-block; border: 2px solid white; box-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);" src="<c:url value='/filePath?no=${ course.myPetInCourse.attachNo }' />" alt="img">
		   	<span class="ml-1" style="font-size: 15px;">${ course.myPetInCourse.petName }</span>
			</div>
			<div class="col-3" style="display: flex; justify-content: flex-end; align-items: center;">
				<button type="button" class="btn btn-outline-secondary" style="height: 30px; padding: 2px 5px;" onclick="openPrintModal('${ course.myPetInCourse.petName }', '${ sessionScope.loginAccount.name }', '${ course.title }', '${ course.classData.classNo }', '${ course.name }')" >다운로드</button>
			</div>
		</div>
	</c:forEach>

	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<script>
		function openPrintModal(petName, memberName, title, classNo, trainerName) {
			const congratString = "본 회원은 ○○훈련소의<br>" + title + " 교육 과정을<br>성공적으로 수료하여 이 수료증을 드립니다.";
			
			const date = new Date();
			const graduateNo = date.getFullYear() + "-구-" + classNo;
			
			$("#printPetName").text("반려견 " + petName);
			$("#printMemberName").text("반려인 " + memberName);
			$("#printBody").html(congratString);
			$("#printGraduateNo").text(graduateNo);
			$("#printTrainerName").text("훈련사 " + trainerName);
		
			$("#printModal").modal("show");
		}
		
		function printCert() {
			window.print();
		}
	</script>
</body>

</html>